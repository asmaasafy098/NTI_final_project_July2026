# 1 "Logic/Communication/console/console.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Logic/Communication/console/console.c"





# 1 "Logic/Communication/console/console.h" 1
# 9 "Logic/Communication/console/console.h"
# 1 "Service/STD_Types.h" 1



# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
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
# 10 "Logic/Communication/console/console.h" 2
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
# 11 "Logic/Communication/console/console.h" 2







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
# 7 "Logic/Communication/console/console.c" 2
# 1 "Logic/Communication/console/../../../MCL/UART/uart_interface.h" 1



# 1 "Logic/Communication/console/../../../MCL/UART/../../Service/STD_Types.h" 1
# 5 "Logic/Communication/console/../../../MCL/UART/uart_interface.h" 2
# 1 "Logic/Communication/console/../../../MCL/UART/uart_registers.h" 1
# 6 "Logic/Communication/console/../../../MCL/UART/uart_interface.h" 2
# 64 "Logic/Communication/console/../../../MCL/UART/uart_interface.h"
typedef enum
{
    UART_DATA_5BITS = 0,
    UART_DATA_6BITS = 1,
    UART_DATA_7BITS = 2,
    UART_DATA_8BITS = 3,
    UART_DATA_9BITS = 7
} UART_DataSizeType;





typedef enum
{
    UART_PARITY_NONE = 0,
    UART_PARITY_EVEN = 2,
    UART_PARITY_ODD = 3
} UART_ParityType;





typedef enum
{
    UART_STOP_1BIT = 0,
    UART_STOP_2BIT = 1
} UART_StopBitType;
# 102 "Logic/Communication/console/../../../MCL/UART/uart_interface.h"
typedef struct
{
    uint32_t baudRate;
    UART_DataSizeType dataSize;
    UART_ParityType parity;
    UART_StopBitType stopBits;
} UART_ConfigType;






typedef void (*UART_RxCallBackType)(uint8_t receivedByte);
# 128 "Logic/Communication/console/../../../MCL/UART/uart_interface.h"
Std_ReturnType UART_Init(const UART_ConfigType *addConfig);





Std_ReturnType UART_DeInit(void);
# 143 "Logic/Communication/console/../../../MCL/UART/uart_interface.h"
Std_ReturnType UART_SendByte(uint8_t uint8Data);
# 152 "Logic/Communication/console/../../../MCL/UART/uart_interface.h"
Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data);







Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data);







Std_ReturnType UART_SendString(const uint8_t *pString);
# 178 "Logic/Communication/console/../../../MCL/UART/uart_interface.h"
Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator);







Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack);






Std_ReturnType UART_TxBusy(void);
void USART_TransmitByte(uint8_t byte);
void USART_TransmitString(const char *str);
# 8 "Logic/Communication/console/console.c" 2
# 1 "Logic/Communication/console/../../Control/drive_fsm/drive_fsm.h" 1
# 13 "Logic/Communication/console/../../Control/drive_fsm/drive_fsm.h"
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
# 9 "Logic/Communication/console/console.c" 2
# 1 "Logic/Communication/console/../../Control/protection/protection.h" 1
# 13 "Logic/Communication/console/../../Control/protection/protection.h"
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
# 10 "Logic/Communication/console/console.c" 2
# 1 "Logic/Communication/console/../../Data/data_manager.h" 1
# 10 "Logic/Communication/console/../../Data/data_manager.h"
# 1 "Logic/Communication/console/../../Data/data_types.h" 1
# 11 "Logic/Communication/console/../../Data/data_manager.h" 2
# 19 "Logic/Communication/console/../../Data/data_manager.h"
void DataManager_Init(DriveData_t* data, DriveCfg_t* cfg);




void DataManager_Update(void);





DriveData_t* DataManager_GetData(void);





DriveCfg_t* DataManager_GetConfig(void);
# 45 "Logic/Communication/console/../../Data/data_manager.h"
void DataManager_UpdateSensors(int16_t rpm, uint16_t current,
                                uint16_t voltage, uint8_t temp);





void DataManager_UpdateSetpoint(int16_t setpoint);





void DataManager_UpdateDuty(uint16_t duty);




