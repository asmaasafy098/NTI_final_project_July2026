# 1 "Src/main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Src/main.c"







# 1 "Src/../Service/STD_Types.h" 1



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
# 5 "Src/../Service/STD_Types.h" 2



# 7 "Src/../Service/STD_Types.h"
typedef int8_t sint8_t;
typedef int16_t sint16_t;
typedef int32_t sint32_t;
typedef int64_t sint64_t;

typedef sint8_t sint8;
typedef sint16_t sint16;
typedef sint32_t sint32;
typedef sint64_t sint64;


typedef uint8_t uint8_h;
typedef uint16_t uint16_h;
typedef uint32_t uint32_h;
typedef uint64_t uint64_h;


typedef float float32_t;
typedef double float64_t;


typedef enum {
    FALSE = 0,
    TRUE = 1
} bool_t;


typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 9 "Src/main.c" 2
# 1 "Src/../Service/Bit_Math.h" 1
# 10 "Src/main.c" 2
# 1 "Src/../Logic/Data/data_types.h" 1
# 9 "Src/../Logic/Data/data_types.h"
# 1 "Service/STD_Types.h" 1
# 10 "Src/../Logic/Data/data_types.h" 2




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
# 153 "Src/../Logic/Data/data_types.h"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 11 "Src/main.c" 2
# 1 "Src/../Logic/Data/data_manager.h" 1
# 10 "Src/../Logic/Data/data_manager.h"
# 1 "Src/../Logic/Data/data_types.h" 1
# 11 "Src/../Logic/Data/data_manager.h" 2
# 19 "Src/../Logic/Data/data_manager.h"
void DataManager_Init(DriveData_t* data, DriveCfg_t* cfg);




void DataManager_Update(void);





DriveData_t* DataManager_GetData(void);





DriveCfg_t* DataManager_GetConfig(void);
# 45 "Src/../Logic/Data/data_manager.h"
void DataManager_UpdateSensors(int16_t rpm, uint16_t current,
                                uint16_t voltage, uint8_t temp);





void DataManager_UpdateSetpoint(int16_t setpoint);





void DataManager_UpdateDuty(uint16_t duty);




void DataManager_UpdateError(void);




void DataManager_IncrementRunSeconds(void);




void DataManager_Persist(void);
# 12 "Src/main.c" 2
# 1 "Src/../Logic/Control/drive_fsm/drive_fsm.h" 1
# 10 "Src/../Logic/Control/drive_fsm/drive_fsm.h"
# 1 "Logic/Data/data_types.h" 1
# 11 "Src/../Logic/Control/drive_fsm/drive_fsm.h" 2


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
# 13 "Src/main.c" 2
# 1 "Src/../Logic/Control/pi_controller/pi_controller.h" 1
# 13 "Src/../Logic/Control/pi_controller/pi_controller.h"
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
# 32 "Src/../Logic/Control/pi_controller/pi_controller.h"
void PI_Init(PI_Handle_t* pi, int16_t kp, int16_t ki);







void PI_InitLimits(PI_Handle_t* pi, int16_t outMin, int16_t outMax);
# 49 "Src/../Logic/Control/pi_controller/pi_controller.h"
int16_t PI_Step(PI_Handle_t* pi, int16_t setpoint, int16_t measured);





void PI_Reset(PI_Handle_t* pi);







void PI_SetGains(PI_Handle_t* pi, int16_t kp, int16_t ki);






int32_t PI_GetIntegral(const PI_Handle_t* pi);






int16_t PI_GetError(const PI_Handle_t* pi);
# 14 "Src/main.c" 2
# 1 "Src/../Logic/Control/ramp_generator/ramp_generator.h" 1
# 12 "Src/../Logic/Control/ramp_generator/ramp_generator.h"
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
# 15 "Src/main.c" 2
# 1 "Src/../Logic/Control/protection/protection.h" 1
# 13 "Src/../Logic/Control/protection/protection.h"
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
# 16 "Src/main.c" 2
# 1 "Src/../Logic/Scheduler/scheduler.h" 1
# 14 "Src/../Logic/Scheduler/scheduler.h"
typedef struct {
    void (*task)(void);
    const char* name;
    uint16_t period;
    uint16_t offset;
    uint32_t lastRun;
    uint32_t nextRun;
    uint16_t overrun;
    uint16_t maxDuration;
    uint32_t startTime;
    uint8_t enabled;
} Task_t;






