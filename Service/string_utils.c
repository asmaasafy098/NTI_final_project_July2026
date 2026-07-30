#include "string_utils.h"
#include <string.h>

uint8_t UTL_IntToStr(int16_t value, char* buffer, uint8_t width)
{
    uint8_t isNegative = 0;
    uint8_t len = 0;
    char temp[8];
    uint8_t i;
    
    if (value < 0) {
        isNegative = 1;
        value = -value;
    }
    
    if (value == 0) {
        temp[len++] = '0';
    } else {
        while (value > 0 && len < 7) {
            temp[len++] = '0' + (value % 10);
            value /= 10;
        }
    }
    
    if (isNegative) {
        temp[len++] = '-';
    }
    
    for (i = 0; i < len; i++) {
        buffer[i] = temp[len - 1 - i];
    }
    
    while (i < width) {
        buffer[i++] = ' ';
    }
    
    buffer[i] = '\0';
    return i;
}

uint8_t UTL_UIntToStr(uint16_t value, char* buffer, uint8_t width)
{
    uint8_t len = 0;
    char temp[8];
    uint8_t i;
    
    if (value == 0) {
        temp[len++] = '0';
    } else {
        while (value > 0 && len < 7) {
            temp[len++] = '0' + (value % 10);
            value /= 10;
        }
    }
    
    for (i = 0; i < len; i++) {
        buffer[i] = temp[len - 1 - i];
    }
    
    while (i < width) {
        buffer[i++] = ' ';
    }
    
    buffer[i] = '\0';
    return i;
}

void UTL_PadRight(char* buffer, uint8_t length)
{
    uint8_t len = strlen(buffer);
    while (len < length) {
        buffer[len++] = ' ';
    }
    buffer[len] = '\0';
}

uint8_t UTL_IntToStr1Dec(uint16_t value, char* buffer)
{
    uint8_t len = 0;
    char temp[8];
    uint8_t i;
    uint16_t whole = value / 10;
    uint8_t frac = value % 10;
    
    if (whole == 0) {
        temp[len++] = '0';
    } else {
        while (whole > 0 && len < 6) {
            temp[len++] = '0' + (whole % 10);
            whole /= 10;
        }
    }
    
    temp[len++] = '.';
    temp[len++] = '0' + frac;
    
    for (i = 0; i < len; i++) {
        buffer[i] = temp[len - 1 - i];
    }
    buffer[i] = '\0';
    
    return i;
}