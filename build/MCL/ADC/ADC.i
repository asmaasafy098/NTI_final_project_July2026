# 1 "MCL/ADC/ADC.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCL/ADC/ADC.c"
# 1 "MCL/ADC/../../Service/STD_Types.h" 1



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
# 5 "MCL/ADC/../../Service/STD_Types.h" 2



# 7 "MCL/ADC/../../Service/STD_Types.h"
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
# 2 "MCL/ADC/ADC.c" 2
# 1 "MCL/ADC/../../Service/Bit_Math.h" 1
# 3 "MCL/ADC/ADC.c" 2
# 1 "MCL/ADC/ADC_Registers.h" 1
# 4 "MCL/ADC/ADC.c" 2
# 1 "MCL/ADC/ADC_Interfaces.h" 1
# 39 "MCL/ADC/ADC_Interfaces.h"
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
# 87 "MCL/ADC/ADC_Interfaces.h"
Std_ReturnType ADC_ReadChannelBlocking(uint8_t uint8Channel, uint16_t *puint16Result);
# 5 "MCL/ADC/ADC.c" 2





Std_ReturnType ADC_Init(const ADC_ConfigType *addConfig)
{

    Std_ReturnType local_Status = E_OK;


    if (addConfig == ((void *)0))
    {
        local_Status = E_NOK;
    }
    else
    {

        switch (addConfig->uint8ReferenceVoltage)
        {
            case 0:
                (((*(volatile uint8_t *)0x27)) &= ~(1 << (6)));
                (((*(volatile uint8_t *)0x27)) &= ~(1 << (7)));
                break;

            case 1:
                (((*(volatile uint8_t *)0x27)) |= (1 << (6)));
                (((*(volatile uint8_t *)0x27)) &= ~(1 << (7)));
                break;

            case 3:
                (((*(volatile uint8_t *)0x27)) |= (1 << (6)));
                (((*(volatile uint8_t *)0x27)) |= (1 << (7)));
                break;

            default:
                local_Status = E_NOK;
                break;
        }


        if (local_Status == E_OK)
        {

            (((*(volatile uint8_t *)0x27)) &= ~(1 << (5)));


            (((*(volatile uint8_t *)0x27)) &= ~(1 << (0)));
            (((*(volatile uint8_t *)0x27)) &= ~(1 << (1)));
            (((*(volatile uint8_t *)0x27)) &= ~(1 << (2)));
            (((*(volatile uint8_t *)0x27)) &= ~(1 << (3)));
            (((*(volatile uint8_t *)0x27)) &= ~(1 << (4)));


            (((*(volatile uint8_t *)0x26)) &= ~(1 << (0)));
            (((*(volatile uint8_t *)0x26)) &= ~(1 << (1)));
            (((*(volatile uint8_t *)0x26)) &= ~(1 << (2)));

            if ((((addConfig->uint8Prescaler) >> (0)) & 0x01) == 1)
            {
                (((*(volatile uint8_t *)0x26)) |= (1 << (0)));
            }
            if ((((addConfig->uint8Prescaler) >> (1)) & 0x01) == 1)
            {
                (((*(volatile uint8_t *)0x26)) |= (1 << (1)));
            }
            if ((((addConfig->uint8Prescaler) >> (2)) & 0x01) == 1)
            {
                (((*(volatile uint8_t *)0x26)) |= (1 << (2)));
            }


            (((*(volatile uint8_t *)0x26)) |= (1 << (7)));
        }
    }


    return local_Status;
}




Std_ReturnType ADC_DeInit(void)
{

    (((*(volatile uint8_t *)0x26)) &= ~(1 << (7)));


    return E_OK;
}




Std_ReturnType ADC_StartConversion(uint8_t uint8Channel)
{

    Std_ReturnType local_Status = E_OK;


    if (uint8Channel >= 8)
    {
        local_Status = E_NOK;
    }
    else
    {

        (((*(volatile uint8_t *)0x27)) &= ~(1 << (0)));
        (((*(volatile uint8_t *)0x27)) &= ~(1 << (1)));
        (((*(volatile uint8_t *)0x27)) &= ~(1 << (2)));
        (((*(volatile uint8_t *)0x27)) &= ~(1 << (3)));
        (((*(volatile uint8_t *)0x27)) &= ~(1 << (4)));

        if ((((uint8Channel) >> (0)) & 0x01) == 1)
        {
            (((*(volatile uint8_t *)0x27)) |= (1 << (0)));
        }
        if ((((uint8Channel) >> (1)) & 0x01) == 1)
        {
            (((*(volatile uint8_t *)0x27)) |= (1 << (1)));
        }
        if ((((uint8Channel) >> (2)) & 0x01) == 1)
        {
            (((*(volatile uint8_t *)0x27)) |= (1 << (2)));
        }


        (((*(volatile uint8_t *)0x26)) |= (1 << (6)));
    }


    return local_Status;
}




uint8_t ADC_IsConversionComplete(void)
{

    if (((((*(volatile uint8_t *)0x26)) >> (6)) & 0x01) == 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}




Std_ReturnType ADC_ReadResult(uint16_t *puint16Result)
{

    if (puint16Result == ((void *)0))
    {
        return E_NOK;
    }


    uint8_t local_u8LowByte = (*(volatile uint8_t *)0x24);


    uint8_t local_u8HighByte = (*(volatile uint8_t *)0x25);


    *puint16Result = (uint16_t)((local_u8HighByte << 8) | local_u8LowByte);


    return E_OK;
}





Std_ReturnType ADC_ReadChannelBlocking(uint8_t uint8Channel, uint16_t *puint16Result)
{

    Std_ReturnType local_Status = ADC_StartConversion(uint8Channel);


    if (local_Status == E_OK)
    {
        while (ADC_IsConversionComplete() == 0)
        {

        }


        local_Status = ADC_ReadResult(puint16Result);
    }


    return local_Status;
}
