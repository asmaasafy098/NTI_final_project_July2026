/*
 * ramp_generator.h
 * Speed Ramp Generator with Accel/Decel
 */

#ifndef RAMP_GENERATOR_H_
#define RAMP_GENERATOR_H_

#include "STD_Types.h"

/* Ramp Generator Handle */
typedef struct {
    int16_t target;       /* Target speed (RPM) */
    int16_t current;      /* Current ramped speed */
    int16_t output;       /* Output value */
    uint16_t accelRate;   /* Acceleration (RPM/s) */
    uint16_t decelRate;   /* Deceleration (RPM/s) */
    uint16_t minRpm;      /* Minimum speed */
    uint16_t maxRpm;      /* Maximum speed */
    uint8_t atTarget;     /* 1 = at target */
} Ramp_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize ramp generator
 * @param ramp Pointer to ramp handle
 */
void RAMP_Init(Ramp_t* ramp);

/**
 * @brief Set target speed
 * @param ramp Pointer to ramp handle
 * @param target Target speed (RPM)
 */
void RAMP_SetTarget(Ramp_t* ramp, int16_t target);

/**
 * @brief Set speed limits
 * @param ramp Pointer to ramp handle
 * @param minRpm Minimum speed (RPM)
 * @param maxRpm Maximum speed (RPM)
 */
void RAMP_SetLimits(Ramp_t* ramp, int16_t minRpm, int16_t maxRpm);

/**
 * @brief Set ramp rates
 * @param ramp Pointer to ramp handle
 * @param accel Acceleration rate (RPM/s)
 * @param decel Deceleration rate (RPM/s)
 */
void RAMP_SetRates(Ramp_t* ramp, uint16_t accel, uint16_t decel);

/**
 * @brief Execute one ramp step (called every 100ms)
 * @param ramp Pointer to ramp handle
 * @return Current ramped value
 */
int16_t RAMP_Step(Ramp_t* ramp);

/**
 * @brief Get current output
 * @param ramp Pointer to ramp handle
 * @return Current ramped value
 */
int16_t RAMP_GetOutput(const Ramp_t* ramp);

/**
 * @brief Check if at target
 * @param ramp Pointer to ramp handle
 * @return 1 if at target, 0 otherwise
 */
uint8_t RAMP_AtTarget(const Ramp_t* ramp);

/**
 * @brief Reset ramp generator
 * @param ramp Pointer to ramp handle
 */
void RAMP_Reset(Ramp_t* ramp);

/**
 * @brief Get time to reach target
 * @param ramp Pointer to ramp handle
 * @return Time in milliseconds
 */
uint16_t RAMP_GetTimeToTarget(const Ramp_t* ramp);

#endif /* RAMP_GENERATOR_H_ */