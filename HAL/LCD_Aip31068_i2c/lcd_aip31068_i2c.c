#include "../../Service/STD_Types.h"
#include "../../Logic/Data/data_types.h"
#include "lcd_aip31068_i2c.h" 
static LCD_Aip31068_HandleType g_lcdHandle;   

/* في lcd_aip31068_i2c.c */


/* ================================================================================
 *  LOW-LEVEL DRIVER (talks to the AIP31068 controller directly over I2C)
 *  Protocol: START, address+W, control byte (0x00=command, 0x40=data), payload, STOP
 * ============================================================================== */

#define LCD_CTRL_COMMAND   0x00U
#define LCD_CTRL_DATA      0x40U

static uint8_t g_displayControl = 0x0C;  /* Display ON, cursor OFF, blink OFF */


Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command)
{
    if (handle == NULL) return E_NOK;
    if (I2C_WriteAddress(handle->i2cAddress, 0) != E_OK) return E_NOK;
    if (I2C_WriteData(LCD_CTRL_COMMAND) != E_OK) { I2C_Stop(); return E_NOK; }
    if (I2C_WriteData(command) != E_OK) { I2C_Stop(); return E_NOK; }
    I2C_Stop();
    return E_OK;
}


Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character)
{
    if (handle == NULL) return E_NOK;
    if (I2C_WriteAddress(handle->i2cAddress, 0) != E_OK) return E_NOK;
    if (I2C_WriteData(LCD_CTRL_DATA) != E_OK) { I2C_Stop(); return E_NOK; }
    if (I2C_WriteData(character) != E_OK) { I2C_Stop(); return E_NOK; }
    I2C_Stop();
    return E_OK;
}


Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString)
{
    if ((handle == NULL) || (pString == NULL)) return E_NOK;

    if (I2C_WriteAddress(handle->i2cAddress, 0) != E_OK) return E_NOK;
    if (I2C_WriteData(LCD_CTRL_DATA) != E_OK) { I2C_Stop(); return E_NOK; }

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
    uint8_t rowOffsets[2] = { 0x00U, 0x40U };  /* line 1 / line 2 DDRAM base */
    uint8_t address;

    if (handle == NULL) return E_NOK;
    if ((row >= handle->rows) || (column >= handle->cols)) return E_NOK;

    address = (uint8_t)(rowOffsets[row] + column);
    return LCD_Aip31068_SendCommand(handle, (uint8_t)(0x80U | address));
}


Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle,
                                          uint8_t row, uint8_t column,
                                          const uint8_t *pString)
{
    if (LCD_Aip31068_SetCursor(handle, row, column) != E_OK) return E_NOK;
    return LCD_Aip31068_WriteString(handle, pString);
}


Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType status = LCD_Aip31068_SendCommand(handle, 0x01U);
    /* Clear needs ~2ms to complete on real hardware */
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
    if (handle == NULL) return E_NOK;

    /* Function set: 8-bit interface, 2 lines, 5x8 font */
    if (LCD_Aip31068_SendCommand(handle, 0x38U) != E_OK) return E_NOK;

    /* Display ON, cursor off, blink off */
    g_displayControl = 0x0CU;
    if (LCD_Aip31068_SendCommand(handle, (uint8_t)(0x08U | g_displayControl)) != E_OK) return E_NOK;

    /* Clear display */
    if (LCD_Aip31068_Clear(handle) != E_OK) return E_NOK;

    /* Entry mode: increment cursor, no shift */
    if (LCD_Aip31068_SendCommand(handle, 0x06U) != E_OK) return E_NOK;

    return E_OK;
}
Std_ReturnType LCD_InitDefault(void)
{
    g_lcdHandle.i2cAddress =  0x3E;   
    g_lcdHandle.rows = 2;
    g_lcdHandle.cols = 16;
    return LCD_Aip31068_Init(&g_lcdHandle);
}
Std_ReturnType LCD_Update(const DriveData_t *pData)
{
    char dirChar;
    char line1[17], line2[17];

    if (pData == NULL)
    {
        return E_NOK;
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

    return E_OK;
}


Std_ReturnType LCD_ShowTrip(Trip_t tripCode)
{
    static uint16_t blinkCounter = 0;
    static uint8_t  blinkState = 0;

    blinkCounter++;
    if (blinkCounter >= 15)   /* 15 x 250ms LCD task period ≈ 1.5s toggle */
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