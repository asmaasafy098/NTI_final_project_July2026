/*
 * scheduler.h
 * True Cooperative Scheduler
 */

#ifndef SCHEDULER_H_
#define SCHEDULER_H_

#include "STD_Types.h"

/* ==================== Task Structure ==================== */
#define MAX_TASKS 6

typedef struct {
    void (*task)(void);
    const char* name;
    uint16_t period;       /* Task period in milliseconds */
    uint16_t offset;       /* Initial offset in milliseconds */
    uint32_t lastRun;      /* Last run time */
    uint32_t nextRun;      /* Next scheduled run time */
    uint16_t overrun;      /* Overrun counter */
    uint16_t maxDuration;  /* Maximum execution time in microseconds */
    uint32_t startTime;    /* For measuring execution time */
    uint8_t enabled;
} Task_t;

/* ==================== Functions ==================== */

/**
 * @brief Initialize scheduler
 */
void SCHED_Init(void);

/**
 * @brief Run scheduler (called in super loop)
 */
void SCHED_Run(void);

/**
 * @brief Add task to scheduler
 * @param task Function pointer to task
 * @param name Task name
 * @param period Task period in milliseconds
 * @param offset Initial offset in milliseconds
 * @return 1 if successful, 0 if task table full
 */
uint8_t SCHED_AddTask(void (*task)(void), const char* name, 
                       uint16_t period, uint16_t offset);

/**
 * @brief Get overrun count for task
 * @param taskId Task index
 * @return Overrun count
 */
uint16_t SCHED_GetOverrun(uint8_t taskId);

/**
 * @brief Get CPU load percentage
 * @return CPU load percentage (0-100)
 */
uint8_t SCHED_GetLoadPercent(void);

/**
 * @brief Get maximum CPU load
 * @return Maximum CPU load percentage
 */
uint8_t SCHED_GetMaxLoadPercent(void);

/**
 * @brief Report scheduler status via UART
 */
void SCHED_ReportStatus(void);

#endif /* SCHEDULER_H_ */