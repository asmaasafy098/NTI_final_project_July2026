/*
 * crc16.h
 * CRC16 Calculation for Modbus Protocol
 */

#ifndef CRC16_H
#define CRC16_H

#include "STD_Types.h"

/* ==================== Functions ==================== */

/**
 * @brief Calculate CRC16 for a block of data
 * @param data Pointer to data buffer
 * @param length Length of data in bytes
 * @return Calculated CRC16 value
 */
uint16_t CRC16_Calculate(const uint8_t* data, uint16_t length);

/**
 * @brief Update CRC16 with new byte (for streaming)
 * @param crc Current CRC value
 * @param data New byte to add
 * @return Updated CRC value
 */
uint16_t CRC16_Update(uint16_t crc, uint8_t data);

/**
 * @brief Verify CRC16 of a block
 * @param data Pointer to data buffer (including CRC at end)
 * @param length Length of data including CRC
 * @return TRUE if CRC matches, FALSE otherwise
 */
uint8_t CRC16_Verify(const uint8_t* data, uint16_t length);

#endif /* CRC16_H */