void DataManager_UpdateError(void);




void DataManager_IncrementRunSeconds(void);




void DataManager_Persist(void);
# 11 "Logic/Communication/console/console.c" 2
# 1 "Logic/Communication/console/../../Control/pi_controller/pi_controller.h" 1
# 13 "Logic/Communication/console/../../Control/pi_controller/pi_controller.h"
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
# 32 "Logic/Communication/console/../../Control/pi_controller/pi_controller.h"
void PI_Init(PI_Handle_t* pi, int16_t kp, int16_t ki);







void PI_InitLimits(PI_Handle_t* pi, int16_t outMin, int16_t outMax);
# 49 "Logic/Communication/console/../../Control/pi_controller/pi_controller.h"
int16_t PI_Step(PI_Handle_t* pi, int16_t setpoint, int16_t measured);





void PI_Reset(PI_Handle_t* pi);







void PI_SetGains(PI_Handle_t* pi, int16_t kp, int16_t ki);






int32_t PI_GetIntegral(const PI_Handle_t* pi);






int16_t PI_GetError(const PI_Handle_t* pi);
# 12 "Logic/Communication/console/console.c" 2
# 1 "Logic/Communication/console/../../Control/ramp_generator/ramp_generator.h" 1
# 12 "Logic/Communication/console/../../Control/ramp_generator/ramp_generator.h"
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
# 13 "Logic/Communication/console/console.c" 2
# 1 "Logic/Communication/console/../../../Service/util_math.h" 1
# 9 "Logic/Communication/console/../../../Service/util_math.h"
# 1 "Logic/Communication/console/../../../Service/STD_Types.h" 1
# 10 "Logic/Communication/console/../../../Service/util_math.h" 2
# 22 "Logic/Communication/console/../../../Service/util_math.h"
static inline int16_t Util_Map(int16_t x, int16_t in_min, int16_t in_max,
                                int16_t out_min, int16_t out_max) {
    return (int16_t)(((int32_t)(x - in_min) * (out_max - out_min)) / (in_max - in_min) + out_min);
}
# 34 "Logic/Communication/console/../../../Service/util_math.h"
static inline int16_t Util_Clamp(int16_t value, int16_t min, int16_t max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}
# 47 "Logic/Communication/console/../../../Service/util_math.h"
static inline uint8_t Util_IsInRange(int16_t value, int16_t min, int16_t max) {
    return (value >= min && value <= max);
}
# 58 "Logic/Communication/console/../../../Service/util_math.h"
static inline int16_t Util_Deadband(int16_t value, int16_t lastValue, int16_t threshold) {
    int16_t diff = value - lastValue;
    if (((diff) < 0 ? -(diff) : (diff)) < threshold) {
        return lastValue;
    }
    return value;
}
# 14 "Logic/Communication/console/console.c" 2
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 1 3
# 46 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 1 3 4
# 216 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 3 4

# 216 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 3 4
typedef unsigned int size_t;
# 47 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 2 3
# 125 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int ffs(int __val) __attribute__((__const__));





extern int ffsl(long __val) __attribute__((__const__));





