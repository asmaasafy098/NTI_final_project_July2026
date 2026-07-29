#include "Tachometer.h"
#ifndef TACHO_ENTER_CRITICAL
#define TACHO_ENTER_CRITICAL()  __disable_irq()
#endif
#ifndef TACHO_EXIT_CRITICAL
#define TACHO_EXIT_CRITICAL()   __enable_irq()
#endif

static volatile uint16_t pulseCount = 0;
static int16_t rpm = 0;

void TACHO_Init(void)
{
    TACHO_ENTER_CRITICAL();
    pulseCount = 0;
    TACHO_EXIT_CRITICAL();

    rpm = 0;
}

/* Call from the pulse-capture / edge-detect interrupt handler. */
void TACHO_PulseISR(void)
{
    pulseCount++;
}

void TACHO_Update(void)
{
    uint16_t count;

    /* Atomically snapshot and clear the pulse counter so a pulse
     * arriving between the read and the reset isn't lost. */
    TACHO_ENTER_CRITICAL();
    count = pulseCount;
    pulseCount = 0;
    TACHO_EXIT_CRITICAL();

    rpm = (int16_t)(count * RPM_PER_COUNT);
}

int16_t TACHO_GetRPM(void)
{
    return rpm;
}