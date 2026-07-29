/*
 * pi_controller.c
 * PI Controller Implementation with Anti-Windup
 */

#include "pi_controller.h"

/* ==================== Functions Implementation ==================== */

void PI_Init(PI_Handle_t* pi, int16_t kp, int16_t ki) {
    pi->kp = kp;
    pi->ki = ki;
    pi->integral = 0;
    pi->outMin = 0;
    pi->outMax = PWM_TOP;
    pi->lastError = 0;
    pi->lastOutput = 0;
    pi->antiWindupActive = 1;
}

void PI_InitLimits(PI_Handle_t* pi, int16_t outMin, int16_t outMax) {
    pi->outMin = outMin;
    pi->outMax = outMax;
}

int16_t PI_Step(PI_Handle_t* pi, int16_t setpoint, int16_t measured) {
    /* Calculate error */
    int16_t error = (int16_t)(setpoint - measured);
    
    /* Proportional term (P) */
    int32_t p = ((int32_t)pi->kp * error) >> Q;
    
    /* Tentative integral (I) */
    int32_t newIntegral = pi->integral + ((int32_t)pi->ki * error);
    int32_t i = newIntegral >> Q;
    
    /* Calculate output */
    int32_t output = p + i;
    
    /* ===== Anti-Windup Logic ===== */
    if (output > pi->outMax) {
        output = pi->outMax;
        /* Only update integral if error is trying to reduce output */
        if (error < 0 && pi->antiWindupActive) {
            pi->integral = newIntegral;
        }
    } else if (output < pi->outMin) {
        output = pi->outMin;
        /* Only update integral if error is trying to increase output */
        if (error > 0 && pi->antiWindupActive) {
            pi->integral = newIntegral;
        }
    } else {
        /* Within limits - update integral normally */
        pi->integral = newIntegral;
    }
    
    /* Store last values */
    pi->lastError = error;
    pi->lastOutput = (int16_t)output;
    
    return (int16_t)output;
}

void PI_Reset(PI_Handle_t* pi) {
    pi->integral = 0;
    pi->lastError = 0;
    pi->lastOutput = 0;
}

void PI_SetGains(PI_Handle_t* pi, int16_t kp, int16_t ki) {
    pi->kp = kp;
    pi->ki = ki;
}

int32_t PI_GetIntegral(const PI_Handle_t* pi) {
    return pi->integral;
}

int16_t PI_GetError(const PI_Handle_t* pi) {
    return pi->lastError;
}