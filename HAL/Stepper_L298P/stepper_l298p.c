#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_Interface.h"
#include "../../MCL/Timer/timer_interface.h"
#include "stepper_l298p.h"

/* ==================== Excitation Tables ==================== */
static const uint8_t STEPPER_WAVE_TABLE[4] = {
    0x01U, 0x02U, 0x04U, 0x08U
};

static const uint8_t STEPPER_FULL_TABLE[4] = {
    0x03U, 0x06U, 0x0CU, 0x09U
};

static const uint8_t STEPPER_HALF_TABLE[8] = {
    0x01U, 0x03U, 0x02U, 0x06U, 0x04U, 0x0CU, 0x08U, 0x09U
};

/* ==================== Non-Blocking Move Context ==================== */
#define MAX_STEPPER_MOVES  4

typedef struct {
    Stepper_L298P_HandleType* handle;
    uint16_t remainingSteps;
    Stepper_L298P_DirType dir;
    uint32_t nextStepTime;
    uint8_t active;
} Stepper_MoveContext_t;

static Stepper_MoveContext_t g_stepperMoves[MAX_STEPPER_MOVES] = {0};

/* ==================== Private Helpers ==================== */

static uint8_t Stepper_TableLength(Stepper_L298P_ModeType mode)
{
    return (mode == STEPPER_L298P_MODE_HALF) ? 8U : 4U;
}

static uint8_t Stepper_TableEntry(Stepper_L298P_ModeType mode, uint8_t index)
{
    switch (mode) {
        case STEPPER_L298P_MODE_WAVE:  return STEPPER_WAVE_TABLE[index & 0x03U];
        case STEPPER_L298P_MODE_HALF:  return STEPPER_HALF_TABLE[index & 0x07U];
        case STEPPER_L298P_MODE_FULL:
        default:                       return STEPPER_FULL_TABLE[index & 0x03U];
    }
}

static void Stepper_ApplyPattern(Stepper_L298P_HandleType *handle, uint8_t pattern)
{
    GPIO_set_pin_value(handle->in1Port, handle->in1Pin, (uint8_t)GET_BIT(pattern, 0));
    GPIO_set_pin_value(handle->in2Port, handle->in2Pin, (uint8_t)GET_BIT(pattern, 1));
    GPIO_set_pin_value(handle->in3Port, handle->in3Pin, (uint8_t)GET_BIT(pattern, 2));
    GPIO_set_pin_value(handle->in4Port, handle->in4Pin, (uint8_t)GET_BIT(pattern, 3));
    
    handle->energized = (pattern != 0U) ? 1U : 0U;
}

/* ==================== Public Functions ==================== */

Std_ReturnType Stepper_L298P_Init(Stepper_L298P_HandleType *handle)
{
    if (handle == NULL || handle->stepsPerRev == 0U) {
        return E_NOK;
    }
    
    /* Configure bridge inputs as outputs */
    GPIO_set_pin_Direction(handle->in1Port, handle->in1Pin, GPIO_OUTPUT);
    GPIO_set_pin_Direction(handle->in2Port, handle->in2Pin, GPIO_OUTPUT);
    GPIO_set_pin_Direction(handle->in3Port, handle->in3Pin, GPIO_OUTPUT);
    GPIO_set_pin_Direction(handle->in4Port, handle->in4Pin, GPIO_OUTPUT);
    
    /* Enable pins if used */
    if (handle->useEnablePins != 0U) {
        GPIO_set_pin_Direction(handle->enAPort, handle->enAPin, GPIO_OUTPUT);
        GPIO_set_pin_Direction(handle->enBPort, handle->enBPin, GPIO_OUTPUT);
        GPIO_set_pin_value(handle->enAPort, handle->enAPin, GPIO_HIGH);
        GPIO_set_pin_value(handle->enBPort, handle->enBPin, GPIO_HIGH);
    }
    
    /* Clamp step delay */
    if (handle->stepDelayMs == 0U) {
        handle->stepDelayMs = 1U;
    }
    
    /* Start from known state */
    handle->phaseIndex = 0U;
    handle->position = 0;
    handle->energized = 0U;
    Stepper_ApplyPattern(handle, 0x00U);
    handle->initialized = 1U;
    
    return E_OK;
}

