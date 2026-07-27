#include "../Service/STD_Types.h"
#include "../Service/Bit_Math.h"
#include "../GPIO/GPIO_Interface.h"

int main(void)
{
    uint8_t btn1_state = 0;
    uint8_t btn2_state = 0;

    GPIO_set_pin_Direction(GPIO_PORTA, GPIO_PIN3, GPIO_OUTPUT); // LED 1 (PA3)
    GPIO_set_pin_Direction(GPIO_PORTB, GPIO_PIN3, GPIO_OUTPUT); // LED 2 (PB3)

    /* Push Buttons كـ Input */
    GPIO_set_pin_Direction(GPIO_PORTC, GPIO_PIN3, GPIO_INPUT);  // Button 1 (PC3)
    GPIO_set_pin_Direction(GPIO_PORTD, GPIO_PIN3, GPIO_INPUT);  // Button 2 (PD3)

    while (1)
    {
       
        btn1_state = GPIO_get_pin_status(GPIO_PORTC, GPIO_PIN3);
        btn2_state = GPIO_get_pin_status(GPIO_PORTD, GPIO_PIN3);

        
        if (btn1_state == GPIO_HIGH)
        {
            GPIO_set_pin_value(GPIO_PORTA, GPIO_PIN3, GPIO_HIGH); 
        }
        else
        {
            GPIO_set_pin_value(GPIO_PORTA, GPIO_PIN3, GPIO_LOW);  
        }

      
        if (btn2_state == GPIO_LOW)
        {
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN3, GPIO_HIGH); 
        }
        else
        {
            GPIO_set_pin_value(GPIO_PORTB, GPIO_PIN3, GPIO_LOW);  
        }
    }

    return 0;
}