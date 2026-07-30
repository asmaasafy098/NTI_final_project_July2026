# 1 "HAL/ANALOG_SENSOR/ANALOG_SENSOR.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "HAL/ANALOG_SENSOR/ANALOG_SENSOR.c"
# 1 "HAL/ANALOG_SENSOR/../../Service/STD_Types.h" 1



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
# 5 "HAL/ANALOG_SENSOR/../../Service/STD_Types.h" 2



# 7 "HAL/ANALOG_SENSOR/../../Service/STD_Types.h"
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
# 55 "HAL/ANALOG_SENSOR/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "HAL/ANALOG_SENSOR/ANALOG_SENSOR.c" 2
# 1 "HAL/ANALOG_SENSOR/../../MCL/ADC/ADC_Interfaces.h" 1




# 1 "HAL/ANALOG_SENSOR/../../MCL/ADC/../../Service/STD_Types.h" 1
# 6 "HAL/ANALOG_SENSOR/../../MCL/ADC/ADC_Interfaces.h" 2
# 1 "HAL/ANALOG_SENSOR/../../MCL/ADC/ADC_Registers.h" 1
# 7 "HAL/ANALOG_SENSOR/../../MCL/ADC/ADC_Interfaces.h" 2
# 39 "HAL/ANALOG_SENSOR/../../MCL/ADC/ADC_Interfaces.h"
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
# 87 "HAL/ANALOG_SENSOR/../../MCL/ADC/ADC_Interfaces.h"
Std_ReturnType ADC_ReadChannelBlocking(uint8_t uint8Channel, uint16_t *puint16Result);
# 3 "HAL/ANALOG_SENSOR/ANALOG_SENSOR.c" 2
# 1 "HAL/ANALOG_SENSOR/ANALOG_SENSOR.h" 1







typedef enum
{
    ANALOG_CH_SETPOINT = 0,
    ANALOG_CH_CURRENT,
    ANALOG_CH_BUS_VOLTAGE,
    ANALOG_CH_TEMPERATURE,
    ANALOG_CH_COUNT
} AnalogChannel_t;


Std_ReturnType ANALOG_Init(void);
uint16_t ANALOG_GetSetpoint(void);
uint16_t ANALOG_GetCurrent(void);
uint16_t ANALOG_GetBusVoltage(void);
uint8_t ANALOG_GetTemperature(void);
# 4 "HAL/ANALOG_SENSOR/ANALOG_SENSOR.c" 2

Std_ReturnType ANALOG_Init(void)
{
    ADC_ConfigType cfg = {
        .uint8ReferenceVoltage = 1,
        .uint8Prescaler = 7
    };
    return ADC_Init(&cfg);
}
uint16_t ANALOG_GetSetpoint(void)
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_SETPOINT, &raw);
    return (uint16_t)(((uint32_t)raw * 3000UL) / 1023UL);
}

uint16_t ANALOG_GetCurrent(void)
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_CURRENT, &raw);
    return (uint16_t)(((uint32_t)raw * 20000UL) / 1023UL);
}

uint16_t ANALOG_GetBusVoltage(void)
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_BUS_VOLTAGE, &raw);
    return (uint16_t)(((uint32_t)raw * 60000UL) / 1023UL);
}

uint8_t ANALOG_GetTemperature(void)
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_TEMPERATURE, &raw);
    return (uint8_t)(((uint32_t)raw * 150UL) / 1023UL);
}
