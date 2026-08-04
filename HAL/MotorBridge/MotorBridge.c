#include "MotorBridge.h"
#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_interface.h"
#include "../../MCL/Timer/timer_registers.h"
#include "../../MCL/Timer/timer_interface.h"
#include "../../Logic/Data/data_types.h"
/* ==================== Static Variables ==================== */
static uint16_t masterEnabled = FALSE;
static uint8_t bridgeInitialized = 0;
/* ==================== Public Functions ==================== */

Std_ReturnType BRIDGE_Init(void)
{
    if (bridgeInitialized)
        return E_OK;

    /* Direction pins */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN0, GPIO_OUTPUT);
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN1, GPIO_OUTPUT);

    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);

    /* PWM on PD5 (OC1A) */
    Timer1_Init();
    Timer1_SetDuty(0);

    masterEnabled = FALSE;
    bridgeInitialized = 1;

    return E_OK;
}

Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir)
{
    switch (dir) {
        case DIR_FORWARD:
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_HIGH);
            break;
        case DIR_REVERSE:
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_HIGH);
            break;
        case DIR_STOP:
        default:
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
            break;
    }
    return E_OK;
}
Std_ReturnType BRIDGE_SetDuty(uint16_t dutyCounts)
{
    if (!masterEnabled)
    {
        TIMER_OCR1A_REG = 0;
        return E_OK;
    }

    if (dutyCounts > PWM_TOP)
        dutyCounts = PWM_TOP;

    TIMER_OCR1A_REG = dutyCounts;

    return E_OK;
}
Std_ReturnType BRIDGE_Enable(void)
{
    masterEnabled = TRUE;
    return E_OK;
}
Std_ReturnType BRIDGE_Disable(void)
{
    masterEnabled = FALSE;
    Timer1_SetDuty(0);
    return E_OK;
}
void BRIDGE_ForceStop(void)
{
    Timer1_SetDuty(0);

    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);

    masterEnabled = FALSE;
}
uint8_t BRIDGE_IsEnabled(void)
{
    return (uint8_t)masterEnabled;
}