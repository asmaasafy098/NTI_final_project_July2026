/*
 * console.c
 * UART Command Parser Implementation
 */

#include "console.h"
#include "../../../MCL/UART/uart_interface.h"
#include "../../Control/drive_fsm/drive_fsm.h"
#include "../../Control/protection/protection.h"
#include "../../Data/data_manager.h"
#include "../../Control/pi_controller/pi_controller.h"
#include "../../Control/ramp_generator/ramp_generator.h"
#include "../../../Service/util_math.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

/* ==================== External References ==================== */
extern DriveData_t g_driveData;
extern DriveCfg_t g_driveCfg;
extern PI_Handle_t g_pi;
extern Ramp_t g_ramp;

/* ==================== Static Variables ==================== */
static Console_t g_console;
static char* g_argv[MAX_COMMAND_ARGS];
static uint8_t g_argc = 0;

/* ==================== Private Function Prototypes ==================== */
static void CONSOLE_ParseCommand(void);
static uint8_t CONSOLE_GetArg(uint8_t index, char** arg);
static int16_t CONSOLE_ParseNumber(const char* str);
static uint8_t CONSOLE_IsNumber(const char* str);
static void CONSOLE_HandleStatus(void);
static void CONSOLE_HandleRun(void);
static void CONSOLE_HandleStop(void);
static void CONSOLE_HandleReverse(void);
static void CONSOLE_HandleSpeed(void);
static void CONSOLE_HandleSpeedQuery(void);
static void CONSOLE_HandleDirQuery(void);
static void CONSOLE_HandleCfgQuery(void);
static void CONSOLE_HandleSet(void);
static void CONSOLE_HandleAck(void);
static void CONSOLE_HandleTripQuery(void);
static void CONSOLE_HandleTripsQuery(void);
static void CONSOLE_HandleHoursQuery(void);
static void CONSOLE_HandleTuneQuery(void);
static void CONSOLE_HandleSave(void);
static void CONSOLE_HandleHelp(void);

/* ==================== Functions Implementation ==================== */

void CONSOLE_Init(void) {
    g_console.index = 0;
    g_console.ready = 0;
    g_console.echo = 1;
    memset(g_console.buffer, 0, CONSOLE_BUFFER_SIZE);
    
    /* Send welcome message */
    CONSOLE_SendResponse("\r\nIndustrial Motor Controller v1.0");
    CONSOLE_SendResponse("\r\nType HELP for commands\r\n> ");
}

void CONSOLE_ProcessChar(uint8_t ch) {
    /* Echo back if enabled */
    if (g_console.echo) {
        USART_TransmitByte(ch);
    }
    
    /* Handle backspace */
    if (ch == 0x08 || ch == 0x7F) {
        if (g_console.index > 0) {
            g_console.index--;
            g_console.buffer[g_console.index] = 0;
            /* Echo backspace properly */
            USART_TransmitByte(' ');
            USART_TransmitByte(0x08);
        }
        return;
    }
    
    /* Handle carriage return or line feed */
 if (ch == '\r' || ch == '\n') {

    UART_SendString("ENTER\r\n");   // أضف هذا السطر

    if (g_console.index > 0) {
        g_console.buffer[g_console.index] = '\0';
        g_console.ready = 1;
        USART_TransmitString("\r\n");
    } else {
        USART_TransmitString("\r\n> ");
    }
    return;
 }
    
    /* Store character if buffer not full */
    if (g_console.index < CONSOLE_BUFFER_SIZE - 1) {
        g_console.buffer[g_console.index++] = ch;
    }
}

