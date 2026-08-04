/*
 * main.c
 * Project 06 - Industrial Motor Controller
 * Team: Asmaa Safy & Shorouk Anwar
 * Date: July 29, 2026
 */
#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include "../Service/STD_Types.h"
#include "../Service/Bit_Math.h"
#include <avr/pgmspace.h>
#include "../Logic/Data/data_types.h"
#include "../Logic/Control/drive_fsm/drive_fsm.h"
#include "../Logic/Control/pi_controller/pi_controller.h"
#include "../Logic/Control/ramp_generator/ramp_generator.h"
#include "../Logic/Control/protection/protection.h"
#include "../Logic/Scheduler/scheduler.h"
#include "../Logic/Communication/console/console.h"
#include "../Logic/Communication/telemetry/telemetry.h"

/* ==================== MCAL Includes ==================== */
#include "../MCL/GPIO/GPIO_Interface.h"
#include "../MCL/ADC/ADC_Interfaces.h"
#include "../MCL/Timer/timer_interface.h"
#include "../MCL/Interrupt/interrupt_interface.h"
#include "../MCL/UART/uart_interface.h"
#include "../MCL/I2C/i2c_interface.h"

/* ==================== HAL Includes ==================== */
#include "../HAL/UserPanel/UserPanel.h"
#include "../HAL/DC_Motor/dc_motor.h"
#include "../HAL/Tachometer/Tachometer.h"
#include "../HAL/ANALOG_SENSOR/ANALOG_SENSOR.h"
#include "../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
#include "../HAL/BUZZER/BUZZER.h"
#include "../HAL/MotorBridge/MotorBridge.h"

/* ==================== Global Variables ==================== */
DriveData_t g_driveData;
DriveCfg_t g_driveCfg;
PI_Handle_t g_pi;
Ramp_t g_ramp;

/* ==================== E-Stop Flag ==================== */
volatile uint8_t g_estopFlag = 0;

/* ==================== Function Prototypes ==================== */
void Task_Panel(void);
void Task_Current(void);
void Task_Control(void);
void Task_LCD(void);
void Task_SlowSensors(void);
void Task_Telemetry(void);

