#include "../../Service/STD_Types.h"
#include "../../Logic/Data/data_types.h"
#include "lcd_aip31068_i2c.h"
#include <stdio.h>

static LCD_Aip31068_HandleType g_lcdHandle;
static uint8_t g_displayControl = (LCD_AIP31068_DISPLAY_ON);


/* ================================================================================
 *  LOW-LEVEL DRIVER
 * ============================================================================== */

Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command)
{
    if (handle == NULL) return E_NOK;
    if (I2C_WriteAddress(handle->i2cAddress, 0) != E_OK) return E_NOK;
    if (I2C_WriteData(LCD_AIP31068_CTRL_COMMAND) != E_OK) { I2C_Stop(); return E_NOK; }
    if (I2C_WriteData(command) != E_OK) { I2C_Stop(); return E_NOK; }
    I2C_Stop();
    return E_OK;
}


Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character)
{
    if (handle == NULL) return E_NOK;
    if (I2C_WriteAddress(handle->i2cAddress, 0) != E_OK) return E_NOK;
    if (I2C_WriteData(LCD_AIP31068_CTRL_DATA) != E_OK) { I2C_Stop(); return E_NOK; }
    if (I2C_WriteData(character) != E_OK) { I2C_Stop(); return E_NOK; }
    I2C_Stop();
    return E_OK;
}


Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString)
{
    if ((handle == NULL) || (pString == NULL)) return E_NOK;

    if (I2C_WriteAddress(handle->i2cAddress, 0) != E_OK) return E_NOK;
    if (I2C_WriteData(LCD_AIP31068_CTRL_DATA) != E_OK) { I2C_Stop(); return E_NOK; }

    while (*pString != '\0')
    {
        if (I2C_WriteData(*pString) != E_OK) { I2C_Stop(); return E_NOK; }
        pString++;
    }

    I2C_Stop();
    return E_OK;
}


Std_ReturnType LCD_Aip31068_SetCursor(LCD_Aip31068_HandleType *handle, uint8_t row, uint8_t column)
{
    uint8_t rowOffsets[2] = { 0x00U, 0x40U };
    uint8_t address;

    if (handle == NULL) return E_NOK;
    if ((row >= handle->rows) || (column >= handle->cols)) return E_NOK;

    address = (uint8_t)(rowOffsets[row] + column);
    return LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_SET_DDRAM_ADDR | address));
}


Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle,
                                          uint8_t row, uint8_t column,
                                          const uint8_t *pString)
{
    if (LCD_Aip31068_SetCursor(handle, row, column) != E_OK) return E_NOK;
    return LCD_Aip31068_WriteString(handle, pString);
}


Std_ReturnType LCD_Aip31068_WriteNumber(LCD_Aip31068_HandleType *handle, sint32_t number)
{
    char buf[12];
    sprintf(buf, "%ld", (long)number);
    return LCD_Aip31068_WriteString(handle, (const uint8_t *)buf);
}


Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle)
{
    return LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_CLEAR);
}


Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle)
{
    return LCD_Aip31068_SendCommand(handle, LCD_AIP31068_CMD_HOME);
}


Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) { g_displayControl |= LCD_AIP31068_DISPLAY_ON; }
    else    { g_displayControl &= (uint8_t)~LCD_AIP31068_DISPLAY_ON; }
    return LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_DISPLAY_CTRL | g_displayControl));
}


Std_ReturnType LCD_Aip31068_CursorOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) { g_displayControl |= LCD_AIP31068_CURSOR_ON; }
    else    { g_displayControl &= (uint8_t)~LCD_AIP31068_CURSOR_ON; }
    return LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_DISPLAY_CTRL | g_displayControl));
}


Std_ReturnType LCD_Aip31068_BlinkOnOff(LCD_Aip31068_HandleType *handle, uint8_t on)
{
    if (on) { g_displayControl |= LCD_AIP31068_BLINK_ON; }
    else    { g_displayControl &= (uint8_t)~LCD_AIP31068_BLINK_ON; }
    return LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_DISPLAY_CTRL | g_displayControl));
}


Std_ReturnType LCD_Aip31068_ShiftDisplay(LCD_Aip31068_HandleType *handle, uint8_t toRight)
{
    uint8_t cmd = LCD_AIP31068_CMD_SHIFT | 0x08U;
    if (toRight) { cmd |= 0x04U; }
    return LCD_Aip31068_SendCommand(handle, cmd);
}


Std_ReturnType LCD_Aip31068_CreateCustomChar(LCD_Aip31068_HandleType *handle,
                                             uint8_t location, const uint8_t *pPattern)
{
    uint8_t i;

    if ((handle == NULL) || (pPattern == NULL) || (location > 7U)) return E_NOK;

    if (LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_SET_CGRAM_ADDR | (location << 3))) != E_OK)
        return E_NOK;

    for (i = 0; i < 8U; i++)
    {
        if (LCD_Aip31068_WriteChar(handle, pPattern[i]) != E_OK) return E_NOK;
    }

    return LCD_Aip31068_SetCursor(handle, 0, 0);
}


Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle)
{
    if (handle == NULL) return E_NOK;

    if (LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_FUNCTION_SET | 0x18U)) != E_OK)
        return E_NOK;

    g_displayControl = LCD_AIP31068_DISPLAY_ON;
    if (LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_DISPLAY_CTRL | g_displayControl)) != E_OK)
        return E_NOK;

    if (LCD_Aip31068_Clear(handle) != E_OK) return E_NOK;

    if (LCD_Aip31068_SendCommand(handle, (uint8_t)(LCD_AIP31068_CMD_ENTRY_MODE | LCD_AIP31068_ENTRY_INCREMENT)) != E_OK)
        return E_NOK;

    return E_OK;
}


/* ================================================================================
 *  HIGH-LEVEL APP HELPERS
 * ============================================================================== */

Std_ReturnType LCD_InitDefault(void)
{
    g_lcdHandle.i2cAddress = LCD_AIP31068_DEFAULT_ADDRESS;
    g_lcdHandle.rows = 2;
    g_lcdHandle.cols = 16;
    return LCD_Aip31068_Init(&g_lcdHandle);
}


Std_ReturnType LCD_Update(const DriveData_t *pData)
{
    char dirChar;
    char line1[17];
    char line2[21];   /* fixed: was 17, sprintf needed up to 20 bytes + null */

    if (pData == NULL) return E_NOK;

    switch (pData->direction)
    {
        case DIR_FORWARD: dirChar = 'F'; break;
        case DIR_REVERSE: dirChar = 'R'; break;
        default:           dirChar = '-'; break;
    }

    sprintf(line1, "SET%-4d ACT%-4d%c",
            pData->rampedRpm, pData->measuredRpm, dirChar);

    /* trimmed field widths so the whole line fits in 16 visible columns */
    sprintf(line2, "%2d%% %2d.%dA %2dV %2dC",
            pData->dutyPct,
            pData->currentmA / 1000, (pData->currentmA / 100) % 10,
            pData->busmV / 1000,
            pData->tempC);

    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 0, 0, (const uint8_t *)line1);
    LCD_Aip31068_WriteStringAt(&g_lcdHandle, 1, 0, (const uint8_t *)line2);

    return E_OK;
}


Std_ReturnType LCD_ShowTrip(Trip_t tripCode)
{
    static uint16_t blinkCounter = 0;
    static uint8_t  blinkState = 0;

    blinkCounter++;
    if (blinkCounter >= 6)
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

    return E_OK;
}