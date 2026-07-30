# 1 "HAL/Stepper_L298P/stepper_l298p.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "HAL/Stepper_L298P/stepper_l298p.c"
# 1 "HAL/Stepper_L298P/../../Service/STD_Types.h" 1



# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 5 "HAL/Stepper_L298P/../../Service/STD_Types.h" 2



# 7 "HAL/Stepper_L298P/../../Service/STD_Types.h"
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
# 55 "HAL/Stepper_L298P/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "HAL/Stepper_L298P/stepper_l298p.c" 2
# 1 "HAL/Stepper_L298P/../../Service/Bit_Math.h" 1
# 3 "HAL/Stepper_L298P/stepper_l298p.c" 2
# 1 "HAL/Stepper_L298P/../../MCL/GPIO/GPIO_Interface.h" 1



# 1 "HAL/Stepper_L298P/../../MCL/GPIO/../../Service/STD_Types.h" 1
# 5 "HAL/Stepper_L298P/../../MCL/GPIO/GPIO_Interface.h" 2
# 30 "HAL/Stepper_L298P/../../MCL/GPIO/GPIO_Interface.h"
typedef unsigned char GPIO_pin_status;
typedef unsigned char GPIO_port_status;



Std_ReturnType GPIO_set_pin_Direction(uint8_t port, uint8_t pin, uint8_t direction);
Std_ReturnType GPIO_set_pin_value(uint8_t port, uint8_t pin, uint8_t value);
Std_ReturnType GPIO_write_pin(uint8_t port, uint8_t pin, uint8_t value);
GPIO_pin_status GPIO_read_pin(uint8_t port, uint8_t pin);
Std_ReturnType GPIO_toggle_pin(uint8_t port, uint8_t pin);
# 4 "HAL/Stepper_L298P/stepper_l298p.c" 2
# 1 "HAL/Stepper_L298P/stepper_l298p.h" 1
# 73 "HAL/Stepper_L298P/stepper_l298p.h"
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
# 117 "HAL/Stepper_L298P/stepper_l298p.h"
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
# 152 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_Init(Stepper_L298P_HandleType *handle);
# 163 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_SetStepMode(Stepper_L298P_HandleType *handle,
                                         Stepper_L298P_ModeType mode);







Std_ReturnType Stepper_L298P_SetStepDelay(Stepper_L298P_HandleType *handle,
                                          uint16_t stepDelayMs);
# 185 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_SetSpeedRpm(Stepper_L298P_HandleType *handle, uint16_t rpm);
# 199 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_Step(Stepper_L298P_HandleType *handle,
                                  uint16_t steps, Stepper_L298P_DirType dir);
# 222 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_StepOnce(Stepper_L298P_HandleType *handle,
                                      Stepper_L298P_DirType dir);
# 236 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_RotateAngle(Stepper_L298P_HandleType *handle,
                                         uint16_t degrees, Stepper_L298P_DirType dir);
# 247 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_Hold(Stepper_L298P_HandleType *handle);
# 258 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_Release(Stepper_L298P_HandleType *handle);
# 267 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_GetPosition(const Stepper_L298P_HandleType *handle,
                                         sint32 *pPosition);







Std_ReturnType Stepper_L298P_ResetPosition(Stepper_L298P_HandleType *handle);
# 286 "HAL/Stepper_L298P/stepper_l298p.h"
Std_ReturnType Stepper_L298P_GetStepsPerRev(const Stepper_L298P_HandleType *handle,
                                            uint16_t *pStepsPerRev);
# 5 "HAL/Stepper_L298P/stepper_l298p.c" 2
# 18 "HAL/Stepper_L298P/stepper_l298p.c"
static const uint8_t STEPPER_WAVE_TABLE[4] =
{
    0x01U,
    0x02U,
    0x04U,
    0x08U
};


static const uint8_t STEPPER_FULL_TABLE[4] =
{
    0x03U,
    0x06U,
    0x0CU,
    0x09U
};


static const uint8_t STEPPER_HALF_TABLE[8] =
{
    0x01U,
    0x03U,
    0x02U,
    0x06U,
    0x04U,
    0x0CU,
    0x08U,
    0x09U
};







