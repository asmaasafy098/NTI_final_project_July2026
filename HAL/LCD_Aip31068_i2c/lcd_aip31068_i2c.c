/*
 * lcd_aip31068_i2c.c
 *
 * 16x2 LCD + I2C
 * Industrial Motor Controller
 */

#include "../../Service/STD_Types.h"
#include "../../Logic/Data/data_types.h"
#include "lcd_aip31068_i2c.h"

#include <stdio.h>
#include <avr/io.h>
#include <util/delay.h>

#include "../../MCL/I2C/i2c_interface.h"


/* =========================================================================
 * GLOBALS
 * ========================================================================= */

static LCD_Aip31068_HandleType g_lcdHandle;

static uint8_t g_displayControl =
    LCD_AIP31068_DISPLAY_ON;


/* =========================================================================
 * LOW LEVEL DRIVER
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_SendCommand(
    LCD_Aip31068_HandleType *handle,
    uint8_t command)
{
    if (handle == NULL)
    {
        return E_NOK;
    }

    if (I2C_WriteAddress(handle->i2cAddress, 0U) != E_OK)
    {
        return E_NOK;
    }

    if (I2C_WriteData(LCD_AIP31068_CTRL_COMMAND) != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    if (I2C_WriteData(command) != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    I2C_Stop();

    _delay_ms(2);

    return E_OK;
}


/* =========================================================================
 * WRITE CHARACTER
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_WriteChar(
    LCD_Aip31068_HandleType *handle,
    uint8_t character)
{
    if (handle == NULL)
    {
        return E_NOK;
    }

    if (I2C_WriteAddress(handle->i2cAddress, 0U) != E_OK)
    {
        return E_NOK;
    }

    if (I2C_WriteData(LCD_AIP31068_CTRL_DATA) != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    if (I2C_WriteData(character) != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    I2C_Stop();

    _delay_us(100);

    return E_OK;
}


/* =========================================================================
 * WRITE STRING
 *
 * One I2C transaction for the complete string.
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_WriteString(
    LCD_Aip31068_HandleType *handle,
    const uint8_t *pString)
{
    if ((handle == NULL) || (pString == NULL))
    {
        return E_NOK;
    }

    if (I2C_WriteAddress(handle->i2cAddress, 0U) != E_OK)
    {
        return E_NOK;
    }

    if (I2C_WriteData(LCD_AIP31068_CTRL_DATA) != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    while (*pString != '\0')
    {
        if (I2C_WriteData(*pString) != E_OK)
        {
            I2C_Stop();
            return E_NOK;
        }

        _delay_us(100);

        pString++;
    }

    I2C_Stop();

    return E_OK;
}


/* =========================================================================
 * SET CURSOR
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_SetCursor(
    LCD_Aip31068_HandleType *handle,
    uint8_t row,
    uint8_t column)
{
    static const uint8_t rowOffsets[2] =
    {
        0x00U,
        0x40U
    };

    uint8_t address;

    if (handle == NULL)
    {
        return E_NOK;
    }

    if (row >= handle->rows)
    {
        return E_NOK;
    }

    if (column >= handle->cols)
    {
        return E_NOK;
    }

    address =
        (uint8_t)(rowOffsets[row] + column);

    return LCD_Aip31068_SendCommand(
        handle,
        (uint8_t)(
            LCD_AIP31068_CMD_SET_DDRAM_ADDR |
            address
        )
    );
}


/* =========================================================================
 * WRITE STRING AT
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_WriteStringAt(
    LCD_Aip31068_HandleType *handle,
    uint8_t row,
    uint8_t column,
    const uint8_t *pString)
{
    uint8_t i;

    if ((handle == NULL) || (pString == NULL))
    {
        return E_NOK;
    }

    if (row >= handle->rows)
    {
        return E_NOK;
    }

    if (column >= handle->cols)
    {
        return E_NOK;
    }

    if (LCD_Aip31068_SetCursor(
            handle,
            row,
            column) != E_OK)
    {
        return E_NOK;
    }

    /*
     * Write the string.
     * Stop at the end of the physical LCD line.
     */
    for (i = column; i < handle->cols; i++)
    {
        uint8_t c;

        if (*pString != '\0')
        {
            c = *pString;
            pString++;
        }
        else
        {
            /*
             * IMPORTANT:
             * Fill the remaining LCD positions with spaces.
             * This removes old characters/symbols.
             */
            c = ' ';
        }

        if (LCD_Aip31068_WriteChar(
                handle,
                c) != E_OK)
        {
            return E_NOK;
        }
    }

    return E_OK;
}

