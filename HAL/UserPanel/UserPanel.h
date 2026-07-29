/*
 * UserPanel.h
 * User Panel Driver - Buttons and LEDs
 * Layer: HAL
 */

#ifndef USERPANEL_H
#define USERPANEL_H

#include "../Service/STD_Types.h"
#include "../Logic/Data/data_types.h"

/* ==================== Button Events ==================== */
typedef enum {
    PNL_NONE = 0,
    PNL_START,
    PNL_STOP,
    PNL_REVERSE,
    PNL_RESET
} Panel_Event_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize user panel
 * @return E_OK if successful, E_NOK otherwise
 */
Std_ReturnType PANEL_Init(void);

/**
 * @brief Poll buttons (called every 10ms)
 */
void PANEL_Poll(void);

/**
 * @brief Get button event
 * @return Button event
 */
Panel_Event_t PANEL_GetEvent(void);

/**
 * @brief Check if in local mode
 * @return 1 if local mode, 0 if remote mode
 */
uint8_t PANEL_IsLocalMode(void);

/**
 * @brief Set run LED state
 * @param state 1 = ON, 0 = OFF
 * @param blink 1 = blink at 2Hz, 0 = steady
 */
void PANEL_SetRunLED(uint8_t state, uint8_t blink);

/**
 * @brief Set fault LED state
 * @param state 1 = ON, 0 = OFF
 */
void PANEL_SetFaultLED(uint8_t state);

/**
 * @brief Set direction LEDs
 * @param dir Direction (DIR_FORWARD, DIR_REVERSE, DIR_STOP)
 */
void PANEL_SetDirectionLEDs(MotorDir_t dir);

#endif /* USERPANEL_H */