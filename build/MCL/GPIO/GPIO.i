# 1 "MCL/GPIO/GPIO.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCL/GPIO/GPIO.c"
# 1 "MCL/GPIO/../../Service/STD_Types.h" 1



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
# 5 "MCL/GPIO/../../Service/STD_Types.h" 2



# 7 "MCL/GPIO/../../Service/STD_Types.h"
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
# 55 "MCL/GPIO/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "MCL/GPIO/GPIO.c" 2
# 1 "MCL/GPIO/../../Service/Bit_Math.h" 1
# 3 "MCL/GPIO/GPIO.c" 2
# 1 "MCL/GPIO/GPIO_Registers.h" 1
# 4 "MCL/GPIO/GPIO.c" 2
# 1 "MCL/GPIO/GPIO_Interface.h" 1
# 30 "MCL/GPIO/GPIO_Interface.h"
typedef unsigned char GPIO_pin_status;
typedef unsigned char GPIO_port_status;



Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction);
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin, uint8_t *pu8PinStatus);
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value);


Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction);
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port, uint8_t *pu8PortStatus);
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value);
# 5 "MCL/GPIO/GPIO.c" 2


static volatile uint8_t * const GPIO_DDRx[4] = {
    &(*(volatile uint8_t *)0x3A), &(*(volatile uint8_t *)0x37), &(*(volatile uint8_t *)0x34), &(*(volatile uint8_t *)0x31)
};

static volatile uint8_t * const GPIO_PORTx[4] = {
    &(*(volatile uint8_t *)0x3B), &(*(volatile uint8_t *)0x38), &(*(volatile uint8_t *)0x35), &(*(volatile uint8_t *)0x32)
};

static volatile uint8_t * const GPIO_PINx[4] = {
    &(*(volatile uint8_t *)0x39), &(*(volatile uint8_t *)0x36), &(*(volatile uint8_t *)0x33), &(*(volatile uint8_t *)0x30)
};


Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if ((uint8_port >= 4) || (uint8_pin >= 8))
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        switch (uint8_direction)
        {
            case 0:
                ((*GPIO_DDRx[uint8_port]) &= ~(1 << (uint8_pin)));
                break;
            case 1:
                ((*GPIO_DDRx[uint8_port]) |= (1 << (uint8_pin)));
                break;
            default:
                local_Status = ((Std_ReturnType)0x01);
                break;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if ((uint8_port >= 4) || (uint8_pin >= 8))
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        switch (uint8_value)
        {
            case 0:
                ((*GPIO_PORTx[uint8_port]) &= ~(1 << (uint8_pin)));
                break;
            case 1:
                ((*GPIO_PORTx[uint8_port]) |= (1 << (uint8_pin)));
                break;
            default:
                local_Status = ((Std_ReturnType)0x01);
                break;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if ((uint8_port >= 4) || (uint8_pin >= 8))
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        ((*GPIO_PORTx[uint8_port]) ^= (1 << (uint8_pin)));
    }
    return local_Status;
}


Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if (uint8_port >= 4)
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        if (uint8_direction == 0) {
            *GPIO_DDRx[uint8_port] = 0x00;
        } else if (uint8_direction == 1) {
            *GPIO_DDRx[uint8_port] = 0xFF;
        } else {
            *GPIO_DDRx[uint8_port] = uint8_direction;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if (uint8_port >= 4)
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        if (uint8_value == 0) {
            *GPIO_PORTx[uint8_port] = 0x00;
        } else if (uint8_value == 1) {
            *GPIO_PORTx[uint8_port] = 0xFF;
        } else {
            *GPIO_PORTx[uint8_port] = uint8_value;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin, uint8_t *pu8PinStatus)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if ((uint8_port >= 4) || (uint8_pin >= 8) || (pu8PinStatus == 0))
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        *pu8PinStatus = (((*GPIO_PINx[uint8_port]) >> (uint8_pin)) & 0x01);
    }
    return local_Status;
}


Std_ReturnType GPIO_get_port_status(uint8_t uint8_port, uint8_t *pu8PortStatus)
{
    Std_ReturnType local_Status = ((Std_ReturnType)0x00);

    if ((uint8_port >= 4) || (pu8PortStatus == 0))
    {
        local_Status = ((Std_ReturnType)0x01);
    }
    else
    {
        *pu8PortStatus = *GPIO_PINx[uint8_port];
    }
    return local_Status;
}
