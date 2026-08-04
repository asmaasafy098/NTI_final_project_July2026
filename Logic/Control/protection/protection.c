/*
 * protection.c
 * Protection Ladder Implementation
 */

#include "protection.h"
#include "util_math.h"
#include <stdio.h> 
#include "../../../MCL/UART/uart_interface.h"
static ProtectionData_t g_protect;

/* ==================== Functions Implementation ==================== */

void PROTECT_Init(void) {
    g_protect.activeTrip = TRIP_NONE;
    g_protect.latchedTrip = TRIP_NONE;
    g_protect.tripped = 0;
    g_protect.latched = 0;
    g_protect.i2tAccum = 0;
    g_protect.i2tLimit = I2T_LIMIT;
    g_protect.tempCounter = 0;
    g_protect.underVoltCounter = 0;
    g_protect.overVoltCounter = 0;
    g_protect.stallCounter = 0;
    g_protect.overspeedCounter = 0;
    g_protect.noFeedbackCounter = 0;
}

Trip_t PROTECT_Evaluate(const DriveData_t* data, const DriveCfg_t* cfg) {
  Trip_t trip = TRIP_NONE;

    if (data->busmV > cfg->overVoltmV)
    {
        char txt[40];
        sprintf(txt, "BUS=%u LIM=%u\r\n", data->busmV, cfg->overVoltmV);
        UART_SendString(txt);
    }
    /* ===== PRIORITY 1: E-Stop (Highest) ===== */
    if (data->estopRaw) {
        trip = TRIP_ESTOP;
        goto TRIP_ACTIVE;
    }
    
    /* ===== PRIORITY 2: Short Circuit ===== */
    if (data->currentmA >= cfg->shortTripmA) {
        trip = TRIP_SHORT;
        goto TRIP_ACTIVE;
    }
    
    /* ===== PRIORITY 3: Overload (I2T) ===== */
    if (g_protect.i2tAccum >= g_protect.i2tLimit) {
        trip = TRIP_OVERLOAD;
        goto TRIP_ACTIVE;
    }
    
    /* ===== PRIORITY 4: Over Temperature ===== */
    if (data->tempC >= cfg->overTempC) {
        g_protect.tempCounter++;
        if (g_protect.tempCounter >= 20) {  /* 2 seconds */
            trip = TRIP_OVERTEMP;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.tempCounter = 0;
    }
    
    /* ===== PRIORITY 5: Under Voltage ===== */
    /*if (data->busmV < cfg->underVoltmV) {
        g_protect.underVoltCounter++;
        if (g_protect.underVoltCounter >= 5) {  
            trip = TRIP_UNDERVOLT;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.underVoltCounter = 0;
    }*/
    
    /* ===== PRIORITY 6: Over Voltage ===== */
    if (data->busmV > cfg->overVoltmV) {
        g_protect.overVoltCounter++;
        if (g_protect.overVoltCounter >= 2) {  /* 200ms */
            trip = TRIP_OVERVOLT;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.overVoltCounter = 0;
    }
    
    /* ===== PRIORITY 7: Stall ===== */
    if (data->dutyPct > 50 && data->measuredRpm < 100) {
        g_protect.stallCounter++;
        if (g_protect.stallCounter >= 30) {  /* 3 seconds */
            trip = TRIP_STALL;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.stallCounter = 0;
    }
    
    /* ===== PRIORITY 8: Overspeed ===== */
    if (data->measuredRpm > data->setpointRpm + 500) {
        g_protect.overspeedCounter++;
        if (g_protect.overspeedCounter >= 10) {  /* 1 second */
            trip = TRIP_OVERSPEED;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.overspeedCounter = 0;
    }
    
    /* ===== PRIORITY 9: No Feedback ===== */
    if (data->dutyPct > 20 && data->measuredRpm == 0) {
        g_protect.noFeedbackCounter++;
        if (g_protect.noFeedbackCounter >= 20) {  /* 2 seconds */
            trip = TRIP_NOFEEDBACK;
            goto TRIP_ACTIVE;
        }
    } else {
        g_protect.noFeedbackCounter = 0;
    }
    
    /* ===== No Trip ===== */
    g_protect.activeTrip = TRIP_NONE;
    return TRIP_NONE;

TRIP_ACTIVE:
    g_protect.activeTrip = trip;
    g_protect.tripped = 1;
    return trip;
}

void PROTECT_UpdateI2T(uint16_t current, uint16_t rated) {
    int32_t excess = (int32_t)current - (int32_t)rated;
    
    if (excess > 0) {
        /* Accumulate when above rated */
        g_protect.i2tAccum += (uint32_t)((excess * excess) / 1000);
    } else {
        /* Decay when below rated */
        uint32_t decay = (uint32_t)((-excess * -excess) / 4000);
        if (g_protect.i2tAccum > decay) {
            g_protect.i2tAccum -= decay;
        } else {
            g_protect.i2tAccum = 0;
        }
    }
}

void PROTECT_Reset(void) {
    g_protect.tripped = 0;
    g_protect.activeTrip = TRIP_NONE;
    g_protect.tempCounter = 0;
    g_protect.underVoltCounter = 0;
    g_protect.overVoltCounter = 0;
    g_protect.stallCounter = 0;
    g_protect.overspeedCounter = 0;
    g_protect.noFeedbackCounter = 0;
}

void PROTECT_ResetTrip(Trip_t trip) {
    if (g_protect.latchedTrip == trip) {
        g_protect.latchedTrip = TRIP_NONE;
        g_protect.latched = 0;
        PROTECT_Reset();
    }
}

uint8_t PROTECT_IsTripped(void) {
    return g_protect.tripped || g_protect.latched;
}

Trip_t PROTECT_GetActiveTrip(void) {
    return g_protect.activeTrip;
}

Trip_t PROTECT_GetLatchedTrip(void) {
    return g_protect.latchedTrip;
}

uint8_t PROTECT_GetI2TPercent(void) {
    if (g_protect.i2tLimit == 0) return 0;
    return (uint8_t)((g_protect.i2tAccum * 100) / g_protect.i2tLimit);
}

const char* PROTECT_GetTripString(Trip_t trip) {
    switch (trip) {
        case TRIP_NONE:        return "NONE";
        case TRIP_ESTOP:       return "ESTOP";
        case TRIP_SHORT:       return "SHORT";
        case TRIP_OVERLOAD:    return "OVERLOAD";
        case TRIP_OVERTEMP:    return "OVERTEMP";
        case TRIP_UNDERVOLT:   return "UNDERVOLT";
        case TRIP_OVERVOLT:    return "OVERVOLT";
        case TRIP_STALL:       return "STALL";
        case TRIP_OVERSPEED:   return "OVERSPEED";
        case TRIP_NOFEEDBACK:  return "NOFEEDBACK";
        default:               return "UNKNOWN";
    }
}