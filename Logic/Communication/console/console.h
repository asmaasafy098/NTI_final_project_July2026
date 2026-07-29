/*
 * console.h
 * UART Command Parser and Console Interface
 */

#ifndef CONSOLE_H_
#define CONSOLE_H_

#include "STD_Types.h"
#include "data_types.h"

/* ==================== Constants ==================== */
#define CONSOLE_BUFFER_SIZE     64
#define MAX_COMMAND_ARGS        8
#define COMMAND_DELIMITERS      " \t\r\n"

/* ==================== Data Types ==================== */
typedef struct {
    char buffer[CONSOLE_BUFFER_SIZE];
    uint8_t index;
    uint8_t ready;
    uint8_t echo;
} Console_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize console
 */
void CONSOLE_Init(void);

/**
 * @brief Process received character (called from USART ISR)
 * @param ch Received character
 */
void CONSOLE_ProcessChar(uint8_t ch);

/**
 * @brief Execute parsed command
 */
void CONSOLE_ExecuteCommand(void);

/**
 * @brief Send response string
 * @param str Response string
 */
void CONSOLE_SendResponse(const char* str);

/**
 * @brief Send error message
 * @param error Error code/string
 */
void CONSOLE_SendError(const char* error);

/**
 * @brief Send telemetry frame
 * @param data Pointer to drive data
 */
void CONSOLE_SendTelemetry(const DriveData_t* data);

/**
 * @brief Send event notification
 * @param event Event string
 */
void CONSOLE_SendEvent(const char* event);

/**
 * @brief Send help menu
 */
void CONSOLE_SendHelp(void);

/**
 * @brief Check if console has command ready
 * @return 1 if command ready, 0 otherwise
 */
uint8_t CONSOLE_IsCommandReady(void);

/**
 * @brief Get command buffer
 * @return Pointer to command buffer
 */
char* CONSOLE_GetCommand(void);

/**
 * @brief Clear command buffer
 */
void CONSOLE_ClearCommand(void);

#endif /* CONSOLE_H_ */