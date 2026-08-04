/*
 * drive_fsm.c
 * Drive State Machine Implementation
 */

#include "drive_fsm.h"
#include "../pi_controller/pi_controller.h"
#include "../ramp_generator/ramp_generator.h"
#include "../protection/protection.h"
#include "../MotorBridge/MotorBridge.h"
#include "../../Data/data_manager.h"
#include "../../../Service/util_math.h"
#include <stdio.h>
#include "../../../MCL/UART/uart_interface.h"
#include "../../HAL/ANALOG_SENSOR/ANALOG_SENSOR.h"

/* ==================== External References ==================== */

extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
extern PI_Handle_t g_pi;
extern Ramp_t g_ramp;

/* ==================== Static Variables ==================== */

static FSM_Data_t g_fsm;

/* ==================== Private Function Prototypes ==================== */

static void FSM_TransitionTo(DriveState_t newState);
static void FSM_HandleInit(void);
static void FSM_HandleStopped(void);
static void FSM_HandleStarting(void);
static void FSM_HandleRunning(void);
static void FSM_HandleRampDown(void);
static void FSM_HandleDeadTime(void);
static void FSM_HandleCoasting(void);
static void FSM_HandleTripped(void);
static void FSM_HandleEStop(void);
static void FSM_ExecuteActions(void);

/* ==================== Functions Implementation ==================== */

void FSM_Init(void)
{
    g_fsm.currentState = DS_INIT;
    g_fsm.previousState = DS_INIT;

    g_fsm.direction = DIR_STOP;
    g_fsm.pendingDirection = DIR_STOP;

    g_fsm.reversalPending = 0;
    g_fsm.tripPending = 0;
    g_fsm.estopActive = 0;

    g_fsm.stateTimer = 0;
    g_fsm.deadTimeMs = 500;

    g_fsm.atSpeedCounter = 0;
    g_fsm.speedZeroCounter = 0;

    g_fsm.initialized = 1;
}


/* ==================== FSM RUN ==================== */

void FSM_Run(void)
{
    if (!g_fsm.initialized)
    {
        FSM_Init();
        return;
    }

    /* Update state timer */
    g_fsm.stateTimer += 100;

    /* E-Stop has highest priority */
    if (g_driveData.estopRaw &&
        g_fsm.currentState != DS_ESTOP)
    {
        FSM_RequestEmergencyStop();

        /* Apply ESTOP-safe outputs immediately */
        FSM_ExecuteActions();

        return;
    }

    /* Execute current state */
    switch (g_fsm.currentState)
    {
        case DS_INIT:
            FSM_HandleInit();
            break;

        case DS_STOPPED:
            FSM_HandleStopped();
            break;

        case DS_STARTING:
            FSM_HandleStarting();
            break;

        case DS_RUNNING:
            FSM_HandleRunning();
            break;

        case DS_RAMP_DOWN:
            FSM_HandleRampDown();
            break;

        case DS_DEAD_TIME:
            FSM_HandleDeadTime();
            break;

        case DS_COASTING:
            FSM_HandleCoasting();
            break;

        case DS_TRIPPED:
            FSM_HandleTripped();
            break;

        case DS_ESTOP:
            FSM_HandleEStop();
            break;

        default:
            break;
    }

    /* Apply physical bridge state */
    FSM_ExecuteActions();
}


/* ==================== STATE HANDLERS ==================== */

static void FSM_HandleInit(void)
{
    if (!g_driveData.estopRaw)
    {
        if (g_driveCfg.latchedTrip == TRIP_NONE)
        {
            FSM_TransitionTo(DS_STOPPED);
        }
        else
        {
            FSM_TransitionTo(DS_TRIPPED);
        }
    }
    else
    {
        FSM_TransitionTo(DS_ESTOP);
    }
}


/* ==================== STOPPED ==================== */

static void FSM_HandleStopped(void)
{
    g_driveData.dutyCounts = 0;
    g_driveData.dutyPct = 0;
}


