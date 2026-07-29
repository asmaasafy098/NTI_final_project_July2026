/*
 * pi_controller.h
 * PI Controller with Fixed-Point and Anti-Windup
 */

#ifndef PI_CONTROLLER_H_
#define PI_CONTROLLER_H_

#include "STD_Types.h"
#include "data_types.h"

/* PI Controller Handle */
typedef struct {
    int16_t kp;          /* Q8: 1.5 → 384 */
    int16_t ki;          /* Q8: 0.1 → 26 */
    int32_t integral;    /* Q8 accumulator */
    int16_t outMin;      /* PWM_MIN_RUN */
    int16_t outMax;      /* PWM_TOP */
    int16_t lastError;
    int16_t lastOutput;
    uint8_t antiWindupActive;
} PI_Handle_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize PI controller
 * @param pi Pointer to PI handle
 * @param kp Proportional gain (Q8)
 * @param ki Integral gain (Q8)
 */
void PI_Init(PI_Handle_t* pi, int16_t kp, int16_t ki);

/**
 * @brief Set output limits
 * @param pi Pointer to PI handle
 * @param outMin Minimum output
 * @param outMax Maximum output
 */
void PI_InitLimits(PI_Handle_t* pi, int16_t outMin, int16_t outMax);

/**
 * @brief Execute one PI step
 * @param pi Pointer to PI handle
 * @param setpoint Target value
 * @param measured Measured value
 * @return Calculated output (clamped)
 */
int16_t PI_Step(PI_Handle_t* pi, int16_t setpoint, int16_t measured);

/**
 * @brief Reset integral term
 * @param pi Pointer to PI handle
 */
void PI_Reset(PI_Handle_t* pi);

/**
 * @brief Update gains dynamically
 * @param pi Pointer to PI handle
 * @param kp New proportional gain (Q8)
 * @param ki New integral gain (Q8)
 */
void PI_SetGains(PI_Handle_t* pi, int16_t kp, int16_t ki);

/**
 * @brief Get current integral value
 * @param pi Pointer to PI handle
 * @return Integral value (Q8)
 */
int32_t PI_GetIntegral(const PI_Handle_t* pi);

/**
 * @brief Get last error
 * @param pi Pointer to PI handle
 * @return Last error value
 */
int16_t PI_GetError(const PI_Handle_t* pi);

#endif /* PI_CONTROLLER_H_ */