void SCHED_Init(void);




void SCHED_Run(void);
# 47 "Src/../Logic/Scheduler/scheduler.h"
uint8_t SCHED_AddTask(void (*task)(void), const char* name,
                       uint16_t period, uint16_t offset);






uint16_t SCHED_GetOverrun(uint8_t taskId);





uint8_t SCHED_GetLoadPercent(void);





uint8_t SCHED_GetMaxLoadPercent(void);




void SCHED_ReportStatus(void);
# 17 "Src/main.c" 2
# 1 "Src/../Logic/Communication/console/console.h" 1
# 18 "Src/../Logic/Communication/console/console.h"
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
# 18 "Src/main.c" 2
# 1 "Src/../Logic/Communication/telemetry/telemetry.h" 1
# 17 "Src/../Logic/Communication/telemetry/telemetry.h"
void TELEMETRY_Init(void);





void TELEMETRY_Update(const DriveData_t* data);





void TELEMETRY_SendStatus(const DriveData_t* data);






void TELEMETRY_SendTripEvent(Trip_t trip, const DriveData_t* data);





void TELEMETRY_SetEnabled(uint8_t enable);





uint8_t TELEMETRY_IsEnabled(void);
# 19 "Src/main.c" 2


# 1 "Src/../MCL/GPIO/GPIO_Interface.h" 1



# 1 "Src/../MCL/GPIO/../../Service/STD_Types.h" 1
# 5 "Src/../MCL/GPIO/GPIO_Interface.h" 2
# 1 "Src/../MCL/GPIO/GPIO_Registers.h" 1



# 1 "Src/../Service/STD_Types.h" 1
# 5 "Src/../MCL/GPIO/GPIO_Registers.h" 2
# 6 "Src/../MCL/GPIO/GPIO_Interface.h" 2
# 29 "Src/../MCL/GPIO/GPIO_Interface.h"
typedef unsigned char GPIO_pin_status;
typedef unsigned char GPIO_port_status;


Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction);
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value);

Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction);
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port);
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value);
# 22 "Src/main.c" 2
# 1 "Src/../MCL/ADC/ADC_Interfaces.h" 1




# 1 "Src/../MCL/ADC/../../Service/STD_Types.h" 1
# 6 "Src/../MCL/ADC/ADC_Interfaces.h" 2
# 1 "Src/../MCL/ADC/ADC_Registers.h" 1
# 7 "Src/../MCL/ADC/ADC_Interfaces.h" 2
# 39 "Src/../MCL/ADC/ADC_Interfaces.h"
typedef struct
{
    uint8_t uint8ReferenceVoltage;
    uint8_t uint8Prescaler;
} ADC_ConfigType;







Std_ReturnType ADC_Init(const ADC_ConfigType *addConfig);





Std_ReturnType ADC_DeInit(void);







Std_ReturnType ADC_StartConversion(uint8_t uint8Channel);





uint8_t ADC_IsConversionComplete(void);






Std_ReturnType ADC_ReadResult(uint16_t *puint16Result);
# 87 "Src/../MCL/ADC/ADC_Interfaces.h"
Std_ReturnType ADC_ReadChannelBlocking(uint8_t uint8Channel, uint16_t *puint16Result);
# 23 "Src/main.c" 2
# 1 "Src/../MCL/Timer/timer_interface.h" 1



# 1 "Src/../MCL/Timer/../../Service/STD_Types.h" 1
# 5 "Src/../MCL/Timer/timer_interface.h" 2
# 1 "Src/../MCL/Timer/timer_registers.h" 1
# 6 "Src/../MCL/Timer/timer_interface.h" 2
# 23 "Src/../MCL/Timer/timer_interface.h"
typedef enum
{
    TIMER_CHANNEL_0 = 0,
    TIMER_CHANNEL_1 = 1,
    TIMER_CHANNEL_2 = 2,
    TIMER_CHANNEL_MAX
} Timer_ChannelType;
# 39 "Src/../MCL/Timer/timer_interface.h"
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
# 85 "Src/../MCL/Timer/timer_interface.h"
typedef struct
{
    Timer_ChannelType channel;
    Timer_ModeType mode;
    Timer_PrescalerType prescaler;
    uint16_t initialValue;
    uint16_t compareValue;
} Timer_ConfigType;






