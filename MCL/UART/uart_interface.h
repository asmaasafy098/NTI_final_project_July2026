#ifndef UART_INTERFACE_H
#define UART_INTERFACE_H

#include "../../Service/STD_Types.h"
#include "uart_registers.h"

/* ================================================================================
 *  UART (USART) DRIVER - PUBLIC INTERFACE (ATmega32)
 *  ------------------------------------------------------------------------------
 *  Asynchronous serial driver. The caller describes the frame format and baud
 *  rate through a configuration structure, then uses blocking send/receive
 *  helpers for bytes and strings, or registers an RX callback for interrupt-
 *  driven reception.
 * ============================================================================== */

/**
 * @brief CPU clock in Hz. Used together with the requested baud rate to compute
 *        the UBRR value. Adjust to match the actual F_CPU of the target board.
 */
#ifndef UART_F_CPU
  #ifdef F_CPU
    #define UART_F_CPU        F_CPU          /* follow the build's -DF_CPU */
  #else
    #define UART_F_CPU        8000000UL
  #endif
#endif

/* ---------------- Common Baud Rates ---------------- */
#define UART_BAUD_2400        2400UL
#define UART_BAUD_4800        4800UL
#define UART_BAUD_9600        9600UL
#define UART_BAUD_19200       19200UL
#define UART_BAUD_38400       38400UL
#define UART_BAUD_57600       57600UL
#define UART_BAUD_115200      115200UL

/* ---------------------------------------------------------------------------
 *  Ring buffer sizes. Must be a power of two so the index wrap is a cheap
 *  mask instead of a modulo (keeps ISR bodies short, per NFR-10 in spirit).
 *  Exposed here (instead of buried in the .c file) so a caller can override
 *  them with a -D build flag or a #define before including this header.
 * ------------------------------------------------------------------------- */
#ifndef UART_TX_BUF_SIZE
  #define UART_TX_BUF_SIZE   64U
#endif
#ifndef UART_RX_BUF_SIZE
  #define UART_RX_BUF_SIZE   64U
#endif

#define UART_TX_BUF_MASK   (UART_TX_BUF_SIZE - 1U)
#define UART_RX_BUF_MASK   (UART_RX_BUF_SIZE - 1U)

#if (UART_TX_BUF_SIZE & UART_TX_BUF_MASK) != 0U
#error "UART_TX_BUF_SIZE must be a power of two"
#endif
#if (UART_RX_BUF_SIZE & UART_RX_BUF_MASK) != 0U
#error "UART_RX_BUF_SIZE must be a power of two"
#endif

/* ---------------- Character (Data) Size ---------------- */
/**
 * @brief Number of data bits per frame. 9-bit mode uses the TXB8/RXB8 bits.
 */
typedef enum
{
    UART_DATA_5BITS = 0,
    UART_DATA_6BITS = 1,
    UART_DATA_7BITS = 2,
    UART_DATA_8BITS = 3,   /* Most common */
    UART_DATA_9BITS = 7
} UART_DataSizeType;

/* ---------------- Parity Mode ---------------- */
/**
 * @brief Parity bit configuration for the frame.
 */
typedef enum
{
    UART_PARITY_NONE = 0,
    UART_PARITY_EVEN = 2,
    UART_PARITY_ODD  = 3
} UART_ParityType;

/* ---------------- Stop Bits ---------------- */
/**
 * @brief Number of stop bits appended to each frame.
 */
typedef enum
{
    UART_STOP_1BIT = 0,
    UART_STOP_2BIT = 1
} UART_StopBitType;

/* ---------------- Configuration Structure ---------------- */
/**
 * @brief Full description of the desired serial link, consumed by UART_Init().
 * @var UART_ConfigType::baudRate  Target baud rate in bits/second (e.g. UART_BAUD_9600).
 * @var UART_ConfigType::dataSize  Data bits per frame (UART_DataSizeType).
 * @var UART_ConfigType::parity    Parity mode (UART_ParityType).
 * @var UART_ConfigType::stopBits  Number of stop bits (UART_StopBitType).
 */
