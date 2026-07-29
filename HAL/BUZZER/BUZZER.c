#include "Buzzer.h"

/* Adjust to match how often BUZZER_Update() is actually called. */
#define BUZZER_UPDATE_PERIOD_MS   10U

/* Timing patterns, in update ticks */
#define BEEP_ON_TICKS      (200U  / BUZZER_UPDATE_PERIOD_MS)  /* 200 ms on  */
#define BEEP_OFF_TICKS     (800U  / BUZZER_UPDATE_PERIOD_MS)  /* 800 ms off */
#define ALARM_ON_TICKS     (100U  / BUZZER_UPDATE_PERIOD_MS)  /* 100 ms on  */
#define ALARM_OFF_TICKS    (100U  / BUZZER_UPDATE_PERIOD_MS)  /* 100 ms off */

static BuzzerMode_t mode = BUZZ_OFF;
static uint32_t tickCounter = 0;
static uint8_t outputState = 0; /* 0 = silent, 1 = sounding */

/* Hook: drive the actual buzzer pin/PWM. Replace with your platform's
 * GPIO/PWM call -- I don't know your target hardware. */
static void BUZZER_HW_SetOutput(uint8_t on)
{
    (void)on;
    /* TODO: e.g. GPIO_WritePin(BUZZER_PIN, on ? HIGH : LOW); */
}

void BUZZER_Init(void)
{
    mode = BUZZ_OFF;
    tickCounter = 0;
    outputState = 0;
    BUZZER_HW_SetOutput(0);
}

void BUZZER_SetMode(BuzzerMode_t m)
{
    if (m != mode)
    {
        mode = m;
        tickCounter = 0; /* restart pattern cleanly on mode change */
    }
}

void BUZZER_Update(void)
{
    switch (mode)
    {
        case BUZZ_OFF:
            outputState = 0;
            tickCounter = 0;
            break;

        case BUZZ_ON:
            outputState = 1;
            break;

        case BUZZ_BEEP:
            tickCounter++;
            if (outputState)
            {
                if (tickCounter >= BEEP_ON_TICKS)
                {
                    outputState = 0;
                    tickCounter = 0;
                }
            }
            else
            {
                if (tickCounter >= BEEP_OFF_TICKS)
                {
                    outputState = 1;
                    tickCounter = 0;
                }
            }
            break;

        case BUZZ_ALARM:
            tickCounter++;
            if (outputState)
            {
                if (tickCounter >= ALARM_ON_TICKS)
                {
                    outputState = 0;
                    tickCounter = 0;
                }
            }
            else
            {
                if (tickCounter >= ALARM_OFF_TICKS)
                {
                    outputState = 1;
                    tickCounter = 0;
                }
            }
            break;

        default:
            outputState = 0;
            break;
    }

    BUZZER_HW_SetOutput(outputState);
}