static void Stepper_DelayMs(uint16_t ms)
{
    while (ms > 0U)
    {

        volatile uint32_t count = 4000U;
        while (count--)
        {
            __asm__ volatile ("nop");
        }
        ms--;
    }
}


static uint8_t Stepper_TableLength(Stepper_L298P_ModeType mode)
{
    return (mode == STEPPER_L298P_MODE_HALF) ? 8U : 4U;
}


static uint8_t Stepper_TableEntry(Stepper_L298P_ModeType mode, uint8_t index)
{
    uint8_t local_Pattern = 0U;

    switch (mode)
    {
        case STEPPER_L298P_MODE_WAVE: local_Pattern = STEPPER_WAVE_TABLE[index & 0x03U]; break;
        case STEPPER_L298P_MODE_HALF: local_Pattern = STEPPER_HALF_TABLE[index & 0x07U]; break;
        case STEPPER_L298P_MODE_FULL:
        default: local_Pattern = STEPPER_FULL_TABLE[index & 0x03U]; break;
    }

    return local_Pattern;
}


static void Stepper_ApplyPattern(Stepper_L298P_HandleType *handle, uint8_t pattern)
{
    (void)GPIO_set_pin_value(handle->in1Port, handle->in1Pin, (uint8_t)(((pattern) >> (0)) & 0x01));
    (void)GPIO_set_pin_value(handle->in2Port, handle->in2Pin, (uint8_t)(((pattern) >> (1)) & 0x01));
    (void)GPIO_set_pin_value(handle->in3Port, handle->in3Pin, (uint8_t)(((pattern) >> (2)) & 0x01));
    (void)GPIO_set_pin_value(handle->in4Port, handle->in4Pin, (uint8_t)(((pattern) >> (3)) & 0x01));

    handle->energized = (pattern != 0U) ? 1U : 0U;
}






