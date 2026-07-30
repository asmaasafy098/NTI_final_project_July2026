# 1 "MCL/Interrupt/interrupt.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCL/Interrupt/interrupt.c"
# 1 "MCL/Interrupt/../../Service/STD_Types.h" 1



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
# 5 "MCL/Interrupt/../../Service/STD_Types.h" 2



# 7 "MCL/Interrupt/../../Service/STD_Types.h"
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
# 55 "MCL/Interrupt/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "MCL/Interrupt/interrupt.c" 2
# 1 "MCL/Interrupt/../../Service/Bit_Math.h" 1
# 3 "MCL/Interrupt/interrupt.c" 2
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 1 3
# 38 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 3
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 1 3
# 99 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 1 3
# 126 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 3
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 1 3
# 77 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3

# 77 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 127 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 2 3
# 100 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 244 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 1 3
# 720 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 3
       
# 721 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 245 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 703 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\portpins.h" 1 3
# 704 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3

# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\common.h" 1 3
# 706 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3

# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\version.h" 1 3
# 708 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3






# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\fuse.h" 1 3
# 248 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 715 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3


# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\lock.h" 1 3
# 718 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 39 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 2 3
# 4 "MCL/Interrupt/interrupt.c" 2
# 1 "MCL/Interrupt/interrupt_registers.h" 1
# 5 "MCL/Interrupt/interrupt.c" 2
# 1 "MCL/Interrupt/interrupt_interface.h" 1
# 21 "MCL/Interrupt/interrupt_interface.h"

# 21 "MCL/Interrupt/interrupt_interface.h"
typedef enum
{
    EXTI_INT0 = 0,
    EXTI_INT1 = 1,
    EXTI_INT2 = 2,
    EXTI_LINE_MAX
} EXTI_LineType;


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





Std_ReturnType EXTI_Init(const EXTI_ConfigType *addConfig);
Std_ReturnType EXTI_Enable(EXTI_LineType line);
Std_ReturnType EXTI_Disable(EXTI_LineType line);
Std_ReturnType EXTI_SetSenseControl(EXTI_LineType line, EXTI_SenseType sense);
Std_ReturnType EXTI_SetCallBack(EXTI_LineType line, EXTI_CallBackType callBack);
void EXTI_EnableGlobalInterrupt(void);
void EXTI_DisableGlobalInterrupt(void);
# 6 "MCL/Interrupt/interrupt.c" 2





static EXTI_CallBackType EXTI_CallBacks[EXTI_LINE_MAX] = { ((void *)0), ((void *)0), ((void *)0) };

Std_ReturnType EXTI_Init(const EXTI_ConfigType *addConfig)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);


    if ((addConfig == ((void *)0)) || (addConfig->line >= EXTI_LINE_MAX))
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {

        local_Status = EXTI_SetSenseControl(addConfig->line, addConfig->sense);

        if (local_Status == ((Std_ReturnType)0x00))
        {

            switch (addConfig->line)
            {
                case EXTI_INT0:
                    (((*(volatile u8 *)0x5A)) |= (1 << (6)));
                    break;
                case EXTI_INT1:
                    (((*(volatile u8 *)0x5A)) |= (1 << (7)));
                    break;
                case EXTI_INT2:
                    (((*(volatile u8 *)0x5A)) |= (1 << (5)));
                    break;
                default:
                    local_Status = ((Std_ReturnType)0x01);
                    break;
            }

            if (local_Status == ((Std_ReturnType)0x00))
            {

                local_Status = EXTI_Enable(addConfig->line);
            }
        }
    }


    return local_Status;
}


Std_ReturnType EXTI_Enable(EXTI_LineType line)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if (line >= EXTI_LINE_MAX)
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        switch (line)
        {
            case EXTI_INT0:
                (((*(volatile u8 *)0x5B)) |= (1 << (6)));
                break;
            case EXTI_INT1:
                (((*(volatile u8 *)0x5B)) |= (1 << (7)));
                break;
            case EXTI_INT2:
                (((*(volatile u8 *)0x5B)) |= (1 << (5)));
                break;
            default:
                local_Status = ((Std_ReturnType)0x01);
                break;
        }
    }

    return local_Status;
}


