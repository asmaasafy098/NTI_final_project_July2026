/*
 * data_types.h
 * Global Data Types Definition
 */

#ifndef DATA_TYPES_H_
#define DATA_TYPES_H_

#include "STD_Types.h"

/* ==================== Enumerations ==================== */

/* Drive States */
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

/* Motor Direction */
typedef enum {
    DIR_STOP = 0,
    DIR_FORWARD = 1,
    DIR_REVERSE = 2
} MotorDir_t;

/* Trip Types */
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

/* Button Events */
typedef enum {
    EVENT_NONE = 0,
    EVENT_START_PRESSED,
    EVENT_START_RELEASED,
    EVENT_STOP_PRESSED,
    EVENT_REVERSE_PRESSED,
    EVENT_RESET_PRESSED,
    EVENT_RESET_HELD
} PanelEvent_t;

/* FSM Events */
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

/* ==================== Data Structures ==================== */

/* Runtime Drive Data */
typedef struct {
    int16_t setpointRpm;      /* Target speed from pot/console */
    int16_t rampedRpm;        /* After acceleration/deceleration */
    int16_t measuredRpm;      /* Actual speed from tacho */
    int16_t errorRpm;         /* Ramped - Measured */
    uint16_t dutyCounts;      /* 0-399 PWM value */
    uint8_t dutyPct;          /* 0-100 for display */
    uint16_t currentmA;       /* 0-20000 mA */
    uint16_t busmV;           /* 0-60000 mV */
    uint8_t tempC;            /* 0-150 °C */
    uint32_t i2tAccum;        /* Thermal accumulator */
    MotorDir_t direction;     /* Current direction */
    DriveState_t state;       /* Current state */
    Trip_t activeTrip;        /* Active trip if any */
    uint8_t remote : 1;       /* 1 = remote mode */
    uint8_t estopRaw : 1;     /* Live E-stop pin state */
    uint8_t atSetpoint : 1;   /* At target speed */
    uint8_t reserved : 5;
    uint32_t runSeconds;      /* Current run time */
    uint32_t totalRunSec;     /* Lifetime run time */
    uint16_t startCount;      /* Lifetime start count */
    uint32_t upTimeSec;       /* System uptime */
} DriveData_t;

/* Configuration Parameters */
typedef struct {
    uint16_t magic;           /* 0x4D44 signature */
    uint8_t version;          /* 0x01 */
    uint16_t maxRpm;          /* 3000 */
    uint16_t minRpm;          /* 200 */
    uint16_t accelRpmPerSec;  /* 600 */
    uint16_t decelRpmPerSec;  /* 900 */
    uint16_t deadTimeMs;      /* 500 */
    int16_t kp;               /* Q8: 384 */
    int16_t ki;               /* Q8: 26 */
    uint16_t ratedCurrentmA;  /* 8000 */
    uint16_t shortTripmA;     /* 18000 */
    uint8_t overTempC;        /* 110 */
    uint16_t underVoltmV;     /* 20000 */
    uint16_t overVoltmV;      /* 55000 */
    uint16_t stallSec;        /* 3 */
    uint32_t totalRunSec;     /* Lifetime */
    uint16_t startCount;      /* Lifetime */
    uint8_t tripHead;         /* Ring index 0-15 */
    Trip_t latchedTrip;       /* Survives power loss */
    uint8_t checksum;
} DriveCfg_t;

/* Trip Record */
typedef struct {
    Trip_t trip;
    uint32_t timeSec;
    int16_t rpm;
    uint16_t currentmA;
    uint16_t busmV;
    uint8_t tempC;
    uint8_t dutyPct;
} TripRec_t;

/* ==================== Constants ==================== */

#define PWM_TOP             399
#define PWM_MIN_RUN         40
#define TACHO_PPR           6
#define TACHO_WINDOW_MS     100
#define RPM_PER_COUNT       100
#define PI_PERIOD_MS        100
#define Q                   8
#define DEADTIME_TICKS      50
#define I2T_LIMIT           3600000
#define TRIP_LOG_SIZE       16
#define DRV_MAGIC           0x4D44
#define DRV_VERSION         0x01

/* ==================== Global Variables ==================== */

extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;

#endif /* DATA_TYPES_H_ */