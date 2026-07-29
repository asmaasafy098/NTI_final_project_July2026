/*
 * lcd_aip31068_i2c.c
 * AiP31068 CHARACTER LCD DRIVER (HAL, native I2C)
 */

#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/I2C/i2c_interface.h"
#include "lcd_aip31068_i2c.h"

/* Delay Helper Macros using Software Loops to avoid <util/delay.h> issues */
#define LCD_AIP31068_EXEC_DELAY_US    50U
#define LCD_AIP31068_LONG_DELAY_MS    2U

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

/* ================================================================================
 *  INTERNAL HELPER FUNCTIONS
 * ============================================================================== */

static Std_ReturnType LCD_SendBytes(LCD_Aip31068_HandleType *handle, uint8_t controlByte, const uint8_t *pData, uint8_t length)
{
    if ((handle == NULL) || (pData == NULL) || (length == 0))
    {
        return E_NOK;
    }

    if (I2C_Start() != E_OK) return E_NOK;
    
    /* Write Slave Address with Write Bit (0) */
    if (I2C_WriteAddress(handle->i2cAddress, 0) != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    /* Send Control Byte */
    if (I2C_WriteData(controlByte) != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    /* Send Payload Bytes */
    for (uint8_t i = 0; i < length; i++)
    {
        if (I2C_WriteData(pData[i]) != E_OK)
        {
            I2C_Stop();
            return E_NOK;
        }
    }

    I2C_Stop();
    return E_OK;
}

/* ================================================================================
 *  PUBLIC API IMPLEMENTATION
 * ============================================================================== */

Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle)
{
    if ((handle == NULL) || (handle->i2cAddress > 0x7F) || (handle->rows == 0) || (handle->cols == 0))
    {
        return E_NOK;
    }

    LCD_DelayMs(50); /* Wait for LCD power-on */

    /* Initialization sequence for AiP31068 / HD44780 */
    uint8_t cmdFunctionSet = LCD_AIP31068_CMD_FUNCTION_SET | 0x08; /* 2 lines, 5x8 font */
    
    if (LCD_Aip31068_SendCommand(handle, cmdFunctionSet) != E_OK) return E_NOK;
    LCD_DelayUs(LCD_AIP31068_EXEC_DELAY_US);

    handle->displayControl = LCD_AIP31068_DISPLAY_ON;
    if (LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_DISPLAY_CTRL | handle->displayControl) != E_OK) return E_NOK;
    LCD_DelayUs(LCD_AIP31068_EXEC_DELAY_US);

    if (LCD_Aip31068_Clear(handle) != E_OK) return E_NOK;

    handle->entryMode = LCD_AIP31068_ENTRY_INCREMENT;
    if (LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_ENTRY_MODE | handle->entryMode) != E_OK) return E_NOK;
    LCD_DelayUs(LCD_AIP31068_EXEC_DELAY_US);

    handle->initialized = 1;
    return E_OK;
}

Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command)
{
    return LCD_SendBytes(handle, LCD_AIP31068_CTRL_COMMAND, &command, 1);
}

Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character)
{
    return LCD_SendBytes(handle, LCD_AIP31068_CTRL_DATA, &character, 1);
}

Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString)
{
    if ((handle == NULL) || (pString == NULL)) return E_NOK;

    uint8_t len = 0;
    while (pString[len] != '\0') len++;

    return LCD_SendBytes(handle, LCD_AIP31068_CTRL_DATA, pString, len);
}

Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle, uint8_t row, uint8_t column, const uint8_t *pString)
{
    if (LCD_Aip31068_SetCursor(handle, row, column) != E_OK) return E_NOK;
    return LCD_Aip31068_WriteString(handle, pString);
}

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

    /* Reverse and output */
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
    if ((handle == NULL) || (row >= handle->rows) || (column >= handle->cols)) return E_NOK;

    static const uint8_t rowOffsets[] = {0x00, 0x40, 0x14, 0x54};
    uint8_t address = column + rowOffsets[row];

    handle->cursorRow = row;
    handle->cursorCol = column;

    return LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_SET_DDRAM_ADDR | address);
}

Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType status = LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_CLEAR);
    LCD_DelayMs(LCD_AIP31068_LONG_DELAY_MS);
    return status;
}

Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType status = LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_HOME);
    LCD_DelayMs(LCD_AIP31068_LONG_DELAY_MS);
    return status;
}

Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) handle->displayControl |= LCD_AIP31068_DISPLAY_ON;
    else handle->displayControl &= ~LCD_AIP31068_DISPLAY_ON;

    return LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_DISPLAY_CTRL | handle->displayControl);
}

Std_ReturnType LCD_Aip31068_CursorOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) handle->displayControl |= LCD_AIP31068_CURSOR_ON;
    else handle->displayControl &= ~LCD_AIP31068_CURSOR_ON;

    return LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_DISPLAY_CTRL | handle->displayControl);
}

Std_ReturnType LCD_Aip31068_BlinkOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) handle->displayControl |= LCD_AIP31068_BLINK_ON;
    else handle->displayControl &= ~LCD_AIP31068_BLINK_ON;

    return LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_DISPLAY_CTRL | handle->displayControl);
}

Std_ReturnType LCD_Aip31068_ShiftDisplay(LCD_Aip31068_HandleType *handle, uint8_t toRight)
{
    uint8_t cmd = LCD_AIP31068_CMD_SHIFT | 0x08 | (toRight ? 0x04 : 0x00);
    return LCD_Aip31068_SendCommand(handle, cmd);
}

Std_ReturnType LCD_Aip31068_CreateCustomChar(LCD_Aip31068_HandleType *handle, uint8_t location, const uint8_t *pPattern)
{
    if ((handle == NULL) || (pPattern == NULL) || (location > 7)) return E_NOK;

    LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_SET_CGRAM_ADDR | (location << 3));
    
    for (uint8_t i = 0; i < 8; i++)
    {
        LCD_Aip31068_WriteChar(handle, pPattern[i]);
    }

    return LCD_Aip31068_SetCursor(handle, 0, 0);
}