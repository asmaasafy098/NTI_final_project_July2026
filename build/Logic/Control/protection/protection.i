# 1 "Logic/Control/protection/protection.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Logic/Control/protection/protection.c"





# 1 "Logic/Control/protection/protection.h" 1
# 9 "Logic/Control/protection/protection.h"
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
# 10 "Logic/Control/protection/protection.h" 2
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
# 11 "Logic/Control/protection/protection.h" 2


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
# 7 "Logic/Control/protection/protection.c" 2
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
# 8 "Logic/Control/protection/protection.c" 2

static ProtectionData_t g_protect;



void PROTECT_Init(void) {
    g_protect.activeTrip = TRIP_NONE;
    g_protect.latchedTrip = TRIP_NONE;
    g_protect.tripped = 0;
    g_protect.latched = 0;
    g_protect.i2tAccum = 0;
    g_protect.i2tLimit = 3600000;
    g_protect.tempCounter = 0;
    g_protect.underVoltCounter = 0;
    g_protect.overVoltCounter = 0;
    g_protect.stallCounter = 0;
    g_protect.overspeedCounter = 0;
    g_protect.noFeedbackCounter = 0;
}

Trip_t PROTECT_Evaluate(const DriveData_t* data, const DriveCfg_t* cfg) {
    Trip_t trip = TRIP_NONE;


    if (data->estopRaw) {
        trip = TRIP_ESTOP;
        goto TRIP_ACTIVE;
    }


    if (data->currentmA >= cfg->shortTripmA) {
        trip = TRIP_SHORT;
        goto TRIP_ACTIVE;
    }


    if (g_protect.i2tAccum >= g_protect.i2tLimit) {
        trip = TRIP_OVERLOAD;
        goto TRIP_ACTIVE;
    }


    if (data->tempC >= cfg->overTempC) {
        g_protect.tempCounter++;
        if (g_protect.tempCounter >= 20) {
            trip = TRIP_OVERTEMP;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.tempCounter = 0;
    }


    if (data->busmV < cfg->underVoltmV) {
        g_protect.underVoltCounter++;
        if (g_protect.underVoltCounter >= 5) {
            trip = TRIP_UNDERVOLT;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.underVoltCounter = 0;
    }


    if (data->busmV > cfg->overVoltmV) {
        g_protect.overVoltCounter++;
        if (g_protect.overVoltCounter >= 2) {
            trip = TRIP_OVERVOLT;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.overVoltCounter = 0;
    }


    if (data->dutyPct > 50 && data->measuredRpm < 100) {
        g_protect.stallCounter++;
        if (g_protect.stallCounter >= 30) {
            trip = TRIP_STALL;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.stallCounter = 0;
    }


    if (data->measuredRpm > data->setpointRpm + 500) {
        g_protect.overspeedCounter++;
        if (g_protect.overspeedCounter >= 10) {
            trip = TRIP_OVERSPEED;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.overspeedCounter = 0;
    }


    if (data->dutyPct > 20 && data->measuredRpm == 0) {
        g_protect.noFeedbackCounter++;
        if (g_protect.noFeedbackCounter >= 20) {
            trip = TRIP_NOFEEDBACK;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.noFeedbackCounter = 0;
    }


    g_protect.activeTrip = TRIP_NONE;
    return TRIP_NONE;

TRIP_ACTIVE:
    g_protect.activeTrip = trip;
    g_protect.tripped = 1;
    return trip;
}

void PROTECT_UpdateI2T(uint16_t current, uint16_t rated) {
    int32_t excess = (int32_t)current - (int32_t)rated;

    if (excess > 0) {

        g_protect.i2tAccum += (uint32_t)((excess * excess) / 1000);
    } else {

        uint32_t decay = (uint32_t)((-excess * -excess) / 4000);
        if (g_protect.i2tAccum > decay) {
            g_protect.i2tAccum -= decay;
        } else {
            g_protect.i2tAccum = 0;
        }
    }
}

void PROTECT_Reset(void) {
    g_protect.tripped = 0;
    g_protect.activeTrip = TRIP_NONE;
    g_protect.tempCounter = 0;
    g_protect.underVoltCounter = 0;
    g_protect.overVoltCounter = 0;
    g_protect.stallCounter = 0;
    g_protect.overspeedCounter = 0;
    g_protect.noFeedbackCounter = 0;
}

void PROTECT_ResetTrip(Trip_t trip) {
    if (g_protect.latchedTrip == trip) {
        g_protect.latchedTrip = TRIP_NONE;
        g_protect.latched = 0;
        PROTECT_Reset();
    }
}

uint8_t PROTECT_IsTripped(void) {
    return g_protect.tripped || g_protect.latched;
}

Trip_t PROTECT_GetActiveTrip(void) {
    return g_protect.activeTrip;
}

Trip_t PROTECT_GetLatchedTrip(void) {
    return g_protect.latchedTrip;
}

uint8_t PROTECT_GetI2TPercent(void) {
    if (g_protect.i2tLimit == 0) return 0;
    return (uint8_t)((g_protect.i2tAccum * 100) / g_protect.i2tLimit);
}

const char* PROTECT_GetTripString(Trip_t trip) {
    switch (trip) {
        case TRIP_NONE: return "NONE";
        case TRIP_ESTOP: return "ESTOP";
        case TRIP_SHORT: return "SHORT";
        case TRIP_OVERLOAD: return "OVERLOAD";
        case TRIP_OVERTEMP: return "OVERTEMP";
        case TRIP_UNDERVOLT: return "UNDERVOLT";
        case TRIP_OVERVOLT: return "OVERVOLT";
        case TRIP_STALL: return "STALL";
        case TRIP_OVERSPEED: return "OVERSPEED";
        case TRIP_NOFEEDBACK: return "NOFEEDBACK";
        default: return "UNKNOWN";
    }
}
