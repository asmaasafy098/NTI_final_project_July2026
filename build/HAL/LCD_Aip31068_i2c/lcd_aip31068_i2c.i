# 1 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c"
<<<<<<< HEAD
=======





>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
# 1 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h" 1



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
# 5 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h" 2



# 7 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h"
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
# 55 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
<<<<<<< HEAD
# 2 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
=======
# 7 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
# 1 "HAL/LCD_Aip31068_i2c/../../Service/Bit_Math.h" 1
# 8 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
# 1 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h" 1



# 1 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/../../Service/STD_Types.h" 1
# 5 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h" 2
# 1 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_registers.h" 1
# 6 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h" 2
# 40 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h"
typedef enum
{
    I2C_NACK = 0,
    I2C_ACK = 1
} I2C_AckType;






typedef struct
{
    uint32_t sclFrequency;
} I2C_MasterConfigType;







typedef struct
{
    uint8_t ownAddress;
    uint8_t enableGeneralCall;
} I2C_SlaveConfigType;




Std_ReturnType I2C_Init(void);

Std_ReturnType I2C_Start(void);

Std_ReturnType I2C_Stop(void);

Std_ReturnType I2C_WriteByte(uint8_t data);
# 9 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
# 1 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h" 1





>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
# 1 "HAL/LCD_Aip31068_i2c/../../Logic/Data/data_types.h" 1
# 9 "HAL/LCD_Aip31068_i2c/../../Logic/Data/data_types.h"
# 1 "Service/STD_Types.h" 1
# 10 "HAL/LCD_Aip31068_i2c/../../Logic/Data/data_types.h" 2




typedef enum {
    DS_INIT = 0,
    DS_STOPPED,
    DS_STARTING,
    DS_RUNNING,
    DS_RAMP_DOWN,
    DS_DEAD_TIME,
    DS_BRAKING,
    DS_COASTING,
    DS_TRIPPED,
    DS_ESTOP
} DriveState_t;


typedef enum {
    DIR_STOP = 0,
    DIR_FORWARD = 1,
    DIR_REVERSE = 2
} MotorDir_t;

<<<<<<< HEAD
=======

>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef enum {
    TRIP_NONE = 0,
    TRIP_ESTOP = 1,
    TRIP_SHORT = 2,
    TRIP_OVERLOAD = 3,
    TRIP_OVERTEMP = 4,
    TRIP_UNDERVOLT = 5,
    TRIP_OVERVOLT = 6,
    TRIP_STALL = 7,
    TRIP_OVERSPEED = 8,
    TRIP_NOFEEDBACK = 9
} Trip_t;


typedef enum {
    EVENT_NONE = 0,
    EVENT_START_PRESSED,
    EVENT_START_RELEASED,
    EVENT_STOP_PRESSED,
    EVENT_REVERSE_PRESSED,
    EVENT_RESET_PRESSED,
    EVENT_RESET_HELD
} PanelEvent_t;


typedef enum {
    FSM_EVENT_NONE = 0,
    FSM_EVENT_START,
    FSM_EVENT_STOP,
    FSM_EVENT_REVERSE,
    FSM_EVENT_RESET,
    FSM_EVENT_ESTOP,
    FSM_EVENT_TRIP,
    FSM_EVENT_AT_SPEED,
    FSM_EVENT_SPEED_ZERO,
    FSM_EVENT_DEAD_TIME_DONE,
    FSM_EVENT_ACKNOWLEDGE
} FSM_Event_t;




typedef struct {
    int16_t setpointRpm;
    int16_t rampedRpm;
    int16_t measuredRpm;
    int16_t errorRpm;
    uint16_t dutyCounts;
    uint8_t dutyPct;
    uint16_t currentmA;
    uint16_t busmV;
    uint8_t tempC;
    uint32_t i2tAccum;
    MotorDir_t direction;
    DriveState_t state;
    Trip_t activeTrip;
    uint8_t remote : 1;
    uint8_t estopRaw : 1;
    uint8_t atSetpoint : 1;
    uint8_t reserved : 5;
    uint32_t runSeconds;
    uint32_t totalRunSec;
    uint16_t startCount;
    uint32_t upTimeSec;
} DriveData_t;


