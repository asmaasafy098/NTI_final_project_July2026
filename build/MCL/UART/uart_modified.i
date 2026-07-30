# 1 "MCL/UART/uart_modified.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MCL/UART/uart_modified.c"
# 1 "MCL/UART/../../Service/STD_Types.h" 1



# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 5 "MCL/UART/../../Service/STD_Types.h" 2



# 7 "MCL/UART/../../Service/STD_Types.h"
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
# 55 "MCL/UART/../../Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 2 "MCL/UART/uart_modified.c" 2
# 1 "MCL/UART/../../Service/Bit_Math.h" 1
# 3 "MCL/UART/uart_modified.c" 2
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 1 3
# 38 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 1 3
# 99 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 1 3
# 126 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 1 3
# 77 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3

# 77 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\inttypes.h" 3
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 127 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\sfr_defs.h" 2 3
# 100 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 244 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 1 3
# 720 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 3
       
# 721 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\iom32.h" 3

       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
# 245 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 703 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 3
# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\portpins.h" 1 3
# 704 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3

# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\common.h" 1 3
# 706 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3

# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\version.h" 1 3
# 708 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3






# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\fuse.h" 1 3
# 248 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
} __fuse_t;
# 715 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3


# 1 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\lock.h" 1 3
# 718 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\io.h" 2 3
# 39 "c:\\users\\alroad laptop\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\avr\\interrupt.h" 2 3
# 4 "MCL/UART/uart_modified.c" 2
# 1 "MCL/UART/uart_registers.h" 1
# 5 "MCL/UART/uart_modified.c" 2
# 1 "MCL/UART/uart_interface.h" 1
# 64 "MCL/UART/uart_interface.h"

# 64 "MCL/UART/uart_interface.h"
typedef enum
{
    UART_DATA_5BITS = 0,
    UART_DATA_6BITS = 1,
    UART_DATA_7BITS = 2,
    UART_DATA_8BITS = 3,
    UART_DATA_9BITS = 7
} UART_DataSizeType;





typedef enum
{
    UART_PARITY_NONE = 0,
    UART_PARITY_EVEN = 2,
    UART_PARITY_ODD = 3
} UART_ParityType;





typedef enum
{
    UART_STOP_1BIT = 0,
    UART_STOP_2BIT = 1
} UART_StopBitType;
# 102 "MCL/UART/uart_interface.h"
typedef struct
{
    uint32_t baudRate;
    UART_DataSizeType dataSize;
    UART_ParityType parity;
    UART_StopBitType stopBits;
} UART_ConfigType;






typedef void (*UART_RxCallBackType)(uint8_t receivedByte);
# 128 "MCL/UART/uart_interface.h"
Std_ReturnType UART_Init(const UART_ConfigType *addConfig);





Std_ReturnType UART_DeInit(void);
# 143 "MCL/UART/uart_interface.h"
Std_ReturnType UART_SendByte(uint8_t uint8Data);
# 152 "MCL/UART/uart_interface.h"
Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data);







Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data);







Std_ReturnType UART_SendString(const uint8_t *pString);
# 178 "MCL/UART/uart_interface.h"
Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator);







Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack);






Std_ReturnType UART_TxBusy(void);
# 6 "MCL/UART/uart_modified.c" 2
# 15 "MCL/UART/uart_modified.c"
static volatile uint8_t UART_TxBuf[64U];
static volatile uint16_t UART_TxHead = 0U;
static volatile uint16_t UART_TxTail = 0U;

static volatile uint8_t UART_RxBuf[64U];
static volatile uint16_t UART_RxHead = 0U;
static volatile uint16_t UART_RxTail = 0U;






static UART_RxCallBackType UART_RxCallBack = ((void *)0);


Std_ReturnType UART_Init(const UART_ConfigType *addConfig)
{
    uint16_t local_UBRR = 0U;
    uint8_t local_UCSRC = 0U;





    if (addConfig == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }





    if (addConfig->baudRate == 0UL)
    {
        return ((Std_ReturnType)0x01);
    }
    local_UBRR = (uint16_t)((16000000UL / (16UL * addConfig->baudRate)) - 1UL);






    (*(volatile u8 *)0x40) = (uint8_t)((local_UBRR >> 8) & 0x0FU);
    (*(volatile u8 *)0x29) = (uint8_t)local_UBRR;





    ((local_UCSRC) |= (1 << (7)));
    ((local_UCSRC) &= ~(1 << (6)));
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->parity & 0x03U) << 4);
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->stopBits & 0x01U) << 3);
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->dataSize & 0x03U) << 1);

    (*(volatile u8 *)0x40) = local_UCSRC;
