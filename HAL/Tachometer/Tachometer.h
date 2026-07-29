#ifndef TACHOMETER_H
#define TACHOMETER_H

#include <stdint.h>
#ifndef RPM_PER_COUNT
#define RPM_PER_COUNT 60
#endif

void TACHO_Init(void);
void TACHO_Update(void);
void TACHO_PulseISR(void); /* call this from the pulse-capture / edge interrupt */
int16_t TACHO_GetRPM(void);

#endif