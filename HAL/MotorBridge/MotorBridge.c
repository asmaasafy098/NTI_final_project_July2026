#include "MotorBridge.h"
#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_interface.h"
#include "../../MCL/Timer/timer_registers.h"
#include "../../Logic/Data/data_types.h"

/* ==================== Local Defines ==================== */
#define PWM_TOP_VALUE     399U
#define PWM_MIN_RUN_PCT   10U

/* ==================== Static Variables ==================== */
static uint16_t masterEnabled = FALSE;
static uint16_t lastDutyPct = 0;
static uint8_t bridgeInitialized = 0;

/* ==================== Private Functions ==================== */

static void BRIDGE_ApplyOutput(void)
{
    uint16_t dutyCounts = 0;
    
    if (masterEnabled && (lastDutyPct >= PWM_MIN_RUN_PCT)) {
        dutyCounts = (uint16_t)(((uint32_t)lastDutyPct * PWM_TOP_VALUE) / 100U);
        if (dutyCounts > PWM_TOP_VALUE) {
            dutyCounts = PWM_TOP_VALUE;
        }
        TIMER_OCR1A_REG = dutyCounts;
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_HIGH);
    } else {
        TIMER_OCR1A_REG = 0;
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    }
}

/* ==================== Public Functions ==================== */

Std_ReturnType BRIDGE_Init(void)
{
    if (bridgeInitialized) {
        return E_OK;
    }
    
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN0, GPIO_OUTPUT);
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN1, GPIO_OUTPUT);
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN2, GPIO_OUTPUT);
    GPIO_set_pin_Direction(GPIO_PORTD, GPIO_PIN5, GPIO_OUTPUT);
    
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTD, GPIO_PIN5, GPIO_LOW);
    
    /* Fast PWM Mode 14 */
    SET_BIT(TIMER_TCCR1A_REG, TIMER_WGM11_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM12_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM13_BIT);
    CLR_BIT(TIMER_TCCR1A_REG, TIMER_WGM10_BIT);
    
    /* Non-inverting mode on OC1A */
    SET_BIT(TIMER_TCCR1A_REG, TIMER_COM1A1_BIT);
    CLR_BIT(TIMER_TCCR1A_REG, TIMER_COM1A0_BIT);
    
    TIMER_ICR1_REG = PWM_TOP_VALUE;
    TIMER_OCR1A_REG = 0;
    
    SET_BIT(TIMER_TCCR1B_REG, TIMER_CS10_BIT);
    CLR_BIT(TIMER_TCCR1B_REG, TIMER_CS11_BIT);
    CLR_BIT(TIMER_TCCR1B_REG, TIMER_CS12_BIT);
    
    masterEnabled = FALSE;
    lastDutyPct = 0;
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

Std_ReturnType BRIDGE_SetDuty(uint16_t duty_percent)
{
    if (duty_percent > 100U) {
        duty_percent = 100U;
    }
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
    TIMER_OCR1A_REG = 0;
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    return E_OK;
}

void BRIDGE_ForceStop(void)
{
    TIMER_OCR1A_REG = 0;
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
    masterEnabled = FALSE;
    lastDutyPct = 0;
}

uint8_t BRIDGE_IsEnabled(void)
{
    return (uint8_t)masterEnabled;
}