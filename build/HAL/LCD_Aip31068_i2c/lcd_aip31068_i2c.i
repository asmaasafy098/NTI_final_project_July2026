# 1 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c"
# 1 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h" 1



# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 1 3
# 44 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 1 3
# 37 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3
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
<<<<<<< HEAD
# 10 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 5 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h" 2
=======
# 10 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 38 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 2 3
# 77 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 45 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 2 3
# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdarg.h" 1 3 4
# 40 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 99 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 46 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 2 3




# 1 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 1 3 4
# 216 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stddef.h" 3 4
typedef unsigned int size_t;
# 51 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 2 3
# 244 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
struct __file {
 char *buf;
 unsigned char unget;
 uint8_t flags;
# 263 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
 int size;
 int len;
 int (*put)(char, struct __file *);
 int (*get)(struct __file *);
 void *udata;
};
# 277 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
typedef struct __file FILE;
# 407 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern struct __file *__iob[];
# 419 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern FILE *fdevopen(int (*__put)(char, FILE*), int (*__get)(FILE*));
# 436 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int fclose(FILE *__stream);
# 610 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int vfprintf(FILE *__stream, const char *__fmt, va_list __ap);





extern int vfprintf_P(FILE *__stream, const char *__fmt, va_list __ap);






extern int fputc(int __c, FILE *__stream);




extern int putc(int __c, FILE *__stream);


extern int putchar(int __c);
# 651 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int printf(const char *__fmt, ...);





extern int printf_P(const char *__fmt, ...);







extern int vprintf(const char *__fmt, va_list __ap);





extern int sprintf(char *__s, const char *__fmt, ...);





extern int sprintf_P(char *__s, const char *__fmt, ...);
# 687 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int snprintf(char *__s, size_t __n, const char *__fmt, ...);





extern int snprintf_P(char *__s, size_t __n, const char *__fmt, ...);





extern int vsprintf(char *__s, const char *__fmt, va_list ap);





extern int vsprintf_P(char *__s, const char *__fmt, va_list ap);
# 715 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int vsnprintf(char *__s, size_t __n, const char *__fmt, va_list ap);





extern int vsnprintf_P(char *__s, size_t __n, const char *__fmt, va_list ap);




extern int fprintf(FILE *__stream, const char *__fmt, ...);





extern int fprintf_P(FILE *__stream, const char *__fmt, ...);






extern int fputs(const char *__str, FILE *__stream);




extern int fputs_P(const char *__str, FILE *__stream);





extern int puts(const char *__str);




extern int puts_P(const char *__str);
# 764 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern size_t fwrite(const void *__ptr, size_t __size, size_t __nmemb,
         FILE *__stream);







extern int fgetc(FILE *__stream);




extern int getc(FILE *__stream);


extern int getchar(void);
# 812 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int ungetc(int __c, FILE *__stream);
# 824 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern char *fgets(char *__str, int __size, FILE *__stream);






extern char *gets(char *__str);
# 842 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern size_t fread(void *__ptr, size_t __size, size_t __nmemb,
        FILE *__stream);




extern void clearerr(FILE *__stream);
# 859 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int feof(FILE *__stream);
# 870 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
extern int ferror(FILE *__stream);






extern int vfscanf(FILE *__stream, const char *__fmt, va_list __ap);




extern int vfscanf_P(FILE *__stream, const char *__fmt, va_list __ap);







extern int fscanf(FILE *__stream, const char *__fmt, ...);




extern int fscanf_P(FILE *__stream, const char *__fmt, ...);






extern int scanf(const char *__fmt, ...);




extern int scanf_P(const char *__fmt, ...);







extern int vscanf(const char *__fmt, va_list __ap);







extern int sscanf(const char *__buf, const char *__fmt, ...);




extern int sscanf_P(const char *__buf, const char *__fmt, ...);
# 940 "c:\\users\\ahmed\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdio.h" 3
static __inline__ int fflush(FILE *stream __attribute__((unused)))
{
 return 0;
}






__extension__ typedef long long fpos_t;
extern int fgetpos(FILE *stream, fpos_t *pos);
extern FILE *fopen(const char *path, const char *mode);
extern FILE *freopen(const char *path, const char *mode, FILE *stream);
extern FILE *fdopen(int, const char *);
extern int fseek(FILE *stream, long offset, int whence);
extern int fsetpos(FILE *stream, fpos_t *pos);
extern long ftell(FILE *stream);
extern int fileno(FILE *);
extern void perror(const char *s);
extern int remove(const char *pathname);
extern int rename(const char *oldpath, const char *newpath);
extern void rewind(FILE *stream);
extern void setbuf(FILE *stream, char *buf);
extern int setvbuf(FILE *stream, char *buf, int mode, size_t size);
extern FILE *tmpfile(void);
extern char *tmpnam (char *s);
# 2 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
# 1 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h" 1




>>>>>>> b33c0fddb1e171c4dfd51a30de389db7935dea8a



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
# 2 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
# 1 "HAL/LCD_Aip31068_i2c/../../Service/string_utils.h" 1
# 9 "HAL/LCD_Aip31068_i2c/../../Service/string_utils.h"
# 1 "HAL/LCD_Aip31068_i2c/../../Service/STD_Types.h" 1
# 10 "HAL/LCD_Aip31068_i2c/../../Service/string_utils.h" 2
# 20 "HAL/LCD_Aip31068_i2c/../../Service/string_utils.h"
uint8_t UTL_IntToStr(int16_t value, char* buffer, uint8_t width);
# 29 "HAL/LCD_Aip31068_i2c/../../Service/string_utils.h"
uint8_t UTL_UIntToStr(uint16_t value, char* buffer, uint8_t width);






