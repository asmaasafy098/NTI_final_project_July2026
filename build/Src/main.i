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


typedef float float32_t;
typedef double float64_t;


typedef enum
{
    E_OK = 0,
    E_NOK
} Std_ReturnType;
# 2 "Src/main.c" 2
# 1 "Src/../Service/Bit_Math.h" 1
# 3 "Src/main.c" 2
# 1 "MCL/ADC/../GPIO/GPIO_Interface.h" 1



# 1 "Src/../Service/STD_Types.h" 1
# 5 "MCL/ADC/../GPIO/GPIO_Interface.h" 2
# 28 "MCL/ADC/../GPIO/GPIO_Interface.h"
Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction);
Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction);
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port);
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value);
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value);
# 4 "Src/main.c" 2

int main(void)
{
    uint8_t btn1_state = 0;
    uint8_t btn2_state = 0;

    GPIO_set_pin_Direction(0, 3, 1);
    GPIO_set_pin_Direction(1, 3, 1);


    GPIO_set_pin_Direction(2, 3, 0);
    GPIO_set_pin_Direction(3, 3, 0);

    while (1)
    {

        btn1_state = GPIO_get_pin_status(2, 3);
        btn2_state = GPIO_get_pin_status(3, 3);


        if (btn1_state == 1)
        {
            GPIO_set_pin_value(0, 3, 1);
        }
        else
        {
            GPIO_set_pin_value(0, 3, 0);
        }


        if (btn2_state == 0)
        {
            GPIO_set_pin_value(1, 3, 1);
        }
        else
        {
            GPIO_set_pin_value(1, 3, 0);
        }
    }

    return 0;
}
