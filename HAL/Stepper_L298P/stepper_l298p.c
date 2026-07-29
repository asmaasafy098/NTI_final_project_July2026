#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "../../MCL/GPIO/GPIO_Interface.h"
#include "stepper_l298p.h"

/* ================================================================================
 *  STEPPER MOTOR DRIVER - IMPLEMENTATION (HAL, L298P / L298N H-bridge)
 *  ------------------------------------------------------------------------------
 *  Each body keeps the ordered steps it implements as comments, followed by the
 *  actual GPIO calls. All state lives in the caller's handle, so two motors
 *  never interfere.
 *
 *  The excitation tables below hold one nibble per step:
 *      bit0 -> IN1, bit1 -> IN2, bit2 -> IN3, bit3 -> IN4
 * ============================================================================== */

/* WAVE: one coil at a time. Cheapest on current, weakest torque. */
static const uint8_t STEPPER_WAVE_TABLE[4] =
{
    0x01U,   /* 0001 : IN1                */
    0x02U,   /* 0010 :      IN2           */
    0x04U,   /* 0100 :           IN3      */
    0x08U    /* 1000 :                IN4 */
};

/* FULL: two coils at a time. Same resolution as WAVE, roughly double the torque. */
static const uint8_t STEPPER_FULL_TABLE[4] =
{
    0x03U,   /* 0011 : IN1 + IN2 */
    0x06U,   /* 0110 : IN2 + IN3 */
    0x0CU,   /* 1100 : IN3 + IN4 */
    0x09U    /* 1001 : IN4 + IN1 */
};

/* HALF: alternates one and two coils, so each entry is half a full step. */
static const uint8_t STEPPER_HALF_TABLE[8] =
{
    0x01U,   /* 0001 */
    0x03U,   /* 0011 */
    0x02U,   /* 0010 */
    0x06U,   /* 0110 */
    0x04U,   /* 0100 */
    0x0CU,   /* 1100 */
    0x08U,   /* 1000 */
    0x09U    /* 1001 */
};


/* --------------------------------------------------------------------------
 *  INTERNAL HELPERS (static - not part of the public interface)
 * ------------------------------------------------------------------------ */

/* Software Delay Replacement for util/delay.h */
static void Stepper_DelayMs(uint16_t ms)
{
    while (ms > 0U)
    {
        /* Software loop to simulate ~1ms delay on typical clock frequencies */
        volatile uint32_t count = 4000U;
        while (count--)
        {
            __asm__ volatile ("nop");
        }
        ms--;
    }
}

/* Number of entries in the table used by the active mode. */
static uint8_t Stepper_TableLength(Stepper_L298P_ModeType mode)
{
    return (mode == STEPPER_L298P_MODE_HALF) ? 8U : 4U;
}

/* The excitation pattern for one index of the active mode's table. */
static uint8_t Stepper_TableEntry(Stepper_L298P_ModeType mode, uint8_t index)
{
    uint8_t local_Pattern = 0U;

    switch (mode)
    {
        case STEPPER_L298P_MODE_WAVE:  local_Pattern = STEPPER_WAVE_TABLE[index & 0x03U]; break;
        case STEPPER_L298P_MODE_HALF:  local_Pattern = STEPPER_HALF_TABLE[index & 0x07U]; break;
        case STEPPER_L298P_MODE_FULL:
        default:                       local_Pattern = STEPPER_FULL_TABLE[index & 0x03U]; break;
    }

    return local_Pattern;
}

/* Writes one excitation nibble to the four bridge inputs. */
static void Stepper_ApplyPattern(Stepper_L298P_HandleType *handle, uint8_t pattern)
{
    (void)GPIO_set_pin_value(handle->in1Port, handle->in1Pin, (uint8_t)GET_BIT(pattern, 0));
    (void)GPIO_set_pin_value(handle->in2Port, handle->in2Pin, (uint8_t)GET_BIT(pattern, 1));
    (void)GPIO_set_pin_value(handle->in3Port, handle->in3Pin, (uint8_t)GET_BIT(pattern, 2));
    (void)GPIO_set_pin_value(handle->in4Port, handle->in4Pin, (uint8_t)GET_BIT(pattern, 3));

    handle->energized = (pattern != 0U) ? 1U : 0U;
}


/* --------------------------------------------------------------------------
 *  PUBLIC FUNCTIONS
 * ------------------------------------------------------------------------ */