typedef void (*Timer_CallBackType)(void);
# 111 "Src/../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_Init(void);
# 120 "Src/../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 129 "Src/../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 139 "Src/../MCL/Timer/timer_interface.h"
Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType,
                                  Timer_CallBackType callBack);







Std_ReturnType Timer1_Init(void);






Std_ReturnType Timer1_SetDuty(uint16_t duty_percent);







Std_ReturnType Timer2_Init(void);






Std_ReturnType Timer2_SetTone(uint16_t tone);






void Timer_EnableGlobalInterrupt(void);






void Timer_DisableGlobalInterrupt(void);
# 24 "Src/main.c" 2
# 1 "Src/../MCL/Interrupt/interrupt_interface.h" 1


# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 1 3
# 38 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 1 3
# 99 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 1 3
# 126 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 1 3
# 77 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3

# 77 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 127 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 2 3
# 100 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 244 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 1 3
# 720 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 3
       
# 721 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 245 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 703 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\portpins.h" 1 3
# 704 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3

# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\common.h" 1 3
# 706 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3

# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\version.h" 1 3
# 708 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3






# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\fuse.h" 1 3
# 248 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 715 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3


# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\lock.h" 1 3
# 718 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 39 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 2 3
# 4 "Src/../MCL/Interrupt/interrupt_interface.h" 2
# 1 "Src/../MCL/Interrupt/../../Service/STD_Types.h" 1
# 5 "Src/../MCL/Interrupt/interrupt_interface.h" 2
# 1 "Src/../MCL/Interrupt/interrupt_registers.h" 1
# 6 "Src/../MCL/Interrupt/interrupt_interface.h" 2
# 25 "Src/../MCL/Interrupt/interrupt_interface.h"

# 25 "Src/../MCL/Interrupt/interrupt_interface.h"
typedef enum
{
    EXTI_INT0 = 0,
    EXTI_INT1 = 1,
    EXTI_INT2 = 2,
    EXTI_LINE_MAX
} EXTI_LineType;
# 42 "Src/../MCL/Interrupt/interrupt_interface.h"
typedef enum
{
    EXTI_SENSE_LOW_LEVEL = 0,
    EXTI_SENSE_ANY_CHANGE = 1,
    EXTI_SENSE_FALLING = 2,
    EXTI_SENSE_RISING = 3
} EXTI_SenseType;







typedef struct
{
    EXTI_LineType line;
    EXTI_SenseType sense;
} EXTI_ConfigType;






typedef void (*EXTI_CallBackType)(void);
# 80 "Src/../MCL/Interrupt/interrupt_interface.h"
Std_ReturnType EXTI_Init(const EXTI_ConfigType *addConfig);






Std_ReturnType EXTI_Enable(EXTI_LineType line);






Std_ReturnType EXTI_Disable(EXTI_LineType line);
# 103 "Src/../MCL/Interrupt/interrupt_interface.h"
Std_ReturnType EXTI_SetSenseControl(EXTI_LineType line, EXTI_SenseType sense);







Std_ReturnType EXTI_SetCallBack(EXTI_LineType line, EXTI_CallBackType callBack);




void EXTI_EnableGlobalInterrupt(void);




void EXTI_DisableGlobalInterrupt(void);
# 25 "Src/main.c" 2
# 1 "Src/../MCL/UART/uart_interface.h" 1



# 1 "Src/../MCL/UART/../../Service/STD_Types.h" 1
# 5 "Src/../MCL/UART/uart_interface.h" 2
# 1 "Src/../MCL/UART/uart_registers.h" 1
# 6 "Src/../MCL/UART/uart_interface.h" 2
# 64 "Src/../MCL/UART/uart_interface.h"
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
# 102 "Src/../MCL/UART/uart_interface.h"
typedef struct
{
    uint32_t baudRate;
    UART_DataSizeType dataSize;
    UART_ParityType parity;
    UART_StopBitType stopBits;
} UART_ConfigType;






