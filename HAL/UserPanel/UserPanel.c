#include "../../Service/STD_Types.h"
#include "userpanel.h"
#include"../../MCL/GPIO/GPIO_Interface.h"

Std_ReturnType PANEL_Init(void)
{
    GPIO_set_pin_Direction(GPIO_PORTC, GPIO_PIN5, GPIO_INPUT); /* Start */
    GPIO_set_pin_Direction(GPIO_PORTC, GPIO_PIN6, GPIO_INPUT); /* Stop  */
    GPIO_set_pin_Direction(GPIO_PORTC, GPIO_PIN7, GPIO_INPUT); /* Rev   */
    GPIO_set_pin_Direction(GPIO_PORTD, GPIO_PIN6, GPIO_INPUT); /* Reset */
    GPIO_set_pin_Direction(GPIO_PORTD, GPIO_PIN4, GPIO_INPUT); /* Local/Remote */
    return E_OK;
}

void PANEL_Poll(void)   /* called every 10ms, debounce simplified */
{
    /* TODO: add real debounce counters per button if needed */
}

Panel_Event_t PANEL_GetEvent(void)
{
    if (GPIO_get_pin_status(GPIO_PORTC, GPIO_PIN5) == GPIO_LOW) return PNL_START;
    if (GPIO_get_pin_status(GPIO_PORTC, GPIO_PIN6) == GPIO_LOW) return PNL_STOP;
    if (GPIO_get_pin_status(GPIO_PORTC, GPIO_PIN7) == GPIO_LOW) return PNL_REVERSE;
    if (GPIO_get_pin_status(GPIO_PORTD, GPIO_PIN6) == GPIO_LOW) return PNL_RESET;
    return PNL_NONE;
}

uint8_t PANEL_IsLocalMode(void)
{
    return (GPIO_get_pin_status(GPIO_PORTD, GPIO_PIN4) == GPIO_LOW) ? 1 : 0;
}