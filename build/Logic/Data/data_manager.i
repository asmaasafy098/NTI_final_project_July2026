# 1 "Logic/Data/data_manager.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Logic/Data/data_manager.c"





# 1 "Logic/Data/data_manager.h" 1
# 9 "Logic/Data/data_manager.h"
# 1 "Service/STD_Types.h" 1



# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
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
# 10 "Logic/Data/data_manager.h" 2
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
# 152 "Logic/Data/data_types.h"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 11 "Logic/Data/data_manager.h" 2
# 19 "Logic/Data/data_manager.h"
void DataManager_Init(DriveData_t* data, DriveCfg_t* cfg);




void DataManager_Update(void);





DriveData_t* DataManager_GetData(void);





DriveCfg_t* DataManager_GetConfig(void);
# 45 "Logic/Data/data_manager.h"
void DataManager_UpdateSensors(int16_t rpm, uint16_t current,
                                uint16_t voltage, uint8_t temp);





void DataManager_UpdateSetpoint(int16_t setpoint);





void DataManager_UpdateDuty(uint16_t duty);




void DataManager_UpdateError(void);




void DataManager_IncrementRunSeconds(void);




void DataManager_Persist(void);
# 7 "Logic/Data/data_manager.c" 2
# 1 "Service/util_math.h" 1
# 9 "Service/util_math.h"
# 1 "Service/STD_Types.h" 1
# 10 "Service/util_math.h" 2
# 22 "Service/util_math.h"
static inline int16_t Util_Map(int16_t x, int16_t in_min, int16_t in_max,
                                int16_t out_min, int16_t out_max) {
    return (int16_t)(((int32_t)(x - in_min) * (out_max - out_min)) / (in_max - in_min) + out_min);
}
# 34 "Service/util_math.h"
static inline int16_t Util_Clamp(int16_t value, int16_t min, int16_t max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}
# 47 "Service/util_math.h"
static inline uint8_t Util_IsInRange(int16_t value, int16_t min, int16_t max) {
    return (value >= min && value <= max);
}
# 58 "Service/util_math.h"
static inline int16_t Util_Deadband(int16_t value, int16_t lastValue, int16_t threshold) {
    int16_t diff = value - lastValue;
    if (((diff) < 0 ? -(diff) : (diff)) < threshold) {
        return lastValue;
    }
    return value;
}
# 8 "Logic/Data/data_manager.c" 2


static DriveData_t* g_data;
static DriveCfg_t* g_cfg;
static uint32_t g_persistCounter = 0;



void DataManager_Init(DriveData_t* data, DriveCfg_t* cfg) {
    g_data = data;
    g_cfg = cfg;


    g_data->setpointRpm = 0;
    g_data->rampedRpm = 0;
    g_data->measuredRpm = 0;
    g_data->errorRpm = 0;
    g_data->dutyCounts = 0;
    g_data->dutyPct = 0;
    g_data->currentmA = 0;
    g_data->busmV = 0;
    g_data->tempC = 0;
    g_data->i2tAccum = 0;
    g_data->direction = DIR_STOP;
    g_data->state = DS_INIT;
    g_data->activeTrip = TRIP_NONE;
    g_data->remote = 0;
    g_data->estopRaw = 0;
    g_data->atSetpoint = 0;
    g_data->runSeconds = 0;
    g_data->totalRunSec = 0;
    g_data->startCount = 0;
    g_data->upTimeSec = 0;
}

DriveData_t* DataManager_GetData(void) {
    return g_data;
}

DriveCfg_t* DataManager_GetConfig(void) {
    return g_cfg;
}

void DataManager_UpdateSensors(int16_t rpm, uint16_t current,
                                uint16_t voltage, uint8_t temp) {
    g_data->measuredRpm = rpm;
    g_data->currentmA = current;
    g_data->busmV = voltage;
    g_data->tempC = temp;
}

void DataManager_UpdateSetpoint(int16_t setpoint) {
    g_data->setpointRpm = Util_Clamp(setpoint, 0, g_cfg->maxRpm);
}

void DataManager_UpdateDuty(uint16_t duty) {
    g_data->dutyCounts = Util_Clamp(duty, 0, 399);
    g_data->dutyPct = (uint8_t)((g_data->dutyCounts * 100) / 399);
}

void DataManager_UpdateError(void) {
    g_data->errorRpm = g_data->rampedRpm - g_data->measuredRpm;
}

void DataManager_IncrementRunSeconds(void) {
    g_data->runSeconds++;
    g_data->totalRunSec++;
}

void DataManager_Persist(void) {
    g_persistCounter++;


    if (g_persistCounter >= 300) {
        g_persistCounter = 0;
        g_cfg->totalRunSec = g_data->totalRunSec;
        g_cfg->startCount = g_data->startCount;


    }
}