__extension__ extern int ffsll(long long __val) __attribute__((__const__));
# 150 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memccpy(void *, const void *, int, size_t);
# 162 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memchr(const void *, int, size_t) __attribute__((__pure__));
# 180 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int memcmp(const void *, const void *, size_t) __attribute__((__pure__));
# 191 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memcpy(void *, const void *, size_t);
# 203 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memmem(const void *, size_t, const void *, size_t) __attribute__((__pure__));
# 213 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memmove(void *, const void *, size_t);
# 225 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memrchr(const void *, int, size_t) __attribute__((__pure__));
# 235 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern void *memset(void *, int, size_t);
# 248 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strcat(char *, const char *);
# 262 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strchr(const char *, int) __attribute__((__pure__));
# 274 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strchrnul(const char *, int) __attribute__((__pure__));
# 287 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strcmp(const char *, const char *) __attribute__((__pure__));
# 305 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strcpy(char *, const char *);
# 320 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strcasecmp(const char *, const char *) __attribute__((__pure__));
# 333 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strcasestr(const char *, const char *) __attribute__((__pure__));
# 344 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strcspn(const char *__s, const char *__reject) __attribute__((__pure__));
# 364 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strdup(const char *s1);
# 377 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strlcat(char *, const char *, size_t);
# 388 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strlcpy(char *, const char *, size_t);
# 399 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strlen(const char *) __attribute__((__pure__));
# 411 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strlwr(char *);
# 422 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strncat(char *, const char *, size_t);
# 434 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strncmp(const char *, const char *, size_t) __attribute__((__pure__));
# 449 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strncpy(char *, const char *, size_t);
# 464 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern int strncasecmp(const char *, const char *, size_t) __attribute__((__pure__));
# 478 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strnlen(const char *, size_t) __attribute__((__pure__));
# 491 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strpbrk(const char *__s, const char *__accept) __attribute__((__pure__));
# 505 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strrchr(const char *, int) __attribute__((__pure__));
# 515 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strrev(char *);
# 533 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strsep(char **, const char *);
# 544 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern size_t strspn(const char *__s, const char *__accept) __attribute__((__pure__));
# 557 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strstr(const char *, const char *) __attribute__((__pure__));
# 576 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strtok(char *, const char *);
# 593 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strtok_r(char *, const char *, char **);
# 606 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\string.h" 3
extern char *strupr(char *);



extern int strcoll(const char *s1, const char *s2);
extern char *strerror(int errnum);
extern size_t strxfrm(char *dest, const char *src, size_t n);
# 15 "Logic/Communication/console/console.c" 2
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 1 3
# 48 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 1 3 4
# 328 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 3 4
typedef int wchar_t;
# 49 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 2 3
# 70 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
typedef struct {
 int quot;
 int rem;
} div_t;


typedef struct {
 long quot;
 long rem;
} ldiv_t;


typedef int (*__compar_fn_t)(const void *, const void *);
# 116 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern void abort(void) __attribute__((__noreturn__));




extern int abs(int __i) __attribute__((__const__));
# 130 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern long labs(long __i) __attribute__((__const__));
# 153 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern void *bsearch(const void *__key, const void *__base, size_t __nmemb,
       size_t __size, int (*__compar)(const void *, const void *));







extern div_t div(int __num, int __denom) __asm__("__divmodhi4") __attribute__((__const__));





extern ldiv_t ldiv(long __num, long __denom) __asm__("__divmodsi4") __attribute__((__const__));
# 185 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern void qsort(void *__base, size_t __nmemb, size_t __size,
    __compar_fn_t __compar);
# 218 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern long strtol(const char *__nptr, char **__endptr, int __base);
# 252 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern unsigned long strtoul(const char *__nptr, char **__endptr, int __base);
# 264 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern long atol(const char *__s) __attribute__((__pure__));
# 276 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern int atoi(const char *__s) __attribute__((__pure__));
# 288 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern void exit(int __status) __attribute__((__noreturn__));
# 300 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern void *malloc(size_t __size) __attribute__((__malloc__));






extern void free(void *__ptr);




extern size_t __malloc_margin;




extern char *__malloc_heap_start;




extern char *__malloc_heap_end;






extern void *calloc(size_t __nele, size_t __size) __attribute__((__malloc__));
# 348 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern void *realloc(void *__ptr, size_t __size) __attribute__((__malloc__));

extern double strtod(const char *__nptr, char **__endptr);
# 361 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern double atof(const char *__nptr);
# 383 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern int rand(void);



extern void srand(unsigned int __seed);






extern int rand_r(unsigned long *__ctx);
# 428 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *itoa (int __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__itoa (int, char *, int);
 return __itoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__itoa_ncheck (int, char *, unsigned char);
 return __itoa_ncheck (__val, __s, __radix);
    }
}
# 473 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *ltoa (long __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__ltoa (long, char *, int);
 return __ltoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__ltoa_ncheck (long, char *, unsigned char);
 return __ltoa_ncheck (__val, __s, __radix);
    }
}
# 516 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *utoa (unsigned int __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__utoa (unsigned int, char *, int);
 return __utoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__utoa_ncheck (unsigned int, char *, unsigned char);
 return __utoa_ncheck (__val, __s, __radix);
    }
}
# 558 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *ultoa (unsigned long __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__ultoa (unsigned long, char *, int);
 return __ultoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__ultoa_ncheck (unsigned long, char *, unsigned char);
 return __ultoa_ncheck (__val, __s, __radix);
    }
}
# 590 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern long random(void);




