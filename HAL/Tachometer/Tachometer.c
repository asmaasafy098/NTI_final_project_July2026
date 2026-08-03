#include "Tachometer.h"
#include "../../Service/STD_Types.h"
#include "../../MCL/Interrupt/interrupt_interface.h"
#include <stdio.h>
#include "../../MCL/UART/uart_interface.h"
static volatile uint16_t Tacho_PulseCount = 0;
static volatile int16_t Tacho_RPM = 0;

void TACHO_PulseISR(void)
{
    Tacho_PulseCount++;

}
void TACHO_Init(void)
{
    EXTI_ConfigType cfg;

    Tacho_PulseCount = 0;
    Tacho_RPM = 0;

    cfg.line = EXTI_INT0;
    cfg.sense = EXTI_SENSE_RISING;   
    EXTI_Init(&cfg);

    EXTI_SetCallBack(EXTI_INT0, TACHO_PulseISR);
}
void TACHO_Update(void)
{
    uint16_t count;
    int16_t rpmInstant;

    __asm__ volatile ("cli" ::: "memory");
    count = Tacho_PulseCount;
    Tacho_PulseCount = 0;
    __asm__ volatile ("sei" ::: "memory");

    /* Ignore very small counts */
    if (count <= 3)
    {
        rpmInstant = 0;
    }
    else
    {
        rpmInstant = count * RPM_PER_COUNT;
    }

    /* Low-pass filter:
       NewRPM = 75% old + 25% new */
    Tacho_RPM = (int16_t)(((int32_t)Tacho_RPM * 3 + rpmInstant) / 4);

    char txt[80];
    sprintf(txt,
            "COUNT=%u INST=%d FILT=%d\r\n",
            count,
            rpmInstant,
            Tacho_RPM);
    UART_SendString(txt);
}

int16_t TACHO_GetRPM(void)
{
    return Tacho_RPM;
}