typedef void (*UART_RxCallBackType)(uint8_t receivedByte);
# 128 "Src/../MCL/UART/uart_interface.h"
Std_ReturnType UART_Init(const UART_ConfigType *addConfig);





Std_ReturnType UART_DeInit(void);
# 143 "Src/../MCL/UART/uart_interface.h"
Std_ReturnType UART_SendByte(uint8_t uint8Data);
# 152 "Src/../MCL/UART/uart_interface.h"
Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data);







Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data);







Std_ReturnType UART_SendString(const uint8_t *pString);
# 178 "Src/../MCL/UART/uart_interface.h"
Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator);







Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack);






Std_ReturnType UART_TxBusy(void);
# 26 "Src/main.c" 2
# 1 "Src/../MCL/I2C/i2c_interface.h" 1



# 1 "Src/../MCL/I2C/../../Service/STD_Types.h" 1
# 5 "Src/../MCL/I2C/i2c_interface.h" 2
# 1 "Src/../MCL/I2C/i2c_registers.h" 1
# 6 "Src/../MCL/I2C/i2c_interface.h" 2
# 40 "Src/../MCL/I2C/i2c_interface.h"
typedef enum
{
    I2C_NACK = 0,
    I2C_ACK = 1
} I2C_AckType;






typedef struct
{
    uint32_t sclFrequency;
} I2C_MasterConfigType;







typedef struct
{
    uint8_t ownAddress;
    uint8_t enableGeneralCall;
} I2C_SlaveConfigType;
# 78 "Src/../MCL/I2C/i2c_interface.h"
Std_ReturnType I2C_InitMaster(const I2C_MasterConfigType *addConfig);
# 87 "Src/../MCL/I2C/i2c_interface.h"
Std_ReturnType I2C_InitSlave(const I2C_SlaveConfigType *addConfig);





Std_ReturnType I2C_DeInit(void);






Std_ReturnType I2C_Start(void);





Std_ReturnType I2C_Stop(void);







Std_ReturnType I2C_WriteByte(uint8_t uint8Data);






Std_ReturnType I2C_ReadByteWithAck(uint8_t *puint8Data);






Std_ReturnType I2C_ReadByteWithNack(uint8_t *puint8Data);






uint8_t I2C_GetStatus(void);
# 144 "Src/../MCL/I2C/i2c_interface.h"
Std_ReturnType I2C_MasterWrite(uint8_t slaveAddress, const uint8_t *pData, uint16_t length);
# 154 "Src/../MCL/I2C/i2c_interface.h"
Std_ReturnType I2C_MasterRead(uint8_t slaveAddress, uint8_t *pBuffer, uint16_t length);
# 27 "Src/main.c" 2


# 1 "Src/../HAL/DC_Motor/dc_motor.h" 1



# 1 "Src/../HAL/DC_Motor/../../Service/STD_Types.h" 1
# 5 "Src/../HAL/DC_Motor/dc_motor.h" 2
# 1 "Src/../HAL/DC_Motor/../../MCL/GPIO/gpio_interface.h" 1
# 6 "Src/../HAL/DC_Motor/dc_motor.h" 2
# 86 "Src/../HAL/DC_Motor/dc_motor.h"
typedef enum
{
    DC_MOTOR_PWM_NONE = 0,
    DC_MOTOR_PWM_OC0 = 1,
    DC_MOTOR_PWM_OC1A = 2,
    DC_MOTOR_PWM_OC1B = 3,
    DC_MOTOR_PWM_OC2 = 4
} DC_MotorPwmChannelType;