typedef struct
{
    uint32_t          baudRate;
    UART_DataSizeType dataSize;
    UART_ParityType   parity;
    UART_StopBitType  stopBits;
} UART_ConfigType;

/* ---------------- Callback Pointer Type ---------------- */
/**
 * @brief Type of the RX-complete callback. Receives the byte just read from UDR.
 *        Runs in interrupt context - keep it short.
 */
typedef void (*UART_RxCallBackType)(uint8_t receivedByte);

/* ================================================================================
 *  FUNCTION PROTOTYPES
 * ============================================================================== */

/**
 * @brief  Initializes the USART: computes and loads UBRR from baudRate, selects
 *         the frame format (data size / parity / stop bits), and enables the
 *         transmitter and receiver in asynchronous mode.
 * @param  addConfig  Pointer to a populated configuration structure.
 * @return Std_ReturnType  E_OK on success, E_NOK on NULL pointer / invalid field.
 */
Std_ReturnType UART_Init(const UART_ConfigType *addConfig);

/**
 * @brief  Disables the transmitter and receiver.
 * @return Std_ReturnType  E_OK/E_NOK.
 */
Std_ReturnType UART_DeInit(void);

/**
 * @brief  Enqueues a single byte into the TX ring buffer (non-blocking, except
 *         for a short bounded wait if the buffer is momentarily full); the
 *         UDRE interrupt drains it to the hardware.
 * @param  uint8Data  Byte to transmit.
 * @return Std_ReturnType  E_OK when the byte has been handed to the buffer.
 */
Std_ReturnType UART_SendByte(uint8_t uint8Data);

/**
 * @brief  Blocking receive of a single byte from the RX ring buffer: waits
 *         until the ISR has buffered a byte, then returns it through the
 *         pointer.
 * @param  puint8Data  Pointer that receives the read byte; must not be NULL.
 * @return Std_ReturnType  E_OK/E_NOK (E_NOK on NULL pointer).
 */
Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data);

/**
 * @brief  Non-blocking receive: returns immediately with the byte if one is ready.
 * @param  puint8Data  Pointer that receives the byte when available.
 * @return Std_ReturnType  E_OK if a byte was read, E_NOK if none was available
 *                         (or on NULL pointer).
 */
Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data);

/**
 * @brief  Sends a NUL-terminated string byte-by-byte (queued into the TX
 *         ring buffer, not fully blocking).
 * @param  pString  Pointer to a '\0'-terminated C string; must not be NULL.
 * @return Std_ReturnType  E_OK/E_NOK.
 */
Std_ReturnType UART_SendString(const uint8_t *pString);

/**
 * @brief  Receives characters into 'buffer' until the terminator byte is seen or
 *         (maxLength-1) characters have been stored; always NUL-terminates.
 * @param  buffer      Destination buffer; must not be NULL.
 * @param  maxLength   Size of 'buffer' in bytes (including room for the '\0').
 * @param  terminator  Byte that ends reception (e.g. '\n' or '\r').
 * @return Std_ReturnType  E_OK/E_NOK.
 */
Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator);

/**
 * @brief  Registers the callback fired on each RX-complete interrupt and enables
 *         the RXC interrupt. The caller must also enable global interrupts.
 * @param  callBack  Pointer to a void(uint8_t) function; must not be NULL.
 * @return Std_ReturnType  E_OK/E_NOK.
 */
Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack);

/**
 * @brief  Reports whether the TX ring buffer still has unsent bytes.
 * @return Std_ReturnType  E_BUSY if bytes remain queued, E_OK if the TX
 *                          buffer is empty.
 */
Std_ReturnType UART_TxBusy(void);
void USART_TransmitByte(uint8_t byte);
void USART_TransmitString(const char *str);

#endif /* UART_INTERFACE_H */
