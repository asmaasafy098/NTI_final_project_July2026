#include "AnalogSensor.h"

static uint16_t rawCounts[ANALOG_CH_COUNT];

/* --- Calibration constants: replace with real values for your board --- */
#define ADC_VREF_MV        3300U   /* reference voltage, millivolts */
#define ADC_MAX_COUNTS     4095U   /* 12-bit ADC full scale */

/* Hook 1: low-level ADC init (clocks, pin config, resolution, etc.) */
static void ANALOG_HW_Init(void)
{
    /* TODO: platform-specific ADC peripheral init */
}

/* Hook 2: perform (or trigger + wait for) one conversion on a channel,
 * return the raw ADC count. */
static uint16_t ANALOG_HW_ReadRaw(AnalogChannel_t channel)
{
    (void)channel;
    /* TODO: platform-specific single-channel conversion */
    return 0;
}

void ANALOG_Init(void)
{
    uint8_t i;

    ANALOG_HW_Init();

    for (i = 0; i < ANALOG_CH_COUNT; i++)
    {
        rawCounts[i] = 0;
    }
}

/* Call this periodically (e.g. from a timer tick or main loop) to
 * refresh all cached channel readings. */
void ANALOG_Update(void)
{
    uint8_t i;

    for (i = 0; i < ANALOG_CH_COUNT; i++)
    {
        rawCounts[i] = ANALOG_HW_ReadRaw((AnalogChannel_t)i);
    }
}

uint16_t ANALOG_GetSetpoint(void)
{
    return rawCounts[ANALOG_CH_SETPOINT];
}

uint16_t ANALOG_GetCurrent(void)
{
    return rawCounts[ANALOG_CH_CURRENT];
}

uint16_t ANALOG_GetBusVoltage(void)
{
    /* Example scaling to millivolts assuming a resistive divider;
     * adjust the divider ratio for your actual board. */
    return (uint16_t)(((uint32_t)rawCounts[ANALOG_CH_BUS_VOLTAGE] * ADC_VREF_MV) / ADC_MAX_COUNTS);
}

uint8_t ANALOG_GetTemperature(void)
{
    /* TODO: apply your sensor's actual counts->degrees conversion
     * (e.g. NTC lookup table or linear sensor formula). Placeholder
     * clamps to a uint8_t-safe range. */
    uint16_t raw = rawCounts[ANALOG_CH_TEMPERATURE];
    return (uint8_t)(raw > 255U ? 255U : raw);
}