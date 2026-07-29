#include "../../Service/STD_Types.h"
#include "../../MCL/Timer/timer_interface.h"
#include "BUZZER.h"

/* Global Variable Definitions */
Buzzer_Mode_t Buzzer_CurrentMode = BUZZ_OFF;
uint16_t      Buzzer_TickCounter = 0;

Std_ReturnType BUZZER_Init(void)
{
    Buzzer_CurrentMode = BUZZ_OFF;
    Buzzer_TickCounter = 0;
    return Timer2_Init();
}

Std_ReturnType BUZZER_SetMode(Buzzer_Mode_t mode)
{
    Std_ReturnType local_Status = E_OK;

    Buzzer_CurrentMode = mode;
    Buzzer_TickCounter = 0;

    switch (mode)
    {
        case BUZZ_OFF:
            local_Status = Timer2_SetTone(0);
            break;
        case BUZZ_SLOW:
            local_Status = Timer2_SetTone(BUZZ_TONE_SLOW);
            break;
        case BUZZ_FAST:
            local_Status = Timer2_SetTone(BUZZ_TONE_FAST);
            break;
        case BUZZ_CONTINUOUS:
            local_Status = Timer2_SetTone(BUZZ_TONE_FAST);
            break;
        default:
            local_Status = E_NOK;
            break;
    }

    return local_Status;
}

void BUZZER_Update(void)
{
    uint16_t period;

    if (Buzzer_CurrentMode == BUZZ_OFF || Buzzer_CurrentMode == BUZZ_CONTINUOUS)
    {
        return;
    }

    period = (Buzzer_CurrentMode == BUZZ_SLOW) ? BUZZ_SLOW_PERIOD_TICKS
                                                : BUZZ_FAST_PERIOD_TICKS;

    Buzzer_TickCounter++;

    if (Buzzer_TickCounter >= period)
    {
        Buzzer_TickCounter = 0;
        /* toggle between tone-on and silent */
        static uint8_t soundOn = 1;
        if (soundOn)
        {
            Timer2_SetTone(0);
        }
        else
        {
            Timer2_SetTone((Buzzer_CurrentMode == BUZZ_SLOW) ? BUZZ_TONE_SLOW : BUZZ_TONE_FAST);
        }
        soundOn = !soundOn;
    }
}