# 1 "MCL/I2C/i2c.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCL/I2C/i2c.c"
# 1 "MCL/I2C/../../Service/STD_Types.h" 1



# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 5 "MCL/I2C/../../Service/STD_Types.h" 2



# 7 "MCL/I2C/../../Service/STD_Types.h"
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
# 55 "MCL/I2C/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "MCL/I2C/i2c.c" 2
# 1 "MCL/I2C/../../Service/Bit_Math.h" 1
# 3 "MCL/I2C/i2c.c" 2
# 1 "MCL/I2C/i2c_registers.h" 1
# 4 "MCL/I2C/i2c.c" 2
# 1 "MCL/I2C/i2c_interface.h" 1
# 40 "MCL/I2C/i2c_interface.h"
typedef enum
{
    I2C_NACK = 0,
    I2C_ACK = 1
} I2C_AckType;
# 53 "MCL/I2C/i2c_interface.h"
typedef struct
{
    uint8_t ownAddress;
    uint8_t enableGeneralCall;
} I2C_SlaveConfigType;

typedef struct {
    uint32_t sclFrequency;
} I2C_MasterConfigType;



Std_ReturnType I2C_Init(void);

Std_ReturnType I2C_Start(void);

Std_ReturnType I2C_Stop(void);

Std_ReturnType I2C_WriteByte(uint8_t data);






Std_ReturnType I2C_WriteAddress(uint8_t address, uint8_t rw_bit);






Std_ReturnType I2C_WriteData(uint8_t data);
Std_ReturnType I2C_InitMaster(const I2C_MasterConfigType *config);
# 5 "MCL/I2C/i2c.c" 2


Std_ReturnType I2C_Init(void)
{

    (*(volatile uint8_t *)0x20) = 72;
    (((*(volatile uint8_t *)0x21)) &= ~(1 << (0)));
    (((*(volatile uint8_t *)0x21)) &= ~(1 << (1)));

    (((*(volatile uint8_t *)0x56)) |= (1 << (2)));

    return ((Std_ReturnType)0x00);
}


Std_ReturnType I2C_InitMaster(const I2C_MasterConfigType *config)
{


    (void)config;
    return I2C_Init();
}




Std_ReturnType I2C_Start(void)
{
    uint32_t timeout = 0;

    (*(volatile uint8_t *)0x56) = (1 << 7) | (1 << 5) | (1 << 2);


    while (((((*(volatile uint8_t *)0x56)) >> (7)) & 0x01) == 0)
    {
        timeout++;
        if (timeout > 10000U)
        {
            return ((Std_ReturnType)0x01);
        }
    }

    if (((*(volatile uint8_t *)0x21) & 0xF8) != 0x08)
    {
        return ((Std_ReturnType)0x01);
    }
    return ((Std_ReturnType)0x00);
}


Std_ReturnType I2C_Stop(void)
{
    (*(volatile uint8_t *)0x56) = (1 << 7) | (1 << 4) | (1 << 2);
    return ((Std_ReturnType)0x00);
}


Std_ReturnType I2C_WriteByte(uint8_t data)
{
    uint32_t timeout = 0;

    (*(volatile uint8_t *)0x23) = data;
    (*(volatile uint8_t *)0x56) = (1 << 7) | (1 << 2);

    while (((((*(volatile uint8_t *)0x56)) >> (7)) & 0x01) == 0)
    {
        timeout++;
        if (timeout > 10000U)
        {
            return ((Std_ReturnType)0x01);
        }
    }

    uint8_t status = (*(volatile uint8_t *)0x21) & 0xF8;
    if ((status != 0x18) && (status != 0x28) && (status != 0x40))
    {
        return ((Std_ReturnType)0x01);
    }
    return ((Std_ReturnType)0x00);
}


Std_ReturnType I2C_WriteAddress(uint8_t address, uint8_t rw_bit)
{
    Std_ReturnType local_Status;

    local_Status = I2C_Start();
    if (local_Status != ((Std_ReturnType)0x00))
    {
        return local_Status;
    }


    local_Status = I2C_WriteByte((uint8_t)((address << 1) | (rw_bit & 0x01U)));
    return local_Status;
}


Std_ReturnType I2C_WriteData(uint8_t data)
{
    return I2C_WriteByte(data);
}
