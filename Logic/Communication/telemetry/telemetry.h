/*
 * telemetry.h
 * Telemetry Frame Transmitter
 */

#ifndef TELEMETRY_H_
#define TELEMETRY_H_

#include "STD_Types.h"
#include "data_types.h"

/* ==================== Functions ==================== */

/**
 * @brief Initialize telemetry
 */
void TELEMETRY_Init(void);

/**
 * @brief Update and send telemetry (called every 1 second)
 * @param data Pointer to drive data
 */
void TELEMETRY_Update(const DriveData_t* data);

/**
 * @brief Send immediate status frame
 * @param data Pointer to drive data
 */
void TELEMETRY_SendStatus(const DriveData_t* data);

/**
 * @brief Send trip event
 * @param trip Trip type
 * @param data Pointer to drive data
 */
void TELEMETRY_SendTripEvent(Trip_t trip, const DriveData_t* data);

/**
 * @brief Set telemetry enabled/disabled
 * @param enable 1 to enable, 0 to disable
 */
void TELEMETRY_SetEnabled(uint8_t enable);

/**
 * @brief Check if telemetry is enabled
 * @return 1 if enabled, 0 otherwise
 */
uint8_t TELEMETRY_IsEnabled(void);
void TELEMETRY_ResetTripEvent(void);
#endif /* TELEMETRY_H_ */