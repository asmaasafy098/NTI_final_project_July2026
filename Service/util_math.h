/*
 * util_math.h
 * Utility Math Functions
 */

#ifndef UTIL_MATH_H
#define UTIL_MATH_H

#include "STD_Types.h"

/* ==================== Math Functions ==================== */

/**
 * @brief Map a value from one range to another
 * @param x Value to map
 * @param in_min Input range minimum
 * @param in_max Input range maximum
 * @param out_min Output range minimum
 * @param out_max Output range maximum
 * @return Mapped value
 */
static inline int16_t Util_Map(int16_t x, int16_t in_min, int16_t in_max, 
                                int16_t out_min, int16_t out_max) {
    return (int16_t)(((int32_t)(x - in_min) * (out_max - out_min)) / (in_max - in_min) + out_min);
}

/**
 * @brief Clamp a value between min and max
 * @param value Value to clamp
 * @param min Minimum allowed value
 * @param max Maximum allowed value
 * @return Clamped value
 */
static inline int16_t Util_Clamp(int16_t value, int16_t min, int16_t max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

/**
 * @brief Check if value is in range
 * @param value Value to check
 * @param min Minimum value
 * @param max Maximum value
 * @return TRUE if in range, FALSE otherwise
 */
static inline uint8_t Util_IsInRange(int16_t value, int16_t min, int16_t max) {
    return (value >= min && value <= max);
}

/**
 * @brief Deadband filter (ignore small changes)
 * @param value Current value
 * @param lastValue Previous value
 * @param threshold Deadband threshold
 * @return Filtered value
 */
static inline int16_t Util_Deadband(int16_t value, int16_t lastValue, int16_t threshold) {
    int16_t diff = value - lastValue;
    if (ABS(diff) < threshold) {
        return lastValue;
    }
    return value;
}

#endif /* UTIL_MATH_H */