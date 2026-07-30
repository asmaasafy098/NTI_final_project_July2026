#include "MotorBridge.h"
#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_interface.h"
#include "../../MCL/Timer/timer_registers.h"
#include "../../Logic/Data/data_types.h"

/* ============================================================================
 * MOTOR BRIDGE - PWM Version (using Timer1 Fast PWM on OC1A/PD5)
 * ============================================================================ */

/* ==================== Local Defines ==================== */
#define PWM_TOP_VALUE     399U   /* ICR1 = 399 → 40kHz PWM @ 16MHz */
#define PWM_MIN_RUN_PCT   10U    /* Minimum duty to run motor */

/* ==================== Static Variables ==================== */
static uint16_t masterEnabled = FALSE;
static uint16_t lastDutyPct = 0;
static uint8_t bridgeInitialized = 0;

/* ==================== Private Functions ==================== */

static void BRIDGE_ApplyOutput(void)
{
    uint16_t dutyCounts = 0;
    
    if (masterEnabled && (lastDutyPct >= PWM_MIN_RUN_PCT)) {
        /* Convert percentage to PWM counts (0-399) */
        dutyCounts = (uint16_t)(((uint32_t)lastDutyPct * PWM_TOP_VALUE) / 100U);
        
        /* Clamp to safe range */
        if (dutyCounts > PWM_TOP_VALUE) {
            dutyCounts = PWM_TOP_VALUE;
        }
        
        TIMER_OCR1A_REG = dutyCounts;          /* Set PWM duty */
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_HIGH);  /* Enable bridge */
    } else {
        TIMER_OCR1A_REG = 0;                   /* 0% duty */
        GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);   /* Disable bridge */
    }
}

/* ==================== Public Functions ==================== */

Std_ReturnType BRIDGE_Init(void)
{
    if (bridgeInitialized) {
        return E_OK;
    }
    
    /* ===== STEP 1: Configure GPIO pins ===== */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN0, GPIO_OUTPUT); /* IN1 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN1, GPIO_OUTPUT); /* IN2 */
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN2, GPIO_OUTPUT); /* EN  */
    GPIO_set_pin_Direction(GPIO_PORTD, GPIO_PIN5, GPIO_OUTPUT); /* OC1A (PWM) */
    
    /* ===== STEP 2: Safe state ===== */
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTD, GPIO_PIN5, GPIO_LOW);
    
    /* ===== STEP 3: Configure Timer1 for Fast PWM ===== */
    /* Fast PWM Mode 14 (WGM13=1, WGM12=1, WGM11=1, WGM10=0) */
    SET_BIT(TIMER_TCCR1A_REG, TIMER_WGM11_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM12_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM13_BIT);
    CLR_BIT(TIMER_TCCR1A_REG, TIMER_WGM10_BIT);
    
    /* Non-inverting mode on OC1A (COM1A1=1, COM1A0=0) */
    SET_BIT(TIMER_TCCR1A_REG, TIMER_COM1A1_BIT);
    CLR_BIT(TIMER_TCCR1A_REG, TIMER_COM1A0_BIT);
    
    /* Set PWM frequency: ICR1 = 399 → 40kHz */
    TIMER_ICR1_REG = PWM_TOP_VALUE;
    TIMER_OCR1A_REG = 0;  /* Start with 0% duty */
    
    /* Prescaler = 1 (CS10=1) */
    SET_BIT(TIMER_TCCR1B_REG, TIMER_CS10_BIT);
    CLR_BIT(TIMER_TCCR1B_REG, TIMER_CS11_BIT);
    CLR_BIT(TIMER_TCCR1B_REG, TIMER_CS12_BIT);
    
    /* ===== STEP 4: Reset state ===== */
    masterEnabled = FALSE;
    lastDutyPct = 0;
    bridgeInitialized = 1;
    
    return E_OK;
}

Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir)
{
    switch (dir) {
        case DIR_FORWARD:
            /* NFR-05: never both high - clear other line first */
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
    /* Step 1: Clear PWM output */
    TIMER_OCR1A_REG = 0;
    
    /* Step 2: Disable bridge enable pin */
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN2, GPIO_LOW);
    
    /* Step 3: Both direction pins low (NFR-05 safe state) */
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN0, GPIO_LOW);
    GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN1, GPIO_LOW);
    
    /* Step 4: Update internal state */
    masterEnabled = FALSE;
    lastDutyPct = 0;
}

uint8_t BRIDGE_IsEnabled(void)
{
    return (uint8_t)masterEnabled;
}