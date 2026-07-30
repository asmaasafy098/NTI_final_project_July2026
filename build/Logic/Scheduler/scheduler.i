# 1 "Logic/Scheduler/scheduler.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Logic/Scheduler/scheduler.c"





# 1 "Logic/Scheduler/scheduler.h" 1
# 9 "Logic/Scheduler/scheduler.h"
# 1 "Service/STD_Types.h" 1



# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 1 3 4
# 9 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 3 4
# 1 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 1 3 4
# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4

# 125 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\avr\\include\\stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "c:\\users\\hp\\.platformio\\packages\\toolchain-atmelavr\\lib\\gcc\\avr\\7.3.0\\include\\stdint.h" 2 3 4
# 5 "Service/STD_Types.h" 2



# 7 "Service/STD_Types.h"
typedef int8_t sint8_t;
typedef int16_t sint16_t;
typedef int32_t sint32_t;
typedef int64_t sint64_t;

typedef sint8_t sint8;
typedef sint16_t sint16;
typedef sint32_t sint32;
typedef sint64_t sint64;

typedef int8_t s8;
typedef int16_t s16;
typedef int32_t s32;
typedef int64_t s64;


typedef uint8_t uint8;
typedef uint16_t uint16;
typedef uint32_t uint32;
typedef uint64_t uint64;


typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;


typedef float float32_t;
typedef double float64_t;
typedef float f32;
typedef double f64;


typedef enum {
    FALSE = 0,
    TRUE = 1
} bool_t;
# 55 "Service/STD_Types.h"
typedef enum {
    E_OK = 0,
    E_NOK,
    E_BUSY,
    E_TIMEOUT,
    E_INVALID,
    E_NOT_READY
} Std_ReturnType;

typedef Std_ReturnType STD_ReturnType;
# 10 "Logic/Scheduler/scheduler.h" 2




typedef struct {
    void (*task)(void);
    const char* name;
    uint16_t period;
    uint16_t offset;
    uint32_t lastRun;
    uint32_t nextRun;
    uint16_t overrun;
    uint16_t maxDuration;
    uint32_t startTime;
    uint8_t enabled;
} Task_t;






void SCHED_Init(void);




void SCHED_Run(void);
# 47 "Logic/Scheduler/scheduler.h"
uint8_t SCHED_AddTask(void (*task)(void), const char* name,
                       uint16_t period, uint16_t offset);






uint16_t SCHED_GetOverrun(uint8_t taskId);





uint8_t SCHED_GetLoadPercent(void);





uint8_t SCHED_GetMaxLoadPercent(void);




void SCHED_ReportStatus(void);
# 7 "Logic/Scheduler/scheduler.c" 2
# 1 "Logic/Scheduler/../../MCL/Timer/timer_interface.h" 1



# 1 "Logic/Scheduler/../../MCL/Timer/../../Service/STD_Types.h" 1
# 5 "Logic/Scheduler/../../MCL/Timer/timer_interface.h" 2
# 1 "Logic/Scheduler/../../MCL/Timer/timer_registers.h" 1
# 6 "Logic/Scheduler/../../MCL/Timer/timer_interface.h" 2
# 23 "Logic/Scheduler/../../MCL/Timer/timer_interface.h"
typedef enum
{
    TIMER_CHANNEL_0 = 0,
    TIMER_CHANNEL_1 = 1,
    TIMER_CHANNEL_2 = 2,
    TIMER_CHANNEL_MAX
} Timer_ChannelType;
# 39 "Logic/Scheduler/../../MCL/Timer/timer_interface.h"
typedef enum
{
    TIMER_MODE_NORMAL = 0,
    TIMER_MODE_CTC = 1,
    TIMER_MODE_FAST_PWM = 2,
    TIMER_MODE_PHASE_PWM = 3
} Timer_ModeType;







typedef enum
{
    TIMER_CLOCK_STOPPED = 0,
    TIMER_CLOCK_DIV_1 = 1,
    TIMER_CLOCK_DIV_8 = 2,
    TIMER_CLOCK_DIV_64 = 3,
    TIMER_CLOCK_DIV_256 = 4,
    TIMER_CLOCK_DIV_1024 = 5
} Timer_PrescalerType;







typedef enum
{
    TIMER_INT_OVERFLOW = 0,
    TIMER_INT_COMPARE_MATCH = 1
} Timer_InterruptType;
# 85 "Logic/Scheduler/../../MCL/Timer/timer_interface.h"
typedef struct
{
    Timer_ChannelType channel;
    Timer_ModeType mode;
    Timer_PrescalerType prescaler;
    uint16_t initialValue;
    uint16_t compareValue;
} Timer_ConfigType;






