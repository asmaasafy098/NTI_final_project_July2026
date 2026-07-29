#ifndef ANALOG_SENSOR_H
#define ANALOG_SENSOR_H

#include <stdint.h>




/* Logical ADC channel indices - map these to your actual pin/channel
 * assignments in AnalogSensor.c */
typedef enum
{
    ANALOG_CH_SETPOINT = 0,
    ANALOG_CH_CURRENT,
    ANALOG_CH_BUS_VOLTAGE,
    ANALOG_CH_TEMPERATURE,
    ANALOG_CH_COUNT
} AnalogChannel_t;

void ANALOG_Init(void);
void ANALOG_Update(void); /* call periodically to refresh cached readings */

uint16_t ANALOG_GetSetpoint(void);
uint16_t ANALOG_GetCurrent(void);
uint16_t ANALOG_GetBusVoltage(void);
uint8_t ANALOG_GetTemperature(void);

#endif