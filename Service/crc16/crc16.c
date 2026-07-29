/*
 * crc16.c
 * CRC16 Implementation for Modbus Protocol
 */

#include "crc16.h"

/* ==================== Constants ==================== */
#define CRC16_POLYNOMIAL  0xA001  /* Modbus CRC polynomial */
#define CRC16_INITIAL     0xFFFF

/* ==================== Functions Implementation ==================== */

uint16_t CRC16_Calculate(const uint8_t* data, uint16_t length) {
    uint16_t crc = CRC16_INITIAL;
    
    for (uint16_t i = 0; i < length; i++) {
        crc ^= data[i];
        for (uint8_t j = 0; j < 8; j++) {
            if (crc & 0x0001) {
                crc = (crc >> 1) ^ CRC16_POLYNOMIAL;
            } else {
                crc >>= 1;
            }
        }
    }
    
    return crc;
}

uint16_t CRC16_Update(uint16_t crc, uint8_t data) {
    crc ^= data;
    for (uint8_t j = 0; j < 8; j++) {
        if (crc & 0x0001) {
            crc = (crc >> 1) ^ CRC16_POLYNOMIAL;
        } else {
            crc >>= 1;
        }
    }
    return crc;
}

uint8_t CRC16_Verify(const uint8_t* data, uint16_t length) {
    /* Calculate CRC of all bytes except last 2 (which are CRC) */
    uint16_t calculatedCRC = CRC16_Calculate(data, length - 2);
    
    /* Extract received CRC (little-endian) */
    uint16_t receivedCRC = data[length - 1] << 8 | data[length - 2];
    
    return (calculatedCRC == receivedCRC);
}