Std_ReturnType EXTI_Disable(EXTI_LineType line)
{
  Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if (line >= EXTI_LINE_MAX)
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        switch (line)
        {
            case EXTI_INT0:
                (((*(volatile u8 *)0x5B)) &= ~(1 << (6)));
                break;
            case EXTI_INT1:
                (((*(volatile u8 *)0x5B)) &= ~(1 << (7)));
                break;
            case EXTI_INT2:
                (((*(volatile u8 *)0x5B)) &= ~(1 << (5)));
                break;
            default:
                local_Status = ((Std_ReturnType)0x01);
                break;
        }
    }

    return local_Status;
}


Std_ReturnType EXTI_SetSenseControl(EXTI_LineType line, EXTI_SenseType sense)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if (line >= EXTI_LINE_MAX)
    {
        return ((Std_ReturnType)0x01);
    }

    switch (line)
    {
        case EXTI_INT0:
            (((*(volatile u8 *)0x55)) &= ~(1 << (0)));
            (((*(volatile u8 *)0x55)) &= ~(1 << (1)));
            switch (sense)
            {
                case EXTI_SENSE_LOW_LEVEL: break;
                case EXTI_SENSE_ANY_CHANGE: (((*(volatile u8 *)0x55)) |= (1 << (0))); break;
                case EXTI_SENSE_FALLING: (((*(volatile u8 *)0x55)) |= (1 << (1))); break;
                case EXTI_SENSE_RISING:
                    (((*(volatile u8 *)0x55)) |= (1 << (0)));
                    (((*(volatile u8 *)0x55)) |= (1 << (1)));
                    break;
                default:
                    local_Status = ((Std_ReturnType)0x01);
                    break;
            }
            break;

        case EXTI_INT1:
            (((*(volatile u8 *)0x55)) &= ~(1 << (2)));
            (((*(volatile u8 *)0x55)) &= ~(1 << (3)));
            switch (sense)
            {
                case EXTI_SENSE_LOW_LEVEL: break;
                case EXTI_SENSE_ANY_CHANGE: (((*(volatile u8 *)0x55)) |= (1 << (2))); break;
                case EXTI_SENSE_FALLING: (((*(volatile u8 *)0x55)) |= (1 << (3))); break;
                case EXTI_SENSE_RISING:
                    (((*(volatile u8 *)0x55)) |= (1 << (2)));
                    (((*(volatile u8 *)0x55)) |= (1 << (3)));
                    break;
                default:
                    local_Status = ((Std_ReturnType)0x01);
                    break;
            }
            break;

        case EXTI_INT2:
            switch (sense)
            {
                case EXTI_SENSE_FALLING:
                    (((*(volatile u8 *)0x54)) &= ~(1 << (6)));
                    break;
                case EXTI_SENSE_RISING:
                    (((*(volatile u8 *)0x54)) |= (1 << (6)));
                    break;
                case EXTI_SENSE_LOW_LEVEL:
                case EXTI_SENSE_ANY_CHANGE:
                default:
                    local_Status = ((Std_ReturnType)0x01);
                    break;
            }
            break;

        default:
            local_Status = ((Std_ReturnType)0x01);
            break;
    }

    return local_Status;
}


Std_ReturnType EXTI_SetCallBack(EXTI_LineType line, EXTI_CallBackType callBack)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if ((line >= EXTI_LINE_MAX) || (callBack == ((void *)0)))
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        EXTI_CallBacks[line] = callBack;
    }

    return local_Status;
}


void EXTI_EnableGlobalInterrupt(void)
{
    (((*(volatile u8 *)0x5F)) |= (1 << (7)));
}


void EXTI_DisableGlobalInterrupt(void)
{
    (((*(volatile u8 *)0x5F)) &= ~(1 << (7)));
}