Std_ReturnType Stepper_L298P_Init(Stepper_L298P_HandleType *handle)
{
    /* STEP 1: Validate the handle and the motor data. */
    if (handle == NULL)
    {
        return E_NOK;
    }

    if (handle->stepsPerRev == 0U)
    {
        return E_NOK;
    }

    /* STEP 2: All four bridge inputs are outputs. */
    (void)GPIO_set_pin_Direction(handle->in1Port, handle->in1Pin, GPIO_OUTPUT);
    (void)GPIO_set_pin_Direction(handle->in2Port, handle->in2Pin, GPIO_OUTPUT);
    (void)GPIO_set_pin_Direction(handle->in3Port, handle->in3Pin, GPIO_OUTPUT);
    (void)GPIO_set_pin_Direction(handle->in4Port, handle->in4Pin, GPIO_OUTPUT);

    /*
     * STEP 3: If the driver owns ENA/ENB, make them outputs and enable the
     *         bridge. Boards with the enable jumpers fitted skip this.
     */
    if (handle->useEnablePins != 0U)
    {
        (void)GPIO_set_pin_Direction(handle->enAPort, handle->enAPin, GPIO_OUTPUT);
        (void)GPIO_set_pin_Direction(handle->enBPort, handle->enBPin, GPIO_OUTPUT);
        (void)GPIO_set_pin_value(handle->enAPort, handle->enAPin, GPIO_HIGH);
        (void)GPIO_set_pin_value(handle->enBPort, handle->enBPin, GPIO_HIGH);
    }

    /* STEP 4: A step delay of zero would mean "step as fast as the CPU can". */
    if (handle->stepDelayMs == 0U)
    {
        handle->stepDelayMs = 1U;
    }

    /* STEP 5: Start from a known phase with the coils off and the position zeroed. */
    handle->phaseIndex = 0U;
    handle->position   = 0;
    handle->energized  = 0U;
    Stepper_ApplyPattern(handle, 0x00U);

    /* STEP 6: Mark the handle usable. */
    handle->initialized = 1U;

    return E_OK;
}


Std_ReturnType Stepper_L298P_SetStepMode(Stepper_L298P_HandleType *handle,
                                          Stepper_L298P_ModeType mode)
{
    /* STEP 1: Validate the handle and the mode. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    if (mode > STEPPER_L298P_MODE_HALF)
    {
        return E_NOK;
    }

    /*
     * STEP 2: Store the mode and restart the sequence.
     */
    handle->stepMode   = mode;
    handle->phaseIndex = 0U;

    return E_OK;
}


Std_ReturnType Stepper_L298P_SetStepDelay(Stepper_L298P_HandleType *handle,
                                           uint16_t stepDelayMs)
{
    /* STEP 1: Validate the handle. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    /* STEP 2: Clamp to 1 ms */
    handle->stepDelayMs = (stepDelayMs == 0U) ? 1U : stepDelayMs;

    return E_OK;
}


Std_ReturnType Stepper_L298P_SetSpeedRpm(Stepper_L298P_HandleType *handle, uint16_t rpm)
{
    uint32_t local_StepsPerRev = 0UL;
    uint32_t local_DelayMs     = 0UL;

    /* STEP 1: Validate the handle and reject a zero speed. */
    if ((handle == NULL) || (handle->initialized == 0U) || (rpm == 0U))
    {
        return E_NOK;
    }

    /* STEP 2: Half-stepping doubles the number of steps in one revolution. */
    local_StepsPerRev = (uint32_t)handle->stepsPerRev;

    if (handle->stepMode == STEPPER_L298P_MODE_HALF)
    {
        local_StepsPerRev *= 2UL;
    }

    /*
     * STEP 3: Calculate delay per step in ms: delay = 60000 / (stepsPerRev * rpm)
     */
    local_DelayMs = 60000UL / (local_StepsPerRev * (uint32_t)rpm);

    if (local_DelayMs == 0UL)
    {
        return E_NOK;
    }

    handle->stepDelayMs = (uint16_t)local_DelayMs;

    return E_OK;
}


Std_ReturnType Stepper_L298P_Step(Stepper_L298P_HandleType *handle,
                                  uint16_t steps, Stepper_L298P_DirType dir)
{
    uint16_t local_Step = 0U;

    /* STEP 1: Validate the handle and the direction. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    if (dir > STEPPER_L298P_DIR_CCW)
    {
        return E_NOK;
    }

    /* STEP 2: Take one step, wait the step delay, repeat. */
    for (local_Step = 0U; local_Step < steps; local_Step++)
    {
        (void)Stepper_L298P_StepOnce(handle, dir);
        Stepper_DelayMs(handle->stepDelayMs);
    }

    return E_OK;
}


