#ifndef BUZZER_H
#define BUZZER_H
 
#include <stdint.h>
 
typedef enum
{
    BUZZ_OFF,
    BUZZ_ON,
    BUZZ_BEEP,
    BUZZ_ALARM
} BuzzerMode_t;
 
void BUZZER_Init(void);
void BUZZER_SetMode(BuzzerMode_t mode);
 
void BUZZER_Update(void);
 
#endif
 