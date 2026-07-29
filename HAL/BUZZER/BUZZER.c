/* ============================ Buzzer.h ============================ */
typedef enum {
    BUZZ_OFF,
    BUZZ_SLOW,
    BUZZ_FAST,
    BUZZ_CONTINUOUS
} Buzzer_Mode_t;


/* ============================ Buzzer.c ============================ */
#include "../../Service/STD_Types.h"
#include "../MCAL/Timer/timer_interface.h"
#include "Buzzer_Interface.h"

static Buzzer_Mode_t Buzzer_CurrentMode = BUZZ_OFF;
static uint16_t      Buzzer_TickCounter = 0;

#define BUZZ_TONE_SLOW        150   /* OCR2 value -> low tone   */
#define BUZZ_TONE_FAST        60    /* OCR2 value -> high tone  */
#define BUZZ_SLOW_PERIOD_TICKS   50 /* toggles every 500ms @10ms tick */
#define BUZZ_FAST_PERIOD_TICKS   10 /* toggles every 100ms @10ms tick */


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