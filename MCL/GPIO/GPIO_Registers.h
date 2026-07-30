#ifndef GPIO_Registers_H
#define GPIO_Registers_H

#include "../../Service/STD_Types.h"

#define GPIO_NUMBER_OF_PORTS    4
#define GPIO_NUMBER_OF_PINS     8

/* PORT A Registers */
#define GPIO_PINA        (*(volatile uint8_t *)0x39)
#define GPIO_DDRA        (*(volatile uint8_t *)0x3A)
#define GPIO_PORTA_REG   (*(volatile uint8_t *)0x3B)

/* PORT B Registers */
#define GPIO_PINB        (*(volatile uint8_t *)0x36)
#define GPIO_DDRB        (*(volatile uint8_t *)0x37)
#define GPIO_PORTB_REG   (*(volatile uint8_t *)0x38)

/* PORT C Registers */
#define GPIO_PINC        (*(volatile uint8_t *)0x33)
#define GPIO_DDRC        (*(volatile uint8_t *)0x34)
#define GPIO_PORTC_REG   (*(volatile uint8_t *)0x35)

/* PORT D Registers */
#define GPIO_PIND        (*(volatile uint8_t *)0x30)
#define GPIO_DDRD        (*(volatile uint8_t *)0x31)
#define GPIO_PORTD_REG   (*(volatile uint8_t *)0x32)

#endif /* GPIO_REGISTERS_H */