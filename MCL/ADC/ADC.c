#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "ADC_Registers.h"
#include "ADC_Interfaces.h"

/*
 * Initializes the ADC peripheral: selects the voltage reference, selects the
 * clock prescaler, and enables the module.
 */
Std_ReturnType ADC_Init(const ADC_ConfigType *addConfig)
{
    /* Step 1: Declare local_Status */
    Std_ReturnType local_Status = E_OK;

    /* Step 2: Check if addConfig is NULL */
    if (addConfig == NULL)
    {
        local_Status = E_NOK;
    }
    else
    {
        /* Step 3: Configure reference voltage using switch-case */
        switch (addConfig->uint8ReferenceVoltage)
        {
            case ADC_REF_AREF:
                CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_REFS0);
                CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_REFS1);
                break;

            case ADC_REF_AVCC:
                SET_BIT(ADC_ADMUX_REG, ADC_ADMUX_REFS0);
                CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_REFS1);
                break;

            case ADC_REF_INTERNAL_2_56V:
                SET_BIT(ADC_ADMUX_REG, ADC_ADMUX_REFS0);
                SET_BIT(ADC_ADMUX_REG, ADC_ADMUX_REFS1);
                break;

            default:
                local_Status = E_NOK;
                break;
        }

        /* Continue configuration only if the reference voltage is valid */
        if (local_Status == E_OK)
        {
            /* Step 4: Make sure result is right-adjusted */
            CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_ADLAR);

            /* Step 5: Select default input channel (channel 0) */
            CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX0);
            CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX1);
            CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX2);
            CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX3);
            CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX4);

            /* Step 6: Configure clock prescaler (ADPS2:ADPS0) */
            CLR_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADPS0);
            CLR_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADPS1);
            CLR_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADPS2);

            if (GET_BIT(addConfig->uint8Prescaler, 0) == 1)
            {
                SET_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADPS0);
            }
            if (GET_BIT(addConfig->uint8Prescaler, 1) == 1)
            {
                SET_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADPS1);
            }
            if (GET_BIT(addConfig->uint8Prescaler, 2) == 1)
            {
                SET_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADPS2);
            }

            /* Step 7: Enable the ADC module */
            SET_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADEN);
        }
    }

    /* Step 8: Return local_Status */
    return local_Status;
}

/*
 * Disables the ADC peripheral (powers it down / stops conversions).
 */
Std_ReturnType ADC_DeInit(void)
{
    /* Step 1: Disable ADC */
    CLR_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADEN);

    /* Step 2: Return E_OK */
    return E_OK;
}

/*
 * Selects the given channel and starts a single conversion (non-blocking).
 */
Std_ReturnType ADC_StartConversion(uint8_t uint8Channel)
{
    /* Step 1: Declare local_Status */
    Std_ReturnType local_Status = E_OK;

    /* Step 2: Validate uint8Channel */
    if (uint8Channel >= ADC_NUMBER_OF_CHANNELS)
    {
        local_Status = E_NOK;
    }
    else
    {
        /* Step 3: Select the channel (MUX4:MUX0) */
        CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX0);
        CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX1);
        CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX2);
        CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX3);
        CLR_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX4);

        if (GET_BIT(uint8Channel, 0) == 1)
        {
            SET_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX0);
        }
        if (GET_BIT(uint8Channel, 1) == 1)
        {
            SET_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX1);
        }
        if (GET_BIT(uint8Channel, 2) == 1)
        {
            SET_BIT(ADC_ADMUX_REG, ADC_ADMUX_MUX2);
        }

        /* Step 4: Start Conversion */
        SET_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADSC);
    }

    /* Step 5: Return local_Status */
    return local_Status;
}

/*
 * Reports whether the ADC has finished the conversion that was last started.
 */
uint8_t ADC_IsConversionComplete(void)
{
    /* Step 1 & 2: Read ADSC bit (Hardware clears it when done) */
    if (GET_BIT(ADC_ADCSRA_REG, ADC_ADCSRA_ADSC) == 0)
    {
        return ADC_CONVERSION_DONE;
    }
    else
    {
        return ADC_CONVERSION_BUSY;
    }
}

/*
 * Reads the 10-bit result of the last completed conversion.
 */
Std_ReturnType ADC_ReadResult(uint16_t *puint16Result)
{
    /* Step 1: Check NULL pointer */
    if (puint16Result == NULL)
    {
        return E_NOK;
    }

    /* Step 2: Read ADCL first */
    uint8_t local_u8LowByte = ADC_ADCL_REG;

    /* Step 3: Read ADCH second */
    uint8_t local_u8HighByte = ADC_ADCH_REG;

    /* Step 4: Combine into 10-bit value */
    *puint16Result = (uint16_t)((local_u8HighByte << 8) | local_u8LowByte);

    /* Step 5: Return E_OK */
    return E_OK;
}

/*
 * Blocking read: starts a conversion on the given channel, busy-waits until it
 * finishes, then returns the result.
 */
Std_ReturnType ADC_ReadChannelBlocking(uint8_t uint8Channel, uint16_t *puint16Result)
{
    /* Step 1: Start conversion */
    Std_ReturnType local_Status = ADC_StartConversion(uint8Channel);

    /* Step 2: Busy wait if StartConversion succeeded */
    if (local_Status == E_OK)
    {
        while (ADC_IsConversionComplete() == ADC_CONVERSION_BUSY)
        {
            /* Busy-wait */
        }

        /* Step 3: Read the result */
        local_Status = ADC_ReadResult(puint16Result);
    }

    /* Step 4: Return local_Status */
    return local_Status;
}