#ifndef LCD_AIP31068_I2C_H
#define LCD_AIP31068_I2C_H

#include "../../Service/STD_Types.h"
#include "../../MCL/I2C/i2c_interface.h"
#include "../../Logic/Data/data_types.h"
<<<<<<< HEAD
=======

void LCD_Update(const DriveData_t *data);
void LCD_ShowTrip(Trip_t trip);

>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
/* ================================================================================
 *  AiP31068 CHARACTER LCD DRIVER - PUBLIC INTERFACE (HAL, native I2C)
 *  ------------------------------------------------------------------------------
 *  The AiP31068 (AiP31068L, and the compatible ST7032 / Grove-LCD controller) is
 *  an HD44780-style character controller with an I2C interface built in. Unlike a
 *  PCF8574 "I2C backpack", there is no port expander and no nibble shuffling: the
 *  MCU sends a control byte followed by the instruction or character byte.
 *
 *  Wire format on the bus:
 *
 *      START | SLA+W | control | payload | ... | STOP
 *
 *      control = 0x00  ->  every following byte is an INSTRUCTION
 *      control = 0x40  ->  every following byte is DISPLAY DATA
 *
 *  (Bit 7 of the control byte is Co "continue"; leaving it 0 means "the rest of
 *  this transfer is all the same kind", which lets a whole string go out in one
 *  I2C transaction.)
 *
 *  Only 2 MCU pins are needed - SDA and SCL - no matter how many displays.
 *
 *  --------------------------------------------------------------------------
 *  MULTIPLE DISPLAYS
 *  --------------------------------------------------------------------------
 *  All state lives in your handle, so several displays are simply several
 *  handles that differ in 'i2cAddress':
 *
 *      LCD_Aip31068_HandleType g_lcdA;   // g_lcdA.i2cAddress = 0x3E
 *      LCD_Aip31068_HandleType g_lcdB;   // g_lcdB.i2cAddress = 0x3F
 *
 *  IMPORTANT, and worth saying in your report: most AiP31068 modules have the
 *  address strapped to 0x3E in hardware with no address-select pads. Two such
 *  modules on one bus will both answer and corrupt each other. To run two you
 *  need either a module with a selectable address, or a TCA9548A-style I2C
 *  multiplexer, or a second bus. The driver supports it - your hardware may not.
 *
 *  --------------------------------------------------------------------------
 *  HOW TO USE
 *  --------------------------------------------------------------------------
 *      I2C_MasterConfigType i2cCfg = { I2C_SCL_100KHZ };
 *      I2C_InitMaster(&i2cCfg);          // ONCE for the whole bus, not per LCD
 *
 *      LCD_Aip31068_HandleType lcd;
 *      lcd.i2cAddress = LCD_AIP31068_DEFAULT_ADDRESS;   // 0x3E
 *      lcd.rows       = 2;
 *      lcd.cols       = 16;
 *
 *      LCD_Aip31068_Init(&lcd);
 *      LCD_Aip31068_WriteStringAt(&lcd, 0, 0, (const uint8_t *)"ALARM PANEL");
 *
 *  Note that the I2C bus itself is a shared resource this driver does NOT own:
 *  call I2C_InitMaster() yourself, and do not call these functions from an ISR
 *  while the main loop is mid-transfer.
 * ============================================================================== */

/* ---------------- Bus Address ---------------- */
/** @brief Factory 7-bit address of nearly every AiP31068 module. */
#define LCD_AIP31068_DEFAULT_ADDRESS       0x3E

/* ---------------- Control Bytes ---------------- */
#define LCD_AIP31068_CTRL_COMMAND          0x00   /* payload bytes are instructions */
#define LCD_AIP31068_CTRL_DATA             0x40   /* payload bytes are characters   */

