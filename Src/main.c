#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdio.h>
#include <stdint.h>

/* =========================================================
   PIN DEFINITIONS
   ========================================================= */

/* L298 */
#define IN1     PB0
#define IN2     PB1
#define ENA     PB2

/* Emergency Stop */
#define EMERGENCY PB4

/* Buttons */
#define START_BTN   PC5
#define STOP_BTN    PC6
#define REVERSE_BTN PC7

/* Tachometer */
#define TACH PD2


/* =========================================================
   GLOBAL VARIABLES
   ========================================================= */

volatile uint16_t tach_pulses = 0;
volatile uint8_t emergency_active = 0;

volatile uint8_t pwm_value = 0;
volatile uint8_t pwm_counter = 0;

uint16_t motor_rpm = 0;
uint16_t speed_setpoint = 0;


/* =========================================================
   I2C / TWI
   ========================================================= */

#define LCD_ADDR 0x27

void TWI_Init(void)
{
    /* 100 kHz I2C */
    TWSR = 0x00;
    TWBR = 72;

    TWCR = (1 << TWEN);
}

void TWI_Start(void)
{
    TWCR = (1 << TWINT) |
           (1 << TWSTA) |
           (1 << TWEN);

    while (!(TWCR & (1 << TWINT)));
}

void TWI_Stop(void)
{
    TWCR = (1 << TWINT) |
           (1 << TWSTO) |
           (1 << TWEN);

    _delay_us(10);
}

void TWI_Write(uint8_t data)
{
    TWDR = data;

    TWCR = (1 << TWINT) |
           (1 << TWEN);

    while (!(TWCR & (1 << TWINT)));
}


/* =========================================================
   LCD
   ========================================================= */

#define LCD_BACKLIGHT 0x08
#define LCD_ENABLE    0x04
#define LCD_RS        0x01

void LCD_Send(uint8_t data)
{
    TWI_Start();

    TWI_Write((LCD_ADDR << 1));

    TWI_Write(data | LCD_BACKLIGHT);

    TWI_Write(data |
              LCD_BACKLIGHT |
              LCD_ENABLE);

    _delay_us(1);

    TWI_Write(data |
              LCD_BACKLIGHT);

    TWI_Stop();

    _delay_us(50);
}


void LCD_Send4Bit(uint8_t data)
{
    LCD_Send(data);
}


void LCD_Command(uint8_t cmd)
{
    LCD_Send4Bit(cmd & 0xF0);

    LCD_Send4Bit((cmd << 4) & 0xF0);

    if (cmd == 0x01 || cmd == 0x02)
        _delay_ms(2);
}


void LCD_Data(uint8_t data)
{
    LCD_Send4Bit((data & 0xF0) | LCD_RS);

    LCD_Send4Bit(((data << 4) & 0xF0) | LCD_RS);
}


void LCD_Init(void)
{
    _delay_ms(50);

    LCD_Send4Bit(0x30);
    _delay_ms(5);

    LCD_Send4Bit(0x30);
    _delay_us(150);

    LCD_Send4Bit(0x30);

    LCD_Send4Bit(0x20);

    LCD_Command(0x28);   // 4-bit, 2 lines
    LCD_Command(0x0C);   // Display ON
    LCD_Command(0x06);   // Entry mode
    LCD_Command(0x01);   // Clear

    _delay_ms(2);
}


void LCD_Goto(uint8_t row, uint8_t col)
{
    uint8_t address;

    if (row == 0)
        address = 0x80 + col;
    else
        address = 0xC0 + col;

    LCD_Command(address);
}


void LCD_Print(const char *str)
{
    while (*str)
    {
        LCD_Data(*str++);
    }
}


void LCD_Clear(void)
{
    LCD_Command(0x01);
    _delay_ms(2);
}


/* =========================================================
   ADC
   ========================================================= */

void ADC_Init(void)
{
    ADMUX = (1 << REFS0);

    ADCSRA =
        (1 << ADEN)  |
        (1 << ADPS2) |
        (1 << ADPS1) |
        (1 << ADPS0);
}


uint16_t ADC_Read(uint8_t channel)
{
    channel &= 0x07;

    ADMUX = (1 << REFS0) | channel;

    ADCSRA |= (1 << ADSC);

    while (ADCSRA & (1 << ADSC));

    return ADC;
}


/* =========================================================
   MOTOR CONTROL
   ========================================================= */

void Motor_Stop(void)
{
    PORTB &= ~((1 << IN1) | (1 << IN2));

    pwm_value = 0;
}


