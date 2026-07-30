# 1 "MCL/Timer/timer_modified.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCL/Timer/timer_modified.c"
# 1 "MCL/Timer/../../Service/STD_Types.h" 1



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
# 5 "MCL/Timer/../../Service/STD_Types.h" 2



# 7 "MCL/Timer/../../Service/STD_Types.h"
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
# 55 "MCL/Timer/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "MCL/Timer/timer_modified.c" 2
# 1 "MCL/Timer/../../Service/Bit_Math.h" 1
# 3 "MCL/Timer/timer_modified.c" 2
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
# 4 "MCL/Timer/timer_modified.c" 2
# 1 "MCL/Timer/timer_registers.h" 1
# 5 "MCL/Timer/timer_modified.c" 2
# 1 "MCL/Timer/timer_interface.h" 1
# 23 "MCL/Timer/timer_interface.h"

# 23 "MCL/Timer/timer_interface.h"
typedef enum
{
    TIMER_CHANNEL_0 = 0,
    TIMER_CHANNEL_1 = 1,
    TIMER_CHANNEL_2 = 2,
    TIMER_CHANNEL_MAX
} Timer_ChannelType;
# 39 "MCL/Timer/timer_interface.h"
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
# 85 "MCL/Timer/timer_interface.h"
typedef struct
{
    Timer_ChannelType channel;
    Timer_ModeType mode;
    Timer_PrescalerType prescaler;
    uint16_t initialValue;
    uint16_t compareValue;
} Timer_ConfigType;






typedef void (*Timer_CallBackType)(void);
# 111 "MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_Init(void);
# 120 "MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 129 "MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 139 "MCL/Timer/timer_interface.h"
Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType,
                                  Timer_CallBackType callBack);







Std_ReturnType Timer1_Init(void);






Std_ReturnType Timer1_SetDuty(uint16_t duty_percent);







Std_ReturnType Timer2_Init(void);






Std_ReturnType Timer2_SetTone(uint16_t tone);






void Timer_EnableGlobalInterrupt(void);






void Timer_DisableGlobalInterrupt(void);
# 6 "MCL/Timer/timer_modified.c" 2
# 1 "MCL/Timer/../GPIO/GPIO_interface.h" 1



# 1 "MCL/Timer/../GPIO/../../Service/STD_Types.h" 1
# 5 "MCL/Timer/../GPIO/GPIO_interface.h" 2
# 30 "MCL/Timer/../GPIO/GPIO_interface.h"
typedef unsigned char GPIO_pin_status;
typedef unsigned char GPIO_port_status;



Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction);
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin, uint8_t *pu8PinStatus);
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value);


Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction);
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port, uint8_t *pu8PortStatus);
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value);
# 7 "MCL/Timer/timer_modified.c" 2





static Timer_CallBackType Timer0_CompareMatch_CallBack = ((void *)0);




Std_ReturnType Timer0_Init()
{
    (((*(volatile uint8_t *)0x53)) &= ~(1 << (6)));
    (((*(volatile uint8_t *)0x53)) |= (1 << (3)));

    (*(volatile uint8_t *)0x52) = 0;
    (*(volatile uint8_t *)0x5C) = 77;
    (((*(volatile uint8_t *)0x53)) |= (1 << (2)));
    (((*(volatile uint8_t *)0x53)) &= ~(1 << (1)));
    (((*(volatile uint8_t *)0x53)) |= (1 << (0)));
    return ((Std_ReturnType)0x00);
}

Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType)
{
    if (channel != TIMER_CHANNEL_0)
    {
        return ((Std_ReturnType)0x01);
    }
    else
    {
        (((*(volatile uint8_t *)0x59)) |= (1 << ((intType == TIMER_INT_OVERFLOW) ? 0 : 1)));
        return ((Std_ReturnType)0x00);
    }
}

Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType)
{
    if (channel != TIMER_CHANNEL_0)
    {
        return ((Std_ReturnType)0x01);
    }
    else
    {
        (((*(volatile uint8_t *)0x59)) &= ~(1 << ((intType == TIMER_INT_OVERFLOW) ? 0 : 1)));
        return ((Std_ReturnType)0x00);
    }
}

Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType, Timer_CallBackType callBack)
{
    if (callBack == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }


    Timer0_CompareMatch_CallBack = callBack;
    return ((Std_ReturnType)0x00);
}



# 69 "MCL/Timer/timer_modified.c" 3
void __vector_10 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_10 (void)

# 70 "MCL/Timer/timer_modified.c"
{
    if (Timer0_CompareMatch_CallBack != ((void *)0))
    {
        Timer0_CompareMatch_CallBack();
    }
}



Std_ReturnType Timer1_Init()
{
    (((*(volatile uint8_t *)0x4F)) &= ~(1 << (0)));
    (((*(volatile uint8_t *)0x4F)) |= (1 << (1)));
    (((*(volatile uint8_t *)0x4E)) |= (1 << (3)));
    (((*(volatile uint8_t *)0x4E)) |= (1 << (4)));

    (((*(volatile uint8_t *)0x4F)) &= ~(1 << (6)));
    (((*(volatile uint8_t *)0x4F)) |= (1 << (7)));
    (*(volatile uint16_t *)0x4C) = 0;
    (*(volatile uint16_t *)0x46) = 399;
    (((*(volatile uint8_t *)0x4E)) &= ~(1 << (2)));
    (((*(volatile uint8_t *)0x4E)) &= ~(1 << (1)));
    (((*(volatile uint8_t *)0x4E)) |= (1 << (0)));
    GPIO_set_pin_Direction(3, 5, 1);
    return ((Std_ReturnType)0x00);
}

Std_ReturnType Timer1_SetDuty(uint16_t duty_percent)
{
    if (duty_percent > 100)
    {
        return ((Std_ReturnType)0x01);
    }
    else if (duty_percent == 0)
    {
        (*(volatile uint16_t *)0x4A) = 0;
    }
    else
    {
        (*(volatile uint16_t *)0x4A) = (((uint32_t)duty_percent * (399 + 1)) / 100) - 1;
    }
    return ((Std_ReturnType)0x00);
}



Std_ReturnType Timer2_Init()
{
    (((*(volatile uint8_t *)0x45)) &= ~(1 << (6)));
    (((*(volatile uint8_t *)0x45)) |= (1 << (3)));

    (*(volatile uint8_t *)0x44) = 0;
    (((*(volatile uint8_t *)0x45)) |= (1 << (2)));
    (((*(volatile uint8_t *)0x45)) &= ~(1 << (1)));
    (((*(volatile uint8_t *)0x45)) |= (1 << (0)));


    (((*(volatile uint8_t *)0x45)) &= ~(1 << (5)));
    (((*(volatile uint8_t *)0x45)) |= (1 << (4)));
    GPIO_set_pin_Direction(3, 7, 1);
    return ((Std_ReturnType)0x00);
}

Std_ReturnType Timer2_SetTone(uint16_t tone)
{
    if (tone > 255)
    {
        return ((Std_ReturnType)0x01);
    }
    else
    {
        (*(volatile uint8_t *)0x43) = tone;
    }
    return ((Std_ReturnType)0x00);
}



void Timer_EnableGlobalInterrupt(void)
{
    (((*(volatile uint8_t *)0x5F)) |= (1 << (7)));
}

void Timer_DisableGlobalInterrupt(void)
{
    (((*(volatile uint8_t *)0x5F)) &= ~(1 << (7)));
}