Std_ReturnType Stepper_L298P_SetStepMode(Stepper_L298P_HandleType *handle,
                                          Stepper_L298P_ModeType mode)
{
    if (handle == NULL || handle->initialized == 0U || mode > STEPPER_L298P_MODE_HALF) {
        return E_NOK;
    }
    
    handle->stepMode = mode;
    handle->phaseIndex = 0U;
    return E_OK;
}

Std_ReturnType Stepper_L298P_SetStepDelay(Stepper_L298P_HandleType *handle,
                                           uint16_t stepDelayMs)
{
    if (handle == NULL || handle->initialized == 0U) {
        return E_NOK;
    }
    handle->stepDelayMs = (stepDelayMs == 0U) ? 1U : stepDelayMs;
    return E_OK;
}

Std_ReturnType Stepper_L298P_SetSpeedRpm(Stepper_L298P_HandleType *handle, uint16_t rpm)
{
    uint32_t stepsPerRev;
    uint32_t delayMs;
    
    if (handle == NULL || handle->initialized == 0U || rpm == 0U) {
        return E_NOK;
    }
    
    stepsPerRev = (uint32_t)handle->stepsPerRev;
    if (handle->stepMode == STEPPER_L298P_MODE_HALF) {
        stepsPerRev *= 2UL;
    }
    
    delayMs = 60000UL / (stepsPerRev * (uint32_t)rpm);
    if (delayMs == 0UL) {
        return E_NOK;
    }
    
    handle->stepDelayMs = (uint16_t)delayMs;
    return E_OK;
}

/* ==================== Blocking Functions ==================== */

/* Software delay using Timer instead of blocking loop */
static void Stepper_DelayMs(uint16_t ms)
{
    uint32_t startTime = TIMER_GetTick();
    while ((TIMER_GetTick() - startTime) < ms) {
        /* Allow interrupts to run */
        __asm__ volatile ("wdr");
    }
}

Std_ReturnType Stepper_L298P_Step(Stepper_L298P_HandleType *handle,
                                  uint16_t steps, Stepper_L298P_DirType dir)
{
    if (handle == NULL || handle->initialized == 0U || dir > STEPPER_L298P_DIR_CCW) {
        return E_NOK;
    }
    
    for (uint16_t i = 0; i < steps; i++) {
        Stepper_L298P_StepOnce(handle, dir);
        Stepper_DelayMs(handle->stepDelayMs);
    }
    
    return E_OK;
}

Std_ReturnType Stepper_L298P_RotateAngle(Stepper_L298P_HandleType *handle,
                                          uint16_t degrees, Stepper_L298P_DirType dir)
{
    uint32_t stepsPerRev;
    uint32_t steps;
    
    if (handle == NULL || handle->initialized == 0U) {
        return E_NOK;
    }
    
    stepsPerRev = (uint32_t)handle->stepsPerRev;
    if (handle->stepMode == STEPPER_L298P_MODE_HALF) {
        stepsPerRev *= 2UL;
    }
    
    steps = ((uint32_t)degrees * stepsPerRev) / 360UL;
    return Stepper_L298P_Step(handle, (uint16_t)steps, dir);
}

/* ==================== Non-Blocking Functions ==================== */

Std_ReturnType Stepper_L298P_StepOnce(Stepper_L298P_HandleType *handle,
                                      Stepper_L298P_DirType dir)
{
    uint8_t length;
    
    if (handle == NULL || handle->initialized == 0U || dir > STEPPER_L298P_DIR_CCW) {
        return E_NOK;
    }
    
    length = Stepper_TableLength(handle->stepMode);
    
    if (dir == STEPPER_L298P_DIR_CW) {
        handle->phaseIndex = (uint8_t)((handle->phaseIndex + 1U) % length);
        handle->position++;
    } else {
        handle->phaseIndex = (uint8_t)((handle->phaseIndex + length - 1U) % length);
        handle->position--;
    }
    
    Stepper_ApplyPattern(handle, Stepper_TableEntry(handle->stepMode, handle->phaseIndex));
    return E_OK;
}

