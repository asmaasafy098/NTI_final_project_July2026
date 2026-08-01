/*
 * telemetry.c
 * Telemetry Frame Transmitter Implementation
 */

#include "telemetry.h"
#include "../console/console.h"
#include "../../Control/drive_fsm/drive_fsm.h"
#include "../../Control/protection/protection.h"
#include "../../../MCL/Timer/timer_interface.h"
#include <stdio.h>

/* ==================== Static Variables ==================== */
static uint8_t g_telemetryEnabled = 1;
static uint32_t g_lastSendTime = 0;

/* ==================== Functions Implementation ==================== */

void TELEMETRY_Init(void) {
    g_telemetryEnabled = 1;
    g_lastSendTime = TIMER_GetTick();
}

void TELEMETRY_Update(const DriveData_t* data) {
    if (!g_telemetryEnabled) {
        return;
    }
    
    uint32_t currentTime = TIMER_GetTick();
    
    /* Send telemetry every 1 second */
    if (currentTime - g_lastSendTime >= 1000) {
        CONSOLE_SendTelemetry(data);
        g_lastSendTime = currentTime;
    }
}

void TELEMETRY_SendStatus(const DriveData_t* data) {
    CONSOLE_SendTelemetry(data);
}

void TELEMETRY_SendTripEvent(Trip_t trip, const DriveData_t* data) {
    char buffer[64];
    sprintf(buffer, "TRIP,%s,I=%d,I2T=%d",
            PROTECT_GetTripString(trip),
            data->currentmA,
            PROTECT_GetI2TPercent());
    CONSOLE_SendEvent(buffer);
}

void TELEMETRY_SetEnabled(uint8_t enable) {
    g_telemetryEnabled = enable;
}

uint8_t TELEMETRY_IsEnabled(void) {
    return g_telemetryEnabled;
}