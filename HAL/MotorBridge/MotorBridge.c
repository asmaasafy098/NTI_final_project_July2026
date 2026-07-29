#include "MotorBridge.h"
#include "../../Service/STD_Types.h"
#include "../../MCL/GPIO/GPIO_interface.h"
typedef enum { DIR_STOP, DIR_FWD, DIR_REV } Dir_t;

Std_ReturnType BRIDGE_Init(void)
{
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN0, GPIO_OUTPUT); /* IN1 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN1, GPIO_OUTPUT); /* IN2 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN2, GPIO_OUTPUT); /* EN  */
    return Timer1_Init();
}



Std_ReturnType BRIDGE_SetDirection(Dir_t dir)
{
    switch (dir)
    {
        case DIR_FWD:
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_HIGH);
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
            break;
        case DIR_REV:
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

Std_ReturnType BRIDGE_SetDuty(uint16_t duty_percent)
{
    return Timer1_SetDuty(duty_percent);
}

Std_ReturnType BRIDGE_Enable(void)
{
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_HIGH);
    return E_OK;
}

Std_ReturnType BRIDGE_Disable(void)
{
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    return E_OK;
}

void BRIDGE_ForceStop(void)   /* used directly inside E-stop ISR */
{
    TIMER_OCR1A_REG = 0;
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
}

