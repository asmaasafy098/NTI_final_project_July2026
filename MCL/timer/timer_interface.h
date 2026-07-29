#ifndef TIMER_INTERFACE_H
#define TIMER_INTERFACE_H

#include "../../Service/STD_Types.h"
#include "timer_registers.h"

/* ================================================================================
 *  TIMER DRIVER - PUBLIC INTERFACE (ATmega32)
 *  ------------------------------------------------------------------------------
 *  This driver abstracts the three timer/counter units of the ATmega32 behind a
 *  single, channel-based API. The caller selects a channel (Timer0/1/2), an
 *  operating mode, and a prescaler through a configuration structure, then uses
 *  the runtime functions to start/stop the timer, read/write its counter, set a
 *  compare value, or register an interrupt callback.
 * ============================================================================== */
#define notvalid 0 
#define PWM_TOP 399
/* ---------------- Timer Channels ---------------- */
/**
 * @brief Identifies which physical timer/counter unit an API call targets.
 *        TIMER_CHANNEL_0 and TIMER_CHANNEL_2 are 8-bit; TIMER_CHANNEL_1 is 16-bit.
 */
typedef enum
{
    TIMER_CHANNEL_0 = 0,   /* 8-bit  Timer0 */
    TIMER_CHANNEL_1 = 1,   /* 16-bit Timer1 */
    TIMER_CHANNEL_2 = 2,   /* 8-bit  Timer2 */
    TIMER_CHANNEL_MAX      /* Sentinel used for range checking - not a real channel */
} Timer_ChannelType;

/* ---------------- Operating Modes ---------------- */
/**
 * @brief Waveform generation mode of the selected timer.
 *  - TIMER_MODE_NORMAL       : Counter runs 0 -> TOP and overflows (TOV interrupt).
 *  - TIMER_MODE_CTC          : Counter runs 0 -> OCR and resets (compare-match interrupt).
 *  - TIMER_MODE_FAST_PWM     : Single-slope PWM on the OCx pin.
 *  - TIMER_MODE_PHASE_PWM    : Dual-slope (phase-correct) PWM on the OCx pin.
 */
typedef enum
{
    TIMER_MODE_NORMAL     = 0,
    TIMER_MODE_CTC        = 1,
    TIMER_MODE_FAST_PWM   = 2,
    TIMER_MODE_PHASE_PWM  = 3
} Timer_ModeType;

/* ---------------- Clock Prescaler ---------------- */
/**
 * @brief Clock source / prescaler for the timer. The numeric value matches the
 *        CSx2:CSx0 bit pattern that is written into the control register.
 *        TIMER_CLOCK_STOPPED disconnects the clock and effectively pauses the timer.
 */
typedef enum
{
    TIMER_CLOCK_STOPPED   = 0,   /* No clock source - timer stopped */
    TIMER_CLOCK_DIV_1     = 1,   /* clk/1    (no prescaling)        */
    TIMER_CLOCK_DIV_8     = 2,   /* clk/8                           */
    TIMER_CLOCK_DIV_64    = 3,   /* clk/64                          */
    TIMER_CLOCK_DIV_256   = 4,   /* clk/256                         */
    TIMER_CLOCK_DIV_1024  = 5    /* clk/1024                        */
} Timer_PrescalerType;

/* ---------------- Interrupt Sources ---------------- */
/**
 * @brief Selects which timer event fires an interrupt / callback.
 *  - TIMER_INT_OVERFLOW      : Fires when the counter overflows past TOP.
 *  - TIMER_INT_COMPARE_MATCH : Fires when the counter equals the compare value.
 */
typedef enum
{
    TIMER_INT_OVERFLOW       = 0,
    TIMER_INT_COMPARE_MATCH  = 1
} Timer_InterruptType;

/* ---------------- Configuration Structure ---------------- */
/**
 * @brief Aggregates everything Timer_Init() needs to configure one channel.
 * @var Timer_ConfigType::channel        Which timer unit to configure (Timer_ChannelType).
 * @var Timer_ConfigType::mode           Waveform generation mode (Timer_ModeType).
 * @var Timer_ConfigType::prescaler      Clock source / prescaler (Timer_PrescalerType).
 * @var Timer_ConfigType::initialValue   Value preloaded into the counter register (TCNTx).
 * @var Timer_ConfigType::compareValue   Value written to the compare register (OCRx),
 *                                        used in CTC / PWM modes and for compare interrupts.
 */