void Motor_Forward(void)
{
    PORTB |= (1 << IN1);
    PORTB &= ~(1 << IN2);
}


void Motor_Reverse(void)
{
    PORTB &= ~(1 << IN1);
    PORTB |= (1 << IN2);
}


/* =========================================================
   SOFTWARE PWM
   ========================================================= */

/*
   Timer1 generates an interrupt every 100 us.

   PWM frequency:
       10 kHz / 100 = 100 Hz
*/

void PWM_Init(void)
{
    TCCR1A = 0;

    TCCR1B =
        (1 << WGM12) |
        (1 << CS11);

    OCR1A = 199;

    TIMSK |= (1 << OCIE1A);
}


ISR(TIMER1_COMPA_vect)
{
    pwm_counter++;

    if (pwm_counter >= 100)
        pwm_counter = 0;

    if (pwm_counter < pwm_value)
        PORTB |= (1 << ENA);
    else
        PORTB &= ~(1 << ENA);
}


/* =========================================================
   TACHOMETER
   ========================================================= */

ISR(INT0_vect)
{
    tach_pulses++;
}


void Tach_Init(void)
{
    /* PD2 input */
    DDRD &= ~(1 << TACH);

    /* Internal pull-up */
    PORTD |= (1 << TACH);

    /*
       INT0 on rising edge
    */
    MCUCR |=
        (1 << ISC01) |
        (1 << ISC00);

    GICR |= (1 << INT0);
}


/* =========================================================
   RPM CALCULATION
   ========================================================= */

/*
   Assumption:
   Tachometer generates 1 pulse / revolution.

   If your tachometer generates more pulses/revolution,
   change PULSES_PER_REV.
*/

#define PULSES_PER_REV 1

uint16_t Calculate_RPM(void)
{
    uint16_t pulses;

    cli();

    pulses = tach_pulses;
    tach_pulses = 0;

    sei();

    /*
       We call this every 1 second.

       RPM = pulses * 60
    */

    return (pulses * 60) / PULSES_PER_REV;
}


/* =========================================================
   BUTTON INITIALIZATION
   ========================================================= */

void Buttons_Init(void)
{
    /*
       PC5 = START
       PC6 = STOP
       PC7 = REVERSE
    */

    DDRC &= ~(
        (1 << START_BTN) |
        (1 << STOP_BTN) |
        (1 << REVERSE_BTN)
    );

    PORTC |=
        (1 << START_BTN) |
        (1 << STOP_BTN) |
        (1 << REVERSE_BTN);
}


/* =========================================================
   EMERGENCY STOP
   ========================================================= */

void Emergency_Init(void)
{
    /*
       PB4 = Emergency Stop

       Switch:
           PB4 ---- switch ---- GND

       Internal pull-up enabled.
    */

    DDRB &= ~(1 << EMERGENCY);

    PORTB |= (1 << EMERGENCY);
}


uint8_t Emergency_Active(void)
{
    /*
       Active LOW
    */

    if (!(PINB & (1 << EMERGENCY)))
        return 1;

    return 0;
}


/* =========================================================
   LCD STATUS
   ========================================================= */

void LCD_Show_RPM(uint16_t rpm)
{
    char buffer[17];

    LCD_Goto(0, 0);

    sprintf(buffer, "RPM: %5u", rpm);

    LCD_Print(buffer);

    LCD_Goto(1, 0);

    if (rpm == 0)
    {
        LCD_Print("Motor: STOPPED ");
    }
    else
    {
        LCD_Print("Motor: RUNNING ");
    }
}


/* =========================================================
   MAIN
   ========================================================= */

