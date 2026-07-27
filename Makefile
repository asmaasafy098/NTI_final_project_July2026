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
C_SOURCES := $(wildcard Src/*.c) $(wildcard MCL/GPIO/*.c) $(wildcard MCL/ADC/*.c)
OBJS      := $(patsubst %.c,build/%.o,$(C_SOURCES))
DEPS      := $(patsubst %.c,build/%.d,$(C_SOURCES))
TARGET    := build/firmware

# Include paths for the current project
INCLUDE_DIRS := . Src GPIO MCL/ADC
CFLAGS += $(addprefix -I,$(INCLUDE_DIRS)) $(DEPFLAGS)

-include $(DEPS)

all: $(TARGET).hex

$(TARGET).elf: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

# Build pipeline: Src/main.c -> build/Src/main.i/.s/.o
build/%.i: %.c
	@if not exist "$(subst /,\,$(dir $@))" mkdir "$(subst /,\,$(dir $@))"
	$(CC) $(CFLAGS) -MMD -MP -MF $(patsubst %.i,%.d,$@) -E $< -o $@

build/%.s: build/%.i
	@if not exist "$(subst /,\,$(dir $@))" mkdir "$(subst /,\,$(dir $@))"
	$(CC) $(CFLAGS) -S $< -o $@

build/%.o: build/%.s
	@if not exist "$(subst /,\,$(dir $@))" mkdir "$(subst /,\,$(dir $@))"
	$(CC) $(CFLAGS) -c $< -o $@

.SECONDARY:

clean:
	@if exist build rmdir /s /q build

flash: $(TARGET).hex
	$(AVRDUDE) -c usbasp -p $(MCU) -U flash:w:$<:i

.PHONY: all clean flash