/* =========================================================================
 * WRITE NUMBER
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_WriteNumber(
    LCD_Aip31068_HandleType *handle,
    sint32_t number)
{
    char buffer[12];

    snprintf(
        buffer,
        sizeof(buffer),
        "%ld",
        (long)number
    );

    return LCD_Aip31068_WriteString(
        handle,
        (const uint8_t *)buffer
    );
}


/* =========================================================================
 * CLEAR
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_Clear(
    LCD_Aip31068_HandleType *handle)
{
    Std_ReturnType ret;

    ret = LCD_Aip31068_SendCommand(
        handle,
        LCD_AIP31068_CMD_CLEAR
    );

    _delay_ms(2);

    return ret;
}


/* =========================================================================
 * HOME
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_Home(
    LCD_Aip31068_HandleType *handle)
{
    return LCD_Aip31068_SendCommand(
        handle,
        LCD_AIP31068_CMD_HOME
    );
}


/* =========================================================================
 * DISPLAY ON / OFF
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_DisplayOnOff(
    LCD_Aip31068_HandleType *handle,
    uint8_t on)
{
    if (on)
    {
        g_displayControl |=
            LCD_AIP31068_DISPLAY_ON;
    }
    else
    {
        g_displayControl &= (uint8_t)
            ~LCD_AIP31068_DISPLAY_ON;
    }

    return LCD_Aip31068_SendCommand(
        handle,
        (uint8_t)(
            LCD_AIP31068_CMD_DISPLAY_CTRL |
            g_displayControl
        )
    );
}


/* =========================================================================
 * CURSOR ON / OFF
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_CursorOnOff(
    LCD_Aip31068_HandleType *handle,
    uint8_t on)
{
    if (on)
    {
        g_displayControl |=
            LCD_AIP31068_CURSOR_ON;
    }
    else
    {
        g_displayControl &= (uint8_t)
            ~LCD_AIP31068_CURSOR_ON;
    }

    return LCD_Aip31068_SendCommand(
        handle,
        (uint8_t)(
            LCD_AIP31068_CMD_DISPLAY_CTRL |
            g_displayControl
        )
    );
}


/* =========================================================================
 * BLINK ON / OFF
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_BlinkOnOff(
    LCD_Aip31068_HandleType *handle,
    uint8_t on)
{
    if (on)
    {
        g_displayControl |=
            LCD_AIP31068_BLINK_ON;
    }
    else
    {
        g_displayControl &= (uint8_t)
            ~LCD_AIP31068_BLINK_ON;
    }

    return LCD_Aip31068_SendCommand(
        handle,
        (uint8_t)(
            LCD_AIP31068_CMD_DISPLAY_CTRL |
            g_displayControl
        )
    );
}


/* =========================================================================
 * SHIFT DISPLAY
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_ShiftDisplay(
    LCD_Aip31068_HandleType *handle,
    uint8_t toRight)
{
    uint8_t command =
        (uint8_t)(LCD_AIP31068_CMD_SHIFT | 0x08U);

    if (toRight)
    {
        command |= 0x04U;
    }

    return LCD_Aip31068_SendCommand(
        handle,
        command
    );
}


/* =========================================================================
 * CUSTOM CHARACTER
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_CreateCustomChar(
    LCD_Aip31068_HandleType *handle,
    uint8_t location,
    const uint8_t *pPattern)
{
    uint8_t i;

    if ((handle == NULL) ||
        (pPattern == NULL) ||
        (location > 7U))
    {
        return E_NOK;
    }

    if (LCD_Aip31068_SendCommand(
            handle,
            (uint8_t)(
                LCD_AIP31068_CMD_SET_CGRAM_ADDR |
                (uint8_t)(location << 3)
            )
        ) != E_OK)
    {
        return E_NOK;
    }

    for (i = 0U; i < 8U; i++)
    {
        if (LCD_Aip31068_WriteChar(
                handle,
                pPattern[i]
            ) != E_OK)
        {
            return E_NOK;
        }
    }

    return LCD_Aip31068_SetCursor(
        handle,
        0U,
        0U
    );
}


/* =========================================================================
 * INITIALIZATION
 * ========================================================================= */

Std_ReturnType LCD_Aip31068_Init(
    LCD_Aip31068_HandleType *handle)
{
    if (handle == NULL)
    {
        return E_NOK;
    }

    /*
     * 8-bit mode
     * 2 lines
     * 5x8 font
     */
    if (LCD_Aip31068_SendCommand(
            handle,
            (uint8_t)(
                LCD_AIP31068_CMD_FUNCTION_SET |
                0x18U
            )
        ) != E_OK)
    {
        return E_NOK;
    }

    g_displayControl =
        LCD_AIP31068_DISPLAY_ON;

    if (LCD_Aip31068_SendCommand(
            handle,
            (uint8_t)(
                LCD_AIP31068_CMD_DISPLAY_CTRL |
                g_displayControl
            )
        ) != E_OK)
    {
        return E_NOK;
    }

    if (LCD_Aip31068_Clear(handle) != E_OK)
    {
        return E_NOK;
    }

    if (LCD_Aip31068_SendCommand(
            handle,
            (uint8_t)(
                LCD_AIP31068_CMD_ENTRY_MODE |
                LCD_AIP31068_ENTRY_INCREMENT
            )
        ) != E_OK)
    {
        return E_NOK;
    }

    return E_OK;
}


/* =========================================================================
 * DEFAULT LCD INIT
 * ========================================================================= */

Std_ReturnType LCD_InitDefault(void)
{
    g_lcdHandle.i2cAddress =
        LCD_AIP31068_DEFAULT_ADDRESS;

    g_lcdHandle.rows = 2U;
    g_lcdHandle.cols = 16U;

    return LCD_Aip31068_Init(
        &g_lcdHandle
    );
}