Std_ReturnType Stepper_L298P_Init(Stepper_L298P_HandleType *handle)
{

    if (handle == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }

    if (handle->stepsPerRev == 0U)
    {
        return ((Std_ReturnType)0x01);
    }


    (void)GPIO_set_pin_Direction(handle->in1Port, handle->in1Pin, 1);
    (void)GPIO_set_pin_Direction(handle->in2Port, handle->in2Pin, 1);
    (void)GPIO_set_pin_Direction(handle->in3Port, handle->in3Pin, 1);
    (void)GPIO_set_pin_Direction(handle->in4Port, handle->in4Pin, 1);





    if (handle->useEnablePins != 0U)
    {
        (void)GPIO_set_pin_Direction(handle->enAPort, handle->enAPin, 1);
        (void)GPIO_set_pin_Direction(handle->enBPort, handle->enBPin, 1);
        (void)GPIO_set_pin_value(handle->enAPort, handle->enAPin, 1);
        (void)GPIO_set_pin_value(handle->enBPort, handle->enBPin, 1);
    }


    if (handle->stepDelayMs == 0U)
    {
        handle->stepDelayMs = 1U;
    }


    handle->phaseIndex = 0U;
    handle->position = 0;
    handle->energized = 0U;
    Stepper_ApplyPattern(handle, 0x00U);


    handle->initialized = 1U;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_SetStepMode(Stepper_L298P_HandleType *handle,
                                          Stepper_L298P_ModeType mode)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }

    if (mode > STEPPER_L298P_MODE_HALF)
    {
        return ((Std_ReturnType)0x01);
    }




    handle->stepMode = mode;
    handle->phaseIndex = 0U;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_SetStepDelay(Stepper_L298P_HandleType *handle,
                                           uint16_t stepDelayMs)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    handle->stepDelayMs = (stepDelayMs == 0U) ? 1U : stepDelayMs;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_SetSpeedRpm(Stepper_L298P_HandleType *handle, uint16_t rpm)
{
    uint32_t local_StepsPerRev = 0UL;
    uint32_t local_DelayMs = 0UL;


    if ((handle == ((void *)0)) || (handle->initialized == 0U) || (rpm == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    local_StepsPerRev = (uint32_t)handle->stepsPerRev;

    if (handle->stepMode == STEPPER_L298P_MODE_HALF)
    {
        local_StepsPerRev *= 2UL;
    }




    local_DelayMs = 60000UL / (local_StepsPerRev * (uint32_t)rpm);

    if (local_DelayMs == 0UL)
    {
        return ((Std_ReturnType)0x01);
    }

    handle->stepDelayMs = (uint16_t)local_DelayMs;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_Step(Stepper_L298P_HandleType *handle,
                                  uint16_t steps, Stepper_L298P_DirType dir)
{
    uint16_t local_Step = 0U;


    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }

    if (dir > STEPPER_L298P_DIR_CCW)
    {
        return ((Std_ReturnType)0x01);
    }


    for (local_Step = 0U; local_Step < steps; local_Step++)
    {
        (void)Stepper_L298P_StepOnce(handle, dir);
        Stepper_DelayMs(handle->stepDelayMs);
    }

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_StepOnce(Stepper_L298P_HandleType *handle,
                                      Stepper_L298P_DirType dir)
{
    uint8_t local_Length = 0U;


    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }

    if (dir > STEPPER_L298P_DIR_CCW)
    {
        return ((Std_ReturnType)0x01);
    }

    local_Length = Stepper_TableLength(handle->stepMode);




    if (dir == STEPPER_L298P_DIR_CW)
    {
        handle->phaseIndex = (uint8_t)((handle->phaseIndex + 1U) % local_Length);
        handle->position++;
    }
    else
    {
        handle->phaseIndex = (uint8_t)((handle->phaseIndex + local_Length - 1U) % local_Length);
        handle->position--;
    }


    Stepper_ApplyPattern(handle, Stepper_TableEntry(handle->stepMode, handle->phaseIndex));

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_RotateAngle(Stepper_L298P_HandleType *handle,
                                          uint16_t degrees, Stepper_L298P_DirType dir)
{
    uint32_t local_StepsPerRev = 0UL;
    uint32_t local_Steps = 0UL;


    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    local_StepsPerRev = (uint32_t)handle->stepsPerRev;

    if (handle->stepMode == STEPPER_L298P_MODE_HALF)
    {
        local_StepsPerRev *= 2UL;
    }


    local_Steps = ((uint32_t)degrees * local_StepsPerRev) / 360UL;


    return Stepper_L298P_Step(handle, (uint16_t)local_Steps, dir);
}


Std_ReturnType Stepper_L298P_Hold(Stepper_L298P_HandleType *handle)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    if (handle->useEnablePins != 0U)
    {
        (void)GPIO_set_pin_value(handle->enAPort, handle->enAPin, 1);
        (void)GPIO_set_pin_value(handle->enBPort, handle->enBPin, 1);
    }


    Stepper_ApplyPattern(handle, Stepper_TableEntry(handle->stepMode, handle->phaseIndex));

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_Release(Stepper_L298P_HandleType *handle)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    Stepper_ApplyPattern(handle, 0x00U);


    if (handle->useEnablePins != 0U)
    {
        (void)GPIO_set_pin_value(handle->enAPort, handle->enAPin, 0);
        (void)GPIO_set_pin_value(handle->enBPort, handle->enBPin, 0);
    }

    handle->energized = 0U;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_GetPosition(const Stepper_L298P_HandleType *handle,
                                          sint32 *pPosition)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U) || (pPosition == ((void *)0)))
    {
        return ((Std_ReturnType)0x01);
    }


    *pPosition = handle->position;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_ResetPosition(Stepper_L298P_HandleType *handle)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }

    handle->position = 0;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType Stepper_L298P_GetStepsPerRev(const Stepper_L298P_HandleType *handle,
                                            uint16_t *pStepsPerRev)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U) || (pStepsPerRev == ((void *)0)))
    {
        return ((Std_ReturnType)0x01);
    }


    if (handle->stepMode == STEPPER_L298P_MODE_HALF)
    {
        *pStepsPerRev = (uint16_t)(handle->stepsPerRev * 2U);
    }
    else
    {
        *pStepsPerRev = handle->stepsPerRev;
    }

    return ((Std_ReturnType)0x00);
}
