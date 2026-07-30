# 1 "Logic/Control/ramp_generator/ramp_generator.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Logic/Control/ramp_generator/ramp_generator.c"





# 1 "Logic/Control/ramp_generator/ramp_generator.h" 1
# 9 "Logic/Control/ramp_generator/ramp_generator.h"
# 1 "Service/STD_Types.h" 1



<<<<<<< HEAD
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
<<<<<<< HEAD
# 146 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 146 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
<<<<<<< HEAD
# 163 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 163 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
<<<<<<< HEAD
# 217 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 217 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
<<<<<<< HEAD
# 277 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
=======
# 277 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
<<<<<<< HEAD
# 10 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
=======
# 10 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
# 5 "Service/STD_Types.h" 2



# 7 "Service/STD_Types.h"
typedef int8_t sint8_t;
typedef int16_t sint16_t;
typedef int32_t sint32_t;
typedef int64_t sint64_t;

typedef sint8_t sint8;
typedef sint16_t sint16;
typedef sint32_t sint32;
typedef sint64_t sint64;

typedef int8_t s8;
typedef int16_t s16;
typedef int32_t s32;
typedef int64_t s64;


typedef uint8_t uint8;
typedef uint16_t uint16;
typedef uint32_t uint32;
typedef uint64_t uint64;


typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;


typedef float float32_t;
typedef double float64_t;
typedef float f32;
typedef double f64;


typedef enum {
    FALSE = 0,
    TRUE = 1
} bool_t;
# 55 "Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 10 "Logic/Control/ramp_generator/ramp_generator.h" 2


typedef struct {
    int16_t target;
    int16_t current;
    int16_t output;
    uint16_t accelRate;
    uint16_t decelRate;
    uint16_t minRpm;
    uint16_t maxRpm;
    uint8_t atTarget;
} Ramp_t;







void RAMP_Init(Ramp_t* ramp);






void RAMP_SetTarget(Ramp_t* ramp, int16_t target);







void RAMP_SetLimits(Ramp_t* ramp, int16_t minRpm, int16_t maxRpm);







void RAMP_SetRates(Ramp_t* ramp, uint16_t accel, uint16_t decel);






int16_t RAMP_Step(Ramp_t* ramp);






int16_t RAMP_GetOutput(const Ramp_t* ramp);






uint8_t RAMP_AtTarget(const Ramp_t* ramp);





void RAMP_Reset(Ramp_t* ramp);






uint16_t RAMP_GetTimeToTarget(const Ramp_t* ramp);
# 7 "Logic/Control/ramp_generator/ramp_generator.c" 2
# 1 "Service/util_math.h" 1
# 9 "Service/util_math.h"
# 1 "Service/STD_Types.h" 1
# 10 "Service/util_math.h" 2
# 22 "Service/util_math.h"
static inline int16_t Util_Map(int16_t x, int16_t in_min, int16_t in_max,
                                int16_t out_min, int16_t out_max) {
    return (int16_t)(((int32_t)(x - in_min) * (out_max - out_min)) / (in_max - in_min) + out_min);
}
# 34 "Service/util_math.h"
static inline int16_t Util_Clamp(int16_t value, int16_t min, int16_t max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}
# 47 "Service/util_math.h"
static inline uint8_t Util_IsInRange(int16_t value, int16_t min, int16_t max) {
    return (value >= min && value <= max);
}
# 58 "Service/util_math.h"
static inline int16_t Util_Deadband(int16_t value, int16_t lastValue, int16_t threshold) {
    int16_t diff = value - lastValue;
    if (((diff) < 0 ? -(diff) : (diff)) < threshold) {
        return lastValue;
    }
    return value;
}
# 8 "Logic/Control/ramp_generator/ramp_generator.c" 2



void RAMP_Init(Ramp_t* ramp) {
    ramp->target = 0;
    ramp->current = 0;
    ramp->output = 0;
    ramp->accelRate = 600;
    ramp->decelRate = 900;
    ramp->minRpm = 200;
    ramp->maxRpm = 3000;
    ramp->atTarget = 1;
}

void RAMP_SetTarget(Ramp_t* ramp, int16_t target) {
    ramp->target = Util_Clamp(target, ramp->minRpm, ramp->maxRpm);
    ramp->atTarget = 0;
}

void RAMP_SetLimits(Ramp_t* ramp, int16_t minRpm, int16_t maxRpm) {
    ramp->minRpm = minRpm;
    ramp->maxRpm = maxRpm;
}

void RAMP_SetRates(Ramp_t* ramp, uint16_t accel, uint16_t decel) {
    ramp->accelRate = accel;
    ramp->decelRate = decel;
}

int16_t RAMP_Step(Ramp_t* ramp) {
    int16_t diff = ramp->target - ramp->current;
    int16_t step;


    if (diff > 0) {
        step = (ramp->accelRate * 100) / 1000;
        if (diff < step) step = diff;
        ramp->current += step;
    } else if (diff < 0) {
        step = (ramp->decelRate * 100) / 1000;
        if (-diff < step) step = -diff;
        ramp->current -= step;
    }


    ramp->current = Util_Clamp(ramp->current, ramp->minRpm, ramp->maxRpm);
    ramp->output = ramp->current;


    if (ramp->current == ramp->target) {
        ramp->atTarget = 1;
    }

    return ramp->output;
}

int16_t RAMP_GetOutput(const Ramp_t* ramp) {
    return ramp->output;
}

uint8_t RAMP_AtTarget(const Ramp_t* ramp) {
    return ramp->atTarget;
}

void RAMP_Reset(Ramp_t* ramp) {
    ramp->current = 0;
    ramp->output = 0;
    ramp->atTarget = 0;
}

uint16_t RAMP_GetTimeToTarget(const Ramp_t* ramp) {
    int16_t diff = ramp->target - ramp->current;
    uint16_t rate;

    if (diff > 0) {
        rate = ramp->accelRate;
    } else if (diff < 0) {
        rate = ramp->decelRate;
        diff = -diff;
    } else {
        return 0;
    }

    if (rate == 0) return 0;
    return (diff * 1000) / rate;
}
