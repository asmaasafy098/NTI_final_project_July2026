# 1 "HAL/DC_Motor/dc_motor.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "HAL/DC_Motor/dc_motor.c"
# 1 "HAL/DC_Motor/../../Service/STD_Types.h" 1



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
# 5 "HAL/DC_Motor/../../Service/STD_Types.h" 2



# 7 "HAL/DC_Motor/../../Service/STD_Types.h"
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
# 55 "HAL/DC_Motor/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "HAL/DC_Motor/dc_motor.c" 2
# 1 "HAL/DC_Motor/../../Service/Bit_Math.h" 1
# 3 "HAL/DC_Motor/dc_motor.c" 2
# 1 "HAL/DC_Motor/../../MCL/GPIO/gpio_interface.h" 1



# 1 "HAL/DC_Motor/../../MCL/GPIO/../../Service/STD_Types.h" 1
# 5 "HAL/DC_Motor/../../MCL/GPIO/gpio_interface.h" 2
# 30 "HAL/DC_Motor/../../MCL/GPIO/gpio_interface.h"
typedef unsigned char GPIO_pin_status;
typedef unsigned char GPIO_port_status;



Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction);
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin, uint8_t *pu8PinStatus);
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value);


Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction);
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port, uint8_t *pu8PortStatus);
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value);
# 4 "HAL/DC_Motor/dc_motor.c" 2
# 1 "HAL/DC_Motor/../../MCL/Timer/timer_registers.h" 1




# 1 "HAL/DC_Motor/../../MCL/Timer/../../Service/STD_Types.h" 1
# 6 "HAL/DC_Motor/../../MCL/Timer/timer_registers.h" 2
# 5 "HAL/DC_Motor/dc_motor.c" 2
# 1 "HAL/DC_Motor/dc_motor.h" 1
# 86 "HAL/DC_Motor/dc_motor.h"
typedef enum
{
    DC_MOTOR_PWM_NONE = 0,
    DC_MOTOR_PWM_OC0 = 1,
    DC_MOTOR_PWM_OC1A = 2,
    DC_MOTOR_PWM_OC1B = 3,
    DC_MOTOR_PWM_OC2 = 4
} DC_MotorPwmChannelType;






typedef enum
{
    DC_MOTOR_DIR_FORWARD = 0,
    DC_MOTOR_DIR_BACKWARD = 1
} DC_MotorDirectionType;
# 115 "HAL/DC_Motor/dc_motor.h"
typedef enum
{
    DC_MOTOR_STATE_STOP = 0,
    DC_MOTOR_STATE_FORWARD = 1,
    DC_MOTOR_STATE_BACKWARD = 2,
    DC_MOTOR_STATE_BRAKE = 3
} DC_MotorStateType;
# 143 "HAL/DC_Motor/dc_motor.h"
typedef struct
{

    uint8_t in1Port; uint8_t in1Pin;
    uint8_t in2Port; uint8_t in2Pin;
    uint8_t enPort; uint8_t enPin;
    DC_MotorPwmChannelType pwmChannel;
    uint8_t invertDirection;


    uint8_t initialized;
    uint8_t speedPercent;
    DC_MotorStateType state;
} DC_MotorHandleType;
# 174 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Init(DC_MotorHandleType *handle);
# 189 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_SetSpeed(DC_MotorHandleType *handle, uint8_t speedPercent);
# 200 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Forward(DC_MotorHandleType *handle);






Std_ReturnType DC_Motor_Backward(DC_MotorHandleType *handle);
# 216 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_SetDirection(DC_MotorHandleType *handle, DC_MotorDirectionType dir);
# 225 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Stop(DC_MotorHandleType *handle);
# 236 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_Brake(DC_MotorHandleType *handle);
# 245 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_GetState(const DC_MotorHandleType *handle, DC_MotorStateType *pState);







Std_ReturnType DC_Motor_GetSpeed(const DC_MotorHandleType *handle, uint8_t *pSpeed);
# 264 "HAL/DC_Motor/dc_motor.h"
Std_ReturnType DC_Motor_DeInit(DC_MotorHandleType *handle);
# 6 "HAL/DC_Motor/dc_motor.c" 2
# 38 "HAL/DC_Motor/dc_motor.c"
static void DC_Motor_PwmPin(DC_MotorPwmChannelType channel, uint8_t *pPort, uint8_t *pPin)
{
    switch (channel)
    {
        case DC_MOTOR_PWM_OC0: *pPort = 1; *pPin = 3; break;
        case DC_MOTOR_PWM_OC1A: *pPort = 3; *pPin = 5; break;
        case DC_MOTOR_PWM_OC1B: *pPort = 3; *pPin = 4; break;
        case DC_MOTOR_PWM_OC2: *pPort = 3; *pPin = 7; break;
        default: *pPort = 0U; *pPin = 0U; break;
    }
}







