/*
 * scheduler.h
 * True Cooperative Scheduler
 */

#ifndef scheduler_H_
#define scheduler_H_

#include "STD_Types.h"

/* ==================== Task Structure ==================== */
#define MAX_TASKS 7

typedef struct {
    void (*task)(void);
    const char* name;
    uint16_t period;       /* Task period in milliseconds */
    uint16_t offset;       /* Initial offset in milliseconds */
    uint32_t lastRun;      /* Last run time */
    uint32_t nextRun;      /* Next scheduled run time */
    uint16_t overrun;      /* Overrun counter */
    uint8_t enabled;
} Task_t;

/* ==================== Functions ==================== */

void SCHED_Init(void);
void SCHED_Run(void);
uint8_t SCHED_AddTask(void (*task)(void), const char* name, 
                       uint16_t period, uint16_t offset);
uint16_t SCHED_GetOverrun(uint8_t taskId);
uint8_t SCHED_GetLoadPercent(void);
uint8_t SCHED_GetMaxLoadPercent(void);
void SCHED_ReportStatus(void);

#endif /* SCHEDULER_H_ */