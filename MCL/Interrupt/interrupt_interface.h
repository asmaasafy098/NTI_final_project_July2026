#ifndef INTERRUPT_INTERFACE_H
#define INTERRUPT_INTERFACE_H

/* حل مشكلة IntelliSense للـ Editor */
#if defined(__has_include)
    #if __has_include(<avr/interrupt.h>)
        #include <avr/interrupt.h>
    #endif
#else
    #include <avr/interrupt.h>
#endif

#include "../../Service/STD_Types.h"
#include "interrupt_registers.h"

/* ================================================================================
 *  EXTERNAL INTERRUPT (EXTI) DRIVER - PUBLIC INTERFACE (ATmega32)
 * ============================================================================== */

/* ---------------- Interrupt Lines ---------------- */
typedef enum
{
    EXTI_INT0 = 0,
    EXTI_INT1 = 1,
    EXTI_INT2 = 2,
    EXTI_LINE_MAX
} EXTI_LineType;

/* ---------------- Sense (Trigger) Control ---------------- */
typedef enum
{
    EXTI_SENSE_LOW_LEVEL  = 0,
    EXTI_SENSE_ANY_CHANGE = 1,
    EXTI_SENSE_FALLING    = 2,
    EXTI_SENSE_RISING     = 3
} EXTI_SenseType;

/* ---------------- Configuration Structure ---------------- */
typedef struct
{
    EXTI_LineType  line;
    EXTI_SenseType sense;
} EXTI_ConfigType;

/* ---------------- Callback Pointer Type ---------------- */
typedef void (*EXTI_CallBackType)(void);

/* ================================================================================
 *  FUNCTION PROTOTYPES
 * ============================================================================== */

Std_ReturnType EXTI_Init(const EXTI_ConfigType *addConfig);
Std_ReturnType EXTI_Enable(EXTI_LineType line);
Std_ReturnType EXTI_Disable(EXTI_LineType line);
Std_ReturnType EXTI_SetSenseControl(EXTI_LineType line, EXTI_SenseType sense);
Std_ReturnType EXTI_SetCallBack(EXTI_LineType line, EXTI_CallBackType callBack);
void EXTI_EnableGlobalInterrupt(void);
void EXTI_DisableGlobalInterrupt(void);

#endif /* INTERRUPT_INTERFACE_H */