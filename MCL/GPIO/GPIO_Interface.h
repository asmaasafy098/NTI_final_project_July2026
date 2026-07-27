#ifndef GPIO_INTERFACE_H
#define GPIO_INTERFACE_H

#include "../Service/STD_Types.h"
#include "GPIO_Registers.h"

/* Macros Definitions */
#define GPIO_INPUT       0
#define GPIO_OUTPUT      1

#define GPIO_LOW         0
#define GPIO_HIGH        1

#define GPIO_PORTA       0
#define GPIO_PORTB       1
#define GPIO_PORTC       2
#define GPIO_PORTD       3

#define GPIO_PIN0        0
#define GPIO_PIN1        1
#define GPIO_PIN2        2
#define GPIO_PIN3        3
#define GPIO_PIN4        4
#define GPIO_PIN5        5
#define GPIO_PIN6        6
#define GPIO_PIN7        7

/* Function Prototypes */
Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction);
Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction);
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port);
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin);
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value);
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value);

#endif /* GPIO_INTERFACE_H */