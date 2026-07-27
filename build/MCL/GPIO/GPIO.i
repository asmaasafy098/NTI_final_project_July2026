# 1 "MCL/GPIO/GPIO.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCL/GPIO/GPIO.c"
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


typedef float float32_t;
typedef double float64_t;


typedef enum
{
    E_OK = 0,
    E_NOK
} Std_ReturnType;
# 2 "MCL/GPIO/GPIO.c" 2
# 1 "Src/../Service/Bit_Math.h" 1
# 3 "MCL/GPIO/GPIO.c" 2
# 1 "MCL/GPIO/GPIO_Registers.h" 1
# 4 "MCL/GPIO/GPIO.c" 2
# 1 "MCL/GPIO/GPIO_Interface.h" 1
# 28 "MCL/GPIO/GPIO_Interface.h"
Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction);
Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction);
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port);
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value);
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value);
# 5 "MCL/GPIO/GPIO.c" 2


Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= 4) || (uint8_pin >= 8))
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_direction)
        {
            case 0:
                switch (uint8_port)
                {
                    case 0: (((*(volatile uint8_t *)0x3A)) &= ~(1 << (uint8_pin))); break;
                    case 1: (((*(volatile uint8_t *)0x37)) &= ~(1 << (uint8_pin))); break;
                    case 2: (((*(volatile uint8_t *)0x34)) &= ~(1 << (uint8_pin))); break;
                    case 3: (((*(volatile uint8_t *)0x31)) &= ~(1 << (uint8_pin))); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            case 1:
                switch (uint8_port)
                {
                    case 0: (((*(volatile uint8_t *)0x3A)) |= (1 << (uint8_pin))); break;
                    case 1: (((*(volatile uint8_t *)0x37)) |= (1 << (uint8_pin))); break;
                    case 2: (((*(volatile uint8_t *)0x34)) |= (1 << (uint8_pin))); break;
                    case 3: (((*(volatile uint8_t *)0x31)) |= (1 << (uint8_pin))); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            default:
                local_Status = E_NOK;
                break;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= 4) || (uint8_pin >= 8))
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_value)
        {
            case 0:
                switch (uint8_port)
                {
                    case 0: (((*(volatile uint8_t *)0x3B)) &= ~(1 << (uint8_pin))); break;
                    case 1: (((*(volatile uint8_t *)0x38)) &= ~(1 << (uint8_pin))); break;
                    case 2: (((*(volatile uint8_t *)0x35)) &= ~(1 << (uint8_pin))); break;
                    case 3: (((*(volatile uint8_t *)0x32)) &= ~(1 << (uint8_pin))); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            case 1:
                switch (uint8_port)
                {
                    case 0: (((*(volatile uint8_t *)0x3B)) |= (1 << (uint8_pin))); break;
                    case 1: (((*(volatile uint8_t *)0x38)) |= (1 << (uint8_pin))); break;
                    case 2: (((*(volatile uint8_t *)0x35)) |= (1 << (uint8_pin))); break;
                    case 3: (((*(volatile uint8_t *)0x32)) |= (1 << (uint8_pin))); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            default:
                local_Status = E_NOK;
                break;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= 4) || (uint8_pin >= 8))
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_port)
        {
            case 0: (((*(volatile uint8_t *)0x3B)) ^= (1 << (uint8_pin))); break;
            case 1: (((*(volatile uint8_t *)0x38)) ^= (1 << (uint8_pin))); break;
            case 2: (((*(volatile uint8_t *)0x35)) ^= (1 << (uint8_pin))); break;
            case 3: (((*(volatile uint8_t *)0x32)) ^= (1 << (uint8_pin))); break;
            default: local_Status = E_NOK; break;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction)
{
    Std_ReturnType local_Status = E_OK;

    if (uint8_port >= 4)
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_port)
        {
            case 0: (*(volatile uint8_t *)0x3A) = uint8_direction; break;
            case 1: (*(volatile uint8_t *)0x37) = uint8_direction; break;
            case 2: (*(volatile uint8_t *)0x34) = uint8_direction; break;
            case 3: (*(volatile uint8_t *)0x31) = uint8_direction; break;
            default: local_Status = E_NOK; break;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value)
{
    Std_ReturnType local_Status = E_OK;

    if (uint8_port >= 4)
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_port)
        {
            case 0: (*(volatile uint8_t *)0x3B) = uint8_value; break;
            case 1: (*(volatile uint8_t *)0x38) = uint8_value; break;
            case 2: (*(volatile uint8_t *)0x35) = uint8_value; break;
            case 3: (*(volatile uint8_t *)0x32) = uint8_value; break;
            default: local_Status = E_NOK; break;
        }
    }
    return local_Status;
}


Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin)
{
    uint8_t pin_status = 0;

    if ((uint8_port < 4) && (uint8_pin < 8))
    {
        switch (uint8_port)
        {
            case 0: pin_status = ((((*(volatile uint8_t *)0x39)) >> (uint8_pin)) & 0x01); break;
            case 1: pin_status = ((((*(volatile uint8_t *)0x36)) >> (uint8_pin)) & 0x01); break;
            case 2: pin_status = ((((*(volatile uint8_t *)0x33)) >> (uint8_pin)) & 0x01); break;
            case 3: pin_status = ((((*(volatile uint8_t *)0x30)) >> (uint8_pin)) & 0x01); break;
            default: break;
        }
    }
    return pin_status;
}


Std_ReturnType GPIO_get_port_status(uint8_t uint8_port)
{
    uint8_t port_status = 0;

    if (uint8_port < 4)
    {
        switch (uint8_port)
        {
            case 0: port_status = (*(volatile uint8_t *)0x39); break;
            case 1: port_status = (*(volatile uint8_t *)0x36); break;
            case 2: port_status = (*(volatile uint8_t *)0x33); break;
            case 3: port_status = (*(volatile uint8_t *)0x30); break;
            default: break;
        }
    }
    return port_status;
}