extern void srandom(unsigned long __seed);







extern long random_r(unsigned long *__ctx);
# 649 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern char *dtostre(double __val, char *__s, unsigned char __prec,
       unsigned char __flags);
# 666 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern char *dtostrf(double __val, signed char __width,
                     unsigned char __prec, char *__s);
# 685 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdlib.h" 3
extern int atexit(void (*)(void));
extern int system (const char *);
extern char *getenv (const char *);
# 16 "Logic/Communication/console/console.c" 2



# 18 "Logic/Communication/console/console.c"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
extern PI_Handle_t g_pi;
extern Ramp_t g_ramp;


static Console_t g_console;
static char* g_argv[8];
static uint8_t g_argc = 0;


static void CONSOLE_ParseCommand(void);
static uint8_t CONSOLE_GetArg(uint8_t index, char** arg);
static int16_t CONSOLE_ParseNumber(const char* str);
static uint8_t CONSOLE_IsNumber(const char* str);
static void CONSOLE_HandleStatus(void);
static void CONSOLE_HandleRun(void);
static void CONSOLE_HandleStop(void);
static void CONSOLE_HandleReverse(void);
static void CONSOLE_HandleSpeed(void);
static void CONSOLE_HandleSpeedQuery(void);
static void CONSOLE_HandleDirQuery(void);
static void CONSOLE_HandleCfgQuery(void);
static void CONSOLE_HandleSet(void);
static void CONSOLE_HandleAck(void);
static void CONSOLE_HandleTripQuery(void);
static void CONSOLE_HandleTripsQuery(void);
static void CONSOLE_HandleHoursQuery(void);
static void CONSOLE_HandleTuneQuery(void);
static void CONSOLE_HandleSave(void);
static void CONSOLE_HandleHelp(void);



void CONSOLE_Init(void) {
    g_console.index = 0;
    g_console.ready = 0;
    g_console.echo = 1;
    memset(g_console.buffer, 0, 64);


    CONSOLE_SendResponse("\r\nIndustrial Motor Controller v1.0");
    CONSOLE_SendResponse("\r\nType HELP for commands\r\n> ");
}

void CONSOLE_ProcessChar(uint8_t ch) {

    if (g_console.echo) {
        USART_TransmitByte(ch);
    }


    if (ch == 0x08 || ch == 0x7F) {
        if (g_console.index > 0) {
            g_console.index--;
            g_console.buffer[g_console.index] = 0;

            USART_TransmitByte(' ');
            USART_TransmitByte(0x08);
        }
        return;
    }


    if (ch == '\r' || ch == '\n') {
        if (g_console.index > 0) {
            g_console.buffer[g_console.index] = '\0';
            g_console.ready = 1;
            USART_TransmitString("\r\n");
        } else {
            USART_TransmitString("\r\n> ");
        }
        return;
    }


    if (g_console.index < 64 - 1) {
        g_console.buffer[g_console.index++] = ch;
    }
}

