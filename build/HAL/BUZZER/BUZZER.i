# 1 "HAL/BUZZER/BUZZER.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "HAL/BUZZER/BUZZER.c"
# 1 "HAL/BUZZER/../../Service/STD_Types.h" 1



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
# 5 "HAL/BUZZER/../../Service/STD_Types.h" 2



# 7 "HAL/BUZZER/../../Service/STD_Types.h"
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
# 55 "HAL/BUZZER/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "HAL/BUZZER/BUZZER.c" 2
# 1 "HAL/BUZZER/../../MCL/Timer/timer_interface.h" 1



# 1 "HAL/BUZZER/../../MCL/Timer/../../Service/STD_Types.h" 1
# 5 "HAL/BUZZER/../../MCL/Timer/timer_interface.h" 2
# 1 "HAL/BUZZER/../../MCL/Timer/timer_registers.h" 1
# 6 "HAL/BUZZER/../../MCL/Timer/timer_interface.h" 2
# 23 "HAL/BUZZER/../../MCL/Timer/timer_interface.h"
typedef enum
{
    TIMER_CHANNEL_0 = 0,
    TIMER_CHANNEL_1 = 1,
    TIMER_CHANNEL_2 = 2,
    TIMER_CHANNEL_MAX
} Timer_ChannelType;
# 39 "HAL/BUZZER/../../MCL/Timer/timer_interface.h"
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
# 85 "HAL/BUZZER/../../MCL/Timer/timer_interface.h"
typedef struct
{
    Timer_ChannelType channel;
    Timer_ModeType mode;
    Timer_PrescalerType prescaler;
    uint16_t initialValue;
    uint16_t compareValue;
} Timer_ConfigType;






typedef void (*Timer_CallBackType)(void);
# 111 "HAL/BUZZER/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_Init(void);
# 120 "HAL/BUZZER/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 129 "HAL/BUZZER/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 139 "HAL/BUZZER/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType,
                                  Timer_CallBackType callBack);







Std_ReturnType Timer1_Init(void);






Std_ReturnType Timer1_SetDuty(uint16_t duty_percent);







Std_ReturnType Timer2_Init(void);






Std_ReturnType Timer2_SetTone(uint16_t tone);






void Timer_EnableGlobalInterrupt(void);






void Timer_DisableGlobalInterrupt(void);


uint32_t TIMER_GetTick(void);
# 3 "HAL/BUZZER/BUZZER.c" 2
# 1 "HAL/BUZZER/BUZZER.h" 1
# 10 "HAL/BUZZER/BUZZER.h"
typedef enum
{
    BUZZ_OFF = 0,
    BUZZ_SLOW,
    BUZZ_FAST,
    BUZZ_CONTINUOUS
} Buzzer_Mode_t;
# 29 "HAL/BUZZER/BUZZER.h"
extern Buzzer_Mode_t Buzzer_CurrentMode;
extern uint16_t Buzzer_TickCounter;




Std_ReturnType BUZZER_Init(void);
Std_ReturnType BUZZER_SetMode(Buzzer_Mode_t mode);
void BUZZER_Update(void);
# 4 "HAL/BUZZER/BUZZER.c" 2


Buzzer_Mode_t Buzzer_CurrentMode = BUZZ_OFF;
uint16_t Buzzer_TickCounter = 0;

Std_ReturnType BUZZER_Init(void)
{
    Buzzer_CurrentMode = BUZZ_OFF;
    Buzzer_TickCounter = 0;
    return Timer2_Init();
}

Std_ReturnType BUZZER_SetMode(Buzzer_Mode_t mode)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    Buzzer_CurrentMode = mode;
    Buzzer_TickCounter = 0;

    switch (mode)
    {
        case BUZZ_OFF:
            local_Status = Timer2_SetTone(0);
            break;
        case BUZZ_SLOW:
            local_Status = Timer2_SetTone(150);
            break;
        case BUZZ_FAST:
            local_Status = Timer2_SetTone(60);
            break;
        case BUZZ_CONTINUOUS:
            local_Status = Timer2_SetTone(60);
            break;
        default:
            local_Status = ((Std_ReturnType)0x01);
            break;
    }

    return local_Status;
}

void BUZZER_Update(void)
{
    uint16_t period;

    if (Buzzer_CurrentMode == BUZZ_OFF || Buzzer_CurrentMode == BUZZ_CONTINUOUS)
    {
        return;
    }

    period = (Buzzer_CurrentMode == BUZZ_SLOW) ? 50
                                                : 10;

    Buzzer_TickCounter++;

    if (Buzzer_TickCounter >= period)
    {
        Buzzer_TickCounter = 0;

        static uint8_t soundOn = 1;
        if (soundOn)
        {
            Timer2_SetTone(0);
        }
        else
        {
            Timer2_SetTone((Buzzer_CurrentMode == BUZZ_SLOW) ? 150 : 60);
        }
        soundOn = !soundOn;
    }
}
