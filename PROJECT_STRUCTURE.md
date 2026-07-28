# PROJECT_06_MOTOR - Final Project Structure

## 👥 Team Members & Responsibilities

| Team Member | Assigned Layers | Assigned Modules |
|-------------|-----------------|------------------|
| **Asmaa** | **MCAL & HAL** | All modules in `02-MCAL/` and `03-HAL/` |
| **Shorouk** | **LIB & APP** | All modules in `01-LIB/` and `04-APP/` |

---

## 📁 Project Directory Structure

```text
PROJECT_06_MOTOR/
│
├── 📂 01-LIB/                          # Layer 1: Standard Utilities & Types
│   │                                    👩‍💻 Assigned to: SHOROUK
│   ├── STD_TYPES.h                     # Standard type definitions (uint8_t, int16_t, etc.)
│   ├── BIT_MATH.h                      # Bit manipulation macros (SET_BIT, CLR_BIT, TOG_BIT, GET_BIT)
│   ├── ring_buffer.h                   # Ring buffer structure and functions
│   ├── ring_buffer.c
│   ├── crc16.h                         # CRC16 calculations for Modbus/Protocols
│   ├── crc16.c
│   └── util_math.h                     # Helper math functions (Clamping, Mapping)
│
├── 📂 02-MCAL/                         # Layer 2: Microcontroller Drivers (ATmega32A)
│   │                                    👩‍💻 Assigned to: ASMAA
│   ├── 📂 DIO/
│   │   ├── dio.h
│   │   └── dio.c
│   ├── 📂 ADC/
│   │   ├── adc.h
│   │   └── adc.c
│   ├── 📂 TIMER/                       # Timer0 (Tick), Timer1 (PWM), Timer2 (Buzzer)
│   │   ├── timer.h
│   │   └── timer.c
│   ├── 📂 EXTI/                        # INT0 (Tacho), INT1 (E-Stop)
│   │   ├── exti.h
│   │   └── exti.c
│   ├── 📂 USART/
│   │   ├── usart.h
│   │   └── usart.c
│   ├── 📂 SPI/
│   │   ├── spi.h
│   │   └── spi.c
│   └── 📂 I2C/
│       ├── i2c.h
│       └── i2c.c
│
├── 📂 03-HAL/                          # Layer 3: Hardware Abstraction Layer
│   │                                    👩‍💻 Assigned to: ASMAA
│   ├── 📂 Drivers/
│   │   ├── motor_bridge.h              # ★ Sole writer of PWM and direction pins ★
│   │   ├── motor_bridge.c
│   │   ├── user_panel.h                # Buttons and switches (Local/Remote)
│   │   ├── user_panel.c
│   │   ├── lcd_display.h               # LCD via I2C
│   │   ├── lcd_display.c
│   │   ├── buzzer.h                    # Buzzer and audio alerts
│   │   └── buzzer.c
│   ├── 📂 Sensors/
│   │   ├── tachometer.h                # RPM measurement from INT0 pulses
│   │   ├── tachometer.c
│   │   ├── analog_sensor.h             # Read (Temperature, Voltage, Current, Potentiometer)
│   │   └── analog_sensor.c
│   ├── 📂 Storage/
│   │   ├── eeprom_store.h              # SPI EEPROM read/write
│   │   ├── eeprom_store.c
│   │   ├── triplog_store.h             # Trip log on EEPROM
│   │   └── triplog_store.c
│   └── 📂 Utils/
│       ├── filter.h                    # ADC smoothing (Moving Average)
│       ├── filter.c
│       ├── debounce.h                  # Button debounce handling
│       ├── debounce.c
│       └── checksum.h                  # Checksum calculations for stored data
│
├── 📂 04-APP/                          # Layer 4: Application Logic
│   │                                    👩‍💻 Assigned to: SHOROUK
│   ├── 📂 Data/
│   │   ├── data_types.h                # DriveData_t, DriveCfg_t, Enums
│   │   ├── data_manager.h              # Central data management
│   │   └── data_manager.c
│   ├── 📂 Control/
│   │   ├── drive_fsm.h                 # Main state machine and sequencing
│   │   ├── drive_fsm.c
│   │   ├── pi_controller.h             # PI control with Q8 Fixed-Point + Anti-windup
│   │   ├── pi_controller.c
│   │   ├── ramp_generator.h            # Speed ramping (Accel/Decel)
│   │   ├── ramp_generator.c
│   │   ├── protection.h                # 9-step protection ladder + I²t curve
│   │   ├── protection.c
│   │   ├── torque_est.h                # Torque estimation from current and speed (B6)
│   │   └── torque_est.c
│   ├── 📂 Communication/
│   │   ├── console.h                   # USART command receiver (ASCII)
│   │   ├── console.c
│   │   ├── telemetry.h                 # Periodic data frame transmitter (1s)
│   │   ├── telemetry.c
│   │   ├── trace.h                     # Step response data streaming (B2)
│   │   ├── trace.c
│   │   ├── auto_tuner.h                # Automatic gain tuning (Relay Feedback) (B1)
│   │   └── auto_tuner.c
│   └── 📂 Scheduler/
│       ├── scheduler.h                 # Time scheduler (10ms, 50ms, 100ms, 250ms, 1s) (B4)
│       └── scheduler.c
│
├── 📂 Docs/                            # Required reports and diagrams
│   │                                    👩‍💻 Assigned to: BOTH (Collaboration)
│   ├── control_design.md
│   ├── safety_notes.md
│   ├── test_report.md
│   ├── flowchart.png
│   └── state_machine.png
│
├── 📂 Simulation/
│   │                                    👩‍💻 Assigned to: BOTH (Collaboration)
│   └── motor.sim1                      # SimulIDE simulation circuit file
│
├── main.c                              # Entry point and general initialization
│   │                                    👩‍💻 Assigned to: SHOROUK (Main Integration)
│   └── Makefile                        # avr-gcc build file
│                                        👩‍💻 Assigned to: ASMAA
└──
```