void CONSOLE_ExecuteCommand(void) {
    if (!g_console.ready) {
        return;
    }


    CONSOLE_ParseCommand();
    g_console.ready = 0;
    g_console.index = 0;
    memset(g_console.buffer, 0, 64);


    if (g_argc > 0) {
        if (strcmp(g_argv[0], "STATUS") == 0) {
            CONSOLE_HandleStatus();
        } else if (strcmp(g_argv[0], "RUN") == 0) {
            CONSOLE_HandleRun();
        } else if (strcmp(g_argv[0], "STOP") == 0) {
            CONSOLE_HandleStop();
        } else if (strcmp(g_argv[0], "REV") == 0) {
            CONSOLE_HandleReverse();
        } else if (strcmp(g_argv[0], "SPEED") == 0) {
            if (g_argc > 1 && strcmp(g_argv[1], "?") == 0) {
                CONSOLE_HandleSpeedQuery();
            } else {
                CONSOLE_HandleSpeed();
            }
        } else if (strcmp(g_argv[0], "DIR?") == 0) {
            CONSOLE_HandleDirQuery();
        } else if (strcmp(g_argv[0], "CFG?") == 0) {
            CONSOLE_HandleCfgQuery();
        } else if (strcmp(g_argv[0], "SET") == 0) {
            CONSOLE_HandleSet();
        } else if (strcmp(g_argv[0], "ACK") == 0) {
            CONSOLE_HandleAck();
        } else if (strcmp(g_argv[0], "TRIP?") == 0) {
            CONSOLE_HandleTripQuery();
        } else if (strcmp(g_argv[0], "TRIPS?") == 0) {
            CONSOLE_HandleTripsQuery();
        } else if (strcmp(g_argv[0], "HOURS?") == 0) {
            CONSOLE_HandleHoursQuery();
        } else if (strcmp(g_argv[0], "TUNE?") == 0) {
            CONSOLE_HandleTuneQuery();
        } else if (strcmp(g_argv[0], "SAVE") == 0) {
            CONSOLE_HandleSave();
        } else if (strcmp(g_argv[0], "HELP") == 0) {
            CONSOLE_HandleHelp();
        } else {
            CONSOLE_SendError("ERR CMD");
        }
    }


    USART_TransmitString("> ");
}

void CONSOLE_SendResponse(const char* str) {
    USART_TransmitString(str);
    USART_TransmitString("\r\n");
}

void CONSOLE_SendError(const char* error) {
    USART_TransmitString("ERROR: ");
    USART_TransmitString(error);
    USART_TransmitString("\r\n");
}

void CONSOLE_SendTelemetry(const DriveData_t* data) {
    char buffer[128];
    uint8_t checksum = 0;
    uint8_t i;


    sprintf(buffer, "$MD,SP=%d,RP=%d,D=%d,I=%d,V=%d,T=%d,DIR=%c,ST=%s,TR=%d,I2T=%d,RH=%lu,SC=%d",
            data->rampedRpm,
            data->measuredRpm,
            data->dutyPct,
            data->currentmA,
            data->busmV,
            data->tempC,
            (data->direction == DIR_FORWARD) ? 'F' :
            (data->direction == DIR_REVERSE) ? 'R' : '-',
            FSM_GetStateString(),
            data->activeTrip,
            PROTECT_GetI2TPercent(),
            data->totalRunSec,
            data->startCount);


    for (i = 1; buffer[i] != '\0'; i++) {
        checksum ^= buffer[i];
    }


    sprintf(buffer + strlen(buffer), "*%02X\r\n", checksum);

    USART_TransmitString(buffer);
}

void CONSOLE_SendEvent(const char* event) {
    USART_TransmitString("!EVT,");
    USART_TransmitString(event);
    USART_TransmitString("\r\n");
}

void CONSOLE_SendHelp(void) {
    CONSOLE_SendResponse("\r\n=== Available Commands ===");
    CONSOLE_SendResponse("STATUS        - Show telemetry");
    CONSOLE_SendResponse("RUN           - Start motor (remote only)");
    CONSOLE_SendResponse("STOP          - Stop motor");
    CONSOLE_SendResponse("REV           - Reverse direction (remote only)");
    CONSOLE_SendResponse("SPEED <n>     - Set speed (0-maxRpm)");
    CONSOLE_SendResponse("SPEED?        - Show current speed");
    CONSOLE_SendResponse("DIR?          - Show direction");
    CONSOLE_SendResponse("CFG?          - Show configuration");
    CONSOLE_SendResponse("SET <param> <value> - Set parameter");
    CONSOLE_SendResponse("ACK           - Acknowledge trip");
    CONSOLE_SendResponse("TRIP?         - Show active trip");
    CONSOLE_SendResponse("TRIPS?        - Show trip log");
    CONSOLE_SendResponse("HOURS?        - Show run hours");
    CONSOLE_SendResponse("TUNE?         - Show PI internals");
    CONSOLE_SendResponse("SAVE          - Save config to EEPROM");
    CONSOLE_SendResponse("HELP          - Show this menu");
    CONSOLE_SendResponse("");
}

