#ifndef MotorBridge_H
#define MotorBridge_H

#include "../../Service/STD_Types.h"
Std_ReturnType BRIDGE_Init(void);
Std_ReturnType BRIDGE_SetDirection(Dir_t dir);
Std_ReturnType BRIDGE_SetDuty(uint16_t duty_percent);
Std_ReturnType BRIDGE_Enable(void);
Std_ReturnType BRIDGE_Disable(void);
void BRIDGE_ForceStop(void);
#endif