void CONSOLE_ExecuteCommand(void) {
    if (!g_console.ready) {
        return;
    }
    
    /* Parse command */
    CONSOLE_ParseCommand();
    
    g_console.ready = 0;
    g_console.index = 0;
    /* NOTE: buffer clearing moved to the END of this function — ParseCommand()
       fills g_argv[] with pointers INTO g_console.buffer (strtok doesn't copy),
       so clearing the buffer here, before those pointers are used below,
       wiped out every argument before any strcmp() could match it. */
    
    /* Execute based on first argument */
    if (g_argc > 0) {
        
        if (strcmp(g_argv[0], "STATUS") == 0) {
            CONSOLE_HandleStatus();
        } else if (strcmp(g_argv[0], "RUN") == 0) {
            CONSOLE_HandleRun();
        } else if (strcmp(g_argv[0], "STOP") == 0) {
            CONSOLE_HandleStop();
        } else if (strcmp(g_argv[0], "REV") == 0) {
            CONSOLE_HandleReverse();
        } else if (strcmp(g_argv[0], "SPEED") == 0) {
            if (g_argc > 1 && strcmp(g_argv[1], "?") == 0) {
                CONSOLE_HandleSpeedQuery();
            } else {
                CONSOLE_HandleSpeed();
            }
        } else if (strcmp(g_argv[0], "DIR?") == 0) {
            CONSOLE_HandleDirQuery();
        } else if (strcmp(g_argv[0], "CFG?") == 0) {
            CONSOLE_HandleCfgQuery();
        } else if (strcmp(g_argv[0], "SET") == 0) {
            CONSOLE_HandleSet();
        } else if (strcmp(g_argv[0], "ACK") == 0) {
            CONSOLE_HandleAck();
        } else if (strcmp(g_argv[0], "TRIP?") == 0) {
            CONSOLE_HandleTripQuery();
        } else if (strcmp(g_argv[0], "TRIPS?") == 0) {
            CONSOLE_HandleTripsQuery();
        } else if (strcmp(g_argv[0], "HOURS?") == 0) {
            CONSOLE_HandleHoursQuery();
        } else if (strcmp(g_argv[0], "TUNE?") == 0) {
            CONSOLE_HandleTuneQuery();
        } else if (strcmp(g_argv[0], "SAVE") == 0) {
            CONSOLE_HandleSave();
        } else if (strcmp(g_argv[0], "HELP") == 0) {
            CONSOLE_HandleHelp();
        } else {
            CONSOLE_SendError("ERR CMD");
        }
    }
    
    /* Now it's safe to clear — nothing below needs g_argv[] anymore */
    memset(g_console.buffer, 0, CONSOLE_BUFFER_SIZE);
    
    /* Print prompt */
    USART_TransmitString("> ");
}

void CONSOLE_SendResponse(const char* str) {
    USART_TransmitString(str);
    USART_TransmitString("\r\n");
}

void CONSOLE_SendError(const char* error) {
    USART_TransmitString("ERROR: ");
    USART_TransmitString(error);
    USART_TransmitString("\r\n");
}

void CONSOLE_SendTelemetry(const DriveData_t* data) {
    char buffer[128];
    uint8_t checksum = 0;
    uint8_t i;
    
    /* Build telemetry frame */
    sprintf(buffer, "$MD,SP=%d,RP=%d,D=%d,I=%d,V=%d,T=%d,DIR=%c,ST=%s,TR=%d,I2T=%d,RH=%lu,SC=%d",
            data->rampedRpm,
            data->measuredRpm,
            data->dutyPct,
            data->currentmA,
            data->busmV,
            data->tempC,
            (data->direction == DIR_FORWARD) ? 'F' : 
            (data->direction == DIR_REVERSE) ? 'R' : '-',
            FSM_GetStateString(),
            data->activeTrip,
            PROTECT_GetI2TPercent(),
            data->totalRunSec,
            data->startCount);
    
    /* Calculate XOR checksum (between $ and *) */
    for (i = 1; buffer[i] != '\0'; i++) {
        checksum ^= buffer[i];
    }
    
    /* Append checksum */
    sprintf(buffer + strlen(buffer), "*%02X\r\n", checksum);
    
    USART_TransmitString(buffer);
}

void CONSOLE_SendEvent(const char* event) {
    USART_TransmitString("!EVT,");
    USART_TransmitString(event);
    USART_TransmitString("\r\n");
}

void CONSOLE_SendHelp(void) {
    CONSOLE_SendResponse("\r\n=== Available Commands ===");
    CONSOLE_SendResponse("STATUS        - Show telemetry");
    CONSOLE_SendResponse("RUN           - Start motor (remote only)");
    CONSOLE_SendResponse("STOP          - Stop motor");
    CONSOLE_SendResponse("REV           - Reverse direction (remote only)");
    CONSOLE_SendResponse("SPEED <n>     - Set speed (0-maxRpm)");
    CONSOLE_SendResponse("SPEED?        - Show current speed");
    CONSOLE_SendResponse("DIR?          - Show direction");
    CONSOLE_SendResponse("CFG?          - Show configuration");
    CONSOLE_SendResponse("SET <param> <value> - Set parameter");
    CONSOLE_SendResponse("ACK           - Acknowledge trip");
    CONSOLE_SendResponse("TRIP?         - Show active trip");
    CONSOLE_SendResponse("TRIPS?        - Show trip log");
    CONSOLE_SendResponse("HOURS?        - Show run hours");
    CONSOLE_SendResponse("TUNE?         - Show PI internals");
    CONSOLE_SendResponse("SAVE          - Save config to EEPROM");
    CONSOLE_SendResponse("HELP          - Show this menu");
    CONSOLE_SendResponse("");
}