Std_ReturnType Stepper_L298P_StepOnce(Stepper_L298P_HandleType *handle,
                                      Stepper_L298P_DirType dir)
{
    uint8_t local_Length = 0U;

    /* STEP 1: Validate the handle and the direction. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    if (dir > STEPPER_L298P_DIR_CCW)
    {
        return E_NOK;
    }

    local_Length = Stepper_TableLength(handle->stepMode);

    /*
     * STEP 2: Move one entry along the excitation table.
     */
    if (dir == STEPPER_L298P_DIR_CW)
    {
        handle->phaseIndex = (uint8_t)((handle->phaseIndex + 1U) % local_Length);
        handle->position++;
    }
    else
    {
        handle->phaseIndex = (uint8_t)((handle->phaseIndex + local_Length - 1U) % local_Length);
        handle->position--;
    }

    /* STEP 3: Energize the coils for the new phase. */
    Stepper_ApplyPattern(handle, Stepper_TableEntry(handle->stepMode, handle->phaseIndex));

    return E_OK;
}


Std_ReturnType Stepper_L298P_RotateAngle(Stepper_L298P_HandleType *handle,
                                          uint16_t degrees, Stepper_L298P_DirType dir)
{
    uint32_t local_StepsPerRev = 0UL;
    uint32_t local_Steps       = 0UL;

    /* STEP 1: Validate the handle. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    /* STEP 2: Half-stepping doubles the steps in one revolution. */
    local_StepsPerRev = (uint32_t)handle->stepsPerRev;

    if (handle->stepMode == STEPPER_L298P_MODE_HALF)
    {
        local_StepsPerRev *= 2UL;
    }

    /* STEP 3: Calculate required steps */
    local_Steps = ((uint32_t)degrees * local_StepsPerRev) / 360UL;

    /* STEP 4: Hand the step count to the blocking stepper. */
    return Stepper_L298P_Step(handle, (uint16_t)local_Steps, dir);
}


Std_ReturnType Stepper_L298P_Hold(Stepper_L298P_HandleType *handle)
{
    /* STEP 1: Validate the handle. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    /* STEP 2: If the driver owns the enables, switch the bridge back on. */
    if (handle->useEnablePins != 0U)
    {
        (void)GPIO_set_pin_value(handle->enAPort, handle->enAPin, GPIO_HIGH);
        (void)GPIO_set_pin_value(handle->enBPort, handle->enBPin, GPIO_HIGH);
    }

    /* STEP 3: Re-apply the current phase. */
    Stepper_ApplyPattern(handle, Stepper_TableEntry(handle->stepMode, handle->phaseIndex));

    return E_OK;
}


Std_ReturnType Stepper_L298P_Release(Stepper_L298P_HandleType *handle)
{
    /* STEP 1: Validate the handle. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    /* STEP 2: Drop all four inputs so no coil is driven. */
    Stepper_ApplyPattern(handle, 0x00U);

    /* STEP 3: Disable ENABLE pins if used. */
    if (handle->useEnablePins != 0U)
    {
        (void)GPIO_set_pin_value(handle->enAPort, handle->enAPin, GPIO_LOW);
        (void)GPIO_set_pin_value(handle->enBPort, handle->enBPin, GPIO_LOW);
    }

    handle->energized = 0U;

    return E_OK;
}


Std_ReturnType Stepper_L298P_GetPosition(const Stepper_L298P_HandleType *handle,
                                          sint32 *pPosition)
{
    /* STEP 1: Validate the handle and output pointer. */
    if ((handle == NULL) || (handle->initialized == 0U) || (pPosition == NULL))
    {
        return E_NOK;
    }

    /* STEP 2: Hand back net step count. */
    *pPosition = handle->position;

    return E_OK;
}


Std_ReturnType Stepper_L298P_ResetPosition(Stepper_L298P_HandleType *handle)
{
    /* STEP 1: Validate the handle. */
    if ((handle == NULL) || (handle->initialized == 0U))
    {
        return E_NOK;
    }

    handle->position = 0;

    return E_OK;
}


Std_ReturnType Stepper_L298P_GetStepsPerRev(const Stepper_L298P_HandleType *handle,
                                            uint16_t *pStepsPerRev)
{
    /* STEP 1: Validate the handle and output pointer. */
    if ((handle == NULL) || (handle->initialized == 0U) || (pStepsPerRev == NULL))
    {
        return E_NOK;
    }

    /* STEP 2: Report steps per revolution based on current mode. */
    if (handle->stepMode == STEPPER_L298P_MODE_HALF)
    {
        *pStepsPerRev = (uint16_t)(handle->stepsPerRev * 2U);
    }
    else
    {
        *pStepsPerRev = handle->stepsPerRev;
    }

    return E_OK;
}