/* ==================== Main Function ==================== */
int main(void)
{
    /* ===== STEP 1: Disable Global Interrupts ===== */
    cli();

    /* ===== STEP 2: Initialize Core System & UART ===== */
    UART_ConfigType uartCfg = {
        .baudRate = UART_BAUD_9600,
        .dataSize = UART_DATA_8BITS,
        .parity = UART_PARITY_NONE,
        .stopBits = UART_STOP_1BIT
    };
    UART_Init(&uartCfg);

    /* NOTE: sei() moved here on purpose. UART_SendByte()/UART_SendString()
       only queue bytes into a software ring buffer; the actual byte-by-byte
       transmission happens inside the USART_UDRE_vect ISR. If interrupts
       stay disabled while the boot/console banners are printed, the ring
       buffer (128 bytes) fills up faster than it can ever be drained and
       UART_SendByte() spins forever in its "buffer full" wait loop -
       deadlocking main() before it ever reaches the old sei() call at the
       end of init. Enabling interrupts immediately after UART_Init() lets
       the UDRE ISR drain the buffer as it fills, so no boot text can ever
       overflow it. No other peripheral is configured yet, so nothing else
       can spuriously interrupt at this point. */
    sei();

    UART_SendString_P(PSTR("\r\n--- SYSTEM STARTING ---\r\n"));
    UART_SendString_P(PSTR("BOOT1: UART OK\r\n"));

    /* ===== STEP 3: Initialize Hardware (MCAL) ===== */
    /* I2C for LCD */
    I2C_MasterConfigType i2cCfg = { I2C_SCL_100KHZ };
    I2C_InitMaster(&i2cCfg);
    
    /* ADC */
    ADC_ConfigType adcCfg = {
        .uint8ReferenceVoltage = ADC_REF_AVCC,
        .uint8Prescaler = ADC_PRESCALER_128
    };
    ADC_Init(&adcCfg);

    /* The very first ADC conversion right after enabling the ADC/changing
     * the reference (and after switching the input mux to a new channel)
     * can return an unreliable value on real AVR hardware, before the
     * reference/mux has settled. Do one throwaway conversion on each
     * channel here and discard it, so the first REAL reading each task
     * takes is trustworthy. Without this, a garbage first current sample
     * could look like an overcurrent spike and trip TRIP_SHORT immediately
     * at boot (same risk exists for temperature/voltage trips). */
    {
        uint16_t dummy;
        (void)ADC_ReadChannelBlocking(ANALOG_CH_SETPOINT, &dummy);
        (void)ADC_ReadChannelBlocking(ANALOG_CH_CURRENT, &dummy);
        (void)ADC_ReadChannelBlocking(ANALOG_CH_BUS_VOLTAGE, &dummy);
        (void)ADC_ReadChannelBlocking(ANALOG_CH_TEMPERATURE, &dummy);
    }

    /* Timer0 for system tick (1ms) */
    Timer0_Init();
    
    /* Timer2 for buzzer */
    Timer2_Init();

    /* External Interrupts */
    EXTI_ConfigType extiCfg1 = { .line = EXTI_INT1, .sense = EXTI_SENSE_RISING };
    EXTI_ConfigType extiCfg0 = { .line = EXTI_INT0, .sense = EXTI_SENSE_RISING };
    EXTI_Init(&extiCfg1);
    EXTI_Init(&extiCfg0);
    
    /* NOTE: Timer1 is initialized inside BRIDGE_Init() for PWM */
    
    UART_SendString_P(PSTR("BOOT2: MCAL OK\r\n"));

    /* ===== STEP 4: Initialize HAL ===== */
    LCD_InitDefault();
    TACHO_Init();
    ANALOG_Init();
    PANEL_Init();
    BUZZER_Init();
    BRIDGE_Init();  /* This sets up Timer1 PWM */
    UART_SendString_P(PSTR("BOOT3: HAL OK\r\n"));

    /* ===== STEP 5: Default Configuration & APP ===== */
    g_driveCfg.magic            = 0x4D44;
    g_driveCfg.version          = 0x01;
    g_driveCfg.maxRpm           = 3000;
    g_driveCfg.minRpm           = 200;
    g_driveCfg.accelRpmPerSec   = 600;
    g_driveCfg.decelRpmPerSec   = 900;
    g_driveCfg.deadTimeMs       = 500;
    g_driveCfg.kp               = 384;
    g_driveCfg.ki               = 26;
    g_driveCfg.ratedCurrentmA   = 8000;
    g_driveCfg.shortTripmA      = 18000;
    g_driveCfg.overTempC        = 110;
    g_driveCfg.underVoltmV      = 20000;
    g_driveCfg.overVoltmV       = 55000;
    g_driveCfg.stallSec         = 3;
    g_driveCfg.totalRunSec      = 0;
    g_driveCfg.startCount       = 0;
    g_driveCfg.tripHead         = 0;
    g_driveCfg.latchedTrip      = TRIP_NONE;
    g_driveCfg.checksum         = 0;

    PI_Init(&g_pi, g_driveCfg.kp, g_driveCfg.ki);
    PI_InitLimits(&g_pi, PWM_MIN_RUN, PWM_TOP);
    
    RAMP_Init(&g_ramp);
    RAMP_SetLimits(&g_ramp, g_driveCfg.minRpm, g_driveCfg.maxRpm);
    RAMP_SetRates(&g_ramp, g_driveCfg.accelRpmPerSec, g_driveCfg.decelRpmPerSec);
    
    PROTECT_Init();
    FSM_Init();
    FSM_SetDeadTime(g_driveCfg.deadTimeMs);
    CONSOLE_Init();
    TELEMETRY_Init();

    /* Without this, UART_RxCallBack stays NULL forever and the RX ISR has
     * nowhere to forward received bytes - CONSOLE_ProcessChar() never runs,
     * so typed commands (HELP, RUN, ...) are silently swallowed with no
     * echo and no response, even though the bytes do arrive on the wire. */
    UART_SetRxCallBack(CONSOLE_ProcessChar);
    
    /* ===== STEP 6: Initialize Scheduler ===== */
    g_driveData.busmV = ANALOG_GetBusVoltage();
    SCHED_Init();
    SCHED_AddTask(Task_Panel, "Panel", 10, 0);
    SCHED_AddTask(Task_Current, "Current", 50, 1);
    SCHED_AddTask(Task_Control, "Control", 100, 2);
    SCHED_AddTask(Task_LCD, "LCD", 250, 4);
    SCHED_AddTask(Task_SlowSensors, "SlowSensors", 500, 3);
    SCHED_AddTask(Task_Telemetry, "Telemetry", 1000, 5);

    UART_SendString_P(PSTR("BOOT4: SCHEDULER READY, RUNNING...\r\n"));

    /* ===== STEP 7: Run ===== */
    /* (Interrupts were already enabled right after UART_Init() - see note above) */

    while (1) {
        SCHED_Run();
        if (CONSOLE_IsCommandReady()) {
            CONSOLE_ExecuteCommand();
        }
    }
    
    return 0;
}