/* ==================== STARTING ==================== */

static void FSM_HandleStarting(void)
{
     if (!g_driveData.remote)
    {
        g_driveData.setpointRpm = ANALOG_GetSetpoint();
    }
    char txt[100];

    sprintf(
        txt,
        "RT=%u RR=%d MR=%d DIFF=%d CNT=%lu\r\n",
        (unsigned)RAMP_AtTarget(&g_ramp),
        g_driveData.rampedRpm,
        g_driveData.measuredRpm,
        ABS(
            g_driveData.measuredRpm -
            g_driveData.rampedRpm
        ),
        (unsigned long)g_fsm.atSpeedCounter
    );

    UART_SendString(txt);

    if (RAMP_AtTarget(&g_ramp) &&
        ABS(
            g_driveData.measuredRpm -
            g_driveData.rampedRpm
        ) <= 250)
    {
        if (g_fsm.atSpeedCounter < 20)
        {
            g_fsm.atSpeedCounter++;
        }
    }
    else
    {
        UART_SendString("RESET CNT\r\n");

        if (g_fsm.atSpeedCounter > 0)
        {
            g_fsm.atSpeedCounter--;
        }
    }

    if (g_fsm.atSpeedCounter >= 20)
    {
        UART_SendString("RUNNING\r\n");

        FSM_TransitionTo(DS_RUNNING);

        g_fsm.atSpeedCounter = 0;
    }
}


/* ==================== RUNNING ==================== */

static void FSM_HandleRunning(void)
{
    if (g_driveData.setpointRpm < g_driveCfg.minRpm)
    {
        FSM_RequestStop();
    }
}


/* ==================== RAMP DOWN ==================== */
static void FSM_HandleRampDown(void)
{
    /*
     * Ramp down is used for both:
     *  1. Normal STOP
     *  2. Direction reversal
     *
     * The tachometer may keep a residual RPM after the motor
     * has physically stopped, so we use a maximum timeout as
     * a safety fallback.
     */

    if (g_driveData.measuredRpm <= 0)
    {
        g_fsm.speedZeroCounter++;

        if (g_fsm.speedZeroCounter >= 3U)
        {
            g_fsm.speedZeroCounter = 0U;

            if (g_fsm.reversalPending)
            {
                FSM_TransitionTo(DS_DEAD_TIME);
            }
            else
            {
                FSM_TransitionTo(DS_COASTING);
            }

            return;
        }
    }
    else
    {
        g_fsm.speedZeroCounter = 0U;
    }

    /*
     * Fallback:
     * stateTimer is incremented every 100 ms.
     * After 2 seconds, do not remain stuck in RAMP_DOWN.
     */
    if (g_fsm.stateTimer >= 2000U)
    {
        g_fsm.speedZeroCounter = 0U;

        if (g_fsm.reversalPending)
        {
            FSM_TransitionTo(DS_DEAD_TIME);
        }
        else
        {
            FSM_TransitionTo(DS_COASTING);
        }
    }
}
/* ==================== DEAD TIME ==================== */

static void FSM_HandleDeadTime(void)
{
    /*
     * During DEAD_TIME:
     *  - Direction = STOP
     *  - Bridge disabled
     *  - Both direction outputs are LOW
     *
     * After the dead time, apply the new direction and
     * enter STARTING.
     */

    if (g_fsm.stateTimer >= g_fsm.deadTimeMs)
    {
        g_fsm.direction = g_fsm.pendingDirection;

        g_fsm.reversalPending = 0U;
        g_fsm.speedZeroCounter = 0U;
        g_fsm.atSpeedCounter = 0U;

        FSM_TransitionTo(DS_STARTING);
    }
}

/* ==================== COASTING ==================== */

static void FSM_HandleCoasting(void)
{
    if (g_fsm.stateTimer >= 500)
    {
        FSM_TransitionTo(DS_STOPPED);
    }
}


/* ==================== TRIPPED ==================== */

