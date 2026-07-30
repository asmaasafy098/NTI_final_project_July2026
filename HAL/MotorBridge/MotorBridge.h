#ifndef MotorBridge_H
#define MotorBridge_H
#include "../../Service/STD_Types.h"
<<<<<<< HEAD
#include "../../MCL/timer/timer_interface.h"
#include "../../Logic/Data/data_types.h"
Std_ReturnType BRIDGE_Init(void);
Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir); 
=======
#include "../../Logic/Data/data_types.h"   
#include "../../MCL/Timer/timer_interface.h"

Std_ReturnType BRIDGE_Init(void);
Std_ReturnType BRIDGE_SetDirection(MotorDir_t dir);
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
Std_ReturnType BRIDGE_SetDuty(uint16_t duty_percent);
Std_ReturnType BRIDGE_Enable(void);
Std_ReturnType BRIDGE_Disable(void);
void BRIDGE_ForceStop(void);

#endif