---

## 👩‍💻 Detailed Module Assignment Table

### 🔵 Asmaa's Assignments (MCAL & HAL - Lower Layers)

| # | Layer | Module | Files | Responsibility |
|---|-------|--------|-------|----------------|
| 1 | **MCAL** | DIO | `dio.h/c` | Digital I/O port control |
| 2 | **MCAL** | ADC | `adc.h/c` | Analog-to-Digital Converter |
| 3 | **MCAL** | TIMER | `timer.h/c` | Timers (0, 1, 2) |
| 4 | **MCAL** | EXTI | `exti.h/c` | External interrupts (INT0, INT1) |
| 5 | **MCAL** | USART | `usart.h/c` | Serial communication |
| 6 | **MCAL** | SPI | `spi.h/c` | SPI communication with EEPROM |
| 7 | **MCAL** | I2C | `i2c.h/c` | I2C communication with LCD |
| 8 | **HAL** | MotorBridge | `motor_bridge.h/c` | ★ H-Bridge motor control ★ |
| 9 | **HAL** | UserPanel | `user_panel.h/c` | Buttons and LEDs |
| 10 | **HAL** | LCD_Display | `lcd_display.h/c` | LCD display |
| 11 | **HAL** | Buzzer | `buzzer.h/c` | Buzzer and alerts |
| 12 | **HAL** | Tachometer | `tachometer.h/c` | Speed measurement (Tacho) |
| 13 | **HAL** | AnalogSensor | `analog_sensor.h/c` | Analog sensor reading |
| 14 | **HAL** | EEPROM_Store | `eeprom_store.h/c` | EEPROM data storage |
| 15 | **HAL** | TripLog_Store | `triplog_store.h/c` | Trip log management |
| 16 | **HAL** | Filter | `filter.h/c` | Signal filtering |
| 17 | **HAL** | Debounce | `debounce.h/c` | Button debounce handling |
| 18 | **HAL** | Checksum | `checksum.h` | Checksum calculations |

**📌 Total Modules for Asmaa: 18 modules**

---

### 🟢 Shorouk's Assignments (LIB & APP - Upper Layers)