typedef struct
{
    Timer_ChannelType   channel;
    Timer_ModeType      mode;
    Timer_PrescalerType prescaler;
    uint16_t            initialValue;
    uint16_t            compareValue;
} Timer_ConfigType;

/* ---------------- Callback Pointer Type ---------------- */
/**
 * @brief Type of the user function invoked from the timer ISR.
 *        Keep the callback short and non-blocking - it runs in interrupt context.
 */
typedef void (*Timer_CallBackType)(void);

/* ================================================================================
 *  FUNCTION PROTOTYPES
 * ============================================================================== */

/**
 * @brief  Initializes Timer0 in CTC mode with OCR0=77 and prescaler 1024,
 *         producing a 10ms compare-match period.
 * @param  None.
 * @return Std_ReturnType  E_OK on success.
 */
Std_ReturnType Timer0_Init(void);

/**
 * @brief  Enables the specified interrupt source (overflow or compare match)
 *         for Timer0.
 * @param  channel  Must be TIMER_CHANNEL_0.
 * @param  intType  TIMER_INT_OVERFLOW or TIMER_INT_COMPARE_MATCH.
 * @return Std_ReturnType  E_OK/E_NOK (E_NOK on invalid channel).
 */
Std_ReturnType Timer0_EnableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);

/**
 * @brief  Disables the specified interrupt source (overflow or compare match)
 *         for Timer0.
 * @param  channel  Must be TIMER_CHANNEL_0.
 * @param  intType  TIMER_INT_OVERFLOW or TIMER_INT_COMPARE_MATCH.
 * @return Std_ReturnType  E_OK/E_NOK (E_NOK on invalid channel).
 */
Std_ReturnType Timer0_DisableInterrupt(Timer_ChannelType channel, Timer_InterruptType intType);

/**
 * @brief  Registers a callback function to be invoked from the ISR when the
 *         specified timer channel and interrupt type fire.
 * @param  channel   Timer channel (TIMER_CHANNEL_0, _1, _2...).
 * @param  intType   TIMER_INT_OVERFLOW or TIMER_INT_COMPARE_MATCH.
 * @param  callBack  Function pointer to invoke; must not be NULL.
 * @return Std_ReturnType  E_OK/E_NOK (E_NOK on invalid channel or NULL callback).
 */
Std_ReturnType Timer_SetCallBack(Timer_ChannelType channel, Timer_InterruptType intType,
                                  Timer_CallBackType callBack);

/**
 * @brief  Initializes Timer1 in Fast PWM mode 14 (TOP = ICR1 = 399) with
 *         non-inverting output on OC1A, producing a 20kHz PWM signal.
 * @param  None.
 * @return Std_ReturnType  E_OK on success.
 */
Std_ReturnType Timer1_Init(void);

/**
 * @brief  Sets the PWM duty cycle on OC1A as a percentage (0-100).
 * @param  duty_percent  Desired duty cycle, 0 to 100.
 * @return Std_ReturnType  E_OK/E_NOK (E_NOK if duty_percent > 100).
 */
Std_ReturnType Timer1_SetDuty(uint16_t duty_percent);

/**
 * @brief  Initializes Timer2 in CTC mode with toggle-on-compare-match output
 *         on OC2, allowing the output frequency to be set via Timer2_SetTone.
 * @param  None.
 * @return Std_ReturnType  E_OK on success.
 */
Std_ReturnType Timer2_Init(void);

/**
 * @brief  Sets the compare value (OCR2) controlling the buzzer tone frequency.
 * @param  tone  Compare value, 0 to 255.
 * @return Std_ReturnType  E_OK/E_NOK (E_NOK if tone > 255).
 */
Std_ReturnType Timer2_SetTone(uint16_t tone);

/**
 * @brief  Enables global interrupts (sets the I-bit in SREG, equivalent to sei()).
 * @param  None.
 * @return void
 */
void Timer_EnableGlobalInterrupt(void);

/**
 * @brief  Disables global interrupts (clears the I-bit in SREG, equivalent to cli()).
 * @param  None.
 * @return void
 */
void Timer_DisableGlobalInterrupt(void);

#endif /* TIMER_INTERFACE_H */
