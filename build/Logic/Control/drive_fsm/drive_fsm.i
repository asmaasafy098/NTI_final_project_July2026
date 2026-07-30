# 1 "Logic/Control/drive_fsm/drive_fsm.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Logic/Control/drive_fsm/drive_fsm.c"





# 1 "Logic/Control/drive_fsm/drive_fsm.h" 1
# 9 "Logic/Control/drive_fsm/drive_fsm.h"
# 1 "Service/STD_Types.h" 1



# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 5 "Service/STD_Types.h" 2



# 7 "Service/STD_Types.h"
typedef int8_t sint8_t;
typedef int16_t sint16_t;
typedef int32_t sint32_t;
typedef int64_t sint64_t;

typedef sint8_t sint8;
typedef sint16_t sint16;
typedef sint32_t sint32;
typedef sint64_t sint64;

typedef int8_t s8;
typedef int16_t s16;
typedef int32_t s32;
typedef int64_t s64;


typedef uint8_t uint8;
typedef uint16_t uint16;
typedef uint32_t uint32;
typedef uint64_t uint64;


typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;


typedef float float32_t;
typedef double float64_t;
typedef float f32;
typedef double f64;


typedef enum {
    FALSE = 0,
    TRUE = 1
} bool_t;
# 55 "Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 10 "Logic/Control/drive_fsm/drive_fsm.h" 2
# 1 "Logic/Data/data_types.h" 1
# 14 "Logic/Data/data_types.h"
typedef enum {
    DS_INIT = 0,
    DS_STOPPED,
    DS_STARTING,
    DS_RUNNING,
    DS_RAMP_DOWN,
    DS_DEAD_TIME,
    DS_BRAKING,
    DS_COASTING,
    DS_TRIPPED,
    DS_ESTOP
} DriveState_t;


typedef enum {
    DIR_STOP = 0,
    DIR_FORWARD = 1,
    DIR_REVERSE = 2
} MotorDir_t;


typedef enum {
    TRIP_NONE = 0,
    TRIP_ESTOP = 1,
    TRIP_SHORT = 2,
    TRIP_OVERLOAD = 3,
    TRIP_OVERTEMP = 4,
    TRIP_UNDERVOLT = 5,
    TRIP_OVERVOLT = 6,
    TRIP_STALL = 7,
    TRIP_OVERSPEED = 8,
    TRIP_NOFEEDBACK = 9
} Trip_t;


typedef enum {
    EVENT_NONE = 0,
    EVENT_START_PRESSED,
    EVENT_START_RELEASED,
    EVENT_STOP_PRESSED,
    EVENT_REVERSE_PRESSED,
    EVENT_RESET_PRESSED,
    EVENT_RESET_HELD
} PanelEvent_t;


typedef enum {
    FSM_EVENT_NONE = 0,
    FSM_EVENT_START,
    FSM_EVENT_STOP,
    FSM_EVENT_REVERSE,
    FSM_EVENT_RESET,
    FSM_EVENT_ESTOP,
    FSM_EVENT_TRIP,
    FSM_EVENT_AT_SPEED,
    FSM_EVENT_SPEED_ZERO,
    FSM_EVENT_DEAD_TIME_DONE,
    FSM_EVENT_ACKNOWLEDGE
} FSM_Event_t;




typedef struct {
    int16_t setpointRpm;
    int16_t rampedRpm;
    int16_t measuredRpm;
    int16_t errorRpm;
    uint16_t dutyCounts;
    uint8_t dutyPct;
    uint16_t currentmA;
    uint16_t busmV;
    uint8_t tempC;
    uint32_t i2tAccum;
    MotorDir_t direction;
    DriveState_t state;
    Trip_t activeTrip;
    uint8_t remote : 1;
    uint8_t estopRaw : 1;
    uint8_t atSetpoint : 1;
    uint8_t reserved : 5;
    uint32_t runSeconds;
    uint32_t totalRunSec;
    uint16_t startCount;
    uint32_t upTimeSec;
} DriveData_t;


