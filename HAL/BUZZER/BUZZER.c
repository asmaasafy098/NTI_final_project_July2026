#include "../../Service/STD_Types.h"
#include "../../MCL/Timer/timer_interface.h"
#include "BUZZER.h"


/* ============================================================
 * Global Variables
 * ============================================================ */

Buzzer_Mode_t Buzzer_CurrentMode = BUZZ_OFF;
uint16_t      Buzzer_TickCounter = 0;


/* ============================================================
 * Initialization
 * ============================================================ */

Std_ReturnType BUZZER_Init(void)
{
    Std_ReturnType status;

    /*
     * Initialize Timer2 first.
     */
    status = Timer2_Init();

    /*
     * VERY IMPORTANT:
     * Force buzzer OFF immediately after timer initialization.
     * This prevents the buzzer from sounding at system startup.
     */
    Timer2_SetTone(0);

    Buzzer_CurrentMode = BUZZ_OFF;
    Buzzer_TickCounter = 0;

    return status;
}


/* ============================================================
 * Set Buzzer Mode
 * ============================================================ */

Std_ReturnType BUZZER_SetMode(Buzzer_Mode_t mode)
{
    Std_ReturnType status = E_OK;

    Buzzer_CurrentMode = mode;
    Buzzer_TickCounter = 0;

    switch (mode)
    {
        case BUZZ_OFF:

            Timer2_SetTone(0);
            break;


        case BUZZ_SLOW:

            Timer2_SetTone(BUZZ_TONE_SLOW);
            break;


        case BUZZ_FAST:

            Timer2_SetTone(BUZZ_TONE_FAST);
            break;


        case BUZZ_CONTINUOUS:

            Timer2_SetTone(BUZZ_TONE_FAST);
            break;


        case BUZZ_ACTION:

            /*
             * Start short action beep.
             */
            Timer2_SetTone(BUZZ_TONE_FAST);
            break;


        default:

            Timer2_SetTone(0);
            Buzzer_CurrentMode = BUZZ_OFF;
            status = E_NOK;
            break;
    }

    return status;
}


/* ============================================================
 * Short Action Beep
 * ============================================================ */

void BUZZER_ActionBeep(void)
{
    /*
     * Start a new short beep.
     */
    Buzzer_CurrentMode = BUZZ_ACTION;
    Buzzer_TickCounter = 0;

    Timer2_SetTone(BUZZ_TONE_FAST);
}


/* ============================================================
 * Periodic Update
 *
 * Called every 10 ms from Task_Panel().
 * ============================================================ */

void BUZZER_Update(void)
{
    uint16_t period;

    /*
     * Completely silent.
     */
    if (Buzzer_CurrentMode == BUZZ_OFF)
    {
        return;
    }


    /*
     * Continuous tone.
     */
    if (Buzzer_CurrentMode == BUZZ_CONTINUOUS)
    {
        return;
    }


    /*
     * Short action beep.
     *
     * 10 ticks x 10 ms = 100 ms.
     */
    if (Buzzer_CurrentMode == BUZZ_ACTION)
    {
        Buzzer_TickCounter++;

        if (Buzzer_TickCounter >= BUZZ_ACTION_TICKS)
        {
            Buzzer_TickCounter = 0;

            /*
             * Stop sound completely.
             */
            Timer2_SetTone(0);

            Buzzer_CurrentMode = BUZZ_OFF;
        }

        return;
    }


    /*
     * Slow / Fast periodic beep.
     */
    period = (Buzzer_CurrentMode == BUZZ_SLOW)
             ? BUZZ_SLOW_PERIOD_TICKS
             : BUZZ_FAST_PERIOD_TICKS;

    Buzzer_TickCounter++;

    if (Buzzer_TickCounter >= period)
    {
        Buzzer_TickCounter = 0;

        /*
         * Toggle tone.
         */
        static uint8_t soundOn = 0;

        if (soundOn)
        {
            Timer2_SetTone(0);
            soundOn = 0;
        }
        else
        {
            if (Buzzer_CurrentMode == BUZZ_SLOW)
            {
                Timer2_SetTone(BUZZ_TONE_SLOW);
            }
            else
            {
                Timer2_SetTone(BUZZ_TONE_FAST);
            }

            soundOn = 1;
        }
    }
}