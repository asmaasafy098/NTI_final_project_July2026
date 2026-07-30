.DEFAULT_GOAL := all

PIO     = $(USERPROFILE)/.platformio/packages
CC      = $(PIO)/toolchain-atmelavr/bin/avr-gcc.exe
OBJCOPY = $(PIO)/toolchain-atmelavr/bin/avr-objcopy.exe
AVRDUDE = $(PIO)/tool-avrdude/avrdude.exe

MCU     = m32
F_CPU   = 16000000UL

CFLAGS  = -mmcu=atmega32 -DF_CPU=$(F_CPU) -std=c99 -Wall -Os
DEPFLAGS = -MMD -MP
LDFLAGS = -mmcu=atmega32

# Discover sources from this project's actual layout
C_SOURCES := $(wildcard Src/*.c) \
             $(wildcard MCL/GPIO/*.c) \
             $(wildcard MCL/ADC/*.c) \
             $(wildcard MCL/timer/*.c) \
             $(wildcard MCL/Interrupt/*.c) \
             $(wildcard MCL/UART/*.c) \
             $(wildcard MCL/I2C/*.c) \
             $(wildcard HAL/ANALOG_SENSOR/*.c) \
             $(wildcard HAL/BUZZER/*.c) \
             $(wildcard HAL/DC_Motor/*.c) \
             $(wildcard HAL/LCD_Aip31068_i2c/*.c) \
             $(wildcard HAL/MotorBridge/*.c) \
             $(wildcard HAL/Stepper_L298P/*.c) \
             $(wildcard HAL/Tachometer/*.c) \
             $(wildcard HAL/UserPanel/*.c) \
             $(wildcard Logic/Communication/console/*.c) \
             $(wildcard Logic/Communication/telemetry/*.c) \
             $(wildcard Logic/Control/drive_fsm/*.c) \
             $(wildcard Logic/Control/pi_controller/*.c) \
             $(wildcard Logic/Control/protection/*.c) \
             $(wildcard Logic/Control/ramp_generator/*.c) \
             $(wildcard Logic/Data/*.c) \
             $(wildcard Logic/Scheduler/*.c)

OBJS      := $(patsubst %.c,build/%.o,$(C_SOURCES))
DEPS      := $(patsubst %.c,build/%.d,$(C_SOURCES))
TARGET    := build/firmware

# Include paths for the current project
INCLUDE_DIRS := . Src \
                MCL/GPIO MCL/ADC MCL/timer MCL/Interrupt MCL/UART MCL/I2C \
                HAL/ANALOG_SENSOR HAL/BUZZER HAL/DC_Motor HAL/LCD_Aip31068_i2c \
                HAL/MotorBridge HAL/Stepper_L298P HAL/Tachometer HAL/UserPanel \
                Logic/Communication/console Logic/Communication/telemetry \
                Logic/Control/drive_fsm Logic/Control/pi_controller \
                Logic/Control/protection Logic/Control/ramp_generator \
                Logic/Data Logic/Scheduler \
                Service

CFLAGS += $(addprefix -I,$(INCLUDE_DIRS)) $(DEPFLAGS)

-include $(DEPS)

all: $(TARGET).hex

$(TARGET).elf: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

build/%.i: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -MMD -MP -MF $(patsubst %.i,%.d,$@) -E $< -o $@

build/%.s: build/%.i
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -S $< -o $@

build/%.o: build/%.s
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

.SECONDARY:

clean:
	@rm -rf build

flash: $(TARGET).hex
	$(AVRDUDE) -c usbasp -p $(MCU) -U flash:w:$<:i

.PHONY: all clean flash