typedef enum
{
    DC_MOTOR_DIR_FORWARD = 0,
    DC_MOTOR_DIR_BACKWARD = 1
} DC_MotorDirectionType;
# 115 "Src/../HAL/DC_Motor/dc_motor.h"
typedef enum
{
    DC_MOTOR_STATE_STOP = 0,
    DC_MOTOR_STATE_FORWARD = 1,
    DC_MOTOR_STATE_BACKWARD = 2,
    DC_MOTOR_STATE_BRAKE = 3
} DC_MotorStateType;
# 143 "Src/../HAL/DC_Motor/dc_motor.h"
typedef struct
{

    uint8_t in1Port; uint8_t in1Pin;
    uint8_t in2Port; uint8_t in2Pin;
    uint8_t enPort; uint8_t enPin;
    DC_MotorPwmChannelType pwmChannel;
    uint8_t invertDirection;


    uint8_t initialized;
    uint8_t speedPercent;
    DC_MotorStateType state;
} DC_MotorHandleType;
# 174 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Init(DC_MotorHandleType *handle);
# 189 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_SetSpeed(DC_MotorHandleType *handle, uint8_t speedPercent);
# 200 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Forward(DC_MotorHandleType *handle);






Std_ReturnType DC_Motor_Backward(DC_MotorHandleType *handle);
# 216 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_SetDirection(DC_MotorHandleType *handle, DC_MotorDirectionType dir);
# 225 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Stop(DC_MotorHandleType *handle);
# 236 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Brake(DC_MotorHandleType *handle);
# 245 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_GetState(const DC_MotorHandleType *handle, DC_MotorStateType *pState);







Std_ReturnType DC_Motor_GetSpeed(const DC_MotorHandleType *handle, uint8_t *pSpeed);
# 264 "Src/../HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_DeInit(DC_MotorHandleType *handle);
# 30 "Src/main.c" 2
# 1 "Src/../HAL/Tachometer/Tachometer.h" 1






void TACHO_Init(void);
void TACHO_Update(void);
void TACHO_PulseISR(void);
int16_t TACHO_GetRPM(void);
# 31 "Src/main.c" 2
# 1 "Src/../HAL/ANALOG_SENSOR/ANALOG_SENSOR.h" 1







typedef enum
{
    ANALOG_CH_SETPOINT = 0,
    ANALOG_CH_CURRENT,
    ANALOG_CH_BUS_VOLTAGE,
    ANALOG_CH_TEMPERATURE,
    ANALOG_CH_COUNT
} AnalogChannel_t;

void ANALOG_Init(void);
void ANALOG_Update(void);

uint16_t ANALOG_GetSetpoint(void);
uint16_t ANALOG_GetCurrent(void);
uint16_t ANALOG_GetBusVoltage(void);
uint8_t ANALOG_GetTemperature(void);
# 32 "Src/main.c" 2
# 1 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h" 1



# 1 "Src/../HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h" 1
# 5 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h" 2
# 1 "Src/../HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h" 1
# 6 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h" 2
# 101 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
typedef struct
{

    uint8_t i2cAddress;
    uint8_t rows;
    uint8_t cols;


    uint8_t initialized;
    uint8_t displayControl;
    uint8_t entryMode;
    uint8_t cursorRow;
    uint8_t cursorCol;
} LCD_Aip31068_HandleType;
# 132 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle);
# 141 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command);







Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character);
# 161 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString);
# 171 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle,
                                          uint8_t row, uint8_t column,
                                          const uint8_t *pString);
# 183 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_WriteNumber(LCD_Aip31068_HandleType *handle, sint32 number);
# 193 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_SetCursor(LCD_Aip31068_HandleType *handle,
                                      uint8_t row, uint8_t column);







Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle);






Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle);







Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);







Std_ReturnType LCD_Aip31068_CursorOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);







Std_ReturnType LCD_Aip31068_BlinkOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);
# 242 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_ShiftDisplay(LCD_Aip31068_HandleType *handle, uint8_t toRight);
# 252 "Src/../HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_CreateCustomChar(LCD_Aip31068_HandleType *handle,
                                             uint8_t location, const uint8_t *pPattern);
# 33 "Src/main.c" 2
# 1 "Src/../HAL/BUZZER/BUZZER.h" 1





typedef enum
{
    BUZZ_OFF,
    BUZZ_ON,
    BUZZ_BEEP,
    BUZZ_ALARM
} BuzzerMode_t;

void BUZZER_Init(void);
void BUZZER_SetMode(BuzzerMode_t mode);

void BUZZER_Update(void);
# 34 "Src/main.c" 2
# 1 "Src/../HAL/Stepper_L298P/Stepper_L298P.h" 1



