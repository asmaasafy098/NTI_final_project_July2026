/*
 * UserPanel.c
 * User Panel Driver Implementation
 * Layer: HAL
 */

#include "UserPanel.h"
#include "../MCL/GPIO/GPIO_Interface.h"
#include "../MCL/Timer/timer_interface.h"
#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"

#include <stdio.h>
#include "../../../MCL/UART/uart_interface.h"


/* ==================== Pin Definitions ==================== */

#define BUTTON_START_PIN    GPIO_PIN5   /* PC5 */
#define BUTTON_STOP_PIN     GPIO_PIN6   /* PC6 */
#define BUTTON_REV_PIN      GPIO_PIN7   /* PC7 */
#define BUTTON_RESET_PIN    GPIO_PIN6   /* PD6 */
#define BUTTON_MODE_PIN     GPIO_PIN4   /* PD4 - Local/Remote */

#define LED_RUN_PIN         GPIO_PIN3   /* PB3 */
#define LED_FAULT_PIN       GPIO_PIN2   /* PC2 */
#define LED_FWD_PIN         GPIO_PIN3   /* PC3 */
#define LED_REV_PIN         GPIO_PIN4   /* PC4 */

#define DEBOUNCE_TIME       5U          /* 5 * 10ms = 50ms */

/*
 * RESET long press:
 *
 * Task_Panel / PANEL_Poll runs every 10ms.
 *
 * 3 seconds = 300 * 10ms
 */
#define RESET_LONG_PRESS_TICKS    300U


/* ==================== Static Variables ==================== */

static Panel_Event_t g_lastEvent = PNL_NONE;

static uint8_t g_buttonStates[4] = {0};

static uint8_t g_debounceCounters[4] = {0};

static uint8_t g_previousStates[4] = {0};

static uint8_t g_blinkCounter = 0;


/*
 * RESET long-press handling
 */
static uint16_t g_resetHoldCounter = 0;

static uint8_t g_resetLongHandled = 0;


/* ==================== Functions Implementation ==================== */

Std_ReturnType PANEL_Init(void)
{
    /* Set button pins as input with pull-up */

    GPIO_set_pin_Direction(
        GPIO_PORTC,
        BUTTON_START_PIN,
        GPIO_INPUT
    );

    GPIO_set_pin_Direction(
        GPIO_PORTC,
        BUTTON_STOP_PIN,
        GPIO_INPUT
    );

    GPIO_set_pin_Direction(
        GPIO_PORTC,
        BUTTON_REV_PIN,
        GPIO_INPUT
    );

    GPIO_set_pin_Direction(
        GPIO_PORTD,
        BUTTON_RESET_PIN,
        GPIO_INPUT
    );

    GPIO_set_pin_Direction(
        GPIO_PORTD,
        BUTTON_MODE_PIN,
        GPIO_INPUT
    );


    /* Enable pull-ups */

    GPIO_set_pull_up(
        GPIO_PORTC,
        BUTTON_START_PIN,
        GPIO_ENABLE
    );

    GPIO_set_pull_up(
        GPIO_PORTC,
        BUTTON_STOP_PIN,
        GPIO_ENABLE
    );

    GPIO_set_pull_up(
        GPIO_PORTC,
        BUTTON_REV_PIN,
        GPIO_ENABLE
    );

    GPIO_set_pull_up(
        GPIO_PORTD,
        BUTTON_RESET_PIN,
        GPIO_ENABLE
    );

    GPIO_set_pull_up(
        GPIO_PORTD,
        BUTTON_MODE_PIN,
        GPIO_ENABLE
    );


    /* Set LED pins as output */

    GPIO_set_pin_Direction(
        GPIO_PORTB,
        LED_RUN_PIN,
        GPIO_OUTPUT
    );

    GPIO_set_pin_Direction(
        GPIO_PORTC,
        LED_FAULT_PIN,
        GPIO_OUTPUT
    );

    GPIO_set_pin_Direction(
        GPIO_PORTC,
        LED_FWD_PIN,
        GPIO_OUTPUT
    );

    GPIO_set_pin_Direction(
        GPIO_PORTC,
        LED_REV_PIN,
        GPIO_OUTPUT
    );


    /* Turn all LEDs off */

    GPIO_write_pin(
        GPIO_PORTB,
        LED_RUN_PIN,
        GPIO_LOW
    );

    GPIO_write_pin(
        GPIO_PORTC,
        LED_FAULT_PIN,
        GPIO_LOW
    );

    GPIO_write_pin(
        GPIO_PORTC,
        LED_FWD_PIN,
        GPIO_LOW
    );

    GPIO_write_pin(
        GPIO_PORTC,
        LED_REV_PIN,
        GPIO_LOW
    );


    /* Reset internal states */

    g_lastEvent = PNL_NONE;

    g_resetHoldCounter = 0;

    g_resetLongHandled = 0;


    return E_OK;
}


/* ================================================================
 * PANEL POLL
 *
 * START / STOP / REV:
 *     Same behavior as before.
 *
 * RESET:
 *
 *     Short press (< 3 seconds)
 *          -> PNL_RESET
 *
 *     Long press (>= 3 seconds)
 *          -> PNL_RESET_ACK
 *
 * ================================================================ */

