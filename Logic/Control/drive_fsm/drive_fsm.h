/*
 * drive_fsm.h
 * Drive State Machine with Sequencing
 */

#ifndef DRIVE_FSM_H_
#define DRIVE_FSM_H_

#include "STD_Types.h"
#include "data_types.h"

/* ==================== FSM Data ==================== */
typedef struct {
    DriveState_t currentState;
    DriveState_t previousState;
    DriveState_t nextState;
    MotorDir_t direction;
    MotorDir_t pendingDirection;
    uint8_t reversalPending;
    uint8_t tripPending;
    uint8_t estopActive;
    uint32_t stateTimer;
    uint32_t deadTimeMs;
    uint32_t atSpeedCounter;
    uint32_t speedZeroCounter;
    uint8_t initialized;
} FSM_Data_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize FSM
 */
void FSM_Init(void);

/**
 * @brief Run FSM (called every 10ms)
 */
void FSM_Run(void);

/**
 * @brief Process an event
 * @param event Event to process
 */
void FSM_ProcessEvent(FSM_Event_t event);

/**
 * @brief Get current state
 * @return Current drive state
 */
DriveState_t FSM_GetState(void);

/**
 * @brief Get state as string
 * @return String representation of state
 */
const char* FSM_GetStateString(void);

/**
 * @brief Get current direction
 * @return Current direction
 */
MotorDir_t FSM_GetDirection(void);

/**
 * @brief Check if motor is running
 * @return 1 if running, 0 otherwise
 */
uint8_t FSM_IsRunning(void);

/**
 * @brief Check if tripped
 * @return 1 if tripped, 0 otherwise
 */
uint8_t FSM_IsTripped(void);

/**
 * @brief Request start
 * @return 1 if accepted, 0 if refused
 */
uint8_t FSM_RequestStart(void);

/**
 * @brief Request stop
 * @return 1 if accepted, 0 if refused
 */
uint8_t FSM_RequestStop(void);

/**
 * @brief Request reverse
 * @return 1 if accepted, 0 if refused
 */
uint8_t FSM_RequestReverse(void);

/**
 * @brief Request reset/acknowledge
 * @return 1 if accepted, 0 if refused
 */
uint8_t FSM_RequestReset(void);

/**
 * @brief Request emergency stop
 * @return 1 if accepted, 0 if refused
 */
uint8_t FSM_RequestEmergencyStop(void);

/**
 * @brief Request trip
 * @param trip Trip to set
 * @return 1 if accepted, 0 if refused
 */
uint8_t FSM_RequestTrip(Trip_t trip);

/**
 * @brief Set dead time
 * @param ms Dead time in milliseconds
 */
void FSM_SetDeadTime(uint32_t ms);

/**
 * @brief Get time in current state
 * @return Time in milliseconds
 */
uint32_t FSM_GetStateTime(void);

#endif /* DRIVE_FSM_H_ */