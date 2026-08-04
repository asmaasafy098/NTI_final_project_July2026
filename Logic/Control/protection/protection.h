/*
 * protection.h
 * 9-Step Protection Ladder with I2T Overload
 */

#ifndef PROTECTION_H_
#define PROTECTION_H_

#include "STD_Types.h"
#include "data_types.h"

/* Protection Data */
typedef struct {
    Trip_t activeTrip;
    Trip_t latchedTrip;
    uint8_t tripped;
    uint8_t latched;
    uint32_t i2tAccum;
    uint32_t i2tLimit;
    uint8_t tempCounter;
    uint8_t underVoltCounter;
    uint8_t overVoltCounter;
    uint8_t stallCounter;
    uint8_t overspeedCounter;
    uint8_t noFeedbackCounter;
} ProtectionData_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize protection system
 */
void PROTECT_Init(void);

/**
 * @brief Evaluate all protection conditions
 * @param data Pointer to drive data
 * @param cfg Pointer to configuration
 * @return Active trip if any, TRIP_NONE otherwise
 */
Trip_t PROTECT_Evaluate(const DriveData_t* data, const DriveCfg_t* cfg);

/**
 * @brief Update I2T thermal accumulator
 * @param current Current in mA
 * @param rated Rated current in mA
 */
void PROTECT_UpdateI2T(uint16_t current, uint16_t rated);

/**
 * @brief Reset protection system
 */
void PROTECT_Reset(void);

/**
 * @brief Reset specific trip
 * @param trip Trip to reset
 */
void PROTECT_ResetTrip(Trip_t trip);

/**
 * @brief Check if tripped
 * @return 1 if tripped, 0 otherwise
 */
uint8_t PROTECT_IsTripped(void);

/**
 * @brief Get active trip
 * @return Active trip code
 */
Trip_t PROTECT_GetActiveTrip(void);

/**
 * @brief Get latched trip
 * @return Latched trip code
 */
Trip_t PROTECT_GetLatchedTrip(void);

/**
 * @brief Get I2T percentage (for display)
 * @return 0-100 percent
 */
uint8_t PROTECT_GetI2TPercent(void);

/**
 * @brief Get trip string
 * @param trip Trip code
 * @return String description
 */
const char* PROTECT_GetTripString(Trip_t trip);

#endif /* PROTECTION_H_ */