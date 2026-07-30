#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include <avr/interrupt.h>
#include "timer_registers.h"
#include "timer_interface.h"
#include "../GPIO/GPIO_interface.h"

/* ==================================================================================================== */
/* ====================== GLOBAL VARIABLES ============================================================ */

static Timer_CallBackType Timer0_CompareMatch_CallBack = NULL;
static volatile uint32_t g_tickCount = 0;

/* ==================================================================================================== */
/* ====================== TIMER0 ====================================================================== */

Std_ReturnType Timer0_Init(void)
{
    /* CTC Mode */
    CLR_BIT(TIMER_TCCR0_REG, TIMER_WGM00_BIT);
    SET_BIT(TIMER_TCCR0_REG, TIMER_WGM01_BIT);

    TIMER_TCNT0_REG = 0;
    TIMER_OCR0_REG  = 249; /* 1ms tick at 16MHz with 64 prescaler (16MHz / (64 * 1000Hz) - 1) */

    /* Prescaler 64: CS01=1, CS00=1, CS02=0 */
    CLR_BIT(TIMER_TCCR0_REG, TIMER_CS02_BIT);
    SET_BIT(TIMER_TCCR0_REG, TIMER_CS01_BIT);
    SET_BIT(TIMER_TCCR0_REG, TIMER_CS00_BIT);

 
    SET_BIT(TIMER_TIMSK_REG, TIMER_OCIE0_BIT);

    return E_OK;
}

Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType)
{
    if (channel != TIMER_CHANNEL_0)
    {
        return E_NOK;
    }
    else
    {
        SET_BIT(TIMER_TIMSK_REG, (intType == TIMER_INT_OVERFLOW) ? TIMER_TOIE0_BIT : TIMER_OCIE0_BIT);
        return E_OK;
    }
}

Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType)
{
    if (channel != TIMER_CHANNEL_0)
    {
        return E_NOK;
    }
    else
    {
        CLR_BIT(TIMER_TIMSK_REG, (intType == TIMER_INT_OVERFLOW) ? TIMER_TOIE0_BIT : TIMER_OCIE0_BIT);
        return E_OK;
    }
}

Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType, Timer_CallBackType callBack)
{
    if (callBack == NULL)
    {
        return E_NOK;
    }

    Timer0_CompareMatch_CallBack = callBack;
    return E_OK;
}

ISR(TIMER0_COMP_vect)
{
    g_tickCount++; /* زيادة عداد الـ System Tick */

    if (Timer0_CompareMatch_CallBack != NULL)
    {
        Timer0_CompareMatch_CallBack();
    }
}

/* ==================== TIMER1 (PWM) ================================================================== */

Std_ReturnType Timer1_Init(void)
{
    /* Fast PWM Mode 14 (TOP = ICR1) */
    CLR_BIT(TIMER_TCCR1A_REG, TIMER_WGM10_BIT);
    SET_BIT(TIMER_TCCR1A_REG, TIMER_WGM11_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM12_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM13_BIT);

    /* Non-Inverting Mode on OC1A (PD5) */
    CLR_BIT(TIMER_TCCR1A_REG, TIMER_COM1A0_BIT);
    SET_BIT(TIMER_TCCR1A_REG, TIMER_COM1A1_BIT);
    
    TIMER_TCNT1_REG = 0;
    TIMER_ICR1_REG  = 399; /* PWM Frequency ~40kHz @ 16MHz */
    
    /* Prescaler 1 */
    CLR_BIT(TIMER_TCCR1B_REG, TIMER_CS12_BIT);
    CLR_BIT(TIMER_TCCR1B_REG, TIMER_CS11_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_CS10_BIT);
    
    GPIO_set_pin_Direction(GPIO_PORTD, GPIO_PIN5, GPIO_OUTPUT);
    return E_OK;
}

Std_ReturnType Timer1_SetDuty(uint16_t duty_percent)
{ 
    if (duty_percent > 100)
    {
        return E_NOK;
    }
    else if (duty_percent == 0)
    {
        TIMER_OCR1A_REG = 0;
    }
    else
    {
        TIMER_OCR1A_REG = (((uint32_t)duty_percent * 399) / 100);
    }
    return E_OK;
}

/* ==================== TIMER2 (Buzzer Tone) ========================================================== */

Std_ReturnType Timer2_Init(void)
{
    /* CTC Mode */
    CLR_BIT(TIMER_TCCR2_REG, TIMER_WGM20_BIT);
    SET_BIT(TIMER_TCCR2_REG, TIMER_WGM21_BIT);

    TIMER_TCNT2_REG = 0;


    SET_BIT(TIMER_TCCR2_REG, TIMER_CS22_BIT);
    CLR_BIT(TIMER_TCCR2_REG, TIMER_CS21_BIT);
    SET_BIT(TIMER_TCCR2_REG, TIMER_CS20_BIT);

    // Toggle OC2 on Compare Match
    CLR_BIT(TIMER_TCCR2_REG, TIMER_COM21_BIT);
    SET_BIT(TIMER_TCCR2_REG, TIMER_COM20_BIT);
    
    GPIO_set_pin_Direction(GPIO_PORTD, GPIO_PIN7, GPIO_OUTPUT);
    return E_OK;
}

Std_ReturnType Timer2_SetTone(uint16_t tone)
{
    if (tone > 255)
    {
        return E_NOK;
    }
    else
    {
        TIMER_OCR2_REG = tone;
    }
    return E_OK;
}

/* ==================== GLOBAL INTERRUPT & SYSTEM TICK =============================================== */

void Timer_EnableGlobalInterrupt(void)
{
    sei();
}

void Timer_DisableGlobalInterrupt(void)
{
    cli();
}

uint32_t TIMER_GetTick(void)
{
    uint32_t local_tick;
    uint8_t sreg = SREG; /* حفظ حالة المقاطعات الحالية */
    cli();               /* إيقاف المؤقت */
    local_tick = g_tickCount;
    SREG = sreg;         /* استرجاع حالة المقاطعات الأصلية */
    return local_tick;
}