static void DC_Motor_PwmTimerSetup(DC_MotorPwmChannelType channel)
{
    switch (channel)
    {
        case DC_MOTOR_PWM_OC0:

            (*(volatile uint8_t *)0x53) = (uint8_t)((1U << 6) | (1U << 3) |
                                        (1U << 1) | (1U << 0));
            (*(volatile uint8_t *)0x5C) = 0U;
            break;

        case DC_MOTOR_PWM_OC1A:
        case DC_MOTOR_PWM_OC1B:

            (((*(volatile uint8_t *)0x4F)) |= (1 << (0)));
            (((*(volatile uint8_t *)0x4E)) |= (1 << (3)));
            (((*(volatile uint8_t *)0x4E)) |= (1 << (1)));
            (((*(volatile uint8_t *)0x4E)) |= (1 << (0)));
            break;

        case DC_MOTOR_PWM_OC2:






            (*(volatile uint8_t *)0x45) = (uint8_t)((1U << 6) | (1U << 3) |
                                        (1U << 2));
            (*(volatile uint8_t *)0x43) = 0U;
            break;

        default:

            break;
    }
}


static void DC_Motor_PwmConnect(DC_MotorPwmChannelType channel, uint8_t enable)
{
    switch (channel)
    {
        case DC_MOTOR_PWM_OC0:
            if (enable != 0U) { (((*(volatile uint8_t *)0x53)) |= (1 << (5))); }
            else { (((*(volatile uint8_t *)0x53)) &= ~(1 << (5))); }
            break;

        case DC_MOTOR_PWM_OC1A:
            if (enable != 0U) { (((*(volatile uint8_t *)0x4F)) |= (1 << (7))); }
            else { (((*(volatile uint8_t *)0x4F)) &= ~(1 << (7))); }
            break;

        case DC_MOTOR_PWM_OC1B:
            if (enable != 0U) { (((*(volatile uint8_t *)0x4F)) |= (1 << (5))); }
            else { (((*(volatile uint8_t *)0x4F)) &= ~(1 << (5))); }
            break;

        case DC_MOTOR_PWM_OC2:
            if (enable != 0U) { (((*(volatile uint8_t *)0x45)) |= (1 << (5))); }
            else { (((*(volatile uint8_t *)0x45)) &= ~(1 << (5))); }
            break;

        default:
            break;
    }
}


static void DC_Motor_PwmSetDuty(DC_MotorPwmChannelType channel, uint8_t duty)
{
    switch (channel)
    {
        case DC_MOTOR_PWM_OC0: (*(volatile uint8_t *)0x5C) = duty; break;
        case DC_MOTOR_PWM_OC1A: (*(volatile uint16_t *)0x4A) = (uint16_t)duty; break;
        case DC_MOTOR_PWM_OC1B: (*(volatile uint16_t *)0x48) = (uint16_t)duty; break;
        case DC_MOTOR_PWM_OC2: (*(volatile uint8_t *)0x43) = duty; break;
        default: break;
    }
}
# 144 "HAL/DC_Motor/dc_motor.c"
static void DC_Motor_ApplySpeed(const DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin = 0U;
    uint8_t local_Duty = 0U;

    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {

        (void)GPIO_set_pin_value(handle->enPort, handle->enPin,
                               (handle->speedPercent > 0U) ? 1 : 0);
        return;
    }

    DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);

    if (handle->speedPercent == 0U)
    {
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
        (void)GPIO_set_pin_value(local_Port, local_Pin, 0);
        return;
    }


    local_Duty = (uint8_t)(((uint16_t)handle->speedPercent * 255U) / 100U);

    DC_Motor_PwmSetDuty(handle->pwmChannel, local_Duty);
    DC_Motor_PwmConnect(handle->pwmChannel, 1U);
}


static void DC_Motor_ApplyState(DC_MotorHandleType *handle, DC_MotorStateType state)
{
    uint8_t local_In1 = 0;
    uint8_t local_In2 = 0;

    switch (state)
    {
        case DC_MOTOR_STATE_FORWARD: local_In1 = 1; local_In2 = 0; break;
        case DC_MOTOR_STATE_BACKWARD: local_In1 = 0; local_In2 = 1; break;
        case DC_MOTOR_STATE_BRAKE: local_In1 = 1; local_In2 = 1; break;
        case DC_MOTOR_STATE_STOP:
        default: local_In1 = 0; local_In2 = 0; break;
    }





    if ((handle->invertDirection != 0U) &&
        ((state == DC_MOTOR_STATE_FORWARD) || (state == DC_MOTOR_STATE_BACKWARD)))
    {
        uint8_t local_Swap = local_In1;
        local_In1 = local_In2;
        local_In2 = local_Swap;
    }

    (void)GPIO_set_pin_value(handle->in1Port, handle->in1Pin, local_In1);
    (void)GPIO_set_pin_value(handle->in2Port, handle->in2Pin, local_In2);

    handle->state = state;
}