typedef struct {
    uint16_t magic;
    uint8_t version;
    uint16_t maxRpm;
    uint16_t minRpm;
    uint16_t accelRpmPerSec;
    uint16_t decelRpmPerSec;
    uint16_t deadTimeMs;
    int16_t kp;
    int16_t ki;
    uint16_t ratedCurrentmA;
    uint16_t shortTripmA;
    uint8_t overTempC;
    uint16_t underVoltmV;
    uint16_t overVoltmV;
    uint16_t stallSec;
    uint32_t totalRunSec;
    uint16_t startCount;
    uint8_t tripHead;
    Trip_t latchedTrip;
    uint8_t checksum;
} DriveCfg_t;


typedef struct {
    Trip_t trip;
    uint32_t timeSec;
    int16_t rpm;
    uint16_t currentmA;
    uint16_t busmV;
    uint8_t tempC;
    uint8_t dutyPct;
} TripRec_t;
# 153 "Logic/Data/data_types.h"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 11 "Logic/Control/drive_fsm/drive_fsm.h" 2


typedef struct {
    DriveState_t currentState;
    DriveState_t previousState;
    DriveState_t nextState;
    MotorDir_t direction;
    MotorDir_t pendingDirection;
    uint8_t reversalPending;
    uint8_t tripPending;
    uint8_t estopActive;
    uint32_t stateTimer;
    uint32_t deadTimeMs;
    uint32_t atSpeedCounter;
    uint32_t speedZeroCounter;
    uint8_t initialized;
} FSM_Data_t;






void FSM_Init(void);




void FSM_Run(void);





void FSM_ProcessEvent(FSM_Event_t event);





DriveState_t FSM_GetState(void);





const char* FSM_GetStateString(void);





MotorDir_t FSM_GetDirection(void);





uint8_t FSM_IsRunning(void);





uint8_t FSM_IsTripped(void);





uint8_t FSM_RequestStart(void);





uint8_t FSM_RequestStop(void);





uint8_t FSM_RequestReverse(void);





uint8_t FSM_RequestReset(void);





uint8_t FSM_RequestEmergencyStop(void);






uint8_t FSM_RequestTrip(Trip_t trip);





void FSM_SetDeadTime(uint32_t ms);





uint32_t FSM_GetStateTime(void);
# 7 "Logic/Control/drive_fsm/drive_fsm.c" 2
# 1 "Logic/Control/drive_fsm/../pi_controller/pi_controller.h" 1
# 13 "Logic/Control/drive_fsm/../pi_controller/pi_controller.h"
typedef struct {
    int16_t kp;
    int16_t ki;
    int32_t integral;
    int16_t outMin;
    int16_t outMax;
    int16_t lastError;
    int16_t lastOutput;
    uint8_t antiWindupActive;
} PI_Handle_t;
# 32 "Logic/Control/drive_fsm/../pi_controller/pi_controller.h"
void PI_Init(PI_Handle_t* pi, int16_t kp, int16_t ki);







void PI_InitLimits(PI_Handle_t* pi, int16_t outMin, int16_t outMax);
# 49 "Logic/Control/drive_fsm/../pi_controller/pi_controller.h"
int16_t PI_Step(PI_Handle_t* pi, int16_t setpoint, int16_t measured);





void PI_Reset(PI_Handle_t* pi);







void PI_SetGains(PI_Handle_t* pi, int16_t kp, int16_t ki);






int32_t PI_GetIntegral(const PI_Handle_t* pi);






int16_t PI_GetError(const PI_Handle_t* pi);
# 8 "Logic/Control/drive_fsm/drive_fsm.c" 2
# 1 "Logic/Control/drive_fsm/../ramp_generator/ramp_generator.h" 1
# 12 "Logic/Control/drive_fsm/../ramp_generator/ramp_generator.h"
typedef struct {
    int16_t target;
    int16_t current;
    int16_t output;
    uint16_t accelRate;
    uint16_t decelRate;
    uint16_t minRpm;
    uint16_t maxRpm;
    uint8_t atTarget;
} Ramp_t;







void RAMP_Init(Ramp_t* ramp);






void RAMP_SetTarget(Ramp_t* ramp, int16_t target);







void RAMP_SetLimits(Ramp_t* ramp, int16_t minRpm, int16_t maxRpm);







void RAMP_SetRates(Ramp_t* ramp, uint16_t accel, uint16_t decel);






int16_t RAMP_Step(Ramp_t* ramp);






