/*
 * data_manager.c
 * Central Data Management Implementation
 */

#include "data_manager.h"
#include "util_math.h"

/* ==================== Static Variables ==================== */
static DriveData_t* g_data;
static DriveCfg_t* g_cfg;
static uint32_t g_persistCounter = 0;

/* ==================== Functions Implementation ==================== */

void DataManager_Init(DriveData_t* data, DriveCfg_t* cfg) {
    g_data = data;
    g_cfg = cfg;
    
    /* Initialize data with defaults */
    g_data->setpointRpm = 0;
    g_data->rampedRpm = 0;
    g_data->measuredRpm = 0;
    g_data->errorRpm = 0;
    g_data->dutyCounts = 0;
    g_data->dutyPct = 0;
    g_data->currentmA = 0;
    g_data->busmV = 0;
    g_data->tempC = 0;
    g_data->i2tAccum = 0;
    g_data->direction = DIR_STOP;
    g_data->state = DS_INIT;
    g_data->activeTrip = TRIP_NONE;
    g_data->remote = 0;
    g_data->estopRaw = 0;
    g_data->atSetpoint = 0;
    g_data->runSeconds = 0;
    g_data->totalRunSec = 0;
    g_data->startCount = 0;
    g_data->upTimeSec = 0;
}

DriveData_t* DataManager_GetData(void) {
    return g_data;
}

DriveCfg_t* DataManager_GetConfig(void) {
    return g_cfg;
}

void DataManager_UpdateSensors(int16_t rpm, uint16_t current, 
                                uint16_t voltage, uint8_t temp) {
    g_data->measuredRpm = rpm;
    g_data->currentmA = current;
    g_data->busmV = voltage;
    g_data->tempC = temp;
}

void DataManager_UpdateSetpoint(int16_t setpoint) {
    g_data->setpointRpm = Util_Clamp(setpoint, 0, g_cfg->maxRpm);
}

void DataManager_UpdateDuty(uint16_t duty) {
    g_data->dutyCounts = Util_Clamp(duty, 0, PWM_TOP);
    g_data->dutyPct = (uint8_t)((g_data->dutyCounts * 100) / PWM_TOP);
}

void DataManager_UpdateError(void) {
    g_data->errorRpm = g_data->rampedRpm - g_data->measuredRpm;
}

void DataManager_IncrementRunSeconds(void) {
    g_data->runSeconds++;
    g_data->totalRunSec++;
}

void DataManager_Persist(void) {
    g_persistCounter++;
    
    /* Persist every 5 minutes (300 seconds) */
    if (g_persistCounter >= 300) {
        g_persistCounter = 0;
        g_cfg->totalRunSec = g_data->totalRunSec;
        g_cfg->startCount = g_data->startCount;
        /* Call EEPROM save function */
        /* EEPROM_SaveStatistics(g_data->totalRunSec, g_data->startCount); */
    }
}