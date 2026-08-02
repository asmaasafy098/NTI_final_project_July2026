#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include <avr/interrupt.h>
#include "uart_registers.h"
#include "uart_interface.h"

static volatile uint8_t  UART_TxBuf[UART_TX_BUF_SIZE];
static volatile uint16_t UART_TxHead = 0U;
static volatile uint16_t UART_TxTail = 0U;

static volatile uint8_t  UART_RxBuf[UART_RX_BUF_SIZE];
static volatile uint16_t UART_RxHead = 0U;
static volatile uint16_t UART_RxTail = 0U;

static UART_RxCallBackType UART_RxCallBack = NULL;

Std_ReturnType UART_Init(const UART_ConfigType *addConfig)
{
    uint16_t local_UBRR  = 0U;
    uint8_t  local_UCSRC = 0U;

    if (addConfig == NULL) {
        return E_NOK;
    }

    if (addConfig->baudRate == 0UL) {
        return E_NOK;
    }
    local_UBRR = (uint16_t)((UART_F_CPU / (16UL * addConfig->baudRate)) - 1UL);

    UART_UBRRL_REG = (uint8_t)local_UBRR;

    /* UBRRH and UCSRC share the same I/O address (0x40) on the ATmega32.
       SimulIDE's model doesn't correctly disambiguate them via URSEL, so
       writing both corrupts whichever is written first. UBRRH's required
       value here is 0x00 anyway (same as its power-on reset default), so
       we skip writing it entirely and only touch this shared address once
       -- for UCSRC below. */
    uint8_t ubrrh_val = (uint8_t)((local_UBRR >> 8) & 0x0FU);
    if (ubrrh_val != 0U) {
        UART_UBRRH_REG = ubrrh_val;
    }

    SET_BIT(local_UCSRC, UART_URSEL_BIT);
    CLR_BIT(local_UCSRC, UART_UMSEL_BIT);
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->parity   & 0x03U) << UART_UPM0_BIT);
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->stopBits & 0x01U) << UART_USBS_BIT);
    local_UCSRC |= (uint8_t)(((uint8_t)addConfig->dataSize & 0x03U) << UART_UCSZ0_BIT);

    UART_UCSRC_REG = local_UCSRC;

    if (addConfig->dataSize == UART_DATA_9BITS) {
        SET_BIT(UART_UCSRB_REG, UART_UCSZ2_BIT);
    } else {
        CLR_BIT(UART_UCSRB_REG, UART_UCSZ2_BIT);
    }

    SET_BIT(UART_UCSRB_REG, UART_TXEN_BIT);
    SET_BIT(UART_UCSRB_REG, UART_RXEN_BIT);
    SET_BIT(UART_UCSRB_REG, UART_RXCIE_BIT);

    UART_TxHead = 0U;
    UART_TxTail = 0U;
    UART_RxHead = 0U;
    UART_RxTail = 0U;

    return E_OK;
}

Std_ReturnType UART_DeInit(void)
{
    CLR_BIT(UART_UCSRB_REG, UART_TXEN_BIT);
    CLR_BIT(UART_UCSRB_REG, UART_RXEN_BIT);
    CLR_BIT(UART_UCSRB_REG, UART_RXCIE_BIT);
    CLR_BIT(UART_UCSRB_REG, UART_TXCIE_BIT);
    CLR_BIT(UART_UCSRB_REG, UART_UDRIE_BIT);
    UART_RxCallBack = NULL;
    return E_OK;
}

Std_ReturnType UART_SendByte(uint8_t uint8Data)
{
    uint16_t local_NextHead = 0U;
    local_NextHead = (uint16_t)((UART_TxHead + 1U) & UART_TX_BUF_MASK);
    uint32_t local_SpinGuard = 0UL;
    while (local_NextHead == UART_TxTail)
    {
        local_SpinGuard++;
        if (local_SpinGuard > 200000UL)
        {
            return E_NOK;
        }
    }

    UART_TxBuf[UART_TxHead] = uint8Data;
    UART_TxHead = local_NextHead;

    SET_BIT(UART_UCSRB_REG, UART_UDRIE_BIT);

    return E_OK;
}
Std_ReturnType UART_ReceiveByte(uint8_t *puint8Data)
{
    if (puint8Data == NULL) {
        return E_NOK;
    }

    while (UART_RxHead == UART_RxTail) { }

    *puint8Data = UART_RxBuf[UART_RxTail];
    UART_RxTail = (uint16_t)((UART_RxTail + 1U) & UART_RX_BUF_MASK);

    return E_OK;
}

Std_ReturnType UART_ReceiveByteNonBlocking(uint8_t *puint8Data)
{
    if (puint8Data == NULL) {
        return E_NOK;
    }

    if (UART_RxHead == UART_RxTail) {
        return E_NOK;
    }

    *puint8Data = UART_RxBuf[UART_RxTail];
    UART_RxTail = (uint16_t)((UART_RxTail + 1U) & UART_RX_BUF_MASK);

    return E_OK;
}

Std_ReturnType UART_SendString(const char *pString)
{
    uint16_t local_Index = 0U;

    if (pString == NULL) {
        return E_NOK;
    }

    for (local_Index = 0U; pString[local_Index] != '\0'; local_Index++) {
        (void)UART_SendByte((uint8_t)pString[local_Index]);
    }

    return E_OK;
}

Std_ReturnType UART_ReceiveString(uint8_t *buffer, uint16_t maxLength, uint8_t terminator)
{
    uint16_t local_Index    = 0U;
    uint8_t  local_Received = 0U;

    if ((buffer == NULL) || (maxLength == 0U)) {
        return E_NOK;
    }

    while (local_Index < (uint16_t)(maxLength - 1U)) {
        if (UART_ReceiveByte(&local_Received) != E_OK) {
            return E_NOK;
        }

        if (local_Received == terminator) {
            break;
        }

        buffer[local_Index] = local_Received;
        local_Index++;
    }

    buffer[local_Index] = '\0';

    return E_OK;
}

Std_ReturnType UART_SetRxCallBack(UART_RxCallBackType callBack)
{
    if (callBack == NULL) {
        return E_NOK;
    }

    UART_RxCallBack = callBack;
    SET_BIT(UART_UCSRB_REG, UART_RXCIE_BIT);

    return E_OK;
}

Std_ReturnType UART_TxBusy(void)
{
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

ISR(USART_RXC_vect)
{
    uint8_t receivedByte = UART_UDR_REG;
    uint16_t local_NextHead;

    local_NextHead = (uint16_t)((UART_RxHead + 1U) & UART_RX_BUF_MASK);
    
    if (local_NextHead != UART_RxTail) {
        UART_RxBuf[UART_RxHead] = receivedByte;
        UART_RxHead = local_NextHead;
    }

    if (UART_RxCallBack != NULL) {
        UART_RxCallBack(receivedByte);
    }
}

ISR(USART_UDRE_vect)
{
    uint8_t txByte;

    if (UART_TxHead != UART_TxTail) {
        txByte = UART_TxBuf[UART_TxTail];
        UART_TxTail = (uint16_t)((UART_TxTail + 1U) & UART_TX_BUF_MASK);
        UART_UDR_REG = txByte;
    } else {
        CLR_BIT(UART_UCSRB_REG, UART_UDRIE_BIT);
    }
}