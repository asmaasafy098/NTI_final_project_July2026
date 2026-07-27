#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "GPIO_Registers.h"
#include "GPIO_Interface.h"

/* 1. Set Pin Direction */
Std_ReturnType GPIO_set_pin_Direction(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_direction)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= GPIO_NUMBER_OF_PORTS) || (uint8_pin >= GPIO_NUMBER_OF_PINS))
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_direction)
        {
            case GPIO_INPUT:
                switch (uint8_port)
                {
                    case GPIO_PORTA: CLR_BIT(GPIO_DDRA, uint8_pin); break;
                    case GPIO_PORTB: CLR_BIT(GPIO_DDRB, uint8_pin); break;
                    case GPIO_PORTC: CLR_BIT(GPIO_DDRC, uint8_pin); break;
                    case GPIO_PORTD: CLR_BIT(GPIO_DDRD, uint8_pin); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            case GPIO_OUTPUT:
                switch (uint8_port)
                {
                    case GPIO_PORTA: SET_BIT(GPIO_DDRA, uint8_pin); break;
                    case GPIO_PORTB: SET_BIT(GPIO_DDRB, uint8_pin); break;
                    case GPIO_PORTC: SET_BIT(GPIO_DDRC, uint8_pin); break;
                    case GPIO_PORTD: SET_BIT(GPIO_DDRD, uint8_pin); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            default:
                local_Status = E_NOK;
                break;
        }
    }
    return local_Status;
}

/* 2. Set Pin Value */
Std_ReturnType GPIO_set_pin_value(uint8_t uint8_port, uint8_t uint8_pin, uint8_t uint8_value)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= GPIO_NUMBER_OF_PORTS) || (uint8_pin >= GPIO_NUMBER_OF_PINS))
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_value)
        {
            case GPIO_LOW:
                switch (uint8_port)
                {
                    case GPIO_PORTA: CLR_BIT(GPIO_PORTA_REG, uint8_pin); break;
                    case GPIO_PORTB: CLR_BIT(GPIO_PORTB_REG, uint8_pin); break;
                    case GPIO_PORTC: CLR_BIT(GPIO_PORTC_REG, uint8_pin); break;
                    case GPIO_PORTD: CLR_BIT(GPIO_PORTD_REG, uint8_pin); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            case GPIO_HIGH:
                switch (uint8_port)
                {
                    case GPIO_PORTA: SET_BIT(GPIO_PORTA_REG, uint8_pin); break;
                    case GPIO_PORTB: SET_BIT(GPIO_PORTB_REG, uint8_pin); break;
                    case GPIO_PORTC: SET_BIT(GPIO_PORTC_REG, uint8_pin); break;
                    case GPIO_PORTD: SET_BIT(GPIO_PORTD_REG, uint8_pin); break;
                    default: local_Status = E_NOK; break;
                }
                break;

            default:
                local_Status = E_NOK;
                break;
        }
    }
    return local_Status;
}

/* 3. Toggle Pin */
Std_ReturnType GPIO_pin_toggle(uint8_t uint8_port, uint8_t uint8_pin)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= GPIO_NUMBER_OF_PORTS) || (uint8_pin >= GPIO_NUMBER_OF_PINS))
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_port)
        {
            case GPIO_PORTA: TOG_BIT(GPIO_PORTA_REG, uint8_pin); break;
            case GPIO_PORTB: TOG_BIT(GPIO_PORTB_REG, uint8_pin); break;
            case GPIO_PORTC: TOG_BIT(GPIO_PORTC_REG, uint8_pin); break;
            case GPIO_PORTD: TOG_BIT(GPIO_PORTD_REG, uint8_pin); break;
            default: local_Status = E_NOK; break;
        }
    }
    return local_Status;
}

/* 4. Set Port Direction */
Std_ReturnType GPIO_set_port_Direction(uint8_t uint8_port, uint8_t uint8_direction)
{
    Std_ReturnType local_Status = E_OK;

    if (uint8_port >= GPIO_NUMBER_OF_PORTS)
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_port)
        {
            case GPIO_PORTA: GPIO_DDRA = uint8_direction; break;
            case GPIO_PORTB: GPIO_DDRB = uint8_direction; break;
            case GPIO_PORTC: GPIO_DDRC = uint8_direction; break;
            case GPIO_PORTD: GPIO_DDRD = uint8_direction; break;
            default: local_Status = E_NOK; break;
        }
    }
    return local_Status;
}

/* 5. Set Port Value */
Std_ReturnType GPIO_set_port_value(uint8_t uint8_port, uint8_t uint8_value)
{
    Std_ReturnType local_Status = E_OK;

    if (uint8_port >= GPIO_NUMBER_OF_PORTS)
    {
        local_Status = E_NOK;
    }
    else
    {
        switch (uint8_port)
        {
            case GPIO_PORTA: GPIO_PORTA_REG = uint8_value; break;
            case GPIO_PORTB: GPIO_PORTB_REG = uint8_value; break;
            case GPIO_PORTC: GPIO_PORTC_REG = uint8_value; break;
            case GPIO_PORTD: GPIO_PORTD_REG = uint8_value; break;
            default: local_Status = E_NOK; break;
        }
    }
    return local_Status;
}

/* 6. Get Pin Status */
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin)
{
    uint8_t pin_status = 0;

    if ((uint8_port < GPIO_NUMBER_OF_PORTS) && (uint8_pin < GPIO_NUMBER_OF_PINS))
    {
        switch (uint8_port)
        {
            case GPIO_PORTA: pin_status = GET_BIT(GPIO_PINA, uint8_pin); break;
            case GPIO_PORTB: pin_status = GET_BIT(GPIO_PINB, uint8_pin); break;
            case GPIO_PORTC: pin_status = GET_BIT(GPIO_PINC, uint8_pin); break;
            case GPIO_PORTD: pin_status = GET_BIT(GPIO_PIND, uint8_pin); break;
            default: break;
        }
    }
    return pin_status;
}

/* 7. Get Port Status */
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port)
{
    uint8_t port_status = 0;

    if (uint8_port < GPIO_NUMBER_OF_PORTS)
    {
        switch (uint8_port)
        {
            case GPIO_PORTA: port_status = GPIO_PINA; break;
            case GPIO_PORTB: port_status = GPIO_PINB; break;
            case GPIO_PORTC: port_status = GPIO_PINC; break;
            case GPIO_PORTD: port_status = GPIO_PIND; break;
            default: break;
        }
    }
    return port_status;
}