| # | Layer | Module | Files | Responsibility |
|---|-------|--------|-------|----------------|
| 1 | **LIB** | StdTypes | `STD_TYPES.h` | Standard type definitions |
| 2 | **LIB** | BitMath | `BIT_MATH.h` | Bit manipulation operations |
| 3 | **LIB** | RingBuffer | `ring_buffer.h/c` | Circular buffer for UART |
| 4 | **LIB** | CRC16 | `crc16.h/c` | CRC-16 calculation (B8) |
| 5 | **LIB** | UtilMath | `util_math.h` | Helper math functions |
| 6 | **APP** | DataTypes | `data_types.h` | Global structure definitions |
| 7 | **APP** | DataManager | `data_manager.h/c` | Central data management |
| 8 | **APP** | DriveFSM | `drive_fsm.h/c` | Motor state machine |
| 9 | **APP** | PIController | `pi_controller.h/c` | PI controller with Anti-Windup |
| 10 | **APP** | RampGenerator | `ramp_generator.h/c` | Speed ramp generation |
| 11 | **APP** | Protection | `protection.h/c` | Protection ladder (9 conditions) |
| 12 | **APP** | TorqueEst | `torque_est.h/c` | Torque estimation (B6) |
| 13 | **APP** | Console | `console.h/c` | UART command parser |
| 14 | **APP** | Telemetry | `telemetry.h/c` | Operational data transmission |
| 15 | **APP** | Trace | `trace.h/c` | Data tracing (B2) |
| 16 | **APP** | AutoTuner | `auto_tuner.h/c` | Auto-tuning (B1) |
| 17 | **APP** | Scheduler | `scheduler.h/c` | Task scheduling (B4) |
| 18 | **APP** | main.c | `main.c` | Entry point and integration |

**📌 Total Modules for Shorouk: 18 modules**

---

### 🟡 Collaborative Work (Both Members)

| # | Item | Responsibility |
|---|------|----------------|
| 1 | 📂 Docs/ | Both members collaborate on documentation |
| 2 | 📂 Simulation/ | Both members work on simulation circuit |
| 3 | 🔧 Integration | Both members collaborate on system integration |
| 4 | 🧪 Testing | Both members perform testing together |
| 5 | 📹 Demo Video | Both members prepare and present |

---

## 📊 Module Summary by Layer with Assignments

| # | Layer | Modules | Files | Assigned To |
|---|-------|---------|-------|-------------|
| 1 | **LIB** | 5 modules | 7 files | 👩‍💻 **Shorouk** |
| 2 | **MCAL** | 7 modules | 14 files | 👩‍💻 **Asmaa** |
| 3 | **HAL** | 11 modules | 22 files | 👩‍💻 **Asmaa** |
| 4 | **APP** | 13 modules | 25 files | 👩‍💻 **Shorouk** |
|  | **Total** | **36 modules** | **68 files** | |

---

## 🔄 Module Interaction & Integration Points

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                    INTEGRATION POINTS BETWEEN LAYERS                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │               SHOROUK'S DOMAIN (LIB + APP)                          │   │
│  │                                                                     │   │
│  │  ┌─────────────┐    ┌─────────────┐    ┌─────────────────────────┐ │   │
│  │  │   LIB       │    │    APP      │    │       main.c            │ │   │
│  │  │             │    │             │    │    (Integration)         │ │   │
│  │  │ STD_TYPES   │    │ DriveFSM    │    │                         │ │   │
│  │  │ BIT_MATH    │    │ PIController│    │                         │ │   │
│  │  │ RingBuffer  │    │ RampGen     │    │                         │ │   │
│  │  │ CRC16       │    │ Protection  │    │                         │ │   │
│  │  │ UtilMath    │    │ Console     │    │                         │ │   │
│  │  │             │    │ Telemetry   │    │                         │ │   │
│  │  └─────────────┘    └──────┬──────┘    └─────────────────────────┘ │   │
│  └────────────────────────────┼────────────────────────────────────────┘   │
│                               │                                             │
│                    ┌──────────▼──────────┐                                  │
│                    │   INTERFACE BOUNDARY │                                  │
│                    │   (HAL API Calls)    │                                  │
│                    └──────────┬──────────┘                                  │
│                               │                                             │
│  ┌────────────────────────────┼────────────────────────────────────────┐   │
│  │               ASMAA'S DOMAIN (MCAL + HAL)                          │   │
│  │                               │                                     │   │
│  │  ┌─────────────┐    ┌────────▼────────┐    ┌─────────────────────┐ │   │
│  │  │    MCAL     │    │      HAL         │    │                     │ │   │
│  │  │             │    │                  │    │                     │ │   │
│  │  │ DIO         │    │ MotorBridge   ★  │    │                     │ │   │
│  │  │ ADC         │    │ UserPanel       │    │                     │ │   │
│  │  │ TIMER       │    │ LCD_Display     │    │                     │ │   │
│  │  │ EXTI        │    │ Buzzer          │    │                     │ │   │
│  │  │ USART       │    │ Tachometer      │    │                     │ │   │
│  │  │ SPI         │    │ AnalogSensor    │    │                     │ │   │
│  │  │ I2C         │    │ EEPROM_Store    │    │                     │ │   │
│  │  │             │    │ TripLog_Store   │    │                     │ │   │
│  │  │             │    │ Filter          │    │                     │ │   │
│  │  │             │    │ Debounce        │    │                     │ │   │
│  │  │             │    │ Checksum        │    │                     │ │   │
│  │  └─────────────┘    └─────────────────┘    └─────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 📌 Integration Responsibility Matrix