void UTL_PadRight(char* buffer, uint8_t length);







uint8_t UTL_IntToStr1Dec(uint16_t value, char* buffer);
# 3 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
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
# 152 "HAL/LCD_Aip31068_i2c/../../Logic/Data/data_types.h"
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
# 4 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2
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
# 5 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 2

extern DriveData_t g_driveData;
static LCD_Aip31068_HandleType g_lcdHandle;




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

Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString)
{
    if ((handle == ((void *)0)) || (pString == ((void *)0))) return ((Std_ReturnType)0x01);

    if (I2C_WriteAddress(handle->i2cAddress, 0) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    if (I2C_WriteData(0x40U) != ((Std_ReturnType)0x00)) { I2C_Stop(); return ((Std_ReturnType)0x01); }

    while (*pString != '\0') {
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
{
    if (LCD_Aip31068_SetCursor(handle, row, column) != ((Std_ReturnType)0x00)) return ((Std_ReturnType)0x01);
    return LCD_Aip31068_WriteString(handle, pString);
}

Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType status = LCD_Aip31068_SendCommand(handle, 0x01U);

    for (volatile uint32_t i = 0; i < 2000; i++);
    return status;
}

Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle)
{
    return LCD_Aip31068_SendCommand(handle, 0x02U);
}

Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) { g_displayControl |= 0x04U; }
    else { g_displayControl &= (uint8_t)~0x04U; }
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
    char line1[17];
    char line2[17];
    char temp[6];
    uint8_t pos;

    if (pData == ((void *)0)) {
        return ((Std_ReturnType)0x01);
    }


    pos = 0;


    line1[pos++] = 'S';
    line1[pos++] = 'E';
    line1[pos++] = 'T';


    UTL_IntToStr(pData->rampedRpm, temp, 4);
    for (uint8_t i = 0; temp[i] != '\0'; i++) {
        line1[pos++] = temp[i];
    }
    line1[pos++] = ' ';


    line1[pos++] = 'A';
    line1[pos++] = 'C';
    line1[pos++] = 'T';


    UTL_IntToStr(pData->measuredRpm, temp, 4);
    for (uint8_t i = 0; temp[i] != '\0'; i++) {
        line1[pos++] = temp[i];
    }


    char dirChar;
    switch (pData->direction) {
        case DIR_FORWARD: dirChar = 'F'; break;
        case DIR_REVERSE: dirChar = 'R'; break;
        default: dirChar = '-'; break;
    }
    line1[pos++] = dirChar;


    while (pos < 16) {
        line1[pos++] = ' ';
    }
    line1[16] = '\0';


    pos = 0;


    UTL_UIntToStr(pData->dutyPct, temp, 2);
    line1[pos++] = temp[0];
    line1[pos++] = temp[1];
    line1[pos++] = '%';
    line1[pos++] = ' ';


    UTL_IntToStr1Dec(pData->currentmA / 100, temp);
    for (uint8_t i = 0; temp[i] != '\0'; i++) {
        line1[pos++] = temp[i];
    }
    line1[pos++] = 'A';
    line1[pos++] = ' ';


    UTL_UIntToStr(pData->busmV / 1000, temp, 2);
    line1[pos++] = temp[0];
    line1[pos++] = temp[1];
    line1[pos++] = 'V';
    line1[pos++] = ' ';


    UTL_UIntToStr(pData->tempC, temp, 2);
    line1[pos++] = temp[0];
    line1[pos++] = temp[1];
    line1[pos++] = 'C';


    while (pos < 16) {
        line1[pos++] = ' ';
    }
    line2[16] = '\0';


    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 0, 0, (const uint8_t *)line1);
    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 1, 0, (const uint8_t *)line2);

    return ((Std_ReturnType)0x00);
}


Std_ReturnType LCD_ShowTrip(Trip_t tripCode)
{
    static uint16_t blinkCounter = 0;
    static uint8_t blinkState = 0;

    blinkCounter++;
    if (blinkCounter >= 15) {
        blinkCounter = 0;
        blinkState = !blinkState;
    }

    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 0, 0, (const uint8_t *)"!! TRIPPED !!   ");

    if (blinkState) {
        char buf[17];
        uint8_t pos = 0;
        buf[pos++] = '!';
        buf[pos++] = 'T';
        buf[pos++] = 'R';
        buf[pos++] = 'I';
        buf[pos++] = 'P';
        buf[pos++] = '=';

        char temp[4];
        UTL_UIntToStr((uint16_t)tripCode, temp, 2);
        for (uint8_t i = 0; temp[i] != '\0'; i++) {
            buf[pos++] = temp[i];
        }

        while (pos < 16) {
            buf[pos++] = ' ';
        }
        buf[16] = '\0';

        LCD_Aip31068_WriteStringAt(&g_lcdHandle, 1, 0, (const uint8_t *)buf);
    } else {
        LCD_Update(&g_driveData);
    }

    return ((Std_ReturnType)0x00);
}
