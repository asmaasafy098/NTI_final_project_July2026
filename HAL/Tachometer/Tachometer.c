

static volatile uint16_t Tacho_PulseCount = 0;
static uint16_t Tacho_RPM = 0;

void TACHO_OnPulse(void)   /* EXTI0 callback */
{
    Tacho_PulseCount++;
}

Std_ReturnType TACHO_Init(void)
{
    Tacho_PulseCount = 0;
    Tacho_RPM = 0;
    return EXTI_SetCallBack(EXTI_INT0, TACHO_OnPulse);
}

void TACHO_Update(void)   /* called every 100ms */
{
    uint16_t count;
    EXTI_DisableGlobalInterrupt();
    count = Tacho_PulseCount;
    Tacho_PulseCount = 0;
    EXTI_EnableGlobalInterrupt();

    Tacho_RPM = count * 100;   /* RPM_PER_COUNT = 100 */
}

uint16_t TACHO_GetRPM(void)
{
    return Tacho_RPM;
}