# 83 "MCL/UART/uart_modified.c"
    if (addConfig->dataSize == UART_DATA_9BITS)
    {
        (((*(volatile u8 *)0x2A)) |= (1 << (2)));
    }
    else
    {
        (((*(volatile u8 *)0x2A)) &= ~(1 << (2)));
    }

    (((*(volatile u8 *)0x2A)) |= (1 << (3)));
    (((*(volatile u8 *)0x2A)) |= (1 << (4)));
    (((*(volatile u8 *)0x2A)) |= (1 << (7)));


    UART_TxHead = 0U;
    UART_TxTail = 0U;
    UART_RxHead = 0U;
    UART_RxTail = 0U;


    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_DeInit(void)
{

    (((*(volatile u8 *)0x2A)) &= ~(1 << (3)));
    (((*(volatile u8 *)0x2A)) &= ~(1 << (4)));


    (((*(volatile u8 *)0x2A)) &= ~(1 << (7)));
    (((*(volatile u8 *)0x2A)) &= ~(1 << (6)));
    (((*(volatile u8 *)0x2A)) &= ~(1 << (5)));

    UART_RxCallBack = ((void *)0);


    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_SendByte(uint8_t uint8Data)
{
    uint16_t local_NextHead = 0U;




    local_NextHead = (uint16_t)((UART_TxHead + 1U) & (64U - 1U));
# 142 "MCL/UART/uart_modified.c"
    while (local_NextHead == UART_TxTail)
    {

    }


    UART_TxBuf[UART_TxHead] = uint8Data;
    UART_TxHead = local_NextHead;






    (((*(volatile u8 *)0x2A)) |= (1 << (5)));


    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data)
{

    if (puint8Data == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }







    while (UART_RxHead == UART_RxTail)
    {

    }


    *puint8Data = UART_RxBuf[UART_RxTail];
    UART_RxTail = (uint16_t)((UART_RxTail + 1U) & (64U - 1U));


    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data)
{

    if (puint8Data == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }


    if (UART_RxHead == UART_RxTail)
    {
        return ((Std_ReturnType)0x01);
    }


    *puint8Data = UART_RxBuf[UART_RxTail];
    UART_RxTail = (uint16_t)((UART_RxTail + 1U) & (64U - 1U));

    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_SendString(const uint8_t *pString)
{
    uint16_t local_Index = 0U;


    if (pString == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }






    for (local_Index = 0U; pString[local_Index] != '\0'; local_Index++)
    {
        (void)UART_SendByte(pString[local_Index]);
    }


    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator)
{
    uint16_t local_Index = 0U;
    uint8_t local_Received = 0U;


    if ((buffer == ((void *)0)) || (maxLength == 0U))
    {
        return ((Std_ReturnType)0x01);
    }
# 256 "MCL/UART/uart_modified.c"
    while (local_Index < (uint16_t)(maxLength - 1U))
    {
        if (UART_ReceiveByte(&local_Received) != ((Std_ReturnType)0x00))
        {
            return ((Std_ReturnType)0x01);
        }

        if (local_Received == terminator)
        {
            break;
        }

        buffer[local_Index] = local_Received;
        local_Index++;
    }


    buffer[local_Index] = '\0';


    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack)
{

    if (callBack == ((void *)0))
    {
        return ((Std_ReturnType)0x01);
    }







    UART_RxCallBack = callBack;
    (((*(volatile u8 *)0x2A)) |= (1 << (7)));


    return ((Std_ReturnType)0x00);
}


Std_ReturnType UART_TxBusy(void)
{






    return (UART_TxHead != UART_TxTail) ? E_BUSY : ((Std_ReturnType)0x00);
}
# 325 "MCL/UART/uart_modified.c"

# 325 "MCL/UART/uart_modified.c" 3
void __vector_13 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_13 (void)

# 326 "MCL/UART/uart_modified.c"
{
    uint8_t local_Data;
    uint16_t local_NextHead;

    local_Data = (*(volatile u8 *)0x2C);

    local_NextHead = (uint16_t)((UART_RxHead + 1U) & (64U - 1U));
    if (local_NextHead != UART_RxTail)
    {
        UART_RxBuf[UART_RxHead] = local_Data;
        UART_RxHead = local_NextHead;
    }


    if (UART_RxCallBack != ((void *)0))
    {
        UART_RxCallBack(local_Data);
    }
}







# 351 "MCL/UART/uart_modified.c" 3
void __vector_14 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_14 (void)

# 352 "MCL/UART/uart_modified.c"
{
    if (UART_TxHead != UART_TxTail)
    {
        (*(volatile u8 *)0x2C) = UART_TxBuf[UART_TxTail];
        UART_TxTail = (uint16_t)((UART_TxTail + 1U) & (64U - 1U));
    }
    else
    {
        (((*(volatile u8 *)0x2A)) &= ~(1 << (5)));
    }
}