Std_ReturnType Stepper_L298P_StepNonBlocking(Stepper_L298P_HandleType *handle,
                                              uint16_t steps, Stepper_L298P_DirType dir)
{
    if (handle == NULL || handle->initialized == 0U || steps == 0U) {
        return E_NOK;
    }
    
    /* Find an available move slot */
    for (uint8_t i = 0; i < MAX_STEPPER_MOVES; i++) {
        if (!g_stepperMoves[i].active) {
            g_stepperMoves[i].handle = handle;
            g_stepperMoves[i].remainingSteps = steps;
            g_stepperMoves[i].dir = dir;
            g_stepperMoves[i].nextStepTime = TIMER_GetTick() + handle->stepDelayMs;
            g_stepperMoves[i].active = 1;
            return E_OK;
        }
    }
    return E_NOK;  /* All slots busy */
}

void Stepper_L298P_Tick(void)
{
    for (uint8_t i = 0; i < MAX_STEPPER_MOVES; i++) {
        if (g_stepperMoves[i].active) {
            if (TIMER_GetTick() >= g_stepperMoves[i].nextStepTime) {
                Stepper_L298P_StepOnce(g_stepperMoves[i].handle, g_stepperMoves[i].dir);
                g_stepperMoves[i].remainingSteps--;
                g_stepperMoves[i].nextStepTime = TIMER_GetTick() + 
                    g_stepperMoves[i].handle->stepDelayMs;
                
                if (g_stepperMoves[i].remainingSteps == 0) {
                    g_stepperMoves[i].active = 0;
                }
            }
        }
    }
}

/* ==================== Hold/Release ==================== */

Std_ReturnType Stepper_L298P_Hold(Stepper_L298P_HandleType *handle)
{
    if (handle == NULL || handle->initialized == 0U) {
        return E_NOK;
    }
    
    if (handle->useEnablePins != 0U) {
        GPIO_set_pin_value(handle->enAPort, handle->enAPin, GPIO_HIGH);
        GPIO_set_pin_value(handle->enBPort, handle->enBPin, GPIO_HIGH);
    }
    
    Stepper_ApplyPattern(handle, Stepper_TableEntry(handle->stepMode, handle->phaseIndex));
    return E_OK;
}

Std_ReturnType Stepper_L298P_Release(Stepper_L298P_HandleType *handle)
{
    if (handle == NULL || handle->initialized == 0U) {
        return E_NOK;
    }
    
    Stepper_ApplyPattern(handle, 0x00U);
    
    if (handle->useEnablePins != 0U) {
        GPIO_set_pin_value(handle->enAPort, handle->enAPin, GPIO_LOW);
        GPIO_set_pin_value(handle->enBPort, handle->enBPin, GPIO_LOW);
    }
    
    handle->energized = 0U;
    return E_OK;
}

/* ==================== Position ==================== */

Std_ReturnType Stepper_L298P_GetPosition(const Stepper_L298P_HandleType *handle,
                                          sint32 *pPosition)
{
    if (handle == NULL || handle->initialized == 0U || pPosition == NULL) {
        return E_NOK;
    }
    *pPosition = handle->position;
    return E_OK;
}

Std_ReturnType Stepper_L298P_ResetPosition(Stepper_L298P_HandleType *handle)
{
    if (handle == NULL || handle->initialized == 0U) {
        return E_NOK;
    }
    handle->position = 0;
    return E_OK;
}

Std_ReturnType Stepper_L298P_GetStepsPerRev(const Stepper_L298P_HandleType *handle,
                                            uint16_t *pStepsPerRev)
{
    if (handle == NULL || handle->initialized == 0U || pStepsPerRev == NULL) {
        return E_NOK;
    }
    
    if (handle->stepMode == STEPPER_L298P_MODE_HALF) {
        *pStepsPerRev = (uint16_t)(handle->stepsPerRev * 2U);
    } else {
        *pStepsPerRev = handle->stepsPerRev;
    }
    return E_OK;
}