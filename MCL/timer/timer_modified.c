#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include <avr/interrupt.h>
#include "timer_registers.h"
#include "timer_interface.h"
#include "../GPIO/GPIO_Interface.h"

/* ==================================================================================================== */
/* ====================== GLOBAL CALLBACK POINTER ===================================================== */

/* مؤشر بسيط جدًا لدالة الـ CallBack الخاصة بـ Timer0 */
static Timer_CallBackType Timer0_CompareMatch_CallBack = NULL;

/* ==================================================================================================== */
/* ====================== TIMER0 ====================================================================== */

Std_ReturnType Timer0_Init()
{
    CLR_BIT(TIMER_TCCR0_REG, TIMER_WGM00_BIT);
    SET_BIT(TIMER_TCCR0_REG, TIMER_WGM01_BIT);

    TIMER_TCNT0_REG = 0;
    TIMER_OCR0_REG  = 77;
    SET_BIT(TIMER_TCCR0_REG, TIMER_CS02_BIT);
    CLR_BIT(TIMER_TCCR0_REG, TIMER_CS01_BIT);
    SET_BIT(TIMER_TCCR0_REG, TIMER_CS00_BIT);
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

    /* تخزين الـ Pointer مباشرة للـ Timer0 */
    Timer0_CompareMatch_CallBack = callBack;
    return E_OK;
}

/* ----------------------------- interrupt_timer0 ---------------------------------- */
ISR(TIMER0_COMP_vect)
{
    if (Timer0_CompareMatch_CallBack != NULL)
    {
        Timer0_CompareMatch_CallBack();
    }
}

/* ==================== TIMER1 ======================================================================== */

Std_ReturnType Timer1_Init()
{
    CLR_BIT(TIMER_TCCR1A_REG, TIMER_WGM10_BIT);
    SET_BIT(TIMER_TCCR1A_REG, TIMER_WGM11_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM12_BIT);
    SET_BIT(TIMER_TCCR1B_REG, TIMER_WGM13_BIT);

    CLR_BIT(TIMER_TCCR1A_REG, TIMER_COM1A0_BIT);
    SET_BIT(TIMER_TCCR1A_REG, TIMER_COM1A1_BIT);
    TIMER_TCNT1_REG = 0;
    TIMER_ICR1_REG  = 399;
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
        TIMER_OCR1A_REG = (((uint32_t)duty_percent * (PWM_TOP + 1)) / 100) - 1;
    }
    return E_OK;
}

/* ==================== TIMER2 ======================================================================== */

Std_ReturnType Timer2_Init()
{
    CLR_BIT(TIMER_TCCR2_REG, TIMER_WGM20_BIT); // CTC for diff. freq.
    SET_BIT(TIMER_TCCR2_REG, TIMER_WGM21_BIT);

    TIMER_TCNT2_REG = 0;
    SET_BIT(TIMER_TCCR2_REG, TIMER_CS02_BIT);
    CLR_BIT(TIMER_TCCR2_REG, TIMER_CS01_BIT);
    SET_BIT(TIMER_TCCR2_REG, TIMER_CS00_BIT);

    // Toggle bit @OCR2
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

/* ==================== GLOBAL INTERRUPT ============================================================= */

void Timer_EnableGlobalInterrupt(void)
{
    SET_BIT(TIMER_SREG_REG, TIMER_GLOBAL_INT_BIT);   
}

void Timer_DisableGlobalInterrupt(void)
{
    CLR_BIT(TIMER_SREG_REG, TIMER_GLOBAL_INT_BIT);   
}