#ifndef UART_INTERFACE_H
#define UART_INTERFACE_H

#include "../../Service/STD_Types.h"
#include "uart_registers.h"

#ifndef UART_F_CPU
  #ifdef F_CPU
    #define UART_F_CPU        F_CPU
  #else
    #define UART_F_CPU        8000000UL
  #endif
#endif

#define UART_BAUD_2400        2400UL
#define UART_BAUD_4800        4800UL
#define UART_BAUD_9600        9600UL
#define UART_BAUD_19200       19200UL
#define UART_BAUD_38400       38400UL
#define UART_BAUD_57600       57600UL
#define UART_BAUD_115200      115200UL

#ifndef UART_TX_BUF_SIZE
  #define UART_TX_BUF_SIZE   32U
#endif
#ifndef UART_RX_BUF_SIZE
  #define UART_RX_BUF_SIZE   16U
#endif

#define UART_TX_BUF_MASK   (UART_TX_BUF_SIZE - 1U)
#define UART_RX_BUF_MASK   (UART_RX_BUF_SIZE - 1U)

#if (UART_TX_BUF_SIZE & UART_TX_BUF_MASK) != 0U
#error "UART_TX_BUF_SIZE must be a power of two"
#endif
#if (UART_RX_BUF_SIZE & UART_RX_BUF_MASK) != 0U
#error "UART_RX_BUF_SIZE must be a power of two"
#endif

typedef enum {
    UART_DATA_5BITS = 0,
    UART_DATA_6BITS = 1,
    UART_DATA_7BITS = 2,
    UART_DATA_8BITS = 3,
    UART_DATA_9BITS = 7
} UART_DataSizeType;

typedef enum {
    UART_PARITY_NONE = 0,
    UART_PARITY_EVEN = 2,
    UART_PARITY_ODD  = 3
} UART_ParityType;

typedef enum {
    UART_STOP_1BIT = 0,
    UART_STOP_2BIT = 1
} UART_StopBitType;

typedef struct {
    uint32_t          baudRate;
    UART_DataSizeType dataSize;
    UART_ParityType   parity;
    UART_StopBitType  stopBits;
} UART_ConfigType;

typedef void (*UART_RxCallBackType)(uint8_t receivedByte);

Std_ReturnType UART_Init(const UART_ConfigType *addConfig);
Std_ReturnType UART_DeInit(void);
Std_ReturnType UART_SendByte(uint8_t uint8Data);
Std_ReturnType UART_SendByte_NonBlocking(uint8_t uint8Data);
Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data);
Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data);
Std_ReturnType UART_SendString(const char *pString);
Std_ReturnType UART_SendString_P(const char *pProgmemString);
Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator);
Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack);
Std_ReturnType UART_TxBusy(void);
void USART_TransmitByte(uint8_t byte);
void USART_TransmitString(const char *str);
void USART_TransmitString_P(const char *str);

#endif