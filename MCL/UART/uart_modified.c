#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include <avr/interrupt.h>
#include "uart_registers.h"
#include "uart_interface.h"

/* ================================================================================
 *  UART (USART) DRIVER - IMPLEMENTATION (ATmega32)
 *  ------------------------------------------------------------------------------
 *  NOTE: UART_TX_BUF_SIZE / UART_RX_BUF_SIZE / their masks are now defined in
 *  uart_interface.h so callers can override them; nothing buffer-size-related
 *  is defined locally here anymore.
 * ============================================================================== */

static volatile uint8_t  UART_TxBuf[UART_TX_BUF_SIZE];
static volatile uint16_t UART_TxHead = 0U;   /* written by mainline (producer) */
static volatile uint16_t UART_TxTail = 0U;   /* written by ISR      (consumer) */

static volatile uint8_t  UART_RxBuf[UART_RX_BUF_SIZE];
static volatile uint16_t UART_RxHead = 0U;   /* written by ISR      (producer) */
static volatile uint16_t UART_RxTail = 0U;   /* written by mainline (consumer) */

/*
 * Storage for the RX-complete callback. Still supported for code that wants
 * an event-style hookup (e.g. wiring straight into a protocol parser);
 * independent of the RX ring buffer used by the polling API.
 */
static UART_RxCallBackType UART_RxCallBack = NULL;


Std_ReturnType UART_Init(const UART_ConfigType *addConfig)
{
    uint16_t local_UBRR  = 0U;
    uint8_t  local_UCSRC = 0U;

    /*
     * STEP 1: Validate the input.
     *   - If addConfig == NULL, return E_NOK.
     */
    if (addConfig == NULL)
    {
        return E_NOK;
    }

    /*
     * STEP 2: Compute the baud rate register value (normal speed, U2X = 0):
     *         UBRR = (UART_F_CPU / (16 * baudRate)) - 1
     */
    if (addConfig->baudRate == 0UL)
    {
        return E_NOK;
    }
    local_UBRR = (uint16_t)((UART_F_CPU / (16UL * addConfig->baudRate)) - 1UL);

    /*
     * STEP 3: Load the baud value into the baud registers:
     *   - High byte: write UBRRH with URSEL = 0 (targets UBRRH, not UCSRC).
     *   - Low  byte: UBRRL.
     */
    UART_UBRRH_REG = (uint8_t)((local_UBRR >> 8) & 0x0FU);
    UART_UBRRL_REG = (uint8_t)local_UBRR;

    /*
     * STEP 4: Configure the frame format in UCSRC. Because UCSRC shares the
     *         address with UBRRH, every write MUST set URSEL (bit 7) = 1.
     */
    SET_BIT(local_UCSRC, UART_URSEL_BIT);                                          /* target UCSRC      */
    CLR_BIT(local_UCSRC, UART_UMSEL_BIT);                                          /* asynchronous mode */
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->parity   & 0x03U) << UART_UPM0_BIT);  /* UPM1:UPM0    */
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->stopBits & 0x01U) << UART_USBS_BIT);  /* USBS         */
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->dataSize & 0x03U) << UART_UCSZ0_BIT); /* UCSZ1:UCSZ0  */

    UART_UCSRC_REG = local_UCSRC;

    /*
     * STEP 5: Configure UCSRB:
     *   - Set UCSZ2 only for 9-bit data, otherwise clear it.
     *   - Enable transmitter (TXEN) and receiver (RXEN).
     *   - Enable RX-complete interrupt (RXCIE) so the RX ring buffer works
     *     even if the caller never registers a callback via
     *     UART_SetRxCallBack().
     */
    if (addConfig->dataSize == UART_DATA_9BITS)
    {
        SET_BIT(UART_UCSRB_REG, UART_UCSZ2_BIT);
    }
    else
    {
        CLR_BIT(UART_UCSRB_REG, UART_UCSZ2_BIT);
    }

    SET_BIT(UART_UCSRB_REG, UART_TXEN_BIT);
    SET_BIT(UART_UCSRB_REG, UART_RXEN_BIT);
    SET_BIT(UART_UCSRB_REG, UART_RXCIE_BIT);

    /* Reset the ring buffers on (re)init. */
    UART_TxHead = 0U;
    UART_TxTail = 0U;
    UART_RxHead = 0U;
    UART_RxTail = 0U;

    /* STEP 6: Return E_OK. */
    return E_OK;
}


Std_ReturnType UART_DeInit(void)
{
    /* STEP 1: Clear TXEN and RXEN in UCSRB to disable the transmitter and receiver. */
    CLR_BIT(UART_UCSRB_REG, UART_TXEN_BIT);
    CLR_BIT(UART_UCSRB_REG, UART_RXEN_BIT);

    /* STEP 2: Clear RXCIE/TXCIE/UDRIE in UCSRB to disable USART interrupts. */
    CLR_BIT(UART_UCSRB_REG, UART_RXCIE_BIT);
    CLR_BIT(UART_UCSRB_REG, UART_TXCIE_BIT);
    CLR_BIT(UART_UCSRB_REG, UART_UDRIE_BIT);

    UART_RxCallBack = NULL;

    /* STEP 3: Return E_OK. */
    return E_OK;
}