int16_t RAMP_GetOutput(const Ramp_t* ramp);






uint8_t RAMP_AtTarget(const Ramp_t* ramp);





void RAMP_Reset(Ramp_t* ramp);






uint16_t RAMP_GetTimeToTarget(const Ramp_t* ramp);
# 9 "Logic/Control/drive_fsm/drive_fsm.c" 2
# 1 "Logic/Control/drive_fsm/../protection/protection.h" 1
# 13 "Logic/Control/drive_fsm/../protection/protection.h"
typedef struct {
    Trip_t activeTrip;
    Trip_t latchedTrip;
    uint8_t tripped;
    uint8_t latched;
    uint32_t i2tAccum;
    uint16_t i2tLimit;
    uint8_t tempCounter;
    uint8_t underVoltCounter;
    uint8_t overVoltCounter;
    uint8_t stallCounter;
    uint8_t overspeedCounter;
    uint8_t noFeedbackCounter;
} ProtectionData_t;






void PROTECT_Init(void);







Trip_t PROTECT_Evaluate(const DriveData_t* data, const DriveCfg_t* cfg);






void PROTECT_UpdateI2T(uint16_t current, uint16_t rated);




void PROTECT_Reset(void);





void PROTECT_ResetTrip(Trip_t trip);





uint8_t PROTECT_IsTripped(void);





Trip_t PROTECT_GetActiveTrip(void);





Trip_t PROTECT_GetLatchedTrip(void);





uint8_t PROTECT_GetI2TPercent(void);






const char* PROTECT_GetTripString(Trip_t trip);
# 10 "Logic/Control/drive_fsm/drive_fsm.c" 2
# 1 "Logic/Control/drive_fsm/../../Data/data_manager.h" 1
# 10 "Logic/Control/drive_fsm/../../Data/data_manager.h"
# 1 "Logic/Control/drive_fsm/../../Data/data_types.h" 1
# 11 "Logic/Control/drive_fsm/../../Data/data_manager.h" 2
# 19 "Logic/Control/drive_fsm/../../Data/data_manager.h"
void DataManager_Init(DriveData_t* data, DriveCfg_t* cfg);




void DataManager_Update(void);





DriveData_t* DataManager_GetData(void);





DriveCfg_t* DataManager_GetConfig(void);
# 45 "Logic/Control/drive_fsm/../../Data/data_manager.h"
void DataManager_UpdateSensors(int16_t rpm, uint16_t current,
                                uint16_t voltage, uint8_t temp);





void DataManager_UpdateSetpoint(int16_t setpoint);





void DataManager_UpdateDuty(uint16_t duty);




void DataManager_UpdateError(void);




void DataManager_IncrementRunSeconds(void);




void DataManager_Persist(void);
# 11 "Logic/Control/drive_fsm/drive_fsm.c" 2
# 1 "Logic/Control/drive_fsm/../../../Service/util_math.h" 1
# 9 "Logic/Control/drive_fsm/../../../Service/util_math.h"
# 1 "Logic/Control/drive_fsm/../../../Service/STD_Types.h" 1
# 10 "Logic/Control/drive_fsm/../../../Service/util_math.h" 2
# 22 "Logic/Control/drive_fsm/../../../Service/util_math.h"
static inline int16_t Util_Map(int16_t x, int16_t in_min, int16_t in_max,
                                int16_t out_min, int16_t out_max) {
    return (int16_t)(((int32_t)(x - in_min) * (out_max - out_min)) / (in_max - in_min) + out_min);
}
# 34 "Logic/Control/drive_fsm/../../../Service/util_math.h"
static inline int16_t Util_Clamp(int16_t value, int16_t min, int16_t max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}
# 47 "Logic/Control/drive_fsm/../../../Service/util_math.h"
static inline uint8_t Util_IsInRange(int16_t value, int16_t min, int16_t max) {
    return (value >= min && value <= max);
}
# 58 "Logic/Control/drive_fsm/../../../Service/util_math.h"
static inline int16_t Util_Deadband(int16_t value, int16_t lastValue, int16_t threshold) {
    int16_t diff = value - lastValue;
    if (((diff) < 0 ? -(diff) : (diff)) < threshold) {
        return lastValue;
    }
    return value;
}
# 12 "Logic/Control/drive_fsm/drive_fsm.c" 2


extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
extern PI_Handle_t g_pi;
extern Ramp_t g_ramp;


static FSM_Data_t g_fsm;


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


    g_fsm.stateTimer += 10;


    if (g_driveData.estopRaw && g_fsm.currentState != DS_ESTOP) {
        FSM_RequestEmergencyStop();
        return;
    }


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



static void FSM_HandleInit(void) {

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

    g_driveData.dutyCounts = 0;
    g_driveData.dutyPct = 0;
}

static void FSM_HandleStarting(void) {

    if (RAMP_AtTarget(&g_ramp) &&
        ((g_driveData.measuredRpm - g_driveData.rampedRpm) < 0 ? -(g_driveData.measuredRpm - g_driveData.rampedRpm) : (g_driveData.measuredRpm - g_driveData.rampedRpm)) <= 100) {
        g_fsm.atSpeedCounter++;
        if (g_fsm.atSpeedCounter >= 10) {
            FSM_TransitionTo(DS_RUNNING);
            g_fsm.atSpeedCounter = 0;
        }
    } else {
        g_fsm.atSpeedCounter = 0;
    }
}

static void FSM_HandleRunning(void) {


    if (g_driveData.setpointRpm < g_driveCfg.minRpm) {
        FSM_RequestStop();
    }
}

static void FSM_HandleRampDown(void) {

    if (g_driveData.measuredRpm <= 0) {
        g_fsm.speedZeroCounter++;
        if (g_fsm.speedZeroCounter >= 3) {
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

    if (g_fsm.stateTimer >= g_fsm.deadTimeMs) {

        g_fsm.direction = g_fsm.pendingDirection;
        g_fsm.reversalPending = 0;
        FSM_TransitionTo(DS_STARTING);
    }
}

static void FSM_HandleCoasting(void) {

    if (g_fsm.stateTimer >= 500) {
        FSM_TransitionTo(DS_STOPPED);
    }
}

static void FSM_HandleTripped(void) {


}

static void FSM_HandleEStop(void) {


}



static void FSM_TransitionTo(DriveState_t newState) {
    DriveState_t oldState = g_fsm.currentState;


    switch (oldState) {
        case DS_RUNNING:

            g_driveData.totalRunSec += g_driveData.runSeconds;
            g_driveData.runSeconds = 0;
            break;
        case DS_TRIPPED:

            break;
        default:
            break;
    }


    g_fsm.previousState = oldState;
    g_fsm.currentState = newState;
    g_fsm.stateTimer = 0;


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

            break;

        case DS_RAMP_DOWN:
            RAMP_SetTarget(&g_ramp, 0);
            break;

        case DS_DEAD_TIME:

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


    g_driveData.state = newState;
}



DriveState_t FSM_GetState(void) {
    return g_fsm.currentState;
}

const char* FSM_GetStateString(void) {
    switch (g_fsm.currentState) {
        case DS_INIT: return "INIT";
        case DS_STOPPED: return "STOP";
        case DS_STARTING: return "STRT";
        case DS_RUNNING: return "RUN";
        case DS_RAMP_DOWN: return "RDWN";
        case DS_DEAD_TIME: return "DEAD";
        case DS_BRAKING: return "BRK";
        case DS_COASTING: return "COAST";
        case DS_TRIPPED: return "TRIP";
        case DS_ESTOP: return "ESTOP";
        default: return "UNKN";
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
        return 0;
    }

    if (g_fsm.currentState == DS_TRIPPED || g_fsm.currentState == DS_ESTOP) {
        return 0;
    }

    if (g_driveData.setpointRpm < g_driveCfg.minRpm) {
        return 0;
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
        return 0;
    }

    if (g_fsm.reversalPending) {
        return 0;
    }


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

        Trip_t activeTrip = PROTECT_GetActiveTrip();
        if (activeTrip == TRIP_NONE) {
            g_fsm.tripPending = 0;
            FSM_TransitionTo(DS_STOPPED);
            return 1;
        }
        return 0;
    }

    if (g_fsm.currentState == DS_ESTOP) {

        if (!g_driveData.estopRaw) {
            FSM_TransitionTo(DS_STOPPED);
            return 1;
        }
        return 0;
    }

    return 0;
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
