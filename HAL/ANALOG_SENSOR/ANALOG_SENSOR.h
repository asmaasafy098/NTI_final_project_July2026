#ifndef ANALOG_SENSOR_H
#define ANALOG_SENSOR_H

#include <stdint.h>
#include "../../Service/STD_Types.h"  /* تم إضافة التضمين لحل خطأ Std_ReturnType */

/* Logical ADC channel indices */
typedef enum
{
    ANALOG_CH_SETPOINT = 0,
    ANALOG_CH_CURRENT,
    ANALOG_CH_BUS_VOLTAGE,
    ANALOG_CH_TEMPERATURE,
    ANALOG_CH_COUNT
} AnalogChannel_t;

/* Function Prototypes */
Std_ReturnType ANALOG_Init(void);
uint16_t ANALOG_GetSetpoint(void);
uint16_t ANALOG_GetCurrent(void);
uint16_t ANALOG_GetBusVoltage(void);
uint8_t  ANALOG_GetTemperature(void);

#endif /* ANALOG_SENSOR_H */