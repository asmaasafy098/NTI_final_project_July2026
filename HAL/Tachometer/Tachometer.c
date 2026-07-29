#include "Tachometer.h"
#include "../../Service/STD_Types.h"
#include "../../MCL/Interrupt/interrupt_interface.h"

static volatile uint16_t Tacho_PulseCount = 0;
static volatile int16_t Tacho_RPM = 0;

void TACHO_PulseISR(void)
{
    Tacho_PulseCount++;
}

void TACHO_Init(void)
{
    Tacho_PulseCount = 0;
    Tacho_RPM = 0;

    /* إعداد دالة الـ Callback وتفعيل المقاطعة الخارجية EXTI0 */
    EXTI_SetCallBack(EXTI_INT0, TACHO_PulseISR);
    EXTI_Enable(EXTI_INT0);
}

void TACHO_Update(void)
{
    uint16_t count;

    /* إيقاف المقاطعات العامة مؤقتاً لقراءة المتغير بشكل أتمي (Atomic Read) */
    __asm__ volatile ("cli" ::: "memory");
    count = Tacho_PulseCount;
    Tacho_PulseCount = 0;
    __asm__ volatile ("sei" ::: "memory");

    /* حساب الـ RPM */
    Tacho_RPM = count * RPM_PER_COUNT;
}

int16_t TACHO_GetRPM(void)
{
    return Tacho_RPM;
}