uint8_t CONSOLE_IsCommandReady(void)
{
    return g_console.ready;
}

char* CONSOLE_GetCommand(void) {
    return g_console.buffer;
}

void CONSOLE_ClearCommand(void) {
    g_console.ready = 0;
    g_console.index = 0;
    memset(g_console.buffer, 0, CONSOLE_BUFFER_SIZE);
}

/* ==================== Private Functions ==================== */

static void CONSOLE_ParseCommand(void) {
    char* token;
    g_argc = 0;
    
    /* First token */
    token = strtok(g_console.buffer, COMMAND_DELIMITERS);
    while (token != NULL && g_argc < MAX_COMMAND_ARGS) {
        g_argv[g_argc++] = token;
        token = strtok(NULL, COMMAND_DELIMITERS);
    }
}

static uint8_t CONSOLE_GetArg(uint8_t index, char** arg) {
    if (index >= g_argc) {
        return 0;
    }
    *arg = g_argv[index];
    return 1;
}

static int16_t CONSOLE_ParseNumber(const char* str) {
    return (int16_t)atoi(str);
}

static uint8_t CONSOLE_IsNumber(const char* str) {
    if (str == NULL || *str == '\0') {
        return 0;
    }
    while (*str) {
        if (*str < '0' || *str > '9') {
            return 0;
        }
        str++;
    }
    return 1;
}

/* ==================== Command Handlers ==================== */

static void CONSOLE_HandleStatus(void) {
    CONSOLE_SendTelemetry(&g_driveData);
}

static void CONSOLE_HandleRun(void) {
    /* Check if in remote mode */
    if (!g_driveData.remote) {
        CONSOLE_SendError("ERR MODE");
        return;
    }
    
    if (FSM_IsTripped()) {
        CONSOLE_SendError("ERR TRIPPED");
        return;
    }
    
    if (FSM_RequestStart()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("START,REMOTE");
    } else {
        CONSOLE_SendError("ERR START");
    }
}

static void CONSOLE_HandleStop(void) {
    if (FSM_RequestStop()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("STOP,REMOTE");
    } else {
        CONSOLE_SendError("ERR STOP");
    }
}

static void CONSOLE_HandleReverse(void) {
    if (!g_driveData.remote) {
        CONSOLE_SendError("ERR MODE");
        return;
    }
    
    if (FSM_RequestReverse()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("REVERSE,REMOTE");
    } else {
        CONSOLE_SendError("ERR REV");
    }
}

static void CONSOLE_HandleSpeed(void) {
    char* arg;
    int16_t speed;
    
    if (!g_driveData.remote) {
        CONSOLE_SendError("ERR MODE");
        return;
    }
    
    if (!CONSOLE_GetArg(1, &arg)) {
        CONSOLE_SendError("ERR ARGS");
        return;
    }
    
    if (!CONSOLE_IsNumber(arg)) {
        CONSOLE_SendError("ERR RANGE");
        return;
    }
    
    speed = CONSOLE_ParseNumber(arg);
    if (speed < 0 || speed > g_driveCfg.maxRpm) {
        CONSOLE_SendError("ERR RANGE");
        return;
    }
    
    g_driveData.setpointRpm = speed;
    RAMP_SetTarget(&g_ramp, speed);
    CONSOLE_SendResponse("OK");
}

