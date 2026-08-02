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
static Trip_t g_lastTrip = TRIP_NONE;
/* ==================== Functions Implementation ==================== */

void TELEMETRY_Init(void) {
    g_telemetryEnabled = 1;
    g_lastSendTime = TIMER_GetTick();
}

void TELEMETRY_Update(const DriveData_t *data)
{
    if (data == NULL)
        return;

    if (!g_telemetryEnabled)
        return;

    static uint8_t tripFrameSent = 0;

    /* أثناء الـ TRIP أو الـ ESTOP أرسل Frame واحد فقط */
    if ((data->state == DS_TRIPPED) || (data->state == DS_ESTOP))
    {
        if (!tripFrameSent)
        {
            CONSOLE_SendTelemetry(data);
            tripFrameSent = 1;
        }
        return;
    }

    tripFrameSent = 0;

    uint32_t currentTime = TIMER_GetTick();

    if ((currentTime - g_lastSendTime) >= 1000U)
    {
        CONSOLE_SendTelemetry(data);
        g_lastSendTime = currentTime;
    }
}

void TELEMETRY_SendStatus(const DriveData_t* data) {
    CONSOLE_SendTelemetry(data);
}

void TELEMETRY_SendTripEvent(Trip_t trip, const DriveData_t *data)
{
    if (trip == g_lastTrip)
        return;

    g_lastTrip = trip;

    char buffer[64];

    snprintf(buffer,
             sizeof(buffer),
             "TRIP,%s,I=%u,I2T=%u",
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
void TELEMETRY_ResetTripEvent(void)
{
    g_lastTrip = TRIP_NONE;
}