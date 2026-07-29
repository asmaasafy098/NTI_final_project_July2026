#ifndef STD_TYPES_H
#define STD_TYPES_H

#include <stdint.h>

/* ==================== Signed Data Types ==================== */
typedef int8_t   sint8_t;
typedef int16_t  sint16_t;
typedef int32_t  sint32_t;
typedef int64_t  sint64_t;

/* ==================== Unsigned Data Types ==================== */
typedef uint8_t  uint8_t;
typedef uint16_t uint16_t;
typedef uint32_t uint32_t;
typedef uint64_t uint64_t;

/* ==================== Floating Point Data Types ==================== */
typedef float    float32_t;
typedef double   float64_t;

/* ==================== Boolean Type ==================== */
typedef enum {
    FALSE = 0,
    TRUE = 1
} bool_t;

/* ==================== Standard Return Types ==================== */
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

/* ==================== Macros ==================== */
#define NULL    ((void *)0)

/* ==================== Interrupt Control ==================== */
#define DISABLE_INTERRUPTS()    asm volatile("cli"::)
#define ENABLE_INTERRUPTS()     asm volatile("sei"::)

/* ==================== Utility Macros ==================== */
#define MAX(a, b)   ((a) > (b) ? (a) : (b))
#define MIN(a, b)   ((a) < (b) ? (a) : (b))
#define ABS(a)      ((a) < 0 ? -(a) : (a))
#define CLAMP(x, lo, hi)    ((x) < (lo) ? (lo) : ((x) > (hi) ? (hi) : (x)))

#endif /* STD_TYPES_H */