| Integration Point | From (Shorouk) | To (Asmaa) | API Used |
|-------------------|----------------|------------|----------|
| Speed Measurement | `APP/Control` | `HAL/Tachometer` | `TACHO_GetRPM()` |
| Sensor Data | `APP/Control` | `HAL/AnalogSensor` | `ANALOG_GetCurrent()`, `ANALOG_GetVoltage()`, `ANALOG_GetTemperature()` |
| Motor Control | `APP/Control` | `HAL/MotorBridge` | `BRIDGE_SetDuty()`, `BRIDGE_SetDirection()` |
| User Input | `APP/Control` | `HAL/UserPanel` | `PANEL_GetEvent()` |
| Display | `APP/Data` | `HAL/LCD_Display` | `LCD_Update()` |
| Storage | `APP/Data` | `HAL/EEPROM_Store` | `EEPROM_LoadConfig()`, `EEPROM_SaveConfig()` |
| Communication | `APP/Communication` | `MCAL/USART` | `USART_TransmitString()`, `USART_DataAvailable()` |
| Time Base | `APP/Scheduler` | `MCAL/TIMER` | `TIMER_GetTick()` |

---

## 📅 Development Timeline

| Phase | Days | Tasks | Responsible |
|-------|------|-------|-------------|
| **Phase 1** | Day 1-2 | Requirements Analysis & Pin Mapping | Both |
| **Phase 2** | Day 3-4 | **MCAL Development** - DIO, ADC, TIMER, EXTI | **Asmaa** |
| **Phase 3** | Day 3-4 | **LIB Development** - STD_TYPES, BIT_MATH, RingBuffer | **Shorouk** |
| **Phase 4** | Day 5-7 | **HAL Development** - MotorBridge, Sensors, Storage | **Asmaa** |
| **Phase 5** | Day 5-7 | **APP Development** - Control Modules, FSM, PI | **Shorouk** |
| **Phase 6** | Day 8-9 | **Communication & Scheduler** - Console, Telemetry | **Shorouk** |
| **Phase 7** | Day 10-11 | **Integration & Testing** | Both |
| **Phase 8** | Day 12-13 | **Bonus Features** (B1-B8) | Both |
| **Phase 9** | Day 14-15 | **Documentation, Simulation, Demo** | Both |

---

## ✅ Final Summary

| Item | Details |
|------|---------|
| **Total Modules** | 36 modules |
| **Total Files** | 68 files |
| **Team Members** | 2 members |
| **Asmaa's Modules** | 18 modules (MCAL + HAL) |
| **Shorouk's Modules** | 18 modules (LIB + APP) |
| **Collaborative Work** | Documentation, Simulation, Integration, Testing |
| **Bonuses Included** | All 8 bonuses (B1 to B8) |

---

**The structure is ready for implementation!** 🚀

*Prepared by: Asmaa & Shorouk*