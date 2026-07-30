#include "MotorBridge.h"
#include "../../Service/STD_Types.h"
#include "../../MCL/GPIO/GPIO_interface.h"
#include "../../Logic/Data/data_types.h"

/* PD5/OC1A is not wired to anything in the SimulIDE circuit (checked
 * against Final_Hardware_project.sim1 -- no Connector touches
 * mega32-74-PORTD5 anywhere). Timer1 PWM was removed on purpose: any
 * duty value handed to a hardware PWM channel here would have zero
 * physical effect on the motor. Speed is now bang-bang instead:
 *   PB0 = IN1, PB1 = IN2, PB2 = EnA (plain digital enable, on/off only)
 *
 * BRIDGE_SetDuty() is kept in the API so the PI controller in
 * pi_ctl.c doesn't need to change: any call with
 * duty_percent >= BRIDGE_MIN_RUN_PCT is treated as "request ON",
 * anything below as "request OFF". It does NOT modulate torque.
 * Proportional speed control has to come from the FSM/control layer
 * toggling BRIDGE_Enable()/BRIDGE_Disable() based on measured vs.
 * setpoint RPM, not from a duty cycle applied here.
 */

#define BRIDGE_MIN_RUN_PCT   10u   /* below this, treated as "stay off" */

static uint16_t masterEnabled = FALSE;
static uint16_t lastDutyPct = 0;

static void BRIDGE_ApplyOutput(void)
{
    if (masterEnabled && (lastDutyPct >= BRIDGE_MIN_RUN_PCT))
    {
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_HIGH);
    }
    else
    {
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    }
}

Std_ReturnType BRIDGE_Init(void)
{
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN0, GPIO_OUTPUT); /* IN1 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN1, GPIO_OUTPUT); /* IN2 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN2, GPIO_OUTPUT); /* EN  */

    /* NFR-14: safe state before anything else */
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);

    masterEnabled = FALSE;
    lastDutyPct = 0;

    return E_OK;
}

Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir)
{
    switch (dir)
    {
        case DIR_FORWARD:
            /* NFR-05: never both high -- clear the other line first */
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

Std_ReturnType BRIDGE_SetDuty(uint16_t duty_percent)
{
    lastDutyPct = duty_percent;
    BRIDGE_ApplyOutput();
    return E_OK;
}

Std_ReturnType BRIDGE_Enable(void)
{
    masterEnabled = TRUE;
    BRIDGE_ApplyOutput();
    return E_OK;
}

Std_ReturnType BRIDGE_Disable(void)
{
    masterEnabled = FALSE;
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    return E_OK;
}

void BRIDGE_ForceStop(void)   /* used directly inside E-stop ISR */
{
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
    masterEnabled = FALSE;
    lastDutyPct = 0;
}