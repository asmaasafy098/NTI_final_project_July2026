#ifndef GPIO_Interface_H
#define GPIO_Interface_H

#include "../../Service/STD_Types.h"

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

#define GPIO_NUMBER_OF_PORTS    4
#define GPIO_NUMBER_OF_PINS     8

typedef unsigned char GPIO_pin_status;
typedef unsigned char GPIO_port_status;

/* Function Prototypes */
/*------------------------------ pin configuration ------------------------------------*/
Std_ReturnType GPIO_set_pin_Direction(uint8_t port, uint8_t pin, uint8_t direction);
Std_ReturnType GPIO_set_pin_value(uint8_t port, uint8_t pin, uint8_t value);
Std_ReturnType GPIO_write_pin(uint8_t port, uint8_t pin, uint8_t value);
GPIO_pin_status GPIO_read_pin(uint8_t port, uint8_t pin);
Std_ReturnType GPIO_toggle_pin(uint8_t port, uint8_t pin);
#define GPIO_ENABLE    1
#define GPIO_DISABLE   0
#endif
/* GPIO_INTERFACE_H */