typedef struct {
    uint16_t magic;
    uint8_t version;
    uint16_t maxRpm;
    uint16_t minRpm;
    uint16_t accelRpmPerSec;
    uint16_t decelRpmPerSec;
    uint16_t deadTimeMs;
    int16_t kp;
    int16_t ki;
    uint16_t ratedCurrentmA;
    uint16_t shortTripmA;
    uint8_t overTempC;
    uint16_t underVoltmV;
    uint16_t overVoltmV;
    uint16_t stallSec;
    uint32_t totalRunSec;
    uint16_t startCount;
    uint8_t tripHead;
    Trip_t latchedTrip;
    uint8_t checksum;
} DriveCfg_t;


typedef struct {
    Trip_t trip;
    uint32_t timeSec;
    int16_t rpm;
    uint16_t currentmA;
    uint16_t busmV;
    uint8_t tempC;
    uint8_t dutyPct;
} TripRec_t;
<<<<<<< HEAD
# 152 "HAL/LCD_Aip31068_i2c/../../Logic/Data/data_types.h"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 3 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
# 1 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h" 1




# 1 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h" 1



# 1 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/../../Service/STD_Types.h" 1
# 5 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h" 2
# 1 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_registers.h" 1
# 6 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h" 2
# 40 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h"
typedef enum
{
    I2C_NACK = 0,
    I2C_ACK = 1
} I2C_AckType;
# 53 "HAL/LCD_Aip31068_i2c/../../MCL/I2C/i2c_interface.h"
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
# 6 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h" 2
# 101 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
=======
# 153 "HAL/LCD_Aip31068_i2c/../../Logic/Data/data_types.h"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 7 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h" 2

void LCD_Update(const DriveData_t *data);
void LCD_ShowTrip(Trip_t trip);
# 105 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
typedef struct
{

    uint8_t i2cAddress;
    uint8_t rows;
    uint8_t cols;


    uint8_t initialized;
    uint8_t displayControl;
    uint8_t entryMode;
    uint8_t cursorRow;
    uint8_t cursorCol;
} LCD_Aip31068_HandleType;
<<<<<<< HEAD





Std_ReturnType LCD_InitDefault(void);
Std_ReturnType LCD_Update(const DriveData_t *pData);
Std_ReturnType LCD_ShowTrip(Trip_t tripCode);




Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle);

Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command);

Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character);

Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString);

Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle,
                                          uint8_t row, uint8_t column,
                                          const uint8_t *pString);

Std_ReturnType LCD_Aip31068_WriteNumber(LCD_Aip31068_HandleType *handle, sint32_t number);

Std_ReturnType LCD_Aip31068_SetCursor(LCD_Aip31068_HandleType *handle,
                                      uint8_t row, uint8_t column);

Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle);

Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle);

Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);

Std_ReturnType LCD_Aip31068_CursorOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);

Std_ReturnType LCD_Aip31068_BlinkOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);

Std_ReturnType LCD_Aip31068_ShiftDisplay(LCD_Aip31068_HandleType *handle, uint8_t toRight);

Std_ReturnType LCD_Aip31068_CreateCustomChar(LCD_Aip31068_HandleType *handle,
                                             uint8_t location, const uint8_t *pPattern);
# 4 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
static LCD_Aip31068_HandleType g_lcdHandle;
# 17 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c"
static uint8_t g_displayControl = 0x0C;


Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command)
{
    if (handle == ((void *)0)) return ((Std_ReturnType)0x01);
    if (I2C_WriteAddress(handle->i2cAddress, 0) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    if (I2C_WriteData(0x00U) != ((Std_ReturnType)0x00)) { I2C_Stop(); return ((Std_ReturnType)0x01); }
    if (I2C_WriteData(command) != ((Std_ReturnType)0x00)) { I2C_Stop(); return ((Std_ReturnType)0x01); }
    I2C_Stop();
    return ((Std_ReturnType)0x00);
}


Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character)
{
    if (handle == ((void *)0)) return ((Std_ReturnType)0x01);
    if (I2C_WriteAddress(handle->i2cAddress, 0) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    if (I2C_WriteData(0x40U) != ((Std_ReturnType)0x00)) { I2C_Stop(); return ((Std_ReturnType)0x01); }
    if (I2C_WriteData(character) != ((Std_ReturnType)0x00)) { I2C_Stop(); return ((Std_ReturnType)0x01); }
    I2C_Stop();
    return ((Std_ReturnType)0x00);
}


=======
# 136 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle);
# 145 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command);







Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character);
# 165 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString);
# 175 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle,
                                          uint8_t row, uint8_t column,
                                          const uint8_t *pString);
