/*
 * main.c
 * Project 06 - Industrial Motor Controller
 * Team: Asmaa Safy & Shorouk Anwar
 * Date: July 29, 2026
 */

#include <avr/io.h>
#include <avr/interrupt.h>

#include "../Service/STD_Types.h"
#include "../Service/Bit_Math.h"
#include "../Logic/Data/data_types.h"
#include "../Logic/Data/data_manager.h"
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
#include "../HAL/DC_Motor/dc_motor.h"
#include "../HAL/Tachometer/Tachometer.h"              /* TACHO_* functions */
#include "../HAL/ANALOG_SENSOR/ANALOG_SENSOR.h"        /* ANALOG_* functions */
#include "../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"  /* LCD_* functions */
#include "../HAL/BUZZER/BUZZER.h"                      /* BUZZER_* functions */
#include "../HAL/Stepper_L298P/Stepper_L298P.h" 

/* ==================== Global Variables ==================== */
DriveData_t g_driveData;
DriveCfg_t g_driveCfg;
PI_Handle_t g_pi;
Ramp_t g_ramp;

/* ==================== E-Stop Flag (Used by INT1 ISR) ==================== */
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
    /* ===== STEP 1: SAFETY FIRST ===== */
    /* Ensure bridge is disabled before anything else (NFR-14) */
    BRIDGE_Init();  /* Sets OCR1A=0, EN=0, IN1=0, IN2=0 */
    
    /* ===== STEP 2: Initialize MCAL ===== */
    ADC_ConfigType adcCfg = {
        .uint8ReferenceVoltage = ADC_REF_AVCC,
        .uint8Prescaler = ADC_PRESCALER_128
    };
    EXTI_ConfigType extiCfg1 = {
        .line = EXTI_INT1,
        .sense = EXTI_SENSE_FALLING
    };
    EXTI_ConfigType extiCfg0 = {
        .line = EXTI_INT0,
        .sense = EXTI_SENSE_RISING
    };
    UART_ConfigType uartCfg = {
        .baudRate = UART_BAUD_9600,
        .dataSize = UART_DATA_8BITS,
        .parity = UART_PARITY_NONE,
        .stopBits = UART_STOP_1BIT
    };
    I2C_MasterConfigType i2cCfg = {
        .sclFrequency = I2C_SCL_100KHZ
    };

    ADC_Init(&adcCfg);
    Timer0_Init();
    Timer1_Init();
    Timer2_Init();
    EXTI_Init(&extiCfg1);  /* arm E-stop first */
    EXTI_Init(&extiCfg0);
    UART_Init(&uartCfg);
    I2C_InitMaster(&i2cCfg);  /* For LCD */
    
    /* ===== STEP 3: Initialize HAL ===== */
    TACHO_Init();   /* Tacho measurement */
    ANALOG_Init();  /* 4 ADC channels */
    PANEL_Init();   /* Buttons and LEDs */
    BUZZER_Init();  /* Buzzer */
    EEPROM_Init();  /* 25LC256 SPI EEPROM */
    TRIPLOG_Init(); /* Trip log */
    
    /* ===== STEP 4: Load Configuration from EEPROM ===== */
    if (!EEPROM_LoadConfig(&g_driveCfg)) {
        /* If load fails, use defaults and save them */
        EEPROM_LoadDefaults(&g_driveCfg);
        EEPROM_SaveConfig(&g_driveCfg);
    }
    
    /* Check for latched trip from EEPROM */
    Trip_t latchedTrip = EEPROM_LoadLatchTrip();
    if (latchedTrip != TRIP_NONE) {
        g_driveCfg.latchedTrip = latchedTrip;
        g_driveData.activeTrip = latchedTrip;
        FSM_RequestTrip(latchedTrip);
    }
    
    /* ===== STEP 5: Initialize APP ===== */
    DataManager_Init(&g_driveData, &g_driveCfg);
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
    
    /* ===== STEP 6: Initialize Scheduler ===== */
    SCHED_Init();
    SCHED_AddTask(Task_Panel, "Panel", 10, 0);       /* Buttons and LEDs */
    SCHED_AddTask(Task_Current, "Current", 50, 1);    /* Current + Short Circuit */
    SCHED_AddTask(Task_Control, "Control", 100, 2);   /* ★ MAIN CONTROL LOOP ★ */
    SCHED_AddTask(Task_LCD, "LCD", 250, 4);       /* LCD Update */
    SCHED_AddTask(Task_SlowSensors, "SlowSensors", 500, 3); /* Voltage + Temperature */
    SCHED_AddTask(Task_Telemetry, "Telemetry", 1000, 5); /* Telemetry + Run Hours */
    
    /* ===== STEP 7: Enable Interrupts ===== */
    sei(); /* أو استبدالها بـ ENABLE_INTERRUPTS() لو كانت معرفة داخل interrupt_interface.h */
    
    /* ===== STEP 8: Super Loop ===== */
    while (1) {
        SCHED_Run();
        
        /* Process console commands */
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
    PANEL_Poll();
    PanelEvent_t event = PANEL_GetEvent();
    
    switch (event) {
        case EVENT_START_PRESSED:
            if (!FSM_RequestStart()) {
                CONSOLE_SendError("ERR START");
            }
            break;
        case EVENT_STOP_PRESSED:
            FSM_RequestStop();
            break;
        case EVENT_REVERSE_PRESSED:
            if (!FSM_RequestReverse()) {
                CONSOLE_SendError("ERR REV");
            }
            break;
        case EVENT_RESET_PRESSED:
            if (!FSM_RequestReset()) {
                CONSOLE_SendError("ERR ACTIVE");
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
        PANEL_SetRunLED(1, 1);  /* Blink at 2Hz */
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
}

/**
 * @brief Task_Current - Called every 50ms
 * Reads current and checks short-circuit
 */
void Task_Current(void)
{
    /* Read current from ADC */
    uint16_t current = ANALOG_GetCurrent();
    g_driveData.currentmA = current;
    
    /* Update I2T accumulator */
    PROTECT_UpdateI2T(current, g_driveCfg.ratedCurrentmA);
    
    /* Short-circuit check (FR-10) */
    if (current >= g_driveCfg.shortTripmA) {
        FSM_RequestTrip(TRIP_SHORT);
        TELEMETRY_SendTripEvent(TRIP_SHORT, &g_driveData);
    }
}

/**
 * @brief Task_Control - Called every 100ms
 * Main control loop: Tacho → Ramp → Protect → PI → Bridge
 * (Critical ordering per system flow)
 */
void Task_Control(void)
{
    /* ===== 1. Update Tacho ===== */
    TACHO_Update();
    g_driveData.measuredRpm = TACHO_GetRPM();
    
    /* ===== 2. Update Setpoint ===== */
    int16_t setpoint;
    if (g_driveData.remote) {
        /* Remote mode: setpoint from console */
        setpoint = g_driveData.setpointRpm;
    } else {
        /* Local mode: setpoint from potentiometer */
        setpoint = ANALOG_GetSetpoint();
        g_driveData.setpointRpm = setpoint;
    }
    
    /* ===== 3. Update Ramp ===== */
    RAMP_SetTarget(&g_ramp, setpoint);
    g_driveData.rampedRpm = RAMP_Step(&g_ramp);
    
    /* ===== 4. Update Error ===== */
    g_driveData.errorRpm = g_driveData.rampedRpm - g_driveData.measuredRpm;
    
    /* ===== 5. Evaluate Protection (Before PI!) ===== */
    Trip_t trip = PROTECT_Evaluate(&g_driveData, &g_driveCfg);
    if (trip != TRIP_NONE) {
        /* Trip detected - stop the motor */
        FSM_RequestTrip(trip);
        BRIDGE_ForceStop();
        TELEMETRY_SendTripEvent(trip, &g_driveData);
        return;  /* Exit early - don't apply PI output */
    }
    
    /* ===== 6. PI Controller ===== */
    int16_t duty;
    if (FSM_IsRunning()) {
        /* Running: apply PI control */
        duty = PI_Step(&g_pi, g_driveData.rampedRpm, g_driveData.measuredRpm);
    } else {
        /* Stopped: force duty to 0 */
        duty = 0;
        PI_Reset(&g_pi);
    }
    
    /* ===== 7. Apply to Bridge ===== */
    DataManager_UpdateDuty(duty);
    BRIDGE_SetDuty(duty);
    BRIDGE_SetDirection(g_driveData.direction);
    
    /* ===== 8. Update FSM ===== */
    FSM_Run();
    
    /* ===== 9. Update data manager ===== */
    DataManager_UpdateError();
}

/**
 * @brief Task_LCD - Called every 250ms
 * Updates LCD display
 */
void Task_LCD(void)
{
    if (FSM_IsTripped()) {
        LCD_ShowTrip(g_driveData.activeTrip);
    } else {
        LCD_Update(&g_driveData);
    }
}

/**
 * @brief Task_SlowSensors - Called every 500ms
 * Reads voltage and temperature
 */
void Task_SlowSensors(void)
{
    g_driveData.busmV = ANALOG_GetBusVoltage();
    g_driveData.tempC = ANALOG_GetTemperature();
}

/**
 * @brief Task_Telemetry - Called every 1s
 * Sends telemetry frame and updates run hours
 */
void Task_Telemetry(void)
{
    /* Update run hours if running */
    if (FSM_IsRunning() && g_driveData.measuredRpm >= g_driveCfg.minRpm) {
        DataManager_IncrementRunSeconds();
    }
    
    /* Send telemetry */
    TELEMETRY_Update(&g_driveData);
}

/* ==================== Interrupt Service Routines ==================== */

/**
 * @brief INT0 ISR - Tacho pulse counting
 * Must be minimal: only increment counter (NFR-10)
 */
ISR(INT0_vect)
{
    /* Increment pulse counter - handled by TACHO_OnPulse() */
    TACHO_OnPulse();
}

/**
 * @brief INT1 ISR - Emergency Stop
 * Must be minimal: stop motor immediately (NFR-04)
 * Performs exactly three actions (Section 9.6):
 * 1. OCR1A = 0
 * 2. PORTB &= ~(EN|IN1|IN2)
 * 3. g_estopFlag = 1
 */
ISR(INT1_vect)
{
    /* 1. Force PWM to 0 */
    OCR1A = 0;
    
    /* 2. Disable bridge and clear direction pins */
    CLR_BIT(PORTB, PB2);  /* EN = 0 */
    CLR_BIT(PORTB, PB1);  /* IN2 = 0 */
    CLR_BIT(PORTB, PB0);  /* IN1 = 0 */
    
    /* 3. Set flag for FSM */
    g_estopFlag = 1;
    
    /* Note: The E-stop is NOT debounced (per section 10.5) */
}

/**
 * @brief USART RX ISR - Console input
 */
ISR(USART_RXC_vect)
{
    uint8_t ch = UDR;
    CONSOLE_ProcessChar(ch);
}