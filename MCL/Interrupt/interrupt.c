#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include <avr/interrupt.h>
#include "interrupt_registers.h"
#include "interrupt_interface.h"

/* ================================================================================
 *  EXTERNAL INTERRUPT DRIVER - IMPLEMENTATION
 * ============================================================================== */

static EXTI_CallBackType EXTI_CallBacks[EXTI_LINE_MAX] = { NULL, NULL, NULL };

Std_ReturnType EXTI_Init(const EXTI_ConfigType *addConfig)
{
    Std_ReturnType local_Status = E_OK;

    /* STEP 1: Validate input */
    if ((addConfig == NULL) || (addConfig->line >= EXTI_LINE_MAX))
    {
        local_Status = E_NOK;
    }
    else
    {
        /* STEP 2: Program the sense control */
        local_Status = EXTI_SetSenseControl(addConfig->line, addConfig->sense);

        if (local_Status == E_OK)
        {
            /* STEP 3: Clear any stale pending flag */
            switch (addConfig->line)
            {
                case EXTI_INT0:
                    SET_BIT(EXTI_GIFR_REG, EXTI_INTF0_BIT);
                    break;
                case EXTI_INT1:
                    SET_BIT(EXTI_GIFR_REG, EXTI_INTF1_BIT);
                    break;
                case EXTI_INT2:
                    SET_BIT(EXTI_GIFR_REG, EXTI_INTF2_BIT);
                    break;
                default:
                    local_Status = E_NOK;
                    break;
            }

            if (local_Status == E_OK)
            {
                /* STEP 4: Enable the line */
                local_Status = EXTI_Enable(addConfig->line);
            }
        }
    }

    /* STEP 5: Return status */
    return local_Status;
}


Std_ReturnType EXTI_Enable(EXTI_LineType line)
{
    Std_ReturnType local_Status = E_OK;

    if (line >= EXTI_LINE_MAX)
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (line)
        {
            case EXTI_INT0:
                SET_BIT(EXTI_GICR_REG, EXTI_INT0_BIT);
                break;
            case EXTI_INT1:
                SET_BIT(EXTI_GICR_REG, EXTI_INT1_BIT);
                break;
            case EXTI_INT2:
                SET_BIT(EXTI_GICR_REG, EXTI_INT2_BIT);
                break;
            default:
                local_Status = E_NOK;
                break;
        }
    }

    return local_Status;
}


Std_ReturnType EXTI_Disable(EXTI_LineType line)
{
  Std_ReturnType local_Status = E_OK;

    if (line >= EXTI_LINE_MAX)
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (line)
        {
            case EXTI_INT0:
                CLR_BIT(EXTI_GICR_REG, EXTI_INT0_BIT);
                break;
            case EXTI_INT1:
                CLR_BIT(EXTI_GICR_REG, EXTI_INT1_BIT);
                break;
            case EXTI_INT2:
                CLR_BIT(EXTI_GICR_REG, EXTI_INT2_BIT);
                break;
            default:
                local_Status = E_NOK;
                break;
        }
    }

    return local_Status;
}


Std_ReturnType EXTI_SetSenseControl(EXTI_LineType line, EXTI_SenseType sense)
{
    Std_ReturnType local_Status = E_OK;

    if (line >= EXTI_LINE_MAX)
    {
        return E_NOK;
    }

    switch (line)
    {
        case EXTI_INT0:
            CLR_BIT(EXTI_MCUCR_REG, EXTI_ISC00_BIT);
            CLR_BIT(EXTI_MCUCR_REG, EXTI_ISC01_BIT);
            switch (sense)
            {
                case EXTI_SENSE_LOW_LEVEL:  break; /* 00 */
                case EXTI_SENSE_ANY_CHANGE: SET_BIT(EXTI_MCUCR_REG, EXTI_ISC00_BIT); break; /* 01 */
                case EXTI_SENSE_FALLING:    SET_BIT(EXTI_MCUCR_REG, EXTI_ISC01_BIT); break; /* 10 */
                case EXTI_SENSE_RISING:
                    SET_BIT(EXTI_MCUCR_REG, EXTI_ISC00_BIT);
                    SET_BIT(EXTI_MCUCR_REG, EXTI_ISC01_BIT);
                    break; /* 11 */
                default:
                    local_Status = E_NOK;
                    break;
            }
            break;

        case EXTI_INT1:
            CLR_BIT(EXTI_MCUCR_REG, EXTI_ISC10_BIT);
            CLR_BIT(EXTI_MCUCR_REG, EXTI_ISC11_BIT);
            switch (sense)
            {
                case EXTI_SENSE_LOW_LEVEL:  break; /* 00 */
                case EXTI_SENSE_ANY_CHANGE: SET_BIT(EXTI_MCUCR_REG, EXTI_ISC10_BIT); break; /* 01 */
                case EXTI_SENSE_FALLING:    SET_BIT(EXTI_MCUCR_REG, EXTI_ISC11_BIT); break; /* 10 */
                case EXTI_SENSE_RISING:
                    SET_BIT(EXTI_MCUCR_REG, EXTI_ISC10_BIT);
                    SET_BIT(EXTI_MCUCR_REG, EXTI_ISC11_BIT);
                    break; /* 11 */
                default:
                    local_Status = E_NOK;
                    break;
            }
            break;

        case EXTI_INT2:
            switch (sense)
            {
                case EXTI_SENSE_FALLING:
                    CLR_BIT(EXTI_MCUCSR_REG, EXTI_ISC2_BIT);
                    break;
                case EXTI_SENSE_RISING:
                    SET_BIT(EXTI_MCUCSR_REG, EXTI_ISC2_BIT);
                    break;
                case EXTI_SENSE_LOW_LEVEL:
                case EXTI_SENSE_ANY_CHANGE:
                default:
                    local_Status = E_NOK; /* not supported on INT2 */
                    break;
            }
            break;

        default:
            local_Status = E_NOK;
            break;
    }

    return local_Status;
}


Std_ReturnType EXTI_SetCallBack(EXTI_LineType line, EXTI_CallBackType callBack)
{
    Std_ReturnType local_Status = E_OK;

    if ((line >= EXTI_LINE_MAX) || (callBack == NULL))
    {
        local_Status = E_NOK;
    }
    else
    {
        EXTI_CallBacks[line] = callBack;
    }

    return local_Status;
}


void EXTI_EnableGlobalInterrupt(void)
{
    SET_BIT(EXTI_SREG_REG, EXTI_GLOBAL_INT_BIT);
}


void EXTI_DisableGlobalInterrupt(void)
{
    CLR_BIT(EXTI_SREG_REG, EXTI_GLOBAL_INT_BIT);
}
