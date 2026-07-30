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


/* ---------------- Core primitives ---------------- */

Std_ReturnType GPIO_set_pin_Direction(uint8_t port, uint8_t pin, uint8_t direction)
{
    if ((port >= GPIO_NUMBER_OF_PORTS) || (pin >= GPIO_NUMBER_OF_PINS))
    {
        return E_NOK;
    }

    if (direction == GPIO_OUTPUT)
    {
        SET_BIT(*GPIO_DDRx[port], pin);
    }
    else
    {
        CLR_BIT(*GPIO_DDRx[port], pin);
    }

    return E_OK;
}


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


/* ---------------- Wrappers used across HAL/main ---------------- */

Std_ReturnType GPIO_write_pin(uint8_t port, uint8_t pin, uint8_t value)
{
    if ((port >= GPIO_NUMBER_OF_PORTS) || (pin >= GPIO_NUMBER_OF_PINS))
    {
        return E_NOK;
    }

    if (value == GPIO_HIGH)
    {
        SET_BIT(*GPIO_PORTx[port], pin);
    }
    else
    {
        CLR_BIT(*GPIO_PORTx[port], pin);
    }

    return E_OK;
}


Std_ReturnType GPIO_set_pin_value(uint8_t port, uint8_t pin, uint8_t value)
{
    return GPIO_write_pin(port, pin, value);
}


GPIO_pin_status GPIO_read_pin(uint8_t port, uint8_t pin)
{
    uint8_t status = 0;
    GPIO_get_pin_status(port, pin, &status);
    return (GPIO_pin_status)status;
}


Std_ReturnType GPIO_toggle_pin(uint8_t port, uint8_t pin)
{
    if ((port >= GPIO_NUMBER_OF_PORTS) || (pin >= GPIO_NUMBER_OF_PINS))
    {
        return E_NOK;
    }
    TOG_BIT(*GPIO_PORTx[port], pin);
    return E_OK;
}


Std_ReturnType GPIO_set_pull_up(uint8_t port, uint8_t pin, uint8_t enable)
{
    return GPIO_write_pin(port, pin, (enable != 0) ? GPIO_HIGH : GPIO_LOW);
}