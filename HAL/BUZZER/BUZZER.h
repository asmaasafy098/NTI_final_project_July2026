#ifndef BUZZER_H
#define BUZZER_H
#include <stdint.h>
static Buzzer_Mode_t Buzzer_CurrentMode = BUZZ_OFF;
static uint16_t      Buzzer_TickCounter = 0;

#define BUZZ_TONE_SLOW        150   /* OCR2 value -> low tone   */
#define BUZZ_TONE_FAST        60    /* OCR2 value -> high tone  */
#define BUZZ_SLOW_PERIOD_TICKS   50 /* toggles every 500ms @10ms tick */
#define BUZZ_FAST_PERIOD_TICKS   10 /* toggles every 100ms @10ms tick */

typedef enum
{
    BUZZ_OFF,
    BUZZ_ON,
    BUZZ_BEEP,
    BUZZ_ALARM
} BuzzerMode_t;
 
Std_ReturnType BUZZER_Init(void);
Std_ReturnType BUZZER_SetMode(Buzzer_Mode_t mode);
 
void BUZZER_Update(void);
 
#endif
 