#ifndef BUZZER_H
#define BUZZER_H

#include <stdint.h>
#include "../../Service/STD_Types.h"

/* ============================================================
 * Buzzer Modes
 * ============================================================ */
typedef enum
{
    BUZZ_OFF = 0,
    BUZZ_SLOW,
    BUZZ_FAST,
    BUZZ_CONTINUOUS,
    BUZZ_ACTION
} Buzzer_Mode_t;


/* ============================================================
 * Tone Configuration
 * ============================================================ */

#define BUZZ_TONE_SLOW          150U
#define BUZZ_TONE_FAST           60U

/*
 * Scheduler tick = 10 ms
 *
 * ACTION = 100 ms beep
 * 10 ticks x 10 ms = 100 ms
 */
#define BUZZ_ACTION_TICKS        10U

#define BUZZ_SLOW_PERIOD_TICKS   50U
#define BUZZ_FAST_PERIOD_TICKS   10U


/* ============================================================
 * Global Variables
 * ============================================================ */

extern Buzzer_Mode_t Buzzer_CurrentMode;
extern uint16_t      Buzzer_TickCounter;


/* ============================================================
 * Function Prototypes
 * ============================================================ */

Std_ReturnType BUZZER_Init(void);

Std_ReturnType BUZZER_SetMode(Buzzer_Mode_t mode);

void BUZZER_Update(void);

void BUZZER_ActionBeep(void);

#endif /* BUZZER_H */