# 187 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_WriteNumber(LCD_Aip31068_HandleType *handle, sint32 number);
# 197 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_SetCursor(LCD_Aip31068_HandleType *handle,
                                      uint8_t row, uint8_t column);







Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle);






Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle);







Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);







Std_ReturnType LCD_Aip31068_CursorOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);







Std_ReturnType LCD_Aip31068_BlinkOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);
# 246 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_ShiftDisplay(LCD_Aip31068_HandleType *handle, uint8_t toRight);
# 256 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.h"
Std_ReturnType LCD_Aip31068_CreateCustomChar(LCD_Aip31068_HandleType *handle,
                                             uint8_t location, const uint8_t *pPattern);
# 10 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2





static void LCD_DelayUs(uint32_t us)
{
    volatile uint32_t count = us * 4U;
    while(count--) {
        __asm__ volatile ("nop");
    }
}

static void LCD_DelayMs(uint32_t ms)
{
    while(ms--) {
        LCD_DelayUs(1000U);
    }
}





static Std_ReturnType LCD_SendBytes(LCD_Aip31068_HandleType *handle, uint8_t controlByte, const uint8_t *pData, uint8_t length)
{
    if ((handle == ((void *)0)) || (pData == ((void *)0)) || (length == 0))
    {
        return ((Std_ReturnType)0x01);
    }

    if (I2C_Start() != ((Std_ReturnType)0x00))
    return ((Std_ReturnType)0x01);


if (I2C_WriteByte((handle->i2cAddress << 1) | 0) != ((Std_ReturnType)0x00))
{
    I2C_Stop();
    return ((Std_ReturnType)0x01);
}


if (I2C_WriteByte(controlByte) != ((Std_ReturnType)0x00))
{
    I2C_Stop();
    return ((Std_ReturnType)0x01);
}


for (uint8_t i = 0; i < length; i++)
{
    if (I2C_WriteByte(pData[i]) != ((Std_ReturnType)0x00))
    {
        I2C_Stop();
        return ((Std_ReturnType)0x01);
    }
}

I2C_Stop();
return ((Std_ReturnType)0x00);
}





Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle)
{
    if ((handle == ((void *)0)) || (handle->i2cAddress > 0x7F) || (handle->rows == 0) || (handle->cols == 0))
    {
        return ((Std_ReturnType)0x01);
    }

    LCD_DelayMs(50);


    uint8_t cmdFunctionSet = 0x20 | 0x08;

    if (LCD_Aip31068_SendCommand(handle, cmdFunctionSet) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    LCD_DelayUs(50U);

    handle->displayControl = 0x04;
    if (LCD_Aip31068_SendCommand(handle, 0x08 | handle->displayControl) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    LCD_DelayUs(50U);

    if (LCD_Aip31068_Clear(handle) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);

    handle->entryMode = 0x02;
    if (LCD_Aip31068_SendCommand(handle, 0x04 | handle->entryMode) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    LCD_DelayUs(50U);

    handle->initialized = 1;
    return ((Std_ReturnType)0x00);
}

Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command)
{
    return LCD_SendBytes(handle, 0x00, &command, 1);
}

Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character)
{
    return LCD_SendBytes(handle, 0x40, &character, 1);
}

>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString)
{
    if ((handle == ((void *)0)) || (pString == ((void *)0))) return ((Std_ReturnType)0x01);

<<<<<<< HEAD
    if (I2C_WriteAddress(handle->i2cAddress, 0) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    if (I2C_WriteData(0x40U) != ((Std_ReturnType)0x00)) { I2C_Stop(); return ((Std_ReturnType)0x01); }

    while (*pString != '\0')
    {
        if (I2C_WriteData(*pString) != ((Std_ReturnType)0x00)) { I2C_Stop(); return ((Std_ReturnType)0x01); }
        pString++;
    }

    I2C_Stop();
    return ((Std_ReturnType)0x00);
}


Std_ReturnType LCD_Aip31068_SetCursor(LCD_Aip31068_HandleType *handle, uint8_t row, uint8_t column)
{
    uint8_t rowOffsets[2] = { 0x00U, 0x40U };
    uint8_t address;

    if (handle == ((void *)0)) return ((Std_ReturnType)0x01);
    if ((row >= handle->rows) || (column >= handle->cols)) return ((Std_ReturnType)0x01);

    address = (uint8_t)(rowOffsets[row] + column);
    return LCD_Aip31068_SendCommand(handle, (uint8_t)(0x80U | address));
}


Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle,
                                          uint8_t row, uint8_t column,
                                          const uint8_t *pString)