static void FSM_HandleTripped(void)
{
    if (PROTECT_GetActiveTrip() == TRIP_NONE)
    {
        g_driveData.activeTrip = TRIP_NONE;

        FSM_TransitionTo(DS_STOPPED);
    }
}


/* ==================== ESTOP ==================== */

static void FSM_HandleEStop(void)
{
    /*
     * Stay in E-Stop until the contact is closed
     * and reset is requested.
     *
     * Outputs are forced safe.
     */
}


/* ==================== TRANSITION ==================== */

static void FSM_TransitionTo(DriveState_t newState)
{
    DriveState_t oldState =
        g_fsm.currentState;

    /* ---------- Exit actions ---------- */

    switch (oldState)
    {
        case DS_RUNNING:

            g_driveData.totalRunSec +=
                g_driveData.runSeconds;

            g_driveData.runSeconds = 0;

            break;

        case DS_TRIPPED:
            break;

        default:
            break;
    }


    /* ---------- Update state ---------- */

    g_fsm.previousState =
        oldState;

    g_fsm.currentState =
        newState;

    g_fsm.stateTimer = 0;


    /* ---------- Entry actions ---------- */

    switch (newState)
    {
        case DS_STOPPED:

            g_driveData.direction =
                DIR_STOP;

            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;

            PI_Reset(&g_pi);
            RAMP_Reset(&g_ramp);

            break;


        case DS_STARTING:

            g_driveData.direction =
                g_fsm.direction;

            PI_Reset(&g_pi);
            RAMP_Reset(&g_ramp);

            g_driveData.startCount++;

            g_fsm.atSpeedCounter = 0;

            break;


        case DS_RUNNING:

            /* PI controller active */
            break;


        case DS_RAMP_DOWN:

            /*
             * Ramp target becomes zero.
             */
            RAMP_SetTarget(
                &g_ramp,
                0
            );

            break;


        case DS_DEAD_TIME:

            /*
             * Both direction outputs LOW.
             */
            g_driveData.direction =
                DIR_STOP;

            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;

            break;


        case DS_COASTING:

            g_driveData.direction =
                DIR_STOP;

            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;

            break;


        case DS_TRIPPED:

            g_driveData.direction =
                DIR_STOP;

            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;

            break;


        case DS_ESTOP:

            g_driveData.direction =
                DIR_STOP;

            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;

            break;


        default:
            break;
    }


    /* Update global state */
    g_driveData.state =
        newState;
}


/* ==================== PHYSICAL ACTIONS ==================== */

static void FSM_ExecuteActions(void)
{
    switch (g_fsm.currentState)
    {
        case DS_STARTING:

        case DS_RUNNING:

            /*
             * Direction must be established
             * before enabling the bridge.
             */
            BRIDGE_SetDirection(
                g_fsm.direction
            );

            BRIDGE_Enable();

            break;


        case DS_RAMP_DOWN:

            /*
             * Keep direction while ramping
             * down to zero.
             */
            BRIDGE_SetDirection(
                g_fsm.direction
            );

            BRIDGE_Enable();

            break;


        case DS_DEAD_TIME:

            /*
             * Safety dead time:
             *
             * direction = STOP
             * bridge disabled
             */
            BRIDGE_SetDirection(
                DIR_STOP
            );

            BRIDGE_Disable();

            break;


        case DS_COASTING:

        case DS_STOPPED:

        case DS_INIT:

            BRIDGE_SetDirection(
                DIR_STOP
            );

            BRIDGE_Disable();

            break;


        case DS_TRIPPED:

        case DS_ESTOP:

            BRIDGE_ForceStop();

            break;


        default:

            BRIDGE_ForceStop();

            break;
    }
}


/* ==================== PUBLIC FUNCTIONS ==================== */

DriveState_t FSM_GetState(void)
{
    return g_fsm.currentState;
}


