#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_Interface.h"
#include "../../MCL/Timer/timer_registers.h"
#include "dc_motor.h"

#ifndef GPIO_NUMBER_OF_PORTS
#define GPIO_NUMBER_OF_PORTS    4U
#endif

#define DC_MOTOR_OC0_PORT    GPIO_PORTB
#define DC_MOTOR_OC0_PIN     GPIO_PIN3
#define DC_MOTOR_OC1A_PORT   GPIO_PORTD
#define DC_MOTOR_OC1A_PIN    GPIO_PIN5
#define DC_MOTOR_OC1B_PORT   GPIO_PORTD
#define DC_MOTOR_OC1B_PIN    GPIO_PIN4
#define DC_MOTOR_OC2_PORT    GPIO_PORTD
#define DC_MOTOR_OC2_PIN     GPIO_PIN7

#define DC_MOTOR_PWM_MAX     255U


/* --------------------------------------------------------------------------
 *  INTERNAL HELPERS
 * ------------------------------------------------------------------------ */

static void DC_Motor_PwmPin(DC_MotorPwmChannelType channel, uint8_t *pPort, uint8_t *pPin)
{
    switch (channel)
    {
        case DC_MOTOR_PWM_OC0:  *pPort = DC_MOTOR_OC0_PORT;  *pPin = DC_MOTOR_OC0_PIN;  break;
        case DC_MOTOR_PWM_OC1A: *pPort = DC_MOTOR_OC1A_PORT; *pPin = DC_MOTOR_OC1A_PIN; break;
        case DC_MOTOR_PWM_OC1B: *pPort = DC_MOTOR_OC1B_PORT; *pPin = DC_MOTOR_OC1B_PIN; break;
        case DC_MOTOR_PWM_OC2:  *pPort = DC_MOTOR_OC2_PORT;  *pPin = DC_MOTOR_OC2_PIN;  break;
        default:                *pPort = 0U;                 *pPin = 0U;                break;
    }
}

static void DC_Motor_PwmTimerSetup(DC_MotorPwmChannelType channel)
{
    switch (channel)
    {
        case DC_MOTOR_PWM_OC0:
            TIMER_TCCR0_REG = (uint8_t)((1U << TIMER_WGM00_BIT) | (1U << TIMER_WGM01_BIT) |
                                        (1U << TIMER_CS01_BIT)  | (1U << TIMER_CS00_BIT));
            TIMER_OCR0_REG  = 0U;
            break;

        case DC_MOTOR_PWM_OC1A:
        case DC_MOTOR_PWM_OC1B:
            SET_BIT(TIMER_TCCR1A_REG, TIMER_WGM10_BIT);
            SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM12_BIT);
            SET_BIT(TIMER_TCCR1B_REG, TIMER_CS11_BIT);
            SET_BIT(TIMER_TCCR1B_REG, TIMER_CS10_BIT);
            break;

        case DC_MOTOR_PWM_OC2:
            TIMER_TCCR2_REG = (uint8_t)((1U << TIMER_WGM20_BIT) | (1U << TIMER_WGM21_BIT) |
                                        (1U << TIMER_CS22_BIT));
            TIMER_OCR2_REG  = 0U;
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
            if (enable != 0U) { SET_BIT(TIMER_TCCR0_REG, TIMER_COM01_BIT); }
            else              { CLR_BIT(TIMER_TCCR0_REG, TIMER_COM01_BIT); }
            break;

        case DC_MOTOR_PWM_OC1A:
            if (enable != 0U) { SET_BIT(TIMER_TCCR1A_REG, TIMER_COM1A1_BIT); }
            else              { CLR_BIT(TIMER_TCCR1A_REG, TIMER_COM1A1_BIT); }
            break;

        case DC_MOTOR_PWM_OC1B:
            if (enable != 0U) { SET_BIT(TIMER_TCCR1A_REG, TIMER_COM1B1_BIT); }
            else              { CLR_BIT(TIMER_TCCR1A_REG, TIMER_COM1B1_BIT); }
            break;

        case DC_MOTOR_PWM_OC2:
            if (enable != 0U) { SET_BIT(TIMER_TCCR2_REG, TIMER_COM21_BIT); }
            else              { CLR_BIT(TIMER_TCCR2_REG, TIMER_COM21_BIT); }
            break;

        default:
            break;
    }
}

