#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "GPIO_Registers.h"
#include "GPIO_Interface.h"

/* Register lookup tables marked as const to save RAM */
static volatile uint8_t * const GPIO_DDRx[GPIO_NUMBER_OF_PORTS] = {
    &GPIO_DDRA, &GPIO_DDRB, &GPIO_DDRC, &GPIO_DDRD
};

static volatile uint8_t * const GPIO_PORTx[GPIO_NUMBER_OF_PORTS] = {
    &GPIO_PORTA_REG, &GPIO_PORTB_REG, &GPIO_PORTC_REG, &GPIO_PORTD_REG
};

static volatile uint8_t * const GPIO_PINx[GPIO_NUMBER_OF_PORTS] = {
    &GPIO_PINA, &GPIO_PINB, &GPIO_PINC, &GPIO_PIND
};

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
                CLR_BIT(*GPIO_DDRx[uint8_port], uint8_pin);
                break;
            case GPIO_OUTPUT:
                SET_BIT(*GPIO_DDRx[uint8_port], uint8_pin);
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
                CLR_BIT(*GPIO_PORTx[uint8_port], uint8_pin);
                break;
            case GPIO_HIGH:
                SET_BIT(*GPIO_PORTx[uint8_port], uint8_pin);
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
        TOG_BIT(*GPIO_PORTx[uint8_port], uint8_pin);
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
        if (uint8_direction == GPIO_INPUT) {
            *GPIO_DDRx[uint8_port] = 0x00;
        } else if (uint8_direction == GPIO_OUTPUT) {
            *GPIO_DDRx[uint8_port] = 0xFF;
        } else {
            *GPIO_DDRx[uint8_port] = uint8_direction;
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
        if (uint8_value == GPIO_LOW) {
            *GPIO_PORTx[uint8_port] = 0x00;
        } else if (uint8_value == GPIO_HIGH) {
            *GPIO_PORTx[uint8_port] = 0xFF;
        } else {
            *GPIO_PORTx[uint8_port] = uint8_value;
        }
    }
    return local_Status;
}

/* 6. Get Pin Status */
Std_ReturnType GPIO_get_pin_status(uint8_t uint8_port, uint8_t uint8_pin, uint8_t *pu8PinStatus)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= GPIO_NUMBER_OF_PORTS) || (uint8_pin >= GPIO_NUMBER_OF_PINS) || (pu8PinStatus == 0))
    {
        local_Status = E_NOK;
    }
    else
    {
        *pu8PinStatus = GET_BIT(*GPIO_PINx[uint8_port], uint8_pin);
    }
    return local_Status;
}

/* 7. Get Port Status */
Std_ReturnType GPIO_get_port_status(uint8_t uint8_port, uint8_t *pu8PortStatus)
{
    Std_ReturnType local_Status = E_OK;

    if ((uint8_port >= GPIO_NUMBER_OF_PORTS) || (pu8PortStatus == 0))
    {
        local_Status = E_NOK;
    }
    else
    {
        *pu8PortStatus = *GPIO_PINx[uint8_port];
    }
    return local_Status;
}