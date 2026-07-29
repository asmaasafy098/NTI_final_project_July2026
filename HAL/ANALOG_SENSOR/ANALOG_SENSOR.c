#include "../../Service/STD_Types.h"
#include "../../MCL/ADC/ADC_Interfaces.h"  /* استخدام MCL وإضافة حرف s لـ Interfaces */
#include "ANALOG_SENSOR.h"

Std_ReturnType ANALOG_Init(void)
{
    ADC_ConfigType cfg = {0}; 
    return ADC_Init(&cfg);
}

uint16_t ANALOG_GetSetpoint(void)   /* channel 0 -> 0..3000 RPM */
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_SETPOINT, &raw);
    return (uint16_t)(((uint32_t)raw * 3000UL) / 1023UL);
}

uint16_t ANALOG_GetCurrent(void)    /* channel 1 -> 0..20000 mA */
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_CURRENT, &raw);
    return (uint16_t)(((uint32_t)raw * 20000UL) / 1023UL);
}

uint16_t ANALOG_GetBusVoltage(void) /* channel 2 -> 0..60000 mV */
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_BUS_VOLTAGE, &raw);
    return (uint16_t)(((uint32_t)raw * 60000UL) / 1023UL);
}

uint8_t ANALOG_GetTemperature(void) /* channel 3 -> 0..150 C */
{
    uint16_t raw = 0;
    (void)ADC_ReadChannelBlocking(ANALOG_CH_TEMPERATURE, &raw);
    return (uint8_t)(((uint32_t)raw * 150UL) / 1023UL);
}