int main(void)
{
    uint16_t adc_speed;

    uint16_t adc_current;
    uint16_t adc_voltage;
    uint16_t adc_temperature;

    uint8_t motor_running = 0;
    uint8_t direction = 0;

    uint16_t counter = 0;


    /* -----------------------------------------------------
       PORT INITIALIZATION
       ----------------------------------------------------- */

    /*
       PB0 = IN1
       PB1 = IN2
       PB2 = ENA
    */

    DDRB |=
        (1 << IN1) |
        (1 << IN2) |
        (1 << ENA);

    Motor_Stop();


    /* Initialize peripherals */

    ADC_Init();

    TWI_Init();

    LCD_Init();

    Buttons_Init();

    Emergency_Init();

    Tach_Init();

    PWM_Init();


    /* Enable interrupts */

    sei();


    /* -----------------------------------------------------
       START MESSAGE
       ----------------------------------------------------- */

    LCD_Clear();

    LCD_Goto(0, 0);
    LCD_Print("DC MOTOR CONTROL");

    LCD_Goto(1, 0);
    LCD_Print("System Ready");

    _delay_ms(1500);


    /* -----------------------------------------------------
       MAIN LOOP
       ----------------------------------------------------- */

    while (1)
    {

        /* ================================================
           EMERGENCY STOP
           ================================================ */

        if (Emergency_Active())
        {
            emergency_active = 1;

            motor_running = 0;

            Motor_Stop();

            LCD_Clear();

            LCD_Goto(0, 0);
            LCD_Print("!!! EMERGENCY !!!");

            LCD_Goto(1, 0);
            LCD_Print("Motor STOPPED");

            /*
               Wait until emergency switch is released
            */

            while (Emergency_Active())
            {
                Motor_Stop();

                _delay_ms(50);
            }

            emergency_active = 0;

            LCD_Clear();

            LCD_Goto(0, 0);
            LCD_Print("Emergency Clear");

            LCD_Goto(1, 0);
            LCD_Print("Press START");

            _delay_ms(500);
        }


        /* ================================================
           READ POTENTIOMETERS
           ================================================ */

        adc_speed =
            ADC_Read(0);

        adc_current =
            ADC_Read(1);

        adc_voltage =
            ADC_Read(2);

        adc_temperature =
            ADC_Read(3);


        /*
           Speed potentiometer:

           ADC = 0 ... 1023

           PWM = 0 ... 100
        */

        pwm_value =
            (uint8_t)((adc_speed * 100UL) / 1023UL);


        /*
           Speed setpoint in RPM.

           Maximum = 3000 RPM
        */

        speed_setpoint =
            (uint16_t)((adc_speed * 3000UL) / 1023UL);


        /* ================================================
           START BUTTON
           ================================================ */

        if (!(PINC & (1 << START_BTN)))
        {
            _delay_ms(30);

            if (!(PINC & (1 << START_BTN)))
            {
                motor_running = 1;

                if (direction == 0)
                    Motor_Forward();
                else
                    Motor_Reverse();

                while (!(PINC & (1 << START_BTN)));
            }
        }


        /* ================================================
           STOP BUTTON
           ================================================ */

        if (!(PINC & (1 << STOP_BTN)))
        {
            _delay_ms(30);

            if (!(PINC & (1 << STOP_BTN)))
            {
                motor_running = 0;

                Motor_Stop();

                while (!(PINC & (1 << STOP_BTN)));
            }
        }


        /* ================================================
           REVERSE BUTTON
           ================================================ */

        if (!(PINC & (1 << REVERSE_BTN)))
        {
            _delay_ms(30);

            if (!(PINC & (1 << REVERSE_BTN)))
            {
                /*
                   Stop before reversing
                */

                Motor_Stop();

                motor_running = 0;

                direction ^= 1;

                while (!(PINC & (1 << REVERSE_BTN)));

                _delay_ms(300);
            }
        }


        /* ================================================
           MOTOR CONTROL
           ================================================ */

        if (motor_running)
        {
            if (direction == 0)
                Motor_Forward();
            else
                Motor_Reverse();

            /*
               PWM already controlled by Timer1
            */
        }
        else
        {
            Motor_Stop();
        }


        /* ================================================
           RPM UPDATE
           ================================================ */

        counter++;

        /*
           Approximately every 1 second

           Main loop is not exactly 1 ms, therefore
           use delay below.
        */

        if (counter >= 20)
        {
            counter = 0;

            motor_rpm = Calculate_RPM();


            /* ============================================
               LCD
               ============================================ */

            LCD_Clear();

            if (emergency_active)
            {
                LCD_Goto(0, 0);
                LCD_Print("EMERGENCY STOP");

                LCD_Goto(1, 0);
                LCD_Print("RPM: 0");
            }
            else if (!motor_running)
            {
                LCD_Goto(0, 0);

                LCD_Print("Motor STOPPED");

                LCD_Goto(1, 0);

                LCD_Print("RPM: 0");
            }
            else
            {
                LCD_Goto(0, 0);

                char line1[17];

                sprintf(
                    line1,
                    "RPM:%5u",
                    motor_rpm
                );

                LCD_Print(line1);


                LCD_Goto(1, 0);

                char line2[17];

                sprintf(
                    line2,
                    "SET:%4u",
                    speed_setpoint
                );

                LCD_Print(line2);
            }


            /*
               Delay between RPM measurements
            */

            _delay_ms(50);
        }


        /*
           Small delay for button debounce
        */

        _delay_ms(10);
    }

    return 0;
}