static void DC_Motor_PwmSetDuty(DC_MotorPwmChannelType channel, uint8_t duty)
{
    switch (channel)
    {
        case DC_MOTOR_PWM_OC0:  TIMER_OCR0_REG  = duty;             break;
        case DC_MOTOR_PWM_OC1A: TIMER_OCR1A_REG = (uint16_t)duty;   break;
        case DC_MOTOR_PWM_OC1B: TIMER_OCR1B_REG = (uint16_t)duty;   break;
        case DC_MOTOR_PWM_OC2:  TIMER_OCR2_REG  = duty;             break;
        default:                                                     break;
    }
}

static void DC_Motor_ApplySpeed(const DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin  = 0U;
    uint8_t local_Duty = 0U;

    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {
        (void)GPIO_set_pin_value(handle->enPort, handle->enPin,
                               (handle->speedPercent > 0U) ? GPIO_HIGH : GPIO_LOW);
        return;
    }

    DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);

    if (handle->speedPercent == 0U)
    {
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
        (void)GPIO_set_pin_value(local_Port, local_Pin, GPIO_LOW);
        return;
    }

    local_Duty = (uint8_t)(((uint16_t)handle->speedPercent * DC_MOTOR_PWM_MAX) / 100U);

    DC_Motor_PwmSetDuty(handle->pwmChannel, local_Duty);
    DC_Motor_PwmConnect(handle->pwmChannel, 1U);
}

static void DC_Motor_ApplyState(DC_MotorHandleType *handle, DC_MotorStateType state)
{
    uint8_t local_In1 = GPIO_LOW;
    uint8_t local_In2 = GPIO_LOW;

    switch (state)
    {
        case DC_MOTOR_STATE_FORWARD:   local_In1 = GPIO_HIGH; local_In2 = GPIO_LOW;  break;
        case DC_MOTOR_STATE_BACKWARD:  local_In1 = GPIO_LOW;  local_In2 = GPIO_HIGH; break;
        case DC_MOTOR_STATE_BRAKE:     local_In1 = GPIO_HIGH; local_In2 = GPIO_HIGH; break;
        case DC_MOTOR_STATE_STOP:
        default:                       local_In1 = GPIO_LOW;  local_In2 = GPIO_LOW;  break;
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


/* --------------------------------------------------------------------------
 *  PUBLIC FUNCTIONS
 * ------------------------------------------------------------------------ */

Std_ReturnType DC_Motor_Init(DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin  = 0U;

    if (handle == NULL)
    {
        return E_NOK;
    }

    if ((handle->in1Port >= GPIO_NUMBER_OF_PORTS) || (handle->in2Port >= GPIO_NUMBER_OF_PORTS))
    {
        return E_NOK;
    }

    if (handle->pwmChannel > DC_MOTOR_PWM_OC2)
    {
        return E_NOK;
    }

    (void)GPIO_set_pin_Direction(handle->in1Port, handle->in1Pin, GPIO_OUTPUT);
    (void)GPIO_set_pin_Direction(handle->in2Port, handle->in2Pin, GPIO_OUTPUT);
    (void)GPIO_set_pin_value(handle->in1Port, handle->in1Pin, GPIO_LOW);
    (void)GPIO_set_pin_value(handle->in2Port, handle->in2Pin, GPIO_LOW);

    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {
        if (handle->enPort >= GPIO_NUMBER_OF_PORTS)
        {
            return E_NOK;
        }

        (void)GPIO_set_pin_Direction(handle->enPort, handle->enPin, GPIO_OUTPUT);
        (void)GPIO_set_pin_value(handle->enPort, handle->enPin, GPIO_LOW);
    }
    else
    {
        DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);
        (void)GPIO_set_pin_Direction(local_Port, local_Pin, GPIO_OUTPUT);
        (void)GPIO_set_pin_value(local_Port, local_Pin, GPIO_LOW);

        DC_Motor_PwmTimerSetup(handle->pwmChannel);
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
    }

    handle->speedPercent = 0U;
    handle->initialized  = 1U;
    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_STOP);
    DC_Motor_ApplySpeed(handle);

    return E_OK;
}


