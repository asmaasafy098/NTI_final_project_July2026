#include "MotorBridge.h"
#include "../../Service/STD_Types.h"
#include "../../MCL/GPIO/GPIO_interface.h"
<<<<<<< HEAD
#include "../../MCL/timer/timer_interface.h"
#include "../../Logic/Data/data_types.h"
=======
#include "../../MCL/Timer/timer_interface.h"

>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
Std_ReturnType BRIDGE_Init(void)
{
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN0, GPIO_OUTPUT); /* IN1 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN1, GPIO_OUTPUT); /* IN2 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN2, GPIO_OUTPUT); /* EN  */
    return Timer1_Init();
}


<<<<<<< HEAD
Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir)
{
    switch (dir)
    {
        case DIR_FORWARD:
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_HIGH);
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
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
=======

Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir)
{
    switch(dir)
{
    case DIR_FORWARD:
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_HIGH);
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
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
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
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
    Timer1_SetDuty(0);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
}