=======
    uint8_t len = 0;
    while (pString[len] != '\0') len++;

    return LCD_SendBytes(handle, 0x40, pString, len);
}

Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle, uint8_t row, uint8_t column, const uint8_t *pString)
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
{
    if (LCD_Aip31068_SetCursor(handle, row, column) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    return LCD_Aip31068_WriteString(handle, pString);
}

<<<<<<< HEAD

Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType status = LCD_Aip31068_SendCommand(handle, 0x01U);

    return status;
}


Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle)
{
    return LCD_Aip31068_SendCommand(handle, 0x02U);
}


Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) { g_displayControl |= 0x04U; } else { g_displayControl &= (uint8_t)~0x04U; }
    return LCD_Aip31068_SendCommand(handle, (uint8_t)(0x08U | g_displayControl));
}


Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle)
{
    if (handle == ((void *)0)) return ((Std_ReturnType)0x01);


    if (LCD_Aip31068_SendCommand(handle, 0x38U) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);


    g_displayControl = 0x0CU;
    if (LCD_Aip31068_SendCommand(handle, (uint8_t)(0x08U | g_displayControl)) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);


    if (LCD_Aip31068_Clear(handle) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);


    if (LCD_Aip31068_SendCommand(handle, 0x06U) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);

    return ((Std_ReturnType)0x00);
}
Std_ReturnType LCD_InitDefault(void)
{
    g_lcdHandle.i2cAddress = 0x3E;
    g_lcdHandle.rows = 2;
    g_lcdHandle.cols = 16;
    return LCD_Aip31068_Init(&g_lcdHandle);
}
Std_ReturnType LCD_Update(const DriveData_t *pData)
{
    char dirChar;
    char line1[17], line2[17];

    if (pData == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }

    switch (pData->direction)
    {
        case DIR_FORWARD: dirChar = 'F'; break;
        case DIR_REVERSE: dirChar = 'R'; break;
        default:dirChar = '-'; break;
    }

    sprintf(line1, "SET%-4d ACT%-4d%c",
            pData->rampedRpm, pData->measuredRpm, dirChar);

    sprintf(line2, "%3d%% %2d.%dA %2dV %3dC",
            pData->dutyPct,
            pData->currentmA / 1000, (pData->currentmA / 100) % 10,
            pData->busmV / 1000,
            pData->tempC);

    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 0, 0, (const uint8_t *)line1);
    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 1, 0, (const uint8_t *)line2);

    return ((Std_ReturnType)0x00);
}


Std_ReturnType LCD_ShowTrip(Trip_t tripCode)
{
    static uint16_t blinkCounter = 0;
    static uint8_t blinkState = 0;

    blinkCounter++;
    if (blinkCounter >= 15)
    {
        blinkCounter = 0;
        blinkState = !blinkState;
    }

    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 0, 0, (const uint8_t *)"!! TRIPPED !!   ");

    if (blinkState)
    {
        char buf[17];
       sprintf(buf, "!TRIP CODE=%d", tripCode);
        LCD_Aip31068_WriteStringAt(&g_lcdHandle, 1, 0, (const uint8_t *)buf);
    }
    else
    {
        LCD_Update(&g_driveData);
    }

    return ((Std_ReturnType)0x00);
=======
Std_ReturnType LCD_Aip31068_WriteNumber(LCD_Aip31068_HandleType *handle, sint32 number)
{
    uint8_t buffer[12];
    uint8_t i = 0;
    uint8_t isNegative = 0;

    if (number == 0)
    {
        return LCD_Aip31068_WriteChar(handle, '0');
    }

    if (number < 0)
    {
        isNegative = 1;
        number = -number;
    }

    while (number > 0)
    {
        buffer[i++] = (number % 10) + '0';
        number /= 10;
    }

    if (isNegative)
    {
        buffer[i++] = '-';
    }


    for (uint8_t j = 0; j < i / 2; j++)
    {
        uint8_t temp = buffer[j];
        buffer[j] = buffer[i - 1 - j];
        buffer[i - 1 - j] = temp;
    }
    buffer[i] = '\0';

    return LCD_Aip31068_WriteString(handle, buffer);
}

