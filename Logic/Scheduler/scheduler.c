/*
 * scheduler.c
 * True Cooperative Scheduler Implementation
 */

#include "scheduler.h"
#include "../../MCL/Timer/timer_interface.h"
#include "util_math.h"

/* ==================== Static Variables ==================== */
static Task_t g_tasks[MAX_TASKS];
static uint8_t g_taskCount = 0;
static uint32_t g_idleTime = 0;
static uint32_t g_busyTime = 0;
static uint32_t g_lastLoadCheck = 0;
static uint8_t g_maxLoad = 0;

/* ==================== Functions Implementation ==================== */

void SCHED_Init(void) {
    for (uint8_t i = 0; i < MAX_TASKS; i++) {
        g_tasks[i].task = NULL;
        g_tasks[i].name = NULL;
        g_tasks[i].period = 0;
        g_tasks[i].offset = 0;
        g_tasks[i].lastRun = 0;
        g_tasks[i].nextRun = 0;
        g_tasks[i].overrun = 0;
        g_tasks[i].enabled = 0;
    }
    g_taskCount = 0;
    g_idleTime = 0;
    g_busyTime = 0;
    g_lastLoadCheck = TIMER_GetTick();
    g_maxLoad = 0;
}

void SCHED_Run(void) {
    uint32_t currentTime = TIMER_GetTick();
    uint32_t taskStartTime;
    
    /* Check each task */
    for (uint8_t i = 0; i < g_taskCount; i++) {
        if (!g_tasks[i].enabled || g_tasks[i].task == NULL) {
            continue;
        }
        
        /* Check if task should run */
        if (currentTime >= g_tasks[i].nextRun) {
            /* Record start time for load measurement (local only - no
             * per-task consumer ever read the old startTime/maxDuration
             * fields, so they were removed to save RAM) */
            taskStartTime = TIMER_GetTick();
            
            /* Execute task */
            g_tasks[i].task();
            
            /* Calculate execution time */
            uint32_t execTime = TIMER_GetTick() - taskStartTime;
            
            /* Update busy time for load calculation */
            g_busyTime += execTime;
            
            /* Check for overrun */
            if (currentTime - g_tasks[i].lastRun > g_tasks[i].period + 5) {
                g_tasks[i].overrun++;
            }
            
            /* Update last run and next run */
            g_tasks[i].lastRun = currentTime;
            g_tasks[i].nextRun = currentTime + g_tasks[i].period;
        }
    }
    
    /* Calculate load every 1 second */
    if (currentTime - g_lastLoadCheck >= 1000) {
        uint32_t totalTime = g_busyTime + g_idleTime;
        if (totalTime > 0) {
            uint8_t load = (uint8_t)((g_busyTime * 100) / totalTime);
            if (load > g_maxLoad) {
                g_maxLoad = load;
            }
        }
        
        /* Reset counters */
        g_busyTime = 0;
        g_idleTime = 0;
        g_lastLoadCheck = currentTime;
    }
}

uint8_t SCHED_AddTask(void (*task)(void), const char* name, 
                       uint16_t period, uint16_t offset) {
    if (g_taskCount >= MAX_TASKS || task == NULL) {
        return 0;
    }
    
    g_tasks[g_taskCount].task = task;
    g_tasks[g_taskCount].name = name;
    g_tasks[g_taskCount].period = period;
    g_tasks[g_taskCount].offset = offset;
    g_tasks[g_taskCount].lastRun = 0;
    g_tasks[g_taskCount].nextRun = offset;
    g_tasks[g_taskCount].overrun = 0;
    g_tasks[g_taskCount].enabled = 1;
    
    g_taskCount++;
    return 1;
}

uint16_t SCHED_GetOverrun(uint8_t taskId) {
    if (taskId >= g_taskCount) {
        return 0;
    }
    return g_tasks[taskId].overrun;
}

uint8_t SCHED_GetLoadPercent(void) {
    uint32_t currentTime = TIMER_GetTick();
    if (currentTime - g_lastLoadCheck >= 1000) {
        /* Force recalculation */
        SCHED_Run();
    }
    
    uint32_t totalTime = g_busyTime + g_idleTime;
    if (totalTime == 0) {
        return 0;
    }
    return (uint8_t)((g_busyTime * 100) / totalTime);
}

uint8_t SCHED_GetMaxLoadPercent(void) {
    return g_maxLoad;
}

void SCHED_ReportStatus(void) {
    /* Will be implemented when USART is ready */
    /* Sends task status via UART */
}