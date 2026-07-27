#ifndef ADC_INTERFACE_H
#define ADC_INTERFACE_H

/* ---------------- Included Headers ---------------- */
#include "../../Service/STD_Types.h"
#include "ADC_Registers.h"

/* ---------------- Voltage Reference Options (REFS1:REFS0) ---------------- */
#define ADC_REF_AREF               0   /* External AREF pin, internal Vref turned off        */
#define ADC_REF_AVCC               1   /* AVCC with external capacitor on AREF pin           */
#define ADC_REF_INTERNAL_2_56V     3   /* Internal 2.56V reference, capacitor on AREF pin    */

/* ---------------- Clock Prescaler Options (ADPS2:ADPS0) ---------------- */
#define ADC_PRESCALER_2            1
#define ADC_PRESCALER_4            2
#define ADC_PRESCALER_8            3
#define ADC_PRESCALER_16           4
#define ADC_PRESCALER_32           5
#define ADC_PRESCALER_64           6
#define ADC_PRESCALER_128          7

/* ---------------- Input Channels ---------------- */
#define ADC_CHANNEL0               0
#define ADC_CHANNEL1               1
#define ADC_CHANNEL2               2
#define ADC_CHANNEL3               3
#define ADC_CHANNEL4               4
#define ADC_CHANNEL5               5
#define ADC_CHANNEL6               6
#define ADC_CHANNEL7               7

/* ---------------- Conversion status ---------------- */
#define ADC_CONVERSION_BUSY        0
#define ADC_CONVERSION_DONE        1

/**
 * @brief Configuration used to initialize the ADC peripheral.
 */
typedef struct
{
    uint8_t uint8ReferenceVoltage;   /* One of ADC_REF_x         */
    uint8_t uint8Prescaler;          /* One of ADC_PRESCALER_x   */
} ADC_ConfigType;

/**
 * @brief Initializes the ADC peripheral with the given reference voltage
 *        and clock prescaler, then enables it.
 * @param addConfig Pointer to the desired configuration.
 * @return Std_ReturnType E_OK/E_NOK
 */
Std_ReturnType ADC_Init(const ADC_ConfigType *addConfig);

/**
 * @brief Disables the ADC peripheral.
 * @return Std_ReturnType E_OK/E_NOK
 */
Std_ReturnType ADC_DeInit(void);

/**
 * @brief Selects the given channel and starts a single conversion.
 *        Does not wait for the conversion to finish.
 * @param uint8Channel ADC_CHANNEL0 .. ADC_CHANNEL7
 * @return Std_ReturnType E_OK/E_NOK
 */
Std_ReturnType ADC_StartConversion(uint8_t uint8Channel);

/**
 * @brief Checks whether the previously started conversion has finished.
 * @return uint8_t ADC_CONVERSION_DONE / ADC_CONVERSION_BUSY
 */
uint8_t ADC_IsConversionComplete(void);

/**
 * @brief Reads the result of the last completed conversion.
 * @param puint16Result Pointer to store the 10-bit result (0-1023).
 * @return Std_ReturnType E_OK/E_NOK
 */
Std_ReturnType ADC_ReadResult(uint16_t *puint16Result);

/**
 * @brief Blocking read: starts a conversion on the given channel, waits
 *        until it finishes, then returns the result.
 * @param uint8Channel  ADC_CHANNEL0 .. ADC_CHANNEL7
 * @param puint16Result Pointer to store the 10-bit result (0-1023).
 * @return Std_ReturnType E_OK/E_NOK
 */
Std_ReturnType ADC_ReadChannelBlocking(uint8_t uint8Channel, uint16_t *puint16Result);

#endif /* ADC_INTERFACE_H */