uint8_t CONSOLE_IsCommandReady(void) {
    return g_console.ready;
}

char* CONSOLE_GetCommand(void) {
    return g_console.buffer;
}

void CONSOLE_ClearCommand(void) {
    g_console.ready = 0;
    g_console.index = 0;
    memset(g_console.buffer, 0, 64);
}



static void CONSOLE_ParseCommand(void) {
    char* token;
    g_argc = 0;


    token = strtok(g_console.buffer, " \t\r\n");
    while (token != 
# 247 "Logic/Communication/console/console.c" 3 4
                   ((void *)0) 
# 247 "Logic/Communication/console/console.c"
                        && g_argc < 8) {
        g_argv[g_argc++] = token;
        token = strtok(
# 249 "Logic/Communication/console/console.c" 3 4
                      ((void *)0)
# 249 "Logic/Communication/console/console.c"
                          , " \t\r\n");
    }
}

static uint8_t CONSOLE_GetArg(uint8_t index, char** arg) {
    if (index >= g_argc) {
        return 0;
    }
    *arg = g_argv[index];
    return 1;
}

static int16_t CONSOLE_ParseNumber(const char* str) {
    return (int16_t)atoi(str);
}

static uint8_t CONSOLE_IsNumber(const char* str) {
    if (str == 
# 266 "Logic/Communication/console/console.c" 3 4
              ((void *)0) 
# 266 "Logic/Communication/console/console.c"
                   || *str == '\0') {
        return 0;
    }
    while (*str) {
        if (*str < '0' || *str > '9') {
            return 0;
        }
        str++;
    }
    return 1;
}



static void CONSOLE_HandleStatus(void) {
    CONSOLE_SendTelemetry(&g_driveData);
}

static void CONSOLE_HandleRun(void) {

    if (!g_driveData.remote) {
        CONSOLE_SendError("ERR MODE");
        return;
    }

    if (FSM_IsTripped()) {
        CONSOLE_SendError("ERR TRIPPED");
        return;
    }

    if (FSM_RequestStart()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("START,REMOTE");
    } else {
        CONSOLE_SendError("ERR START");
    }
}

static void CONSOLE_HandleStop(void) {
    if (FSM_RequestStop()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("STOP,REMOTE");
    } else {
        CONSOLE_SendError("ERR STOP");
    }
}

static void CONSOLE_HandleReverse(void) {
    if (!g_driveData.remote) {
        CONSOLE_SendError("ERR MODE");
        return;
    }

    if (FSM_RequestReverse()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("REVERSE,REMOTE");
    } else {
        CONSOLE_SendError("ERR REV");
    }
}

static void CONSOLE_HandleSpeed(void) {
    char* arg;
    int16_t speed;

    if (!g_driveData.remote) {
        CONSOLE_SendError("ERR MODE");
        return;
    }

    if (!CONSOLE_GetArg(1, &arg)) {
        CONSOLE_SendError("ERR ARGS");
        return;
    }

    if (!CONSOLE_IsNumber(arg)) {
        CONSOLE_SendError("ERR RANGE");
        return;
    }

    speed = CONSOLE_ParseNumber(arg);
    if (speed < 0 || speed > g_driveCfg.maxRpm) {
        CONSOLE_SendError("ERR RANGE");
        return;
    }

    g_driveData.setpointRpm = speed;
    RAMP_SetTarget(&g_ramp, speed);
    CONSOLE_SendResponse("OK");
}

