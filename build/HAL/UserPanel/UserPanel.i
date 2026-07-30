# 1 "HAL/UserPanel/UserPanel.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "HAL/UserPanel/UserPanel.c"






# 1 "HAL/UserPanel/UserPanel.h" 1
# 10 "HAL/UserPanel/UserPanel.h"
# 1 "Src/../Service/STD_Types.h" 1



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
# 55 "Src/../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 11 "HAL/UserPanel/UserPanel.h" 2
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
# 152 "Src/../Logic/Data/data_types.h"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 12 "HAL/UserPanel/UserPanel.h" 2


typedef enum {
    PNL_NONE = 0,
    PNL_START,
    PNL_STOP,
    PNL_REVERSE,
    PNL_RESET
} Panel_Event_t;







Std_ReturnType PANEL_Init(void);




void PANEL_Poll(void);





Panel_Event_t PANEL_GetEvent(void);





uint8_t PANEL_IsLocalMode(void);






void PANEL_SetRunLED(uint8_t state, uint8_t blink);





void PANEL_SetFaultLED(uint8_t state);





void PANEL_SetDirectionLEDs(MotorDir_t dir);
# 8 "HAL/UserPanel/UserPanel.c" 2
# 1 "Src/../MCL/GPIO/GPIO_Interface.h" 1



# 1 "Src/../MCL/GPIO/../../Service/STD_Types.h" 1
# 5 "Src/../MCL/GPIO/GPIO_Interface.h" 2
# 30 "Src/../MCL/GPIO/GPIO_Interface.h"
typedef unsigned char GPIO_pin_status;
typedef unsigned char GPIO_port_status;



Std_ReturnType GPIO_set_pin_Direction(uint8_t port, uint8_t pin, uint8_t direction);
Std_ReturnType GPIO_set_pin_value(uint8_t port, uint8_t pin, uint8_t value);
Std_ReturnType GPIO_write_pin(uint8_t port, uint8_t pin, uint8_t value);
GPIO_pin_status GPIO_read_pin(uint8_t port, uint8_t pin);
Std_ReturnType GPIO_toggle_pin(uint8_t port, uint8_t pin);
# 9 "HAL/UserPanel/UserPanel.c" 2
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


uint32_t TIMER_GetTick(void);
# 10 "HAL/UserPanel/UserPanel.c" 2
# 1 "HAL/UserPanel/../../Service/STD_Types.h" 1
# 11 "HAL/UserPanel/UserPanel.c" 2
# 27 "HAL/UserPanel/UserPanel.c"
static Panel_Event_t g_lastEvent = PNL_NONE;
static uint8_t g_buttonStates[4] = {0};
static uint8_t g_debounceCounters[4] = {0};
static uint8_t g_previousStates[4] = {0};
static uint8_t g_blinkCounter = 0;



Std_ReturnType PANEL_Init(void)
{

    GPIO_set_pin_Direction(2, 5, 0);
    GPIO_set_pin_Direction(2, 6, 0);
    GPIO_set_pin_Direction(2, 7, 0);
    GPIO_set_pin_Direction(3, 6, 0);
    GPIO_set_pin_Direction(3, 4, 0);


    GPIO_set_pull_up(2, 5, 1);
    GPIO_set_pull_up(2, 6, 1);
    GPIO_set_pull_up(2, 7, 1);
    GPIO_set_pull_up(3, 6, 1);
    GPIO_set_pull_up(3, 4, 1);


    GPIO_set_pin_Direction(1, 3, 1);
    GPIO_set_pin_Direction(2, 2, 1);
    GPIO_set_pin_Direction(2, 3, 1);
    GPIO_set_pin_Direction(2, 4, 1);


    GPIO_write_pin(1, 3, 0);
    GPIO_write_pin(2, 2, 0);
    GPIO_write_pin(2, 3, 0);
    GPIO_write_pin(2, 4, 0);

    return ((Std_ReturnType)0x00);
}

void PANEL_Poll(void)
{

    uint8_t start = (GPIO_read_pin(2, 5) == 0);
    uint8_t stop = (GPIO_read_pin(2, 6) == 0);
    uint8_t rev = (GPIO_read_pin(2, 7) == 0);
    uint8_t reset = (GPIO_read_pin(3, 6) == 0);

    uint8_t states[4] = {start, stop, rev, reset};
    Panel_Event_t events[4] = {PNL_START, PNL_STOP, PNL_REVERSE, PNL_RESET};


    for (uint8_t i = 0; i < 4; i++) {
        if (states[i] != g_previousStates[i]) {
            g_debounceCounters[i] = 0;
            g_previousStates[i] = states[i];
        } else {
            if (states[i] == 1) {
                g_debounceCounters[i]++;
                if (g_debounceCounters[i] >= 5) {
                    if (g_buttonStates[i] == 0) {
                        g_buttonStates[i] = 1;
                        g_lastEvent = events[i];
                    }
                }
            } else {
                g_debounceCounters[i] = 0;
                g_buttonStates[i] = 0;
            }
        }
    }
}

Panel_Event_t PANEL_GetEvent(void)
{
    Panel_Event_t event = g_lastEvent;
    g_lastEvent = PNL_NONE;
    return event;
}

uint8_t PANEL_IsLocalMode(void)
{

    return (GPIO_read_pin(3, 4) == 0) ? 1 : 0;
}

void PANEL_SetRunLED(uint8_t state, uint8_t blink)
{
    if (blink) {
        g_blinkCounter++;
        if (g_blinkCounter >= 10) {
            g_blinkCounter = 0;
            GPIO_toggle_pin(1, 3);
        }
    } else {
        GPIO_write_pin(1, 3, state ? 1 : 0);
    }
}

void PANEL_SetFaultLED(uint8_t state)
{
    GPIO_write_pin(2, 2, state ? 1 : 0);
}

void PANEL_SetDirectionLEDs(MotorDir_t dir)
{
    switch (dir) {
        case DIR_FORWARD:
            GPIO_write_pin(2, 3, 1);
            GPIO_write_pin(2, 4, 0);
            break;
        case DIR_REVERSE:
            GPIO_write_pin(2, 3, 0);
            GPIO_write_pin(2, 4, 1);
            break;
        case DIR_STOP:
        default:
            GPIO_write_pin(2, 3, 0);
            GPIO_write_pin(2, 4, 0);
            break;
    }
}
