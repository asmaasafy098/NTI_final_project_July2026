/*
 * UserPanel.c
 * User Panel Driver Implementation
 * Layer: HAL
 */

#include "UserPanel.h"
#include "../MCL/GPIO/GPIO_Interface.h"
#include "../MCL/Timer/timer_interface.h"
#include "../../Service/STD_Types.h"

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

#define DEBOUNCE_TIME       5           /* 5 * 10ms = 50ms */

/* ==================== Static Variables ==================== */
static Panel_Event_t g_lastEvent = PNL_NONE;
static uint8_t g_buttonStates[4] = {0};
static uint8_t g_debounceCounters[4] = {0};
static uint8_t g_previousStates[4] = {0};
static uint8_t g_blinkCounter = 0;

/* ==================== Functions Implementation ==================== */

Std_ReturnType PANEL_Init(void)
{
    /* Set button pins as input with pull-up */
    GPIO_set_pin_Direction(GPIO_PORTC, BUTTON_START_PIN, GPIO_INPUT);
    GPIO_set_pin_Direction(GPIO_PORTC, BUTTON_STOP_PIN, GPIO_INPUT);
    GPIO_set_pin_Direction(GPIO_PORTC, BUTTON_REV_PIN, GPIO_INPUT);
    GPIO_set_pin_Direction(GPIO_PORTD, BUTTON_RESET_PIN, GPIO_INPUT);
    GPIO_set_pin_Direction(GPIO_PORTD, BUTTON_MODE_PIN, GPIO_INPUT);
    
    /* Enable pull-ups */
    GPIO_set_pull_up(GPIO_PORTC, BUTTON_START_PIN, GPIO_ENABLE);
    GPIO_set_pull_up(GPIO_PORTC, BUTTON_STOP_PIN, GPIO_ENABLE);
    GPIO_set_pull_up(GPIO_PORTC, BUTTON_REV_PIN, GPIO_ENABLE);
    GPIO_set_pull_up(GPIO_PORTD, BUTTON_RESET_PIN, GPIO_ENABLE);
    GPIO_set_pull_up(GPIO_PORTD, BUTTON_MODE_PIN, GPIO_ENABLE);
    
    /* Set LED pins as output */
    GPIO_set_pin_Direction(GPIO_PORTB, LED_RUN_PIN, GPIO_OUTPUT);
    GPIO_set_pin_Direction(GPIO_PORTC, LED_FAULT_PIN, GPIO_OUTPUT);
    GPIO_set_pin_Direction(GPIO_PORTC, LED_FWD_PIN, GPIO_OUTPUT);
    GPIO_set_pin_Direction(GPIO_PORTC, LED_REV_PIN, GPIO_OUTPUT);
    
    /* Turn all LEDs off */
    GPIO_write_pin(GPIO_PORTB, LED_RUN_PIN, GPIO_LOW);
    GPIO_write_pin(GPIO_PORTC, LED_FAULT_PIN, GPIO_LOW);
    GPIO_write_pin(GPIO_PORTC, LED_FWD_PIN, GPIO_LOW);
    GPIO_write_pin(GPIO_PORTC, LED_REV_PIN, GPIO_LOW);
    
    return E_OK;
}

void PANEL_Poll(void)
{
    /* Read button states (active low) */
    uint8_t start = (GPIO_read_pin(GPIO_PORTC, BUTTON_START_PIN) == GPIO_LOW);
    uint8_t stop = (GPIO_read_pin(GPIO_PORTC, BUTTON_STOP_PIN) == GPIO_LOW);
    uint8_t rev = (GPIO_read_pin(GPIO_PORTC, BUTTON_REV_PIN) == GPIO_LOW);
    uint8_t reset = (GPIO_read_pin(GPIO_PORTD, BUTTON_RESET_PIN) == GPIO_LOW);
    
    uint8_t states[4] = {start, stop, rev, reset};
    Panel_Event_t events[4] = {PNL_START, PNL_STOP, PNL_REVERSE, PNL_RESET};
    
    /* Debounce each button */
    for (uint8_t i = 0; i < 4; i++) {
        if (states[i] != g_previousStates[i]) {
            g_debounceCounters[i] = 0;
            g_previousStates[i] = states[i];
        } else {
            if (states[i] == 1) {  /* Pressed (active low) */
                g_debounceCounters[i]++;
                if (g_debounceCounters[i] >= DEBOUNCE_TIME) {
                    if (g_buttonStates[i] == 0) {
                        g_buttonStates[i] = 1;
                        g_lastEvent = events[i];
                    }
                }
            } else {
                g_debounceCounters[i] = 0;
                g_buttonStates[i] = 0;
            }
        }
    }
}

Panel_Event_t PANEL_GetEvent(void)
{
    Panel_Event_t event = g_lastEvent;
    g_lastEvent = PNL_NONE;
    return event;
}

uint8_t PANEL_IsLocalMode(void)
{
    /* PD4 low = Local mode */
    return (GPIO_read_pin(GPIO_PORTD, BUTTON_MODE_PIN) == GPIO_LOW) ? 1 : 0;
}

void PANEL_SetRunLED(uint8_t state, uint8_t blink)
{
    if (blink) {
        g_blinkCounter++;
        if (g_blinkCounter >= 10) {  /* 10 * 10ms = 100ms = 5Hz */
            g_blinkCounter = 0;
            GPIO_toggle_pin(GPIO_PORTB, LED_RUN_PIN);
        }
    } else {
        GPIO_write_pin(GPIO_PORTB, LED_RUN_PIN, state ? GPIO_HIGH : GPIO_LOW);
    }
}

void PANEL_SetFaultLED(uint8_t state)
{
    GPIO_write_pin(GPIO_PORTC, LED_FAULT_PIN, state ? GPIO_HIGH : GPIO_LOW);
}

void PANEL_SetDirectionLEDs(MotorDir_t dir)
{
    switch (dir) {
        case DIR_FORWARD:
            GPIO_write_pin(GPIO_PORTC, LED_FWD_PIN, GPIO_HIGH);
            GPIO_write_pin(GPIO_PORTC, LED_REV_PIN, GPIO_LOW);
            break;
        case DIR_REVERSE:
            GPIO_write_pin(GPIO_PORTC, LED_FWD_PIN, GPIO_LOW);
            GPIO_write_pin(GPIO_PORTC, LED_REV_PIN, GPIO_HIGH);
            break;
        case DIR_STOP:
        default:
            GPIO_write_pin(GPIO_PORTC, LED_FWD_PIN, GPIO_LOW);
            GPIO_write_pin(GPIO_PORTC, LED_REV_PIN, GPIO_LOW);
            break;
    }
}