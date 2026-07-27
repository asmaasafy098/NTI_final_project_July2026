#ifndef STD_TYPES_H
#define STD_TYPES_H

#include <stdint.h>

/* Signed Data Types */
typedef int8_t   sint8_t;
typedef int16_t  sint16_t;
typedef int32_t  sint32_t;
typedef int64_t  sint64_t;

/* Floating Point Data Types */
typedef float    float32_t;
typedef double   float64_t;

/* Standard Return Types */
typedef enum
{
    E_OK = 0,
    E_NOK
} Std_ReturnType;

#define NULL    ((void *)0)

#endif /* STD_TYPES_H */