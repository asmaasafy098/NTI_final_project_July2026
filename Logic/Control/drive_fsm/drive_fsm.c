/*
 * drive_fsm.c
 * Drive State Machine Implementation
 */

#include "drive_fsm.h"
#include "../pi_controller/pi_controller.h"
#include "../ramp_generator/ramp_generator.h"
#include "../protection/protection.h"
#include "../../Data/data_manager.h"
#include "../../../Service/util_math.h"

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

void FSM_Init(void) {
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

void FSM_Run(void) {
    if (!g_fsm.initialized) {
        FSM_Init();
        return;
    }
    
    /* Update state timer (called every 10ms) */
    g_fsm.stateTimer += 10;
    
    /* Check E-Stop first (highest priority) */
    if (g_driveData.estopRaw && g_fsm.currentState != DS_ESTOP) {
        FSM_RequestEmergencyStop();
        return;
    }
    
    /* Execute state handler */
    switch (g_fsm.currentState) {
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
}

/* ==================== State Handlers ==================== */

static void FSM_HandleInit(void) {
    /* Check if E-Stop is closed and no latched trip */
    if (!g_driveData.estopRaw) {
        if (g_driveCfg.latchedTrip == TRIP_NONE) {
            FSM_TransitionTo(DS_STOPPED);
        } else {
            FSM_TransitionTo(DS_TRIPPED);
        }
    } else {
        FSM_TransitionTo(DS_ESTOP);
    }
}

static void FSM_HandleStopped(void) {
    /* Nothing to do in stopped state */
    g_driveData.dutyCounts = 0;
    g_driveData.dutyPct = 0;
}

static void FSM_HandleStarting(void) {
    /* Check if at setpoint */
    if (RAMP_AtTarget(&g_ramp) && 
        ABS(g_driveData.measuredRpm - g_driveData.rampedRpm) <= 100) {
        g_fsm.atSpeedCounter++;
        if (g_fsm.atSpeedCounter >= 10) {  /* 1 second */
            FSM_TransitionTo(DS_RUNNING);
            g_fsm.atSpeedCounter = 0;
        }
    } else {
        g_fsm.atSpeedCounter = 0;
    }
}

static void FSM_HandleRunning(void) {
    /* Normal running - PI controller handles speed */
    /* Check if setpoint below minRpm */
    if (g_driveData.setpointRpm < g_driveCfg.minRpm) {
        FSM_RequestStop();
    }
}

static void FSM_HandleRampDown(void) {
    /* Wait for speed to reach zero */
    if (g_driveData.measuredRpm <= 0) {
        g_fsm.speedZeroCounter++;
        if (g_fsm.speedZeroCounter >= 3) {  /* 30ms confirmation */
            if (g_fsm.reversalPending) {
                FSM_TransitionTo(DS_DEAD_TIME);
            } else {
                FSM_TransitionTo(DS_COASTING);
            }
            g_fsm.speedZeroCounter = 0;
        }
    } else {
        g_fsm.speedZeroCounter = 0;
    }
}

static void FSM_HandleDeadTime(void) {
    /* Wait for dead time to expire */
    if (g_fsm.stateTimer >= g_fsm.deadTimeMs) {
        /* Transition to starting with new direction */
        g_fsm.direction = g_fsm.pendingDirection;
        g_fsm.reversalPending = 0;
        FSM_TransitionTo(DS_STARTING);
    }
}

static void FSM_HandleCoasting(void) {
    /* Wait for 500ms then go to stopped */
    if (g_fsm.stateTimer >= 500) {
        FSM_TransitionTo(DS_STOPPED);
    }
}

static void FSM_HandleTripped(void) {
    /* Stay in tripped state until acknowledged */
    /* Buzzer and fault LED are handled externally */
}

static void FSM_HandleEStop(void) {
    /* Stay in E-Stop until contact closed and reset pressed */
    /* All outputs are forced safe */
}

/* ==================== Transition Functions ==================== */

static void FSM_TransitionTo(DriveState_t newState) {
    DriveState_t oldState = g_fsm.currentState;
    
    /* Execute exit actions for old state */
    switch (oldState) {
        case DS_RUNNING:
            /* Save run time */
            g_driveData.totalRunSec += g_driveData.runSeconds;
            g_driveData.runSeconds = 0;
            break;
        case DS_TRIPPED:
            /* Trip handled elsewhere */
            break;
        default:
            break;
    }
    
    /* Update state */
    g_fsm.previousState = oldState;
    g_fsm.currentState = newState;
    g_fsm.stateTimer = 0;
    
    /* Execute entry actions for new state */
    switch (newState) {
        case DS_STOPPED:
            g_driveData.direction = DIR_STOP;
            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;
            PI_Reset(&g_pi);
            RAMP_Reset(&g_ramp);
            break;
            
        case DS_STARTING:
            g_driveData.direction = g_fsm.direction;
            PI_Reset(&g_pi);
            RAMP_Reset(&g_ramp);
            g_driveData.startCount++;
            g_fsm.atSpeedCounter = 0;
            break;
            
        case DS_RUNNING:
            /* Running state - PI is active */
            break;
            
        case DS_RAMP_DOWN:
            RAMP_SetTarget(&g_ramp, 0);
            break;
            
        case DS_DEAD_TIME:
            /* Both direction pins LOW */
            g_driveData.direction = DIR_STOP;
            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;
            break;
            
        case DS_COASTING:
            g_driveData.direction = DIR_STOP;
            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;
            break;
            
        case DS_TRIPPED:
            g_driveData.direction = DIR_STOP;
            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;
            break;
            
        case DS_ESTOP:
            g_driveData.direction = DIR_STOP;
            g_driveData.dutyCounts = 0;
            g_driveData.dutyPct = 0;
            break;
            
        default:
            break;
    }
    
    /* Update global state */
    g_driveData.state = newState;
}

/* ==================== Public Functions ==================== */

DriveState_t FSM_GetState(void) {
    return g_fsm.currentState;
}

const char* FSM_GetStateString(void) {
    switch (g_fsm.currentState) {
        case DS_INIT:       return "INIT";
        case DS_STOPPED:    return "STOP";
        case DS_STARTING:   return "STRT";
        case DS_RUNNING:    return "RUN";
        case DS_RAMP_DOWN:  return "RDWN";
        case DS_DEAD_TIME:  return "DEAD";
        case DS_BRAKING:    return "BRK";
        case DS_COASTING:   return "COAST";
        case DS_TRIPPED:    return "TRIP";
        case DS_ESTOP:      return "ESTOP";
        default:            return "UNKN";
    }
}

MotorDir_t FSM_GetDirection(void) {
    return g_fsm.direction;
}

uint8_t FSM_IsRunning(void) {
    return (g_fsm.currentState == DS_RUNNING || 
            g_fsm.currentState == DS_STARTING);
}

uint8_t FSM_IsTripped(void) {
    return (g_fsm.currentState == DS_TRIPPED || 
            g_fsm.currentState == DS_ESTOP);
}

uint8_t FSM_RequestStart(void) {
    if (g_fsm.currentState != DS_STOPPED) {
        return 0;  /* Not in stopped state */
    }
    
    if (g_fsm.currentState == DS_TRIPPED || g_fsm.currentState == DS_ESTOP) {
        return 0;  /* Tripped */
    }
    
    if (g_driveData.setpointRpm < g_driveCfg.minRpm) {
        return 0;  /* Setpoint below minRpm */
    }
    
    g_fsm.direction = DIR_FORWARD;
    FSM_TransitionTo(DS_STARTING);
    return 1;
}

uint8_t FSM_RequestStop(void) {
    if (g_fsm.currentState == DS_RUNNING || g_fsm.currentState == DS_STARTING) {
        FSM_TransitionTo(DS_RAMP_DOWN);
        return 1;
    }
    return 0;
}

uint8_t FSM_RequestReverse(void) {
    if (g_fsm.currentState != DS_RUNNING) {
        return 0;  /* Not running */
    }
    
    if (g_fsm.reversalPending) {
        return 0;  /* Reversal already pending */
    }
    
    /* Determine new direction */
    if (g_fsm.direction == DIR_FORWARD) {
        g_fsm.pendingDirection = DIR_REVERSE;
    } else {
        g_fsm.pendingDirection = DIR_FORWARD;
    }
    
    g_fsm.reversalPending = 1;
    FSM_TransitionTo(DS_RAMP_DOWN);
    return 1;
}

uint8_t FSM_RequestReset(void) {
    if (g_fsm.currentState == DS_TRIPPED) {
        /* Check if cause is cleared */
        Trip_t activeTrip = PROTECT_GetActiveTrip();
        if (activeTrip == TRIP_NONE) {
            g_fsm.tripPending = 0;
            FSM_TransitionTo(DS_STOPPED);
            return 1;
        }
        return 0;  /* Cause still active */
    }
    
    if (g_fsm.currentState == DS_ESTOP) {
        /* Check if E-Stop contact is closed */
        if (!g_driveData.estopRaw) {
            FSM_TransitionTo(DS_STOPPED);
            return 1;
        }
        return 0;  /* E-Stop still open */
    }
    
    return 0;  /* Not in tripped state */
}

uint8_t FSM_RequestEmergencyStop(void) {
    if (g_fsm.currentState != DS_ESTOP) {
        g_fsm.estopActive = 1;
        FSM_TransitionTo(DS_ESTOP);
        return 1;
    }
    return 0;
}

uint8_t FSM_RequestTrip(Trip_t trip) {
    if (g_fsm.currentState != DS_TRIPPED) {
        g_fsm.tripPending = 1;
        g_driveData.activeTrip = trip;
        FSM_TransitionTo(DS_TRIPPED);
        return 1;
    }
    return 0;
}

void FSM_SetDeadTime(uint32_t ms) {
    g_fsm.deadTimeMs = ms;
}

uint32_t FSM_GetStateTime(void) {
    return g_fsm.stateTimer;
}