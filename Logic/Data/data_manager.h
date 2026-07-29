/*
 * data_manager.h
 * Central Data Management
 */

#ifndef DATA_MANAGER_H_
#define DATA_MANAGER_H_

#include "STD_Types.h"
#include "data_types.h"

/* ==================== Functions ==================== */

/**
 * @brief Initialize data manager
 * @param data Pointer to drive data
 * @param cfg Pointer to configuration
 */
void DataManager_Init(DriveData_t* data, DriveCfg_t* cfg);

/**
 * @brief Update all data fields
 */
void DataManager_Update(void);

/**
 * @brief Get drive data pointer
 * @return Pointer to drive data
 */
DriveData_t* DataManager_GetData(void);

/**
 * @brief Get configuration pointer
 * @return Pointer to configuration
 */
DriveCfg_t* DataManager_GetConfig(void);

/**
 * @brief Update measured values from sensors
 * @param rpm Measured RPM
 * @param current Current in mA
 * @param voltage Voltage in mV
 * @param temp Temperature in °C
 */
void DataManager_UpdateSensors(int16_t rpm, uint16_t current, 
                                uint16_t voltage, uint8_t temp);

/**
 * @brief Update setpoint
 * @param setpoint Setpoint in RPM
 */
void DataManager_UpdateSetpoint(int16_t setpoint);

/**
 * @brief Update duty cycle
 * @param duty Duty cycle in counts (0-399)
 */
void DataManager_UpdateDuty(uint16_t duty);

/**
 * @brief Calculate and update error
 */
void DataManager_UpdateError(void);

/**
 * @brief Increment run seconds
 */
void DataManager_IncrementRunSeconds(void);

/**
 * @brief Persist data to EEPROM
 */
void DataManager_Persist(void);

#endif /* DATA_MANAGER_H_ */