Std_ReturnType LCD_Aip31068_SetCursor(LCD_Aip31068_HandleType *handle, uint8_t row, uint8_t column)
{
    if ((handle == ((void *)0)) || (row >= handle->rows) || (column >= handle->cols)) return ((Std_ReturnType)0x01);

    static const uint8_t rowOffsets[] = {0x00, 0x40, 0x14, 0x54};
    uint8_t address = column + rowOffsets[row];

    handle->cursorRow = row;
    handle->cursorCol = column;

    return LCD_Aip31068_SendCommand(handle, 0x80 | address);
}

Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType status = LCD_Aip31068_SendCommand(handle, 0x01);
    LCD_DelayMs(2U);
    return status;
}

Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType status = LCD_Aip31068_SendCommand(handle, 0x02);
    LCD_DelayMs(2U);
    return status;
}

Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) handle->displayControl |= 0x04;
    else handle->displayControl &= ~0x04;

    return LCD_Aip31068_SendCommand(handle, 0x08 | handle->displayControl);
}

Std_ReturnType LCD_Aip31068_CursorOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) handle->displayControl |= 0x02;
    else handle->displayControl &= ~0x02;

    return LCD_Aip31068_SendCommand(handle, 0x08 | handle->displayControl);
}

Std_ReturnType LCD_Aip31068_BlinkOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) handle->displayControl |= 0x01;
    else handle->displayControl &= ~0x01;

    return LCD_Aip31068_SendCommand(handle, 0x08 | handle->displayControl);
}

Std_ReturnType LCD_Aip31068_ShiftDisplay(LCD_Aip31068_HandleType *handle, uint8_t toRight)
{
    uint8_t cmd = 0x10 | 0x08 | (toRight ? 0x04 : 0x00);
    return LCD_Aip31068_SendCommand(handle, cmd);
}

Std_ReturnType LCD_Aip31068_CreateCustomChar(LCD_Aip31068_HandleType *handle, uint8_t location, const uint8_t *pPattern)
{
    if ((handle == ((void *)0)) || (pPattern == ((void *)0)) || (location > 7)) return ((Std_ReturnType)0x01);

    LCD_Aip31068_SendCommand(handle, 0x40 | (location << 3));

    for (uint8_t i = 0; i < 8; i++)
    {
        LCD_Aip31068_WriteChar(handle, pPattern[i]);
    }

    return LCD_Aip31068_SetCursor(handle, 0, 0);
}

static LCD_Aip31068_HandleType lcd =
{
    .i2cAddress = 0x3E,
    .rows = 2,
    .cols = 16
};

void LCD_Update(const DriveData_t *data)
{
    LCD_Aip31068_Clear(&lcd);

    LCD_Aip31068_WriteStringAt(&lcd,0,0,(uint8_t*)"RPM:");
    LCD_Aip31068_WriteNumber(&lcd,data->measuredRpm);

    LCD_Aip31068_WriteStringAt(&lcd,1,0,(uint8_t*)"SET:");
    LCD_Aip31068_WriteNumber(&lcd,data->setpointRpm);
}

void LCD_ShowTrip(Trip_t trip)
{
    LCD_Aip31068_Clear(&lcd);

    LCD_Aip31068_WriteStringAt(&lcd, 0, 0, (const uint8_t *)"FAULT");

    switch (trip)
    {
        case TRIP_ESTOP:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"E-STOP");
            break;

        case TRIP_SHORT:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"SHORT");
            break;

        case TRIP_OVERLOAD:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"OVERLOAD");
            break;

        case TRIP_OVERTEMP:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"OVERTEMP");
            break;

        case TRIP_UNDERVOLT:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"UNDERVOLT");
            break;

        case TRIP_OVERVOLT:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"OVERVOLT");
            break;

        case TRIP_STALL:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"STALL");
            break;

        case TRIP_OVERSPEED:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"OVERSPEED");
            break;

        case TRIP_NOFEEDBACK:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"NO FEEDBACK");
            break;

        default:
            LCD_Aip31068_WriteStringAt(&lcd, 1, 0, (const uint8_t *)"UNKNOWN");
            break;
    }
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
}