const char* FSM_GetStateString(void)
{
    switch (g_fsm.currentState)
    {
        case DS_INIT:
            return "INIT";

        case DS_STOPPED:
            return "STOP";

        case DS_STARTING:
            return "STRT";

        case DS_RUNNING:
            return "RUN";

        case DS_RAMP_DOWN:
            return "RDWN";

        case DS_DEAD_TIME:
            return "DEAD";

        case DS_BRAKING:
            return "BRK";

        case DS_COASTING:
            return "COAST";

        case DS_TRIPPED:
            return "TRIP";

        case DS_ESTOP:
            return "ESTOP";

        default:
            return "UNKN";
    }
}


MotorDir_t FSM_GetDirection(void)
{
    return g_fsm.direction;
}


uint8_t FSM_IsRunning(void)
{
    return (
        g_fsm.currentState == DS_RUNNING ||
        g_fsm.currentState == DS_STARTING
    );
}


uint8_t FSM_IsTripped(void)
{
    return (
        g_fsm.currentState == DS_TRIPPED ||
        g_fsm.currentState == DS_ESTOP
    );
}


/* ==================== REQUEST START ==================== */

uint8_t FSM_RequestStart(void)
{
    char txt[80];

    sprintf(
        txt,
        "REMOTE=%d\r\n",
        g_driveData.remote
    );

    UART_SendString(txt);

    /*
     * In LOCAL mode read potentiometer.
     */
    if (!g_driveData.remote)
    {
        g_driveData.setpointRpm =
            ANALOG_GetSetpoint();
    }


    sprintf(
        txt,
        "START: STATE=%d SP=%d MIN=%d TRIP=%d\r\n",
        g_fsm.currentState,
        g_driveData.setpointRpm,
        g_driveCfg.minRpm,
        PROTECT_GetActiveTrip()
    );

    UART_SendString(txt);


    /*
     * START is accepted only from STOPPED.
     */
    if (g_fsm.currentState != DS_STOPPED)
    {
        UART_SendString(
            "FAIL STATE\r\n"
        );

        return 0;
    }


    /*
     * Speed must be above minimum.
     */
    if (g_driveData.setpointRpm <
        g_driveCfg.minRpm)
    {
        UART_SendString(
            "FAIL SPEED\r\n"
        );

        return 0;
    }


    UART_SendString(
        "START OK\r\n"
    );


    /*
     * Always start forward from STOP.
     */
    g_fsm.direction =
        DIR_FORWARD;

    g_fsm.pendingDirection =
        DIR_STOP;

    g_fsm.reversalPending = 0;

    FSM_TransitionTo(
        DS_STARTING
    );

    return 1;
}


/* ==================== REQUEST STOP ==================== */

uint8_t FSM_RequestStop(void)
{
    /*
     * Normal stop from RUNNING/STARTING.
     */
    if (g_fsm.currentState == DS_RUNNING ||
        g_fsm.currentState == DS_STARTING)
    {
        /*
         * Cancel any pending reverse.
         */
        g_fsm.reversalPending = 0;
        g_fsm.pendingDirection = DIR_STOP;

        /*
         * Ramp motor down to zero.
         */
        FSM_TransitionTo(
            DS_RAMP_DOWN
        );

        return 1;
    }


    /*
     * If already in ramp-down,
     * force a safe stop.
     */
    if (g_fsm.currentState ==
        DS_RAMP_DOWN)
    {
        g_driveData.dutyCounts = 0;
        g_driveData.dutyPct = 0;

        BRIDGE_ForceStop();

        FSM_TransitionTo(
            DS_STOPPED
        );

        return 1;
    }


    /*
     * If waiting in dead time or coasting,
     * force STOP immediately.
     */
    if (g_fsm.currentState ==
            DS_DEAD_TIME ||
        g_fsm.currentState ==
            DS_COASTING)
    {
        g_driveData.dutyCounts = 0;
        g_driveData.dutyPct = 0;

        BRIDGE_ForceStop();

        FSM_TransitionTo(
            DS_STOPPED
        );

        return 1;
    }


    /*
     * Already stopped.
     */
    if (g_fsm.currentState ==
        DS_STOPPED)
    {
        g_driveData.dutyCounts = 0;
        g_driveData.dutyPct = 0;

        BRIDGE_ForceStop();

        return 1;
    }


    return 0;
}