typedef void (*Timer_CallBackType)(void);
# 111 "Logic/Scheduler/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_Init(void);
# 120 "Logic/Scheduler/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 129 "Logic/Scheduler/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);
# 139 "Logic/Scheduler/../../MCL/Timer/timer_interface.h"
Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType,
                                  Timer_CallBackType callBack);







Std_ReturnType Timer1_Init(void);






Std_ReturnType Timer1_SetDuty(uint16_t duty_percent);







Std_ReturnType Timer2_Init(void);






Std_ReturnType Timer2_SetTone(uint16_t tone);






void Timer_EnableGlobalInterrupt(void);






void Timer_DisableGlobalInterrupt(void);


uint32_t TIMER_GetTick(void);
# 8 "Logic/Scheduler/scheduler.c" 2
# 1 "Service/util_math.h" 1
# 9 "Service/util_math.h"
# 1 "Service/STD_Types.h" 1
# 10 "Service/util_math.h" 2
# 22 "Service/util_math.h"
static inline int16_t Util_Map(int16_t x, int16_t in_min, int16_t in_max,
                                int16_t out_min, int16_t out_max) {
    return (int16_t)(((int32_t)(x - in_min) * (out_max - out_min)) / (in_max - in_min) + out_min);
}
# 34 "Service/util_math.h"
static inline int16_t Util_Clamp(int16_t value, int16_t min, int16_t max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}
# 47 "Service/util_math.h"
static inline uint8_t Util_IsInRange(int16_t value, int16_t min, int16_t max) {
    return (value >= min && value <= max);
}
# 58 "Service/util_math.h"
static inline int16_t Util_Deadband(int16_t value, int16_t lastValue, int16_t threshold) {
    int16_t diff = value - lastValue;
    if (((diff) < 0 ? -(diff) : (diff)) < threshold) {
        return lastValue;
    }
    return value;
}
# 9 "Logic/Scheduler/scheduler.c" 2


static Task_t g_tasks[10];
static uint8_t g_taskCount = 0;
static uint32_t g_idleTime = 0;
static uint32_t g_busyTime = 0;
static uint32_t g_lastLoadCheck = 0;
static uint8_t g_maxLoad = 0;



void SCHED_Init(void) {
    for (uint8_t i = 0; i < 10; i++) {
        g_tasks[i].task = ((void *)0);
        g_tasks[i].name = ((void *)0);
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


    for (uint8_t i = 0; i < g_taskCount; i++) {
        if (!g_tasks[i].enabled || g_tasks[i].task == ((void *)0)) {
            continue;
        }


        if (currentTime >= g_tasks[i].nextRun) {

            taskStartTime = TIMER_GetTick();
            g_tasks[i].startTime = taskStartTime;


            g_tasks[i].task();


            uint32_t execTime = TIMER_GetTick() - taskStartTime;
            if (execTime > g_tasks[i].maxDuration) {
                g_tasks[i].maxDuration = (uint16_t)execTime;
            }


            g_busyTime += execTime;


            if (currentTime - g_tasks[i].lastRun > g_tasks[i].period + 5) {
                g_tasks[i].overrun++;
            }


            g_tasks[i].lastRun = currentTime;
            g_tasks[i].nextRun = currentTime + g_tasks[i].period;
        }
    }


    if (currentTime - g_lastLoadCheck >= 1000) {
        uint32_t totalTime = g_busyTime + g_idleTime;
        if (totalTime > 0) {
            uint8_t load = (uint8_t)((g_busyTime * 100) / totalTime);
            if (load > g_maxLoad) {
                g_maxLoad = load;
            }
        }


        g_busyTime = 0;
        g_idleTime = 0;
        g_lastLoadCheck = currentTime;
    }
}

uint8_t SCHED_AddTask(void (*task)(void), const char* name,
                       uint16_t period, uint16_t offset) {
    if (g_taskCount >= 10 || task == ((void *)0)) {
        return 0;
    }

    g_tasks[g_taskCount].task = task;
    g_tasks[g_taskCount].name = name;
    g_tasks[g_taskCount].period = period;
    g_tasks[g_taskCount].offset = offset;
    g_tasks[g_taskCount].lastRun = 0;
    g_tasks[g_taskCount].nextRun = offset;
    g_tasks[g_taskCount].overrun = 0;
    g_tasks[g_taskCount].maxDuration = 0;
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


}
