#ifndef BUZZER_H
#define BUZZER_H

#include <stdint.h>
#include "../../Service/STD_Types.h"

/* --------------------------------------------------------------------------
 * ENUM DEFINITIONS (Must be defined first)
 * -------------------------------------------------------------------------- */
typedef enum 
{
    BUZZ_OFF = 0,
    BUZZ_SLOW,
    BUZZ_FAST,
    BUZZ_CONTINUOUS
} Buzzer_Mode_t;

/* --------------------------------------------------------------------------
 * MACRO DEFINITIONS
 * -------------------------------------------------------------------------- */
#define BUZZ_TONE_SLOW          150  /* OCR2 value -> low tone  */
#define BUZZ_TONE_FAST          60   /* OCR2 value -> high tone */
#define BUZZ_SLOW_PERIOD_TICKS  50   /* toggles every 500ms @10ms tick */
#define BUZZ_FAST_PERIOD_TICKS  10   /* toggles every 100ms @10ms tick */

/* --------------------------------------------------------------------------
 * EXTERNAL VARIABLES (Defined in Buzzer.c)
 * -------------------------------------------------------------------------- */
extern Buzzer_Mode_t Buzzer_CurrentMode;
extern uint16_t      Buzzer_TickCounter;

/* --------------------------------------------------------------------------
 * FUNCTION PROTOTYPES
 * -------------------------------------------------------------------------- */
Std_ReturnType BUZZER_Init(void);
Std_ReturnType BUZZER_SetMode(Buzzer_Mode_t mode);
void           BUZZER_Update(void);

#endif /* BUZZER_H */