void PANEL_Poll(void)
{
    /* Read button states (active low) */

    uint8_t start =
        (GPIO_read_pin(
            GPIO_PORTC,
            BUTTON_START_PIN
        ) == GPIO_LOW);

    uint8_t stop =
        (GPIO_read_pin(
            GPIO_PORTC,
            BUTTON_STOP_PIN
        ) == GPIO_LOW);

    uint8_t rev =
        (GPIO_read_pin(
            GPIO_PORTC,
            BUTTON_REV_PIN
        ) == GPIO_LOW);

    uint8_t reset =
        (GPIO_read_pin(
            GPIO_PORTD,
            BUTTON_RESET_PIN
        ) == GPIO_LOW);


    uint8_t states[4] =
    {
        start,
        stop,
        rev,
        reset
    };


    Panel_Event_t events[3] =
    {
        PNL_START,
        PNL_STOP,
        PNL_REVERSE
    };


    /* ============================================================
     * START / STOP / REVERSE
     *
     * Keep original behavior.
     * ============================================================ */

    for (uint8_t i = 0U; i < 3U; i++)
    {
        if (states[i] != g_previousStates[i])
        {
            g_debounceCounters[i] = 0U;

            g_previousStates[i] = states[i];
        }
        else
        {
            if (states[i] == 1U)
            {
                g_debounceCounters[i]++;

                if (g_debounceCounters[i] >= DEBOUNCE_TIME)
                {
                    if (g_buttonStates[i] == 0U)
                    {
                        g_buttonStates[i] = 1U;

                        g_lastEvent = events[i];
                    }
                }
            }
            else
            {
                g_debounceCounters[i] = 0U;

                g_buttonStates[i] = 0U;
            }
        }
    }


    /* ============================================================
     * RESET BUTTON
     *
     * IMPORTANT:
     *
     * We do NOT generate PNL_RESET immediately when the button
     * is pressed.
     *
     * We wait until release:
     *
     *     < 3 sec  -> PNL_RESET
     *
     *     >= 3 sec -> PNL_RESET_ACK
     *
     * This prevents the short-press action from happening before
     * we know whether the user intended a long press.
     * ============================================================ */

    if (reset)
    {
        /*
         * RESET button just became pressed
         */
        if (g_previousStates[3] == 0U)
        {
            g_debounceCounters[3] = 0U;

            g_previousStates[3] = 1U;

            g_resetHoldCounter = 0U;

            g_resetLongHandled = 0U;
        }
        else
        {
            /*
             * Debounce
             */
            if (g_debounceCounters[3] < DEBOUNCE_TIME)
            {
                g_debounceCounters[3]++;
            }


            /*
             * Start counting hold time after debounce
             */
            if (g_debounceCounters[3] >= DEBOUNCE_TIME)
            {
                if (g_resetHoldCounter <
                    RESET_LONG_PRESS_TICKS)
                {
                    g_resetHoldCounter++;
                }


                /*
                 * Long press reached 3 seconds
                 */
                if ((g_resetHoldCounter >=
                     RESET_LONG_PRESS_TICKS) &&
                    (g_resetLongHandled == 0U))
                {
                    g_lastEvent = PNL_RESET_ACK;

                    g_resetLongHandled = 1U;
                }
            }
        }
    }
    else
    {
        /*
         * RESET button released
         */

        if (g_previousStates[3] == 1U)
        {
            /*
             * If long press was NOT already handled,
             * this was a short press.
             */
            if (g_resetLongHandled == 0U)
            {
                g_lastEvent = PNL_RESET;
            }
        }


        /*
         * Reset RESET button state
         */
        g_debounceCounters[3] = 0U;

        g_buttonStates[3] = 0U;

        g_previousStates[3] = 0U;

        g_resetHoldCounter = 0U;

        g_resetLongHandled = 0U;
    }
}


/* ==================== Get Event ==================== */

Panel_Event_t PANEL_GetEvent(void)
{
    Panel_Event_t event = g_lastEvent;

    g_lastEvent = PNL_NONE;

    return event;
}


/* ==================== Local / Remote ==================== */

uint8_t PANEL_IsLocalMode(void)
{
    return
        (GPIO_read_pin(
            GPIO_PORTD,
            BUTTON_MODE_PIN
        ) == GPIO_HIGH)
        ? 1U
        : 0U;
}


/* ==================== Run LED ==================== */

void PANEL_SetRunLED(
    uint8_t state,
    uint8_t blink)
{
    if (blink)
    {
        g_blinkCounter++;

        if (g_blinkCounter >= 10U)
        {
            g_blinkCounter = 0U;

            GPIO_toggle_pin(
                GPIO_PORTB,
                LED_RUN_PIN
            );
        }
    }
    else
    {
        g_blinkCounter = 0U;

        GPIO_write_pin(
            GPIO_PORTB,
            LED_RUN_PIN,
            state ? GPIO_HIGH : GPIO_LOW
        );
    }
}


/* ==================== Fault LED ==================== */

void PANEL_SetFaultLED(uint8_t state)
{
    GPIO_write_pin(
        GPIO_PORTC,
        LED_FAULT_PIN,
        state ? GPIO_HIGH : GPIO_LOW
    );
}


/* ==================== Direction LEDs ==================== */

void PANEL_SetDirectionLEDs(MotorDir_t dir)
{
    switch (dir)
    {
        case DIR_FORWARD:

            GPIO_write_pin(
                GPIO_PORTC,
                LED_FWD_PIN,
                GPIO_HIGH
            );

            GPIO_write_pin(
                GPIO_PORTC,
                LED_REV_PIN,
                GPIO_LOW
            );

            break;


        case DIR_REVERSE:

            GPIO_write_pin(
                GPIO_PORTC,
                LED_FWD_PIN,
                GPIO_LOW
            );

            GPIO_write_pin(
                GPIO_PORTC,
                LED_REV_PIN,
                GPIO_HIGH
            );

            break;


        case DIR_STOP:

        default:

            GPIO_write_pin(
                GPIO_PORTC,
                LED_FWD_PIN,
                GPIO_LOW
            );

            GPIO_write_pin(
                GPIO_PORTC,
                LED_REV_PIN,
                GPIO_LOW
            );

            break;
    }
}