Std_ReturnType DC_Motor_Init(DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin = 0U;


    if (handle == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }

    if ((handle->in1Port >= 4) || (handle->in2Port >= 4))
    {
        return ((Std_ReturnType)0x01);
    }

    if (handle->pwmChannel > DC_MOTOR_PWM_OC2)
    {
        return ((Std_ReturnType)0x01);
    }


    (void)GPIO_set_pin_Direction(handle->in1Port, handle->in1Pin, 1);
    (void)GPIO_set_pin_Direction(handle->in2Port, handle->in2Pin, 1);
    (void)GPIO_set_pin_value(handle->in1Port, handle->in1Pin, 0);
    (void)GPIO_set_pin_value(handle->in2Port, handle->in2Pin, 0);


    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {

        if (handle->enPort >= 4)
        {
            return ((Std_ReturnType)0x01);
        }

        (void)GPIO_set_pin_Direction(handle->enPort, handle->enPin, 1);
        (void)GPIO_set_pin_value(handle->enPort, handle->enPin, 0);
    }
    else
    {




        DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);
        (void)GPIO_set_pin_Direction(local_Port, local_Pin, 1);
        (void)GPIO_set_pin_value(local_Port, local_Pin, 0);

        DC_Motor_PwmTimerSetup(handle->pwmChannel);
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
    }


    handle->speedPercent = 0U;
    handle->initialized = 1U;
    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_STOP);
    DC_Motor_ApplySpeed(handle);

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_SetSpeed(DC_MotorHandleType *handle, uint8_t speedPercent)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    if (speedPercent > 100U)
    {
        speedPercent = 100U;
    }

    handle->speedPercent = speedPercent;


    DC_Motor_ApplySpeed(handle);

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_Forward(DC_MotorHandleType *handle)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_FORWARD);


    DC_Motor_ApplySpeed(handle);

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_Backward(DC_MotorHandleType *handle)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_BACKWARD);


    DC_Motor_ApplySpeed(handle);

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_SetDirection(DC_MotorHandleType *handle, DC_MotorDirectionType dir)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }

    if (dir > DC_MOTOR_DIR_BACKWARD)
    {
        return ((Std_ReturnType)0x01);
    }


    return (dir == DC_MOTOR_DIR_FORWARD) ? DC_Motor_Forward(handle) : DC_Motor_Backward(handle);
}


Std_ReturnType DC_Motor_Stop(DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin = 0U;


    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_STOP);





    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {
        (void)GPIO_set_pin_value(handle->enPort, handle->enPin, 0);
    }
    else
    {
        DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
        (void)GPIO_set_pin_value(local_Port, local_Pin, 0);
    }

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_Brake(DC_MotorHandleType *handle)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }





    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_BRAKE);





    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {
        (void)GPIO_set_pin_value(handle->enPort, handle->enPin, 1);
    }
    else
    {
        DC_Motor_PwmSetDuty(handle->pwmChannel, 255U);
        DC_Motor_PwmConnect(handle->pwmChannel, 1U);
    }

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_GetState(const DC_MotorHandleType *handle, DC_MotorStateType *pState)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U) || (pState == ((void *)0)))
    {
        return ((Std_ReturnType)0x01);
    }


    *pState = handle->state;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_GetSpeed(const DC_MotorHandleType *handle, uint8_t *pSpeed)
{

    if ((handle == ((void *)0)) || (handle->initialized == 0U) || (pSpeed == ((void *)0)))
    {
        return ((Std_ReturnType)0x01);
    }


    *pSpeed = handle->speedPercent;

    return ((Std_ReturnType)0x00);
}


Std_ReturnType DC_Motor_DeInit(DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin = 0U;


    if ((handle == ((void *)0)) || (handle->initialized == 0U))
    {
        return ((Std_ReturnType)0x01);
    }


    (void)DC_Motor_Stop(handle);






    if (handle->pwmChannel != DC_MOTOR_PWM_NONE)
    {
        DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
        DC_Motor_PwmSetDuty(handle->pwmChannel, 0U);
        (void)GPIO_set_pin_value(local_Port, local_Pin, 0);
    }


    handle->speedPercent = 0U;
    handle->initialized = 0U;

    return ((Std_ReturnType)0x00);
}
