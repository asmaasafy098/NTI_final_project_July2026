#include "../../Service/STD_Types.h"
#include "../../Service/string_utils.h"
#include "../../Logic/Data/data_types.h"
#include "lcd_aip31068_i2c.h"

extern DriveData_t g_driveData;
static LCD_Aip31068_HandleType g_lcdHandle;

#define LCD_CTRL_COMMAND   0x00U
#define LCD_CTRL_DATA      0x40U

static uint8_t g_displayControl = 0x0C;

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
    
    while (*pString != '\0') {
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
    if (handle == NULL) return E_NOK;
    
    if (LCD_Aip31068_SendCommand(handle, 0x38U) != E_OK) return E_NOK;
    
    g_displayControl = 0x0CU;
    if (LCD_Aip31068_SendCommand(handle, (uint8_t)(0x08U | g_displayControl)) != E_OK) return E_NOK;
    
    if (LCD_Aip31068_Clear(handle) != E_OK) return E_NOK;
    
    if (LCD_Aip31068_SendCommand(handle, 0x06U) != E_OK) return E_NOK;
    
    return E_OK;
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
    
    if (pData == NULL) {
        return E_NOK;
    }
    
    /* LINE 1: "SET1500 ACT1450 F" */
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
    
    /* LINE 2: "75% 8.2A 24V 45C" */
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
    
    return E_OK;
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
    
    return E_OK;
}