Std_ReturnType DC_Motor_SetSpeed(DC_MotorHandleType *handle, uint8_t speedPercent)
{
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    if (speedPercent > 100U)
    {
        speedPercent = 100U;
    }

    handle->speedPercent = speedPercent;
    DC_Motor_ApplySpeed(handle);

    return E_OK;
}


Std_ReturnType DC_Motor_Forward(DC_MotorHandleType *handle)
{
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_FORWARD);
    DC_Motor_ApplySpeed(handle);

    return E_OK;
}


Std_ReturnType DC_Motor_Backward(DC_MotorHandleType *handle)
{
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_BACKWARD);
    DC_Motor_ApplySpeed(handle);

    return E_OK;
}


Std_ReturnType DC_Motor_SetDirection(DC_MotorHandleType *handle, DC_MotorDirectionType dir)
{
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    if (dir > DC_MOTOR_DIR_BACKWARD)
    {
        return E_NOK;
    }

    return (dir == DC_MOTOR_DIR_FORWARD) ? DC_Motor_Forward(handle) : DC_Motor_Backward(handle);
}


Std_ReturnType DC_Motor_Stop(DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin  = 0U;

    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_STOP);

    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {
        (void)GPIO_set_pin_value(handle->enPort, handle->enPin, GPIO_LOW);
    }
    else
    {
        DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
        (void)GPIO_set_pin_value(local_Port, local_Pin, GPIO_LOW);
    }

    return E_OK;
}


Std_ReturnType DC_Motor_Brake(DC_MotorHandleType *handle)
{
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    DC_Motor_ApplyState(handle, DC_MOTOR_STATE_BRAKE);

    if (handle->pwmChannel == DC_MOTOR_PWM_NONE)
    {
        (void)GPIO_set_pin_value(handle->enPort, handle->enPin, GPIO_HIGH);
    }
    else
    {
        DC_Motor_PwmSetDuty(handle->pwmChannel, DC_MOTOR_PWM_MAX);
        DC_Motor_PwmConnect(handle->pwmChannel, 1U);
    }

    return E_OK;
}


Std_ReturnType DC_Motor_GetState(const DC_MotorHandleType *handle, DC_MotorStateType *pState)
{
    if ((handle == NULL) || (handle->initialized == 0U) || (pState == NULL))
    {
        return E_NOK;
    }

    *pState = handle->state;

    return E_OK;
}


Std_ReturnType DC_Motor_GetSpeed(const DC_MotorHandleType *handle, uint8_t *pSpeed)
{
    if ((handle == NULL) || (handle->initialized == 0U) || (pSpeed == NULL))
    {
        return E_NOK;
    }

    *pSpeed = handle->speedPercent;

    return E_OK;
}


Std_ReturnType DC_Motor_DeInit(DC_MotorHandleType *handle)
{
    uint8_t local_Port = 0U;
    uint8_t local_Pin  = 0U;

    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    (void)DC_Motor_Stop(handle);

    if (handle->pwmChannel != DC_MOTOR_PWM_NONE)
    {
        DC_Motor_PwmPin(handle->pwmChannel, &local_Port, &local_Pin);
        DC_Motor_PwmConnect(handle->pwmChannel, 0U);
        DC_Motor_PwmSetDuty(handle->pwmChannel, 0U);
        (void)GPIO_set_pin_value(local_Port, local_Pin, GPIO_LOW);
    }

    handle->speedPercent = 0U;
    handle->initialized  = 0U;

    return E_OK;
}


/* --------------------------------------------------------------------------
 *  APPLICATION USAGE EXAMPLE
 * ------------------------------------------------------------------------ */

DC_MotorHandleType myMotor;

void Motor_App_Init(void)
{
    myMotor.in1Port       = GPIO_PORTB;
    myMotor.in1Pin        = GPIO_PIN0;
    myMotor.in2Port       = GPIO_PORTB;
    myMotor.in2Pin        = GPIO_PIN1;

    myMotor.pwmChannel    = DC_MOTOR_PWM_OC0;

    myMotor.enPort        = GPIO_PORTB;
    myMotor.enPin         = GPIO_PIN3;

    myMotor.invertDirection = 0U;

    if (DC_Motor_Init(&myMotor) == E_OK)
    {
        DC_Motor_SetSpeed(&myMotor, 75U);
        DC_Motor_Forward(&myMotor);
    }
    else
    {
        /* Handle initialization error */
    }
}