/*
 * string_utils.h
 * Utility string functions without sprintf
 */

#ifndef STRING_UTILS_H
#define STRING_UTILS_H

#include "STD_Types.h"

/* ==================== Functions ==================== */

/**
 * @brief Convert integer to string with padding
 * @param value Value to convert
 * @param buffer Output buffer (must be large enough)
 * @param width Minimum width (padded with spaces)
 * @return Length of string
 */
uint8_t UTL_IntToStr(int16_t value, char* buffer, uint8_t width);

/**
 * @brief Convert unsigned integer to string with padding
 * @param value Value to convert
 * @param buffer Output buffer (must be large enough)
 * @param width Minimum width (padded with spaces)
 * @return Length of string
 */
uint8_t UTL_UIntToStr(uint16_t value, char* buffer, uint8_t width);

/**
 * @brief Pad string with spaces to the right
 * @param buffer String to pad
 * @param length Desired length
 */
void UTL_PadRight(char* buffer, uint8_t length);

/**
 * @brief Convert uint16_t to decimal with one decimal place (e.g. 1234 -> "12.3")
 * @param value Value in tenths (e.g., 123 = 12.3)
 * @param buffer Output buffer
 * @return Length of string
 */
uint8_t UTL_IntToStr1Dec(uint16_t value, char* buffer);

#endif /* STRING_UTILS_H */