/* ==================== Task Functions ==================== */

/**
 * @brief Task_Panel - Called every 10ms
 * Polls buttons and updates LEDs
 */
void Task_Panel(void)
{
    /* Live-read the physical E-Stop switch (same pin as the INT1 ISR,
     * PD3) every 10ms. estopRaw must reflect the CURRENT pin level (not
     * just "an edge happened once") because FSM_RequestReset() checks
     * "!g_driveData.estopRaw" to decide whether the E-Stop loop has been
     * physically cleared before allowing the operator to acknowledge and
     * resume. Without this, the E-Stop switch cut the motor for an
     * instant (via the ISR) but the FSM never actually knew the system
     * was stopped, and could never be reset back out of DS_ESTOP either. */
    g_driveData.estopRaw = (GPIO_read_pin(GPIO_PORTD, GPIO_PIN3) == GPIO_HIGH) ? 1U : 0U;

    PANEL_Poll();
    Panel_Event_t event = PANEL_GetEvent();
    
    switch (event)
{
    case PNL_START:
        if (!FSM_RequestStart())
        {
            CONSOLE_SendError(PSTR("ERR START"));
        }
        else
        {
            BUZZER_SetMode(BUZZ_ACTION);
        }
        break;

    case PNL_STOP:
        if (FSM_RequestStop())
        {
            BUZZER_SetMode(BUZZ_ACTION);
        }
        break;

    case PNL_REVERSE:
        if (!FSM_RequestReverse())
        {
            CONSOLE_SendError(PSTR("ERR REV"));
        }
        else
        {
            BUZZER_SetMode(BUZZ_ACTION);
        }
        break;

    case PNL_RESET:
        if (!FSM_RequestReset())
        {
            CONSOLE_SendError(PSTR("ERR ACTIVE"));
        }
        else
        {
            BUZZER_SetMode(BUZZ_ACTION);
        }
        break;

    default:
        break;
}
    
    /* Update status LEDs based on FSM state */
    DriveState_t state = FSM_GetState();
    if (state == DS_RUNNING) {
        PANEL_SetRunLED(1, 0);  /* Steady ON */
    } else if (state == DS_STARTING || state == DS_RAMP_DOWN) {
        PANEL_SetRunLED(1, 1);  /* Blink */
    } else {
        PANEL_SetRunLED(0, 0);  /* OFF */
    }
    
    /* Fault LED */
    if (FSM_IsTripped()) {
        PANEL_SetFaultLED(1);
    } else {
        PANEL_SetFaultLED(0);
    }
    
    /* Direction LEDs */
    MotorDir_t dir = FSM_GetDirection();
    PANEL_SetDirectionLEDs(dir);
    
    /* Update Local/Remote mode */
    if (PANEL_IsLocalMode()) {
        g_driveData.remote = 0;
    } else {
        g_driveData.remote = 1;
    }
    BUZZER_Update();
}

/**
 * @brief Task_Current - Called every 50ms
 * Reads current and checks short-circuit
 */
void Task_Current(void)
{
    static Trip_t lastCurrentTrip = TRIP_NONE;   /* NEW */

    /* Read current from ADC */
    uint16_t current = ANALOG_GetCurrent();
    g_driveData.currentmA = current;
    
    /* Update I2T accumulator */
    PROTECT_UpdateI2T(current, g_driveCfg.ratedCurrentmA);
    
    /* Short-circuit check (FR-10) */
    if (current >= g_driveCfg.shortTripmA) {
        FSM_RequestTrip(TRIP_SHORT);
        if (lastCurrentTrip != TRIP_SHORT) {          /* NEW: only once */
            TELEMETRY_SendTripEvent(TRIP_SHORT, &g_driveData);
            lastCurrentTrip = TRIP_SHORT;              /* NEW */
        }
    } else {
        lastCurrentTrip = TRIP_NONE;                   /* NEW: reset when clear */
    }
}

