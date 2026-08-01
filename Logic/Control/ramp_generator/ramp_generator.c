/*
 * ramp_generator.c
 * Speed Ramp Generator Implementation
 */

#include "ramp_generator.h"
#include "util_math.h"

/* ==================== Functions Implementation ==================== */

void RAMP_Init(Ramp_t* ramp) {
    ramp->target = 0;
    ramp->current = 0;
    ramp->output = 0;
    ramp->accelRate = 600;
    ramp->decelRate = 900;
    ramp->minRpm = 200;
    ramp->maxRpm = 3000;
    ramp->atTarget = 1;
}

void RAMP_SetTarget(Ramp_t* ramp, int16_t target) {
    /* target == 0 means "stop" (FR-03: below minRpm while running
     * commands a stop, not a crawl). Clamping 0 up to minRpm here
     * made the ramp physically unable to ever reach zero -- it would
     * decelerate down to minRpm and get stuck there. Only clamp to
     * [minRpm, maxRpm] for genuine run setpoints. */
    if (target <= 0) {
        ramp->target = 0;
    } else {
        ramp->target = Util_Clamp(target, ramp->minRpm, ramp->maxRpm);
    }
    ramp->atTarget = 0;
}

void RAMP_SetLimits(Ramp_t* ramp, int16_t minRpm, int16_t maxRpm) {
    ramp->minRpm = minRpm;
    ramp->maxRpm = maxRpm;
}

void RAMP_SetRates(Ramp_t* ramp, uint16_t accel, uint16_t decel) {
    ramp->accelRate = accel;
    ramp->decelRate = decel;
}

int16_t RAMP_Step(Ramp_t* ramp) {
    int16_t diff = ramp->target - ramp->current;
    int16_t step;
    
    /* Calculate step per 100ms */
    if (diff > 0) {
        step = (ramp->accelRate * 100) / 1000;  /* RPM per 100ms */
        if (diff < step) step = diff;
        ramp->current += step;
    } else if (diff < 0) {
        step = (ramp->decelRate * 100) / 1000;  /* RPM per 100ms */
        if (-diff < step) step = -diff;
        ramp->current -= step;
    }
    
    /* Clamp current value: floor is 0, not minRpm -- otherwise the
     * ramp can never fully decelerate to a stop (see RAMP_SetTarget). */
    ramp->current = Util_Clamp(ramp->current, 0, ramp->maxRpm);
    ramp->output = ramp->current;
    
    /* Check if at target */
    if (ramp->current == ramp->target) {
        ramp->atTarget = 1;
    }
    
    return ramp->output;
}

int16_t RAMP_GetOutput(const Ramp_t* ramp) {
    return ramp->output;
}

uint8_t RAMP_AtTarget(const Ramp_t* ramp) {
    return ramp->atTarget;
}

void RAMP_Reset(Ramp_t* ramp) {
    ramp->current = 0;
    ramp->output = 0;
    ramp->atTarget = 0;
}

uint16_t RAMP_GetTimeToTarget(const Ramp_t* ramp) {
    int16_t diff = ramp->target - ramp->current;
    uint16_t rate;
    
    if (diff > 0) {
        rate = ramp->accelRate;
    } else if (diff < 0) {
        rate = ramp->decelRate;
        diff = -diff;
    } else {
        return 0;
    }
    
    if (rate == 0) return 0;
    return (diff * 1000) / rate;  /* Time in milliseconds */
}