# 1 "Src/../HAL/Stepper_L298P/../../Service/STD_Types.h" 1
# 5 "Src/../HAL/Stepper_L298P/Stepper_L298P.h" 2
# 1 "Src/../HAL/Stepper_L298P/../../MCL/GPIO/gpio_interface.h" 1
# 6 "Src/../HAL/Stepper_L298P/Stepper_L298P.h" 2
# 73 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
typedef enum
{
    STEPPER_L298P_MODE_WAVE = 0,
    STEPPER_L298P_MODE_FULL = 1,
    STEPPER_L298P_MODE_HALF = 2
} Stepper_L298P_ModeType;







typedef enum
{
    STEPPER_L298P_DIR_CW = 0,
    STEPPER_L298P_DIR_CCW = 1
} Stepper_L298P_DirType;
# 117 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
typedef struct
{

    uint8_t in1Port; uint8_t in1Pin;
    uint8_t in2Port; uint8_t in2Pin;
    uint8_t in3Port; uint8_t in3Pin;
    uint8_t in4Port; uint8_t in4Pin;
    uint8_t enAPort; uint8_t enAPin;
    uint8_t enBPort; uint8_t enBPin;
    uint8_t useEnablePins;

    Stepper_L298P_ModeType stepMode;
    uint16_t stepsPerRev;
    uint16_t stepDelayMs;


    uint8_t initialized;
    uint8_t phaseIndex;
    uint8_t energized;
    sint32 position;
} Stepper_L298P_HandleType;
# 152 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_Init(Stepper_L298P_HandleType *handle);
# 163 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_SetStepMode(Stepper_L298P_HandleType *handle,
                                         Stepper_L298P_ModeType mode);







Std_ReturnType Stepper_L298P_SetStepDelay(Stepper_L298P_HandleType *handle,
                                          uint16_t stepDelayMs);
# 185 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_SetSpeedRpm(Stepper_L298P_HandleType *handle, uint16_t rpm);
# 199 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_Step(Stepper_L298P_HandleType *handle,
                                  uint16_t steps, Stepper_L298P_DirType dir);
# 222 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_StepOnce(Stepper_L298P_HandleType *handle,
                                      Stepper_L298P_DirType dir);
# 236 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_RotateAngle(Stepper_L298P_HandleType *handle,
                                         uint16_t degrees, Stepper_L298P_DirType dir);
# 247 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_Hold(Stepper_L298P_HandleType *handle);
# 258 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_Release(Stepper_L298P_HandleType *handle);
# 267 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_GetPosition(const Stepper_L298P_HandleType *handle,
                                         sint32 *pPosition);







Std_ReturnType Stepper_L298P_ResetPosition(Stepper_L298P_HandleType *handle);
# 286 "Src/../HAL/Stepper_L298P/Stepper_L298P.h"
Std_ReturnType Stepper_L298P_GetStepsPerRev(const Stepper_L298P_HandleType *handle,
                                            uint16_t *pStepsPerRev);
# 35 "Src/main.c" 2


DriveData_t g_driveData;
DriveCfg_t g_driveCfg;
PI_Handle_t g_pi;
Ramp_t g_ramp;


volatile uint8_t g_estopFlag = 0;


void Task_Panel(void);
void Task_Current(void);
void Task_Control(void);
void Task_LCD(void);
void Task_SlowSensors(void);
void Task_Telemetry(void);