/**
 * @brief Task_Control - Called every 100ms
 * Main control loop: Tacho -> Ramp -> Protect -> PI -> Bridge
 */
void Task_Control(void)
{
    static Trip_t lastControlTrip = TRIP_NONE;

    /* ===== 1. Update FSM First ===== */
    FSM_Run();

    /* ===== 2. Update Tacho ===== */
    TACHO_Update();
    g_driveData.measuredRpm = TACHO_GetRPM();

    /* ===== 3. Update Setpoint ===== */
    int16_t setpoint;
    if (g_driveData.remote) {
        setpoint = g_driveData.setpointRpm;
    } else {
        setpoint = ANALOG_GetSetpoint();
        g_driveData.setpointRpm = setpoint;
    }

    /* ===== 4. Update Ramp ===== */
    RAMP_SetTarget(&g_ramp, setpoint);
    g_driveData.rampedRpm = RAMP_Step(&g_ramp);

    /* ===== 5. Update Error ===== */
    g_driveData.errorRpm =
        g_driveData.rampedRpm - g_driveData.measuredRpm;

    /* ===== 6. Evaluate Protection ===== */
    Trip_t trip = PROTECT_Evaluate(&g_driveData, &g_driveCfg);

    /* ---------- DEBUG ---------- */
    if (trip != TRIP_NONE)
    {
        char txt[40];
        sprintf(txt, "TRIP=%d\r\n", trip);
        UART_SendString(txt);
    }
    /* --------------------------- */

    if (trip != TRIP_NONE) {
        FSM_RequestTrip(trip);
        BRIDGE_ForceStop();

        if (lastControlTrip != trip) {
            TELEMETRY_SendTripEvent(trip, &g_driveData);
            lastControlTrip = trip;
        }
        return;
    }

    lastControlTrip = TRIP_NONE;

    /* ===== 7. PI Controller ===== */
    int16_t duty;

    if (FSM_IsRunning()) {
        duty = PI_Step(&g_pi,
                       g_driveData.rampedRpm,
                       g_driveData.measuredRpm);
    } else {
        duty = 0;
        PI_Reset(&g_pi);
    }

    
    /* ===== 8. Apply to Bridge =====
     * PI_Step() output is already in raw OCR1A counts (0..PWM_TOP), because
     * PI_InitLimits(&g_pi, PWM_MIN_RUN, PWM_TOP) clamps it to that range.
     * BRIDGE_SetDuty() also expects raw counts (it writes its argument
     * straight into TIMER_OCR1A_REG). Converting to a 0-100 percentage
     * here and passing THAT into BRIDGE_SetDuty() was double-scaling the
     * duty cycle down to a small fraction of what the PI controller
     * actually asked for - that's why the motor barely turned/didn't turn. */
    BRIDGE_SetDuty((uint16_t)duty);
    BRIDGE_SetDirection(g_driveData.direction);
    
}
/**
 * @brief Task_LCD - Called every 250ms
 */
void Task_LCD(void)
{
    Trip_t currentTrip = PROTECT_GetActiveTrip();

    if (FSM_IsTripped())
    {
        LCD_ShowTrip(currentTrip);
    }
    else
    {
        LCD_Update(&g_driveData);
    }
}

/**
 * @brief Task_SlowSensors - Called every 500ms
 */
void Task_SlowSensors(void)
{
    uint16_t v = ANALOG_GetBusVoltage();

    g_driveData.busmV = v;

    char txt[80];
    sprintf(txt, "V=%u STORE=%u\r\n", v, g_driveData.busmV);
    UART_SendString(txt);

    g_driveData.tempC = ANALOG_GetTemperature();
}
/**
 * @brief Task_Telemetry - Called every 1s
 */
void Task_Telemetry(void)
{
    /* Send telemetry */
    TELEMETRY_Update(&g_driveData);
}

//* ==================== Interrupt Service Routines ==================== */

/**
 * @brief INT1 ISR - Emergency Stop
 */
ISR(INT1_vect)
{
    /* Disable bridge and clear direction pins */
 Timer1_SetDuty(0);

 CLR_BIT(PORTB, PB1);
 CLR_BIT(PORTB, PB0);  /* IN1 = 0 */

    g_estopFlag = 1;
}
/**
 * @brief INT0 ISR - Tacho pulse counting     
 * Must be minimal: only increment counter (NFR-10)
 */
ISR(INT0_vect)
{
    TACHO_PulseISR();
}

