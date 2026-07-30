#ifndef STEPPER_L298P_H
#define STEPPER_L298P_H

#include "../../Service/STD_Types.h"
#include "../../MCL/GPIO/GPIO_Interface.h"

/* ==================== Enums ==================== */
typedef enum {
    STEPPER_L298P_MODE_WAVE = 0,
    STEPPER_L298P_MODE_FULL = 1,
    STEPPER_L298P_MODE_HALF = 2
} Stepper_L298P_ModeType;

typedef enum {
    STEPPER_L298P_DIR_CW  = 0,
    STEPPER_L298P_DIR_CCW = 1
} Stepper_L298P_DirType;

/* ==================== Handle ==================== */
typedef struct {
    /* Configuration */
    uint8_t in1Port;  uint8_t in1Pin;
    uint8_t in2Port;  uint8_t in2Pin;
    uint8_t in3Port;  uint8_t in3Pin;
    uint8_t in4Port;  uint8_t in4Pin;
    uint8_t enAPort;  uint8_t enAPin;
    uint8_t enBPort;  uint8_t enBPin;
    uint8_t useEnablePins;
    
    Stepper_L298P_ModeType stepMode;
    uint16_t stepsPerRev;
    uint16_t stepDelayMs;
    
    /* Runtime */
    uint8_t  initialized;
    uint8_t  phaseIndex;
    uint8_t  energized;
    sint32   position;
} Stepper_L298P_HandleType;

/* ==================== Functions ==================== */

Std_ReturnType Stepper_L298P_Init(Stepper_L298P_HandleType *handle);
Std_ReturnType Stepper_L298P_SetStepMode(Stepper_L298P_HandleType *handle,
                                         Stepper_L298P_ModeType mode);
Std_ReturnType Stepper_L298P_SetStepDelay(Stepper_L298P_HandleType *handle,
                                          uint16_t stepDelayMs);
Std_ReturnType Stepper_L298P_SetSpeedRpm(Stepper_L298P_HandleType *handle, uint16_t rpm);

/* Blocking functions */
Std_ReturnType Stepper_L298P_Step(Stepper_L298P_HandleType *handle,
                                  uint16_t steps, Stepper_L298P_DirType dir);
Std_ReturnType Stepper_L298P_RotateAngle(Stepper_L298P_HandleType *handle,
                                         uint16_t degrees, Stepper_L298P_DirType dir);

/* Non-blocking functions (NEW) */
Std_ReturnType Stepper_L298P_StepOnce(Stepper_L298P_HandleType *handle,
                                      Stepper_L298P_DirType dir);
Std_ReturnType Stepper_L298P_StepNonBlocking(Stepper_L298P_HandleType *handle,
                                              uint16_t steps, Stepper_L298P_DirType dir);
void Stepper_L298P_Tick(void);  /* Must be called from scheduler (1ms) */

/* Hold/Release */
Std_ReturnType Stepper_L298P_Hold(Stepper_L298P_HandleType *handle);
Std_ReturnType Stepper_L298P_Release(Stepper_L298P_HandleType *handle);

/* Position */
Std_ReturnType Stepper_L298P_GetPosition(const Stepper_L298P_HandleType *handle,
                                         sint32 *pPosition);
Std_ReturnType Stepper_L298P_ResetPosition(Stepper_L298P_HandleType *handle);
Std_ReturnType Stepper_L298P_GetStepsPerRev(const Stepper_L298P_HandleType *handle,
                                            uint16_t *pStepsPerRev);

#endif /* STEPPER_L298P_H */