int main(void)
{


    BRIDGE_Init();


    ADC_ConfigType adcCfg = {
        .uint8ReferenceVoltage = 1,
        .uint8Prescaler = 7
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
        .baudRate = 9600UL,
        .dataSize = UART_DATA_8BITS,
        .parity = UART_PARITY_NONE,
        .stopBits = UART_STOP_1BIT
    };
    I2C_MasterConfigType i2cCfg = {
        .sclFrequency = 100000UL
    };

    ADC_Init(&adcCfg);
    Timer0_Init();
    Timer1_Init();
    Timer2_Init();
    EXTI_Init(&extiCfg1);
    EXTI_Init(&extiCfg0);
    UART_Init(&uartCfg);
    I2C_InitMaster(&i2cCfg);


    TACHO_Init();
    ANALOG_Init();
    PANEL_Init();
    BUZZER_Init();
    EEPROM_Init();
    TRIPLOG_Init();


    if (!EEPROM_LoadConfig(&g_driveCfg)) {

        EEPROM_LoadDefaults(&g_driveCfg);
        EEPROM_SaveConfig(&g_driveCfg);
    }


    Trip_t latchedTrip = EEPROM_LoadLatchTrip();
    if (latchedTrip != TRIP_NONE) {
        g_driveCfg.latchedTrip = latchedTrip;
        g_driveData.activeTrip = latchedTrip;
        FSM_RequestTrip(latchedTrip);
    }


    DataManager_Init(&g_driveData, &g_driveCfg);
    PI_Init(&g_pi, g_driveCfg.kp, g_driveCfg.ki);
    PI_InitLimits(&g_pi, 40, 399);

    RAMP_Init(&g_ramp);
    RAMP_SetLimits(&g_ramp, g_driveCfg.minRpm, g_driveCfg.maxRpm);
    RAMP_SetRates(&g_ramp, g_driveCfg.accelRpmPerSec, g_driveCfg.decelRpmPerSec);

    PROTECT_Init();

    FSM_Init();
    FSM_SetDeadTime(g_driveCfg.deadTimeMs);

    CONSOLE_Init();
    TELEMETRY_Init();


    SCHED_Init();
    SCHED_AddTask(Task_Panel, "Panel", 10, 0);
    SCHED_AddTask(Task_Current, "Current", 50, 1);
    SCHED_AddTask(Task_Control, "Control", 100, 2);
    SCHED_AddTask(Task_LCD, "LCD", 250, 4);
    SCHED_AddTask(Task_SlowSensors, "SlowSensors", 500, 3);
    SCHED_AddTask(Task_Telemetry, "Telemetry", 1000, 5);


    asm volatile("sei"::);


    while (1) {
        SCHED_Run();


        if (CONSOLE_IsCommandReady()) {
            CONSOLE_ExecuteCommand();
        }
    }

    return 0;
}







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


    DataManager_UpdateDuty(duty);
    BRIDGE_SetDuty(duty);
    BRIDGE_SetDirection(g_driveData.direction);


    FSM_Run();


    DataManager_UpdateError();
}





void Task_LCD(void)
{
    if (FSM_IsTripped()) {
        LCD_ShowTrip(g_driveData.activeTrip);
    } else {
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

    if (FSM_IsRunning() && g_driveData.measuredRpm >= g_driveCfg.minRpm) {
        DataManager_IncrementRunSeconds();
    }


    TELEMETRY_Update(&g_driveData);
}








# 346 "Src/main.c" 3
void __vector_1 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_1 (void)

# 347 "Src/main.c"
{

    TACHO_OnPulse();
}
# 360 "Src/main.c"

# 360 "Src/main.c" 3
void __vector_2 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_2 (void)

# 361 "Src/main.c"
{

    
# 363 "Src/main.c" 3
   (*(volatile uint16_t *)((0x2A) + 0x20)) 
# 363 "Src/main.c"
         = 0;


    ((
# 366 "Src/main.c" 3
   (*(volatile uint8_t *)((0x18) + 0x20))
# 366 "Src/main.c"
   ) &= ~(1 << (
# 366 "Src/main.c" 3
   2
# 366 "Src/main.c"
   )));
    ((
# 367 "Src/main.c" 3
   (*(volatile uint8_t *)((0x18) + 0x20))
# 367 "Src/main.c"
   ) &= ~(1 << (
# 367 "Src/main.c" 3
   1
# 367 "Src/main.c"
   )));
    ((
# 368 "Src/main.c" 3
   (*(volatile uint8_t *)((0x18) + 0x20))
# 368 "Src/main.c"
   ) &= ~(1 << (
# 368 "Src/main.c" 3
   0
# 368 "Src/main.c"
   )));


    g_estopFlag = 1;


}





# 379 "Src/main.c" 3
void __vector_13 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_13 (void)

# 380 "Src/main.c"
{
    uint8_t ch = 
# 381 "Src/main.c" 3
                (*(volatile uint8_t *)((0x0C) + 0x20))
# 381 "Src/main.c"
                   ;
    CONSOLE_ProcessChar(ch);
}