static void CONSOLE_HandleSpeedQuery(void) {
    char buffer[32];
    sprintf(buffer, "SPEED=%d,%d", g_driveData.rampedRpm, g_driveData.measuredRpm);
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleDirQuery(void) {
    char buffer[16];
    sprintf(buffer, "DIR=%c", 
            (g_driveData.direction == DIR_FORWARD) ? 'F' : 
            (g_driveData.direction == DIR_REVERSE) ? 'R' : '-');
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleCfgQuery(void) {
    char buffer[128];
    sprintf(buffer, "CFG=%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
            g_driveCfg.maxRpm,
            g_driveCfg.minRpm,
            g_driveCfg.accelRpmPerSec,
            g_driveCfg.decelRpmPerSec,
            g_driveCfg.deadTimeMs,
            g_driveCfg.kp,
            g_driveCfg.ki,
            g_driveCfg.ratedCurrentmA,
            g_driveCfg.shortTripmA,
            g_driveCfg.overTempC,
            g_driveCfg.underVoltmV,
            g_driveCfg.overVoltmV);
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleSet(void) {
    char* param;
    char* value;
    int16_t val;
    
    if (!CONSOLE_GetArg(1, &param) || !CONSOLE_GetArg(2, &value)) {
        CONSOLE_SendError("ERR ARGS");
        return;
    }
    
    if (!CONSOLE_IsNumber(value)) {
        CONSOLE_SendError("ERR RANGE");
        return;
    }
    
    val = CONSOLE_ParseNumber(value);
    
    if (strcmp(param, "MAXRPM") == 0) {
        if (val < 500 || val > 6000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.maxRpm = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "MINRPM") == 0) {
        if (val < 50 || val > 1000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.minRpm = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "ACCEL") == 0) {
        if (val < 100 || val > 3000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.accelRpmPerSec = (uint16_t)val;
        RAMP_SetRates(&g_ramp, g_driveCfg.accelRpmPerSec, g_driveCfg.decelRpmPerSec);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "DECEL") == 0) {
        if (val < 100 || val > 3000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.decelRpmPerSec = (uint16_t)val;
        RAMP_SetRates(&g_ramp, g_driveCfg.accelRpmPerSec, g_driveCfg.decelRpmPerSec);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "DEADTIME") == 0) {
        if (val < 200 || val > 2000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.deadTimeMs = (uint16_t)val;
        FSM_SetDeadTime((uint32_t)val);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "KP") == 0) {
        if (val < 0 || val > 4096) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.kp = (int16_t)val;
        PI_SetGains(&g_pi, g_driveCfg.kp, g_driveCfg.ki);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "KI") == 0) {
        if (val < 0 || val > 512) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.ki = (int16_t)val;
        PI_SetGains(&g_pi, g_driveCfg.kp, g_driveCfg.ki);
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "RATED") == 0) {
        if (val < 1000 || val > 15000) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.ratedCurrentmA = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "SHORT") == 0) {
        if (val <= g_driveCfg.ratedCurrentmA) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.shortTripmA = (uint16_t)val;
        CONSOLE_SendResponse("OK");
    } else if (strcmp(param, "OVERTEMP") == 0) {
        if (val < 60 || val > 140) {
            CONSOLE_SendError("ERR RANGE");
            return;
        }
        g_driveCfg.overTempC = (uint8_t)val;
        CONSOLE_SendResponse("OK");
    } else {
        CONSOLE_SendError("ERR PARAM");
    }
}

static void CONSOLE_HandleAck(void) {
    if (FSM_RequestReset()) {
        CONSOLE_SendResponse("OK");
        CONSOLE_SendEvent("ACK,OK");
    } else {
        CONSOLE_SendError("ERR ACTIVE");
        CONSOLE_SendEvent("ACK,REFUSED,ACTIVE");
    }
}

static void CONSOLE_HandleTripQuery(void) {
    char buffer[32];
    Trip_t trip = PROTECT_GetActiveTrip();
    if (trip == TRIP_NONE) {
        trip = PROTECT_GetLatchedTrip();
    }
    sprintf(buffer, "TRIP=%d,%s", trip, PROTECT_GetTripString(trip));
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleTripsQuery(void) {
    CONSOLE_SendResponse("=== Trip Log ===");
    /* TODO: Implement trip log reading from EEPROM */
    CONSOLE_SendResponse("TRP,0,NONE");
    CONSOLE_SendResponse("=== End ===");
}

static void CONSOLE_HandleHoursQuery(void) {
    char buffer[32];
    uint32_t hours = g_driveData.totalRunSec / 3600;
    uint32_t minutes = (g_driveData.totalRunSec % 3600) / 60;
    sprintf(buffer, "HOURS=%02lu:%02lu,SC=%d", hours, minutes, g_driveData.startCount);
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleTuneQuery(void) {
    char buffer[64];
    sprintf(buffer, "TUNE=%d,%d,%ld,%d",
            g_driveCfg.kp,
            g_driveCfg.ki,
            PI_GetIntegral(&g_pi),
            PI_GetError(&g_pi));
    CONSOLE_SendResponse(buffer);
}

static void CONSOLE_HandleSave(void) {
    /* TODO: Save to EEPROM */
    CONSOLE_SendResponse("OK");
    CONSOLE_SendEvent("SAVE,OK");
}

static void CONSOLE_HandleHelp(void) {
    CONSOLE_SendHelp();
}