/* ---------------- Instruction Codes (HD44780-compatible) ---------------- */
#define LCD_AIP31068_CMD_CLEAR             0x01
#define LCD_AIP31068_CMD_HOME              0x02
#define LCD_AIP31068_CMD_ENTRY_MODE        0x04
#define LCD_AIP31068_CMD_DISPLAY_CTRL      0x08
#define LCD_AIP31068_CMD_SHIFT             0x10
#define LCD_AIP31068_CMD_FUNCTION_SET      0x20
#define LCD_AIP31068_CMD_SET_CGRAM_ADDR    0x40
#define LCD_AIP31068_CMD_SET_DDRAM_ADDR    0x80

/* Entry-mode flags */
#define LCD_AIP31068_ENTRY_INCREMENT       0x02
#define LCD_AIP31068_ENTRY_SHIFT_DISPLAY   0x01

/* Display-control flags */
#define LCD_AIP31068_DISPLAY_ON            0x04
#define LCD_AIP31068_CURSOR_ON             0x02
#define LCD_AIP31068_BLINK_ON              0x01

/* ---------------- Handle ---------------- */
/**
 * @brief One I2C display instance: its bus address, its geometry and the
 *        driver's private shadow of the controller state.
 *
 * Fill the CONFIGURATION fields before calling LCD_Aip31068_Init().
 * The RUNTIME fields belong to the driver.
 *
 * @var LCD_Aip31068_HandleType::i2cAddress  7-bit slave address (usually 0x3E).
 * @var LCD_Aip31068_HandleType::rows        Character lines (1, 2 or 4).
 * @var LCD_Aip31068_HandleType::cols        Characters per line (8, 16, 20, ...).
 */
typedef struct
{
    /* ---- configuration: fill these before Init ---- */
    uint8_t i2cAddress;
    uint8_t rows;
    uint8_t cols;

    /* ---- runtime: owned by the driver, do not modify ---- */
    uint8_t initialized;
    uint8_t displayControl;
    uint8_t entryMode;
    uint8_t cursorRow;
    uint8_t cursorCol;
} LCD_Aip31068_HandleType;

/* ================================================================================
 *  FUNCTION PROTOTYPES
 * ============================================================================== */
/* ---------------- High-level app helpers (defined in lcd_aip31068_i2c.c) ---------------- */
Std_ReturnType LCD_InitDefault(void);
Std_ReturnType LCD_Update(const DriveData_t *pData);
Std_ReturnType LCD_ShowTrip(Trip_t tripCode);


/* ---------------- Low-level driver API ---------------- */

Std_ReturnType LCD_Aip31068_Init(LCD_Aip31068_HandleType *handle);

Std_ReturnType LCD_Aip31068_SendCommand(LCD_Aip31068_HandleType *handle, uint8_t command);

Std_ReturnType LCD_Aip31068_WriteChar(LCD_Aip31068_HandleType *handle, uint8_t character);

Std_ReturnType LCD_Aip31068_WriteString(LCD_Aip31068_HandleType *handle, const uint8_t *pString);

Std_ReturnType LCD_Aip31068_WriteStringAt(LCD_Aip31068_HandleType *handle,
                                          uint8_t row, uint8_t column,
                                          const uint8_t *pString);

Std_ReturnType LCD_Aip31068_WriteNumber(LCD_Aip31068_HandleType *handle, sint32_t number);

Std_ReturnType LCD_Aip31068_SetCursor(LCD_Aip31068_HandleType *handle,
                                      uint8_t row, uint8_t column);

Std_ReturnType LCD_Aip31068_Clear(LCD_Aip31068_HandleType *handle);

Std_ReturnType LCD_Aip31068_Home(LCD_Aip31068_HandleType *handle);

Std_ReturnType LCD_Aip31068_DisplayOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);

Std_ReturnType LCD_Aip31068_CursorOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);

Std_ReturnType LCD_Aip31068_BlinkOnOff(LCD_Aip31068_HandleType *handle, uint8_t on);

Std_ReturnType LCD_Aip31068_ShiftDisplay(LCD_Aip31068_HandleType *handle, uint8_t toRight);

Std_ReturnType LCD_Aip31068_CreateCustomChar(LCD_Aip31068_HandleType *handle,
                                             uint8_t location, const uint8_t *pPattern);

#endif /* LCD_AIP31068_I2C_H */