#ifndef STRING_UTILS_H
#define STRING_UTILS_H

#include "STD_Types.h"

uint8_t UTL_IntToStr(int16_t value, char* buffer, uint8_t width);
uint8_t UTL_UIntToStr(uint16_t value, char* buffer, uint8_t width);
void UTL_PadRight(char* buffer, uint8_t length);
uint8_t UTL_IntToStr1Dec(uint16_t value, char* buffer);

#endif