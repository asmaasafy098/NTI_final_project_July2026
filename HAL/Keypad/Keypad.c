#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_Interface.h"
#include "Keypad_Interface.h"

/* ================================================================================
 *  MATRIX KEYPAD DRIVER - IMPLEMENTATION SKELETON
 *  ------------------------------------------------------------------------------
 *  Each body lists the ordered steps to implement the function. Replace the
 *  numbered comments with the actual GPIO calls.
 *
 *  You will need a short blocking delay for debouncing, referenced below as
 *  Keypad_DelayMs(ms) - implement it as a static helper (busy loop or Timer).
 * ============================================================================== */

static void Keypad_DelayMs(uint16_t ms)
{
    volatile uint16_t inner;
    while (ms-- > 0)
    {
        for (inner = 0; inner < 3000U; ++inner)
        {
            /* busy wait */
        }
    }
}


Std_ReturnType Keypad_Init(const Keypad_ConfigType *addConfig)
{
    /*
     * STEP 1: Validate addConfig != NULL and both ports are in range (else E_NOK).
     *
     * STEP 2: Configure the ROW pins as OUTPUT (rowStartPin .. +KEYPAD_ROWS-1) via
     *         GPIO_SetPinDirection, and drive them all HIGH (idle/inactive).
     *
     * STEP 3: Configure the COLUMN pins as INPUT (colStartPin .. +KEYPAD_COLS-1).
     *         If the hardware lacks external pull-ups, enable the internal pull-ups
     *         by writing 1 to the column PORT bits while they are inputs.
     *
     * STEP 4: Return E_OK.
     */
    if ((addConfig == NULL) ||
        (addConfig->rowPort >= GPIO_NUMBER_OF_PORTS) ||
        (addConfig->colPort >= GPIO_NUMBER_OF_PORTS))
    {
        return E_NOK;
    }

    for (uint8_t r = 0; r < KEYPAD_ROWS; ++r)
    {
        GPIO_set_pin_Direction(addConfig->rowPort,
                             addConfig->rowStartPin + r,
                             GPIO_OUTPUT);
        GPIO_set_pin_value(addConfig->rowPort,
                         addConfig->rowStartPin + r,
                         GPIO_HIGH);
    }

    for (uint8_t c = 0; c < KEYPAD_COLS; ++c)
    {
        GPIO_set_pin_Direction(addConfig->colPort,
                             addConfig->colStartPin + c,
                             GPIO_INPUT);
        GPIO_set_pin_value(addConfig->colPort,
                         addConfig->colStartPin + c,
                         GPIO_HIGH);
    }

    return E_OK;
}


Std_ReturnType Keypad_GetKey(const Keypad_ConfigType *addConfig, uint8_t *pKey)
{
    /*
     * STEP 1: Validate addConfig != NULL and pKey != NULL (else E_NOK).
     *
     * STEP 2: Default the result: *pKey = KEYPAD_NO_KEY;
     *
     * STEP 3: Scan one row at a time (for r = 0 .. KEYPAD_ROWS-1):
     *   a) Drive ALL rows HIGH (inactive).
     *   b) Drive the current row LOW (active):
     *      GPIO_SetPinValue(rowPort, rowStartPin + r, 0);
     *   c) For each column (for c = 0 .. KEYPAD_COLS-1):
     *        - Read the column pin: GPIO_GetPinStatus(colPort, colStartPin + c).
     *        - If it reads LOW, a key at (r,c) is pressed:
     *            * Debounce: Keypad_DelayMs(~20), then read again to confirm.
     *            * If still LOW, set *pKey = addConfig->keyMap[r][c].
     *            * (Optional) wait for release before returning.
     *            * Return E_OK.
     *
     * STEP 4: If no key found after scanning all rows, *pKey stays KEYPAD_NO_KEY.
     * STEP 5: Return E_OK.
     */
    if ((addConfig == NULL) || (pKey == NULL) ||
        (addConfig->rowPort >= GPIO_NUMBER_OF_PORTS) ||
        (addConfig->colPort >= GPIO_NUMBER_OF_PORTS))
    {
        return E_NOK;
    }

    *pKey = KEYPAD_NO_KEY;

    for (uint8_t r = 0; r < KEYPAD_ROWS; ++r)
    {
        for (uint8_t rr = 0; rr < KEYPAD_ROWS; ++rr)
        {
            GPIO_set_pin_value(addConfig->rowPort,
                             addConfig->rowStartPin + rr,
                             GPIO_HIGH);
        }

        GPIO_set_pin_value(addConfig->rowPort,
                         addConfig->rowStartPin + r,
                         GPIO_LOW);

        for (uint8_t c = 0; c < KEYPAD_COLS; ++c)
        {
            uint8_t colStatus = GPIO_get_pin_status(addConfig->colPort,
                                                         addConfig->colStartPin + c);
            if (colStatus == GPIO_LOW)
            {
                Keypad_DelayMs(20);
                colStatus = GPIO_get_pin_status(addConfig->colPort,
                                              addConfig->colStartPin + c);
                if (colStatus == GPIO_LOW)
                {
                    *pKey = addConfig->keyMap[r][c];
                    while (GPIO_get_pin_status(addConfig->colPort,
                                             addConfig->colStartPin + c) == GPIO_LOW)
                    {
                        /* wait for release */
                    }
                    return E_OK;
                }
            }
        }
    }

    return E_OK;
}


Std_ReturnType Keypad_WaitForKey(const Keypad_ConfigType *addConfig, uint8_t *pKey)
{
    /*
     * STEP 1: Validate addConfig != NULL and pKey != NULL (else E_NOK).
     * STEP 2: Loop:
     *   - Call Keypad_GetKey(addConfig, pKey).
     *   - If *pKey != KEYPAD_NO_KEY, a key was pressed -> break out of the loop.
     * STEP 3: Return E_OK (with the pressed character in *pKey).
     */
    if ((addConfig == NULL) || (pKey == NULL))
    {
        return E_NOK;
    }

    do
    {
        if (Keypad_GetKey(addConfig, pKey) == E_NOK)
        {
            return E_NOK;
        }
    }
    while (*pKey == KEYPAD_NO_KEY);

    return E_OK;
}