/* =========================================================================
 * WRITE EXACTLY 16 CHARACTERS
 *
 * This function ALWAYS writes exactly 16 characters.
 * Short strings are padded with spaces.
 * Long strings are truncated after 16 characters.
 *
 * IMPORTANT:
 * This function is intentionally void.
 * Do NOT compare its return value with E_OK.
 * ========================================================================= */

static void LCD_WriteLine16(
    uint8_t row,
    const char *text)
{
    uint8_t i;

    if (text == NULL)
    {
        text = "";
    }

    (void)LCD_Aip31068_SetCursor(
        &g_lcdHandle,
        row,
        0U
    );

    for (i = 0U; i < 16U; i++)
    {
        char c;

        c = text[i];

        if (c == '\0')
        {
            c = ' ';
        }

        (void)LCD_Aip31068_WriteChar(
            &g_lcdHandle,
            (uint8_t)c
        );
    }
}


/* =========================================================================
 * NORMAL DATA SCREEN
 *
 * 16x2 LCD
 *
 * Line 1 example:
 * S 800 A 286 F
 *
 * Line 2 example:
 * 62% 6.4A 48V
 *
 * Each line is explicitly padded to 16 characters.
 * ========================================================================= */
Std_ReturnType LCD_Update(const DriveData_t *pData)
{
    char line1[17];
    char line2[17];
    char dirChar;

    if (pData == NULL)
    {
        return E_NOK;
    }

    /* Direction */
    if (pData->direction == DIR_FORWARD)
    {
        dirChar = 'F';
    }
    else if (pData->direction == DIR_REVERSE)
    {
        dirChar = 'R';
    }
    else
    {
        dirChar = '-';
    }

    /*
     * 16x2 LCD
     *
     * Example:
     * S1500 A1500 F
     *
     * 62% 6.4A 48V
     */

    snprintf(
        line1,
        sizeof(line1),
        "S%4d A%4d %c",
        (int)pData->rampedRpm,
        (int)pData->measuredRpm,
        dirChar
    );

    snprintf(
        line2,
        sizeof(line2),
        "%3u%% %1u.%1uA %2uV",
        (unsigned)pData->dutyPct,
        (unsigned)(pData->currentmA / 1000U),
        (unsigned)((pData->currentmA / 100U) % 10U),
        (unsigned)(pData->busmV / 1000U)
    );

    /*
     * Write the COMPLETE 16-character lines.
     * Remaining positions are filled with spaces.
     */
    if (LCD_Aip31068_WriteStringAt(
            &g_lcdHandle,
            0,
            0,
            (const uint8_t *)line1) != E_OK)
    {
        return E_NOK;
    }

    if (LCD_Aip31068_WriteStringAt(
            &g_lcdHandle,
            1,
            0,
            (const uint8_t *)line2) != E_OK)
    {
        return E_NOK;
    }

    return E_OK;
}


/* =========================================================================
 * TRIP NAME
 * ========================================================================= */

static const char *LCD_GetTripName(
    Trip_t trip)
{
    switch (trip)
    {
        case TRIP_ESTOP:
            return "ESTOP";

        case TRIP_SHORT:
            return "SHORT";

        case TRIP_OVERLOAD:
            return "OVERLOAD";

        case TRIP_OVERTEMP:
            return "OVERTEMP";

        case TRIP_UNDERVOLT:
            return "UNDERVOLT";

        case TRIP_OVERVOLT:
            return "OVERVOLT";

        case TRIP_STALL:
            return "STALL";

        case TRIP_OVERSPEED:
            return "OVERSPEED";

        case TRIP_NOFEEDBACK:
            return "NOFEEDBACK";

        case TRIP_NONE:
        default:
            return "NONE";
    }
}


/* =========================================================================
 * TRIP SCREEN
 *
 * Line 1:
 * ! TRIPPED !
 *
 * Line 2:
 * ESTOP / SHORT / etc.
 *
 * Both lines are exactly 16 characters.
 * ========================================================================= */

Std_ReturnType LCD_ShowTrip(
    Trip_t tripCode)
{
    const char *tripName;

    tripName =
        LCD_GetTripName(tripCode);

    /*
     * IMPORTANT:
     * LCD_WriteLine16() returns void.
     * Therefore we DO NOT write:
     *
     * if (LCD_WriteLine16(...) != E_OK)
     *
     * We simply call it.
     */

    LCD_WriteLine16(
        0U,
        "! TRIPPED !"
    );

    LCD_WriteLine16(
        1U,
        tripName
    );

    return E_OK;
}


/* =========================================================================
 * LCD TEST
 * ========================================================================= */

Std_ReturnType LCD_Test(void)
{
    if (LCD_Aip31068_Clear(
            &g_lcdHandle
        ) != E_OK)
    {
        return E_NOK;
    }

    LCD_WriteLine16(
        0U,
        "LCD TEST OK"
    );

    LCD_WriteLine16(
        1U,
        "16x2 I2C"
    );

    return E_OK;
}