static void CONSOLE_HandleSpeedQuery(void) {
    char buffer[32];
    sprintf(buffer, "SPEED=%d,%d", g_driveData.rampedRpm, g_driveData.measuredRpm);
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleDirQuery(void) {
    char buffer[16];
    sprintf(buffer, "DIR=%c",
            (g_driveData.direction == DIR_FORWARD) ? 'F' :
            (g_driveData.direction == DIR_REVERSE) ? 'R' : '-');
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleCfgQuery(void) {
    char buffer[128];
    sprintf(buffer, "CFG=%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
            g_driveCfg.maxRpm,
            g_driveCfg.minRpm,
            g_driveCfg.accelRpmPerSec,
            g_driveCfg.decelRpmPerSec,
            g_driveCfg.deadTimeMs,
            g_driveCfg.kp,
            g_driveCfg.ki,
            g_driveCfg.ratedCurrentmA,
            g_driveCfg.shortTripmA,
            g_driveCfg.overTempC,
            g_driveCfg.underVoltmV,
            g_driveCfg.overVoltmV);
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleSet(void) {
    char* param;
    char* value;
    int16_t val;

    if (!CONSOLE_GetArg(1, &param) || !CONSOLE_GetArg(2, &value)) {
        CONSOLE_SendError("ERR ARGS");
        return;
    }

    if (!CONSOLE_IsNumber(value)) {
        CONSOLE_SendError("ERR RANGE");
        return;
    }

    val = CONSOLE_ParseNumber(value);

    if (strcmp(param, "MAXRPM") == 0) {
        if (val < 500 || val > 6000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.maxRpm = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "MINRPM") == 0) {
        if (val < 50 || val > 1000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.minRpm = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "ACCEL") == 0) {
        if (val < 100 || val > 3000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.accelRpmPerSec = (uint16_t)val;
        RAMP_SetRates(&g_ramp, g_driveCfg.accelRpmPerSec, g_driveCfg.decelRpmPerSec);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "DECEL") == 0) {
        if (val < 100 || val > 3000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.decelRpmPerSec = (uint16_t)val;
        RAMP_SetRates(&g_ramp, g_driveCfg.accelRpmPerSec, g_driveCfg.decelRpmPerSec);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "DEADTIME") == 0) {
        if (val < 200 || val > 2000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.deadTimeMs = (uint16_t)val;
        FSM_SetDeadTime((uint32_t)val);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "KP") == 0) {
        if (val < 0 || val > 4096) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.kp = (int16_t)val;
        PI_SetGains(&g_pi, g_driveCfg.kp, g_driveCfg.ki);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "KI") == 0) {
        if (val < 0 || val > 512) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.ki = (int16_t)val;
        PI_SetGains(&g_pi, g_driveCfg.kp, g_driveCfg.ki);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "RATED") == 0) {
        if (val < 1000 || val > 15000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.ratedCurrentmA = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "SHORT") == 0) {
        if (val <= g_driveCfg.ratedCurrentmA) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.shortTripmA = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "OVERTEMP") == 0) {
        if (val < 60 || val > 140) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.overTempC = (uint8_t)val;
        CONSOLE_SendResponse("OK");
    } else {
        CONSOLE_SendError("ERR PARAM");
    }
}

static void CONSOLE_HandleAck(void) {
    if (FSM_RequestReset()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("ACK,OK");
    } else {
        CONSOLE_SendError("ERR ACTIVE");
        CONSOLE_SendEvent("ACK,REFUSED,ACTIVE");
    }
}

static void CONSOLE_HandleTripQuery(void) {
    char buffer[32];
    Trip_t trip = PROTECT_GetActiveTrip();
    if (trip == TRIP_NONE) {
        trip = PROTECT_GetLatchedTrip();
    }
    sprintf(buffer, "TRIP=%d,%s", trip, PROTECT_GetTripString(trip));
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleTripsQuery(void) {
    CONSOLE_SendResponse("=== Trip Log ===");

    CONSOLE_SendResponse("TRP,0,NONE");
    CONSOLE_SendResponse("=== End ===");
}

static void CONSOLE_HandleHoursQuery(void) {
    char buffer[32];
    uint32_t hours = g_driveData.totalRunSec / 3600;
    uint32_t minutes = (g_driveData.totalRunSec % 3600) / 60;
    sprintf(buffer, "HOURS=%02lu:%02lu,SC=%d", hours, minutes, g_driveData.startCount);
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleTuneQuery(void) {
    char buffer[64];
    sprintf(buffer, "TUNE=%d,%d,%ld,%d",
            g_driveCfg.kp,
            g_driveCfg.ki,
            PI_GetIntegral(&g_pi),
            PI_GetError(&g_pi));
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleSave(void) {

    CONSOLE_SendResponse("OK");
    CONSOLE_SendEvent("SAVE,OK");
}

static void CONSOLE_HandleHelp(void) {
    CONSOLE_SendHelp();
}
