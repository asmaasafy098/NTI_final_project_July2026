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
#include "../HAL/Stepper_L298P/Stepper_L298P.h"
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
void Task_StepperTick(void);

/* ==================== Main Function ==================== */
int main(void)
{
    /* ===== STEP 1: Disable Global Interrupts ===== */
    cli();
    UART_ConfigType uartCfg = {
        .baudRate = UART_BAUD_9600,
        .dataSize = UART_DATA_8BITS,
        .parity = UART_PARITY_NONE,
        .stopBits = UART_STOP_1BIT
    };
    UART_Init(&uartCfg);
    

    UART_SendString("\r\n--- SYSTEM STARTING ---\r\n");
    UART_SendString("BOOT1: UART OK\r\n");

    /* ===== STEP 3: Initialize Hardware (MCAL) ===== */
    I2C_MasterConfigType i2cCfg = { I2C_SCL_100KHZ };
    I2C_InitMaster(&i2cCfg);

    ADC_ConfigType adcCfg = {
        .uint8ReferenceVoltage = ADC_REF_AVCC,
        .uint8Prescaler = ADC_PRESCALER_128
    };
    ADC_Init(&adcCfg);

    Timer0_Init();
    Timer2_Init();

    EXTI_ConfigType extiCfg1 = { .line = EXTI_INT1, .sense = EXTI_SENSE_RISING };
    EXTI_ConfigType extiCfg0 = { .line = EXTI_INT0, .sense = EXTI_SENSE_RISING };
    EXTI_Init(&extiCfg1);
    EXTI_Init(&extiCfg0);

    UART_SendString("BOOT2: MCAL OK\r\n");

    /* ===== STEP 4: Initialize HAL ===== */
    LCD_InitDefault();
    TACHO_Init();
    ANALOG_Init();
    PANEL_Init();
    BUZZER_Init();
    BRIDGE_Init();
    UART_SendString("BOOT3: HAL OK\r\n");

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

    /* ===== STEP 6: Initialize Scheduler ===== */
    SCHED_Init();
    SCHED_AddTask(Task_Panel, "Panel", 10, 0);
    SCHED_AddTask(Task_Current, "Current", 50, 1);
    SCHED_AddTask(Task_Control, "Control", 100, 2);
    SCHED_AddTask(Task_LCD, "LCD", 250, 4);
    SCHED_AddTask(Task_SlowSensors, "SlowSensors", 500, 3);
    SCHED_AddTask(Task_Telemetry, "Telemetry", 1000, 5);
    SCHED_AddTask(Task_StepperTick, "Stepper", 1, 0);

    UART_SendString("BOOT4: SCHEDULER READY\r\n");
    sei();

    /* ===== STEP 7: Run ===== */
    while (1) {
        SCHED_Run();

        uint8_t rxByte;
        while (UART_ReceiveByteNonBlocking(&rxByte) == E_OK) {
            CONSOLE_ProcessChar(rxByte);
        }

        if (CONSOLE_IsCommandReady()) {
            CONSOLE_ExecuteCommand();
        }
    }

    return 0;
}

/* ==================== Task Functions ==================== */

void Task_Panel(void)
{
    PANEL_Poll();
    Panel_Event_t event = PANEL_GetEvent();

    switch (event) {
        case PNL_START:
            if (!FSM_RequestStart()) {
                CONSOLE_SendError("ERR START");
            }
            break;

        case PNL_STOP:
            FSM_RequestStop();
            break;

        case PNL_REVERSE:
            if (!FSM_RequestReverse()) {
                CONSOLE_SendError("ERR REV");
            }
            break;

        case PNL_RESET:
            if (!FSM_RequestReset()) {
                CONSOLE_SendError("ERR ACTIVE");
            }
            break;

        default:
            break;
    }

    DriveState_t state = FSM_GetState();
    if (state == DS_RUNNING) {
        PANEL_SetRunLED(1, 0);
    } else if (state == DS_STARTING || state == DS_RAMP_DOWN) {
        PANEL_SetRunLED(1, 1);
    } else {
        PANEL_SetRunLED(0, 0);
    }

    if (FSM_IsTripped()) {
        PANEL_SetFaultLED(1);
    } else {
        PANEL_SetFaultLED(0);
    }

    MotorDir_t dir = FSM_GetDirection();
    PANEL_SetDirectionLEDs(dir);

    if (PANEL_IsLocalMode()) {
        g_driveData.remote = 0;
    } else {
        g_driveData.remote = 1;
    }
}

void Task_Current(void)
{
    uint16_t current = ANALOG_GetCurrent();
    g_driveData.currentmA = current;

    PROTECT_UpdateI2T(current, g_driveCfg.ratedCurrentmA);

    if (current >= g_driveCfg.shortTripmA) {
        FSM_RequestTrip(TRIP_SHORT);
        TELEMETRY_SendTripEvent(TRIP_SHORT, &g_driveData);
    }
}

void Task_Control(void)
{
    FSM_Run();

    TACHO_Update();
    g_driveData.measuredRpm = TACHO_GetRPM();

    int16_t setpoint;
    if (g_driveData.remote) {
        setpoint = g_driveData.setpointRpm;
    } else {
        setpoint = ANALOG_GetSetpoint();
        g_driveData.setpointRpm = setpoint;
    }

    RAMP_SetTarget(&g_ramp, setpoint);
    g_driveData.rampedRpm = RAMP_Step(&g_ramp);

    g_driveData.errorRpm = g_driveData.rampedRpm - g_driveData.measuredRpm;

    Trip_t trip = PROTECT_Evaluate(&g_driveData, &g_driveCfg);
    if (trip != TRIP_NONE) {
        FSM_RequestTrip(trip);
        BRIDGE_ForceStop();
        TELEMETRY_SendTripEvent(trip, &g_driveData);
        return;
    }

    int16_t duty;
    if (FSM_IsRunning()) {
        duty = PI_Step(&g_pi, g_driveData.rampedRpm, g_driveData.measuredRpm);
    } else {
        duty = 0;
        PI_Reset(&g_pi);
    }

    g_driveData.dutyCounts = (uint16_t)duty;
    g_driveData.dutyPct    = (uint8_t)(((uint16_t)duty * 100) / PWM_TOP);

    BRIDGE_SetDuty((uint16_t)duty);
    BRIDGE_SetDirection(g_driveData.direction);
}

void Task_LCD(void)
{
    static uint8_t lastTrip = 0;
    Trip_t currentTrip = PROTECT_GetActiveTrip();

    if (FSM_IsTripped()) {
        if (currentTrip != lastTrip) {
            lastTrip = currentTrip;
            LCD_ShowTrip(currentTrip);
        }
    } else {
        lastTrip = 0;
        LCD_Update(&g_driveData);
    }
}

void Task_SlowSensors(void)
{
    g_driveData.busmV = ANALOG_GetBusVoltage();
    g_driveData.tempC = ANALOG_GetTemperature();
}

void Task_Telemetry(void)
{
    TELEMETRY_Update(&g_driveData);
}

void Task_StepperTick(void)
{
    Stepper_L298P_Tick();
}

/* ==================== Interrupt Service Routines ==================== */

ISR(INT1_vect)
{
    Timer1_SetDuty(0);
    CLR_BIT(PORTB, PB1);
    CLR_BIT(PORTB, PB0);
    g_estopFlag = 1;
}

ISR(INT0_vect)
{
    TACHO_PulseISR();
}