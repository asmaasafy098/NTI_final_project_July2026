#ifndef ADC_REGISTERS_H
#define ADC_REGISTERS_H

#include "../../Service/STD_Types.h"

#define ADC_NUMBER_OF_CHANNELS    8

/* ---------------- Registers (Memory-Mapped Addresses) ---------------- */
#define ADC_ADMUX_REG        (*(volatile uint8_t  *)0x27)
#define ADC_ADCSRA_REG       (*(volatile uint8_t  *)0x26)
#define ADC_ADCH_REG         (*(volatile uint8_t  *)0x25)
#define ADC_ADCL_REG         (*(volatile uint8_t  *)0x24)
#define ADC_ADCDATA_REG      (*(volatile uint16_t *)0x24)
#define ADC_SFIOR_REG        (*(volatile uint8_t  *)0x50)

/* ---------------- ADMUX Register Bits ---------------- */
#define ADC_ADMUX_MUX0       0
#define ADC_ADMUX_MUX1       1
#define ADC_ADMUX_MUX2       2
#define ADC_ADMUX_MUX3       3
#define ADC_ADMUX_MUX4       4
#define ADC_ADMUX_ADLAR      5
#define ADC_ADMUX_REFS0      6
#define ADC_ADMUX_REFS1      7

/* ---------------- ADCSRA Register Bits ---------------- */
#define ADC_ADCSRA_ADPS0     0
#define ADC_ADCSRA_ADPS1     1
#define ADC_ADCSRA_ADPS2     2
#define ADC_ADCSRA_ADIE      3
#define ADC_ADCSRA_ADIF      4
#define ADC_ADCSRA_ADATE     5
#define ADC_ADCSRA_ADSC      6
#define ADC_ADCSRA_ADEN      7

/* ---------------- SFIOR Register Bits ---------------- */
#define ADC_SFIOR_ADTS0      5
#define ADC_SFIOR_ADTS1      6
#define ADC_SFIOR_ADTS2      7

#endif /* ADC_REGISTERS_H */