/* ==================== REQUEST REVERSE ==================== */
uint8_t FSM_RequestReverse(void)
{
    /* Reverse is allowed only while the motor is actually active */
    if (g_fsm.currentState != DS_RUNNING &&
        g_fsm.currentState != DS_STARTING)
    {
        return 0;
    }

    /* Do not accept another reversal while one is already pending */
    if (g_fsm.reversalPending)
    {
        return 0;
    }

    /* Determine the new direction */
    if (g_fsm.direction == DIR_FORWARD)
    {
        g_fsm.pendingDirection = DIR_REVERSE;
    }
    else if (g_fsm.direction == DIR_REVERSE)
    {
        g_fsm.pendingDirection = DIR_FORWARD;
    }
    else
    {
        /* Safety: if current direction is STOP, start forward */
        g_fsm.pendingDirection = DIR_FORWARD;
    }

    /* Mark reversal as pending */
    g_fsm.reversalPending = 1;

    /*
     * Ramp the motor down to zero first.
     * FSM_HandleRampDown() will wait until RPM reaches zero,
     * then enter DEAD_TIME before applying the new direction.
     */
    FSM_TransitionTo(DS_RAMP_DOWN);

    return 1;
}
/* ==================== REQUEST RESET ==================== */

uint8_t FSM_RequestReset(void)
{
    char txt[80];

    sprintf(
        txt,
        "RESET: STATE=%d ACTIVE=%d ESTOP=%d\r\n",
        g_fsm.currentState,
        PROTECT_GetActiveTrip(),
        g_driveData.estopRaw
    );

    UART_SendString(txt);


    /* ---------- TRIPPED ---------- */

    if (g_fsm.currentState ==
        DS_TRIPPED)
    {
        Trip_t activeTrip =
            PROTECT_GetActiveTrip();

        if (activeTrip ==
            TRIP_NONE)
        {
            UART_SendString(
                "RESET->STOPPED\r\n"
            );

            g_fsm.tripPending = 0;

            PROTECT_Reset();

            FSM_TransitionTo(
                DS_STOPPED
            );

            return 1;
        }


        UART_SendString(
            "RESET FAIL ACTIVE TRIP\r\n"
        );

        return 0;
    }


    /* ---------- ESTOP ---------- */

    if (g_fsm.currentState ==
        DS_ESTOP)
    {
        if (!g_driveData.estopRaw)
        {
            UART_SendString(
                "RESET ESTOP->STOPPED\r\n"
            );

            FSM_TransitionTo(
                DS_STOPPED
            );

            return 1;
        }


        UART_SendString(
            "RESET FAIL ESTOP\r\n"
        );

        return 0;
    }


    UART_SendString(
        "RESET FAIL STATE\r\n"
    );

    return 0;
}


/* ==================== EMERGENCY STOP ==================== */

uint8_t FSM_RequestEmergencyStop(void)
{
    if (g_fsm.currentState !=
        DS_ESTOP)
    {
        g_fsm.estopActive = 1;

        FSM_TransitionTo(
            DS_ESTOP
        );

        return 1;
    }

    return 0;
}


/* ==================== REQUEST TRIP ==================== */

uint8_t FSM_RequestTrip(Trip_t trip)
{
    if (g_fsm.currentState !=
        DS_TRIPPED)
    {
        g_fsm.tripPending = 1;

        g_driveData.activeTrip =
            trip;

        FSM_TransitionTo(
            DS_TRIPPED
        );

        return 1;
    }

    return 0;
}


/* ==================== DEAD TIME ==================== */

void FSM_SetDeadTime(uint32_t ms)
{
    g_fsm.deadTimeMs = ms;
}


/* ==================== STATE TIME ==================== */

uint32_t FSM_GetStateTime(void)
{
    return g_fsm.stateTimer;
}