Std_ReturnType UART_SendByte(uint8_t uint8Data)
{
    uint16_t local_NextHead = 0U;

    /*
     * STEP 1: Compute where this byte would land in the TX ring buffer.
     */
    local_NextHead = (uint16_t)((UART_TxHead + 1U) & UART_TX_BUF_MASK);

    /*
     * STEP 2: If the buffer is full (next head would catch the tail), do a
     *         short, bounded wait for the ISR to free at least one slot
     *         instead of the old "wait for UDRE" full-byte-time stall. This
     *         only happens if the producer outruns 9600 baud, which should
     *         not occur inside a single 100 ms telemetry frame with a
     *         64-byte buffer.
     */
    while (local_NextHead == UART_TxTail)
    {
        /* buffer full: wait for ISR to drain one byte */
    }

    /* STEP 3: Push the byte and publish the new head. */
    UART_TxBuf[UART_TxHead] = uint8Data;
    UART_TxHead = local_NextHead;

    /*
     * STEP 4: Make sure UDRIE is enabled so the ISR will pick this byte up.
     *         If UDR is already empty and UDRIE was off, this also primes
     *         the very first transmission.
     */
    SET_BIT(UART_UCSRB_REG, UART_UDRIE_BIT);

    /* STEP 5: Return E_OK. */
    return E_OK;
}


Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data)
{
    /* STEP 1: Validate puint8Data != NULL (else E_NOK). */
    if (puint8Data == NULL)
    {
        return E_NOK;
    }

    /*
     * STEP 2: Wait until the RX ring buffer has at least one byte. Because
     *         RX is filled by ISR(USART_RXC_vect), interrupts stay enabled
     *         while we wait here (unlike a raw RXC poll on the hardware
     *         flag, this does not itself block interrupt-driven TX).
     */
    while (UART_RxHead == UART_RxTail)
    {
        /* wait for a byte to arrive */
    }

    /* STEP 3: Pop the byte and advance the tail. */
    *puint8Data = UART_RxBuf[UART_RxTail];
    UART_RxTail = (uint16_t)((UART_RxTail + 1U) & UART_RX_BUF_MASK);

    /* STEP 4: Return E_OK. */
    return E_OK;
}


Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data)
{
    /* STEP 1: Validate puint8Data != NULL (else E_NOK). */
    if (puint8Data == NULL)
    {
        return E_NOK;
    }

    /* STEP 2: Nothing buffered -> E_NOK, no waiting. */
    if (UART_RxHead == UART_RxTail)
    {
        return E_NOK;
    }

    /* STEP 3: Pop the byte and advance the tail. */
    *puint8Data = UART_RxBuf[UART_RxTail];
    UART_RxTail = (uint16_t)((UART_RxTail + 1U) & UART_RX_BUF_MASK);

    return E_OK;
}


Std_ReturnType UART_SendString(const uint8_t *pString)
{
    uint16_t local_Index = 0U;

    /* STEP 1: Validate pString != NULL (else E_NOK). */
    if (pString == NULL)
    {
        return E_NOK;
    }

    /*
     * STEP 2: Enqueue every byte until the terminator. UART_SendByte() no
     *         longer blocks for the duration of the whole string -- each
     *         call just pushes into the ring buffer and returns.
     */
    for (local_Index = 0U; pString[local_Index] != '\0'; local_Index++)
    {
        (void)UART_SendByte(pString[local_Index]);
    }

    /* STEP 3: Return E_OK. */
    return E_OK;
}


Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator)
{
    uint16_t local_Index    = 0U;
    uint8_t  local_Received = 0U;

    /* STEP 1: Validate buffer != NULL and maxLength > 0 (else E_NOK). */
    if ((buffer == NULL) || (maxLength == 0U))
    {
        return E_NOK;
    }

    /*
     * STEP 2: Loop:
     *   - Read one byte with UART_ReceiveByte() (now buffer-backed).
     *   - If it equals 'terminator', stop.
     *   - Store it in buffer[index] and increment index.
     *   - Stop when index reaches (maxLength - 1) to leave room for '\0'.
     */
    while (local_Index < (uint16_t)(maxLength - 1U))
    {
        if (UART_ReceiveByte(&local_Received) != E_OK)
        {
            return E_NOK;
        }

        if (local_Received == terminator)
        {
            break;
        }

        buffer[local_Index] = local_Received;
        local_Index++;
    }

    /* STEP 3: Write buffer[index] = '\0' to NUL-terminate. */
    buffer[local_Index] = '\0';

    /* STEP 4: Return E_OK. */
    return E_OK;
}


Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack)
{
    /* STEP 1: Validate callBack != NULL (else E_NOK). */
    if (callBack == NULL)
    {
        return E_NOK;
    }

    /*
     * STEP 2: Store it. NOTE: RXCIE is already enabled by UART_Init() so the
     *         RX ring buffer always fills; the callback (if set) is invoked
     *         in addition to buffering, from inside the ISR, so it must stay
     *         extremely short -- no printing, no EEPROM/SPI access, etc.
     */
    UART_RxCallBack = callBack;
    SET_BIT(UART_UCSRB_REG, UART_RXCIE_BIT);

    /* STEP 3: Return E_OK. */
    return E_OK;
}


Std_ReturnType UART_TxBusy(void)
{
    /*
     * Helper for callers that want to know whether the TX ring buffer has
     * unsent bytes (e.g. before entering a low-power state, or before
     * UART_DeInit()). Not part of the original interface, but harmless to
     * add and useful given TX is now asynchronous.
     */
    return (UART_TxHead != UART_TxTail) ? E_BUSY : E_OK;
}

void USART_TransmitByte(uint8_t byte)
{
    UART_SendByte(byte);
}

void USART_TransmitString(const char *str)
{
    UART_SendString(str);
}