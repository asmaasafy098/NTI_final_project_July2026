#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_Interface.h"
#include "7_Segment_Interface.h"

/* ================================================================================
 *  SEVEN-SEGMENT DISPLAY DRIVER - IMPLEMENTATION SKELETON
 *  ------------------------------------------------------------------------------
 *  Each body lists the ordered steps to implement the function. Replace the
 *  numbered comments with the actual GPIO calls.
 * ============================================================================== */

/*
 * Segment lookup table for DIRECT mode (common cathode; 1 = segment ON).
 * Bit order per entry: bit0=a, bit1=b, ... bit6=g (bit7=DP, unused here).
 * TODO: define this table, e.g.
 *   static const uint8_h SevenSeg_DigitTable[10] = {
 *       0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F };
 * For a common-anode display, invert each pattern (~value) before driving.
 */

static const uint8_t SevenSeg_DigitTable[10] = {
    0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
};

Std_ReturnType SevenSeg_Init(const SevenSeg_ConfigType *addConfig)
{
    /*
     * STEP 1: Validate addConfig != NULL and addConfig->dataPort < GPIO_NUMBER_OF_PORTS.
     *
     * STEP 2: Set the data pins as OUTPUT via GPIO_SetPinDirection:
     *   - DIRECT mode: pins startPin .. startPin+6 (segments a..g). Add +7 if you
     *                  also wire the decimal point.
     *   - BCD mode:    pins startPin .. startPin+3 (the 4 decoder inputs).
     *
     * STEP 3: Blank the display by calling SevenSeg_Clear(addConfig).
     * STEP 4: Return E_OK.
     */
    if ((addConfig == NULL) || (addConfig->dataPort >= GPIO_NUMBER_OF_PORTS))
    {
        return E_NOK;
    }

    if (addConfig->connection == SEVEN_SEG_CONNECTION_DIRECT)
    {
        for (uint8_t i = 0; i < 7; ++i)
        {
            GPIO_set_pin_Direction(addConfig->dataPort, addConfig->startPin + i, GPIO_OUTPUT);
        }
    }
    else
    {
        for (uint8_t i = 0; i < 4; ++i)
        {
            GPIO_set_pin_Direction(addConfig->dataPort, addConfig->startPin + i, GPIO_OUTPUT);
        }
    }

    SevenSeg_Clear(addConfig);
    return E_OK;
}


Std_ReturnType SevenSeg_DisplayDigit(const SevenSeg_ConfigType *addConfig, uint8_t digit)
{
    /*
     * STEP 1: Validate addConfig != NULL and digit <= 9 (else E_NOK).
     *
     * STEP 2: Build the value to output:
     *   - DIRECT mode: value = SevenSeg_DigitTable[digit];
     *   - BCD    mode: value = digit;   // decoder converts binary -> segments
     *
     * STEP 3: Apply polarity:
     *   - If addConfig->type == SEVEN_SEG_COMMON_ANODE, invert the bits: value = ~value.
     *     (In BCD mode polarity is usually handled by the decoder; check your IC.)
     *
     * STEP 4: Drive each data pin from the corresponding bit of 'value' using
     *         GPIO_SetPinValue(dataPort, startPin + i, GET_BIT(value, i)):
     *   - DIRECT: i = 0..6   - BCD: i = 0..3
     *
     * STEP 5: Return E_OK.
     */
    if ((addConfig == NULL) || (digit > 9) || (addConfig->dataPort >= GPIO_NUMBER_OF_PORTS))
    {
        return E_NOK;
    }

    uint8_t value;
    if (addConfig->connection == SEVEN_SEG_CONNECTION_DIRECT)
    {
        value = SevenSeg_DigitTable[digit];
    }
    else
    {
        value = digit;
    }

    if (addConfig->type == SEVEN_SEG_COMMON_ANODE)
    {
        value = ~value;
    }

    if (addConfig->connection == SEVEN_SEG_CONNECTION_DIRECT)
    {
        for (uint8_t i = 0; i < 7; ++i)
        {
            GPIO_set_pin_value(addConfig->dataPort,
                             addConfig->startPin + i,
                             GET_BIT(value, i));
        }
    }
    else
    {
        for (uint8_t i = 0; i < 4; ++i)
        {
            GPIO_set_pin_value(addConfig->dataPort,
                             addConfig->startPin + i,
                             GET_BIT(value, i));
        }
    }

    return E_OK;
}


Std_ReturnType SevenSeg_Clear(const SevenSeg_ConfigType *addConfig)
{
    /*
     * STEP 1: Validate addConfig != NULL (else E_NOK).
     * STEP 2: Determine the "off" level: LOW for common cathode, HIGH for common anode.
     * STEP 3: Write that off level to all data pins (segments a..g or the 4 BCD lines).
     * STEP 4: Return E_OK.
     */
    if ((addConfig == NULL) || (addConfig->dataPort >= GPIO_NUMBER_OF_PORTS))
    {
        return E_NOK;
    }

    uint8_t offLevel = (addConfig->type == SEVEN_SEG_COMMON_CATHODE) ? GPIO_LOW : GPIO_HIGH;
    uint8_t pinCount = (addConfig->connection == SEVEN_SEG_CONNECTION_DIRECT) ? 7 : 4;

    for (uint8_t i = 0; i < pinCount; ++i)
    {
        GPIO_set_pin_value(addConfig->dataPort, addConfig->startPin + i, offLevel);
    }

    return E_OK;
}


Std_ReturnType SevenSeg_EnableDigit(uint8_t enablePort, uint8_t enablePin,
                                    SevenSeg_EnableLevel activeLevel)
{
    /*
     * STEP 1: Validate enablePort/enablePin ranges (else E_NOK).
     * STEP 2: Drive the enable pin to the ACTIVE level:
     *         value = (activeLevel == SEVEN_SEG_ENABLE_ACTIVE_HIGH) ? 1 : 0;
     *         GPIO_SetPinValue(enablePort, enablePin, value);
     * STEP 3: Return E_OK.
     */
    if ((enablePort >= GPIO_NUMBER_OF_PORTS) || (enablePin >= GPIO_NUMBER_OF_PINS))
    {
        return E_NOK;
    }

    uint8_t value = (activeLevel == SEVEN_SEG_ENABLE_ACTIVE_HIGH) ? GPIO_HIGH : GPIO_LOW;
    GPIO_set_pin_value(enablePort, enablePin, value);
    return E_OK;
}


Std_ReturnType SevenSeg_DisableDigit(uint8_t enablePort, uint8_t enablePin,
                                     SevenSeg_EnableLevel activeLevel)
{
    /*
     * STEP 1: Validate enablePort/enablePin ranges (else E_NOK).
     * STEP 2: Drive the enable pin to the INACTIVE level (opposite of activeLevel):
     *         value = (activeLevel == SEVEN_SEG_ENABLE_ACTIVE_HIGH) ? 0 : 1;
     *         GPIO_SetPinValue(enablePort, enablePin, value);
     * STEP 3: Return E_OK.
     */
    if ((enablePort >= GPIO_NUMBER_OF_PORTS) || (enablePin >= GPIO_NUMBER_OF_PINS))
    {
        return E_NOK;
    }

    uint8_t value = (activeLevel == SEVEN_SEG_ENABLE_ACTIVE_HIGH) ? GPIO_LOW : GPIO_HIGH;
    GPIO_set_pin_value(enablePort, enablePin, value);
    return E_OK;
}
