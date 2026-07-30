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

# ===========================
# Source Files
# ===========================

C_SOURCES := \
$(wildcard Src/*.c) \
$(wildcard HAL/*/*.c) \
$(wildcard Logic/*/*.c) \
$(wildcard Logic/*/*/*.c) \
$(wildcard MCL/*/*.c) \
$(wildcard Service/*/*.c)

OBJS   := $(patsubst %.c,build/%.o,$(C_SOURCES))
DEPS   := $(patsubst %.c,build/%.d,$(C_SOURCES))

TARGET = build/firmware

# ===========================
# Include Paths
# ===========================

INCLUDE_DIRS := \
. \
Src \
HAL \
HAL/ANALOG_SENSOR \
HAL/BUZZER \
HAL/DC_Motor \
HAL/LCD_Aip31068_i2c \
HAL/MotorBridge \
HAL/Stepper_L298P \
HAL/Tachometer \
HAL/UserPanel \
Logic \
Logic/Communication \
Logic/Communication/console \
Logic/Communication/telemetry \
Logic/Control \
Logic/Control/drive_fsm \
Logic/Control/pi_controller \
Logic/Control/protection \
Logic/Control/ramp_generator \
Logic/Data \
Logic/Scheduler \
MCL \
MCL/ADC \
MCL/GPIO \
MCL/I2C \
MCL/Interrupt \
MCL/Timer \
MCL/UART \
Service \
Service/crc16 \
Service/ring_buffer

CFLAGS += $(addprefix -I,$(INCLUDE_DIRS)) $(DEPFLAGS)

-include $(DEPS)

all: $(TARGET).hex

$(TARGET).elf: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

build/%.i: %.c
	@if not exist "$(subst /,\,$(dir $@))" mkdir "$(subst /,\,$(dir $@))"
	$(CC) $(CFLAGS) -MMD -MP -MF $(patsubst %.i,%.d,$@) -E $< -o $@

build/%.s: build/%.i
	$(CC) $(CFLAGS) -S $< -o $@

build/%.o: build/%.s
	$(CC) $(CFLAGS) -c $< -o $@

.SECONDARY:

clean:
	@if exist build rmdir /s /q build

flash: $(TARGET).hex
	$(AVRDUDE) -c usbasp -p $(MCU) -U flash:w:$<:i

.PHONY: all clean flash