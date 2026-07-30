# 1 "Logic/Communication/telemetry/telemetry.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Logic/Communication/telemetry/telemetry.c"





# 1 "Logic/Communication/telemetry/telemetry.h" 1
# 9 "Logic/Communication/telemetry/telemetry.h"
# 1 "Service/STD_Types.h" 1



<<<<<<< HEAD
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
<<<<<<< HEAD
# 146 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 146 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
<<<<<<< HEAD
# 163 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 163 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
<<<<<<< HEAD
# 217 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 217 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
<<<<<<< HEAD
# 277 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 277 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
<<<<<<< HEAD
# 10 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
=======
# 10 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
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
# 10 "Logic/Communication/telemetry/telemetry.h" 2
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

<<<<<<< HEAD
=======

>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
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
<<<<<<< HEAD
# 152 "Logic/Data/data_types.h"
=======
# 153 "Logic/Data/data_types.h"
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 11 "Logic/Communication/telemetry/telemetry.h" 2






void TELEMETRY_Init(void);





void TELEMETRY_Update(const DriveData_t* data);





void TELEMETRY_SendStatus(const DriveData_t* data);






void TELEMETRY_SendTripEvent(Trip_t trip, const DriveData_t* data);





void TELEMETRY_SetEnabled(uint8_t enable);





uint8_t TELEMETRY_IsEnabled(void);
# 7 "Logic/Communication/telemetry/telemetry.c" 2
# 1 "Logic/Communication/telemetry/../console/console.h" 1
# 18 "Logic/Communication/telemetry/../console/console.h"
typedef struct {
    char buffer[64];
    uint8_t index;
    uint8_t ready;
    uint8_t echo;
} Console_t;






void CONSOLE_Init(void);





void CONSOLE_ProcessChar(uint8_t ch);




void CONSOLE_ExecuteCommand(void);





void CONSOLE_SendResponse(const char* str);





void CONSOLE_SendError(const char* error);





void CONSOLE_SendTelemetry(const DriveData_t* data);





void CONSOLE_SendEvent(const char* event);




void CONSOLE_SendHelp(void);





uint8_t CONSOLE_IsCommandReady(void);





char* CONSOLE_GetCommand(void);




void CONSOLE_ClearCommand(void);
# 8 "Logic/Communication/telemetry/telemetry.c" 2
# 1 "Logic/Communication/telemetry/../../Control/drive_fsm/drive_fsm.h" 1
# 13 "Logic/Communication/telemetry/../../Control/drive_fsm/drive_fsm.h"
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
# 9 "Logic/Communication/telemetry/telemetry.c" 2
# 1 "Logic/Communication/telemetry/../../Control/protection/protection.h" 1
# 13 "Logic/Communication/telemetry/../../Control/protection/protection.h"
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
# 10 "Logic/Communication/telemetry/telemetry.c" 2
# 1 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h" 1



# 1 "Logic/Communication/telemetry/../../../MCL/Timer/../../Service/STD_Types.h" 1
# 5 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h" 2
# 1 "Logic/Communication/telemetry/../../../MCL/Timer/timer_registers.h" 1
# 6 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h" 2
# 23 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h"
typedef enum
{
    TIMER_CHANNEL_0 = 0,
    TIMER_CHANNEL_1 = 1,
    TIMER_CHANNEL_2 = 2,
    TIMER_CHANNEL_MAX
} Timer_ChannelType;
# 39 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h"
typedef enum
{
    TIMER_MODE_NORMAL = 0,
    TIMER_MODE_CTC = 1,
    TIMER_MODE_FAST_PWM = 2,
    TIMER_MODE_PHASE_PWM = 3
} Timer_ModeType;







typedef enum
{
    TIMER_CLOCK_STOPPED = 0,
    TIMER_CLOCK_DIV_1 = 1,
    TIMER_CLOCK_DIV_8 = 2,
    TIMER_CLOCK_DIV_64 = 3,
    TIMER_CLOCK_DIV_256 = 4,
    TIMER_CLOCK_DIV_1024 = 5
} Timer_PrescalerType;







typedef enum
{
    TIMER_INT_OVERFLOW = 0,
    TIMER_INT_COMPARE_MATCH = 1
} Timer_InterruptType;
# 85 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h"
typedef struct
{
    Timer_ChannelType channel;
    Timer_ModeType mode;
    Timer_PrescalerType prescaler;
    uint16_t initialValue;
    uint16_t compareValue;
} Timer_ConfigType;






typedef void (*Timer_CallBackType)(void);
# 111 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_Init(void);
# 120 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 129 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 139 "Logic/Communication/telemetry/../../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType,
                                  Timer_CallBackType callBack);







Std_ReturnType Timer1_Init(void);






Std_ReturnType Timer1_SetDuty(uint16_t duty_percent);







Std_ReturnType Timer2_Init(void);






Std_ReturnType Timer2_SetTone(uint16_t tone);






void Timer_EnableGlobalInterrupt(void);






void Timer_DisableGlobalInterrupt(void);
<<<<<<< HEAD


uint32_t TIMER_GetTick(void);
=======
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
# 11 "Logic/Communication/telemetry/telemetry.c" 2


static uint8_t g_telemetryEnabled = 1;
static uint32_t g_lastSendTime = 0;



void TELEMETRY_Init(void) {
    g_telemetryEnabled = 1;
    g_lastSendTime = TIMER_GetTick();
}

void TELEMETRY_Update(const DriveData_t* data) {
    if (!g_telemetryEnabled) {
        return;
    }

    uint32_t currentTime = TIMER_GetTick();


    if (currentTime - g_lastSendTime >= 1000) {
        CONSOLE_SendTelemetry(data);
        g_lastSendTime = currentTime;
    }
}

void TELEMETRY_SendStatus(const DriveData_t* data) {
    CONSOLE_SendTelemetry(data);
}

void TELEMETRY_SendTripEvent(Trip_t trip, const DriveData_t* data) {
    char buffer[64];
    sprintf(buffer, "TRIP,%s,I=%d,I2T=%d",
            PROTECT_GetTripString(trip),
            data->currentmA,
            PROTECT_GetI2TPercent());
    CONSOLE_SendEvent(buffer);
}

void TELEMETRY_SetEnabled(uint8_t enable) {
    g_telemetryEnabled = enable;
}

uint8_t TELEMETRY_IsEnabled(void) {
    return g_telemetryEnabled;
}
