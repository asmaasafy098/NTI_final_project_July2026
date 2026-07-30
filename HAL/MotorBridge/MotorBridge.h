#ifndef MotorBridge_H
#define MotorBridge_H

#include "../../Service/STD_Types.h"
#include "../../MCL/timer/timer_interface.h"
#include "../../Logic/Data/data_types.h"

/* ==================== Defines ==================== */
#ifndef PWM_TOP_VALUE
#define PWM_TOP_VALUE     399U
#endif

#ifndef PWM_MIN_RUN_PCT
#define PWM_MIN_RUN_PCT   10U
#endif

/* ==================== Functions ==================== */
Std_ReturnType BRIDGE_Init(void);
Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir);
Std_ReturnType BRIDGE_SetDuty(uint16_t duty_percent);
Std_ReturnType BRIDGE_Enable(void);
Std_ReturnType BRIDGE_Disable(void);
void BRIDGE_ForceStop(void);
uint8_t BRIDGE_IsEnabled(void);

#endif