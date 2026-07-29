# Project 06 — Industrial Motor Controller

> Part of the **Embedded Systems Projects Book** — see the
> [book README](../README.md) for the shared platform baseline, layer rules and
> common rubric. Everything in this file is *in addition to* those rules.

---

## 1. Project Identity

| Field | Value |
|-------|-------|
| **Project code** | `PRJ-06-MOTOR` |
| **Team size** | Asmaa Safy (asmaasafy098@gmail.com) – Shorouk Anwar (Shranwer112@gmail.com) |
| **Build window** | Days 11 – 15 (Jul 26 – Jul 30, 2026) |
| **Demo & submission** | July 30, 2026 |
| **Dominant skill** | Closed-loop fixed-point PI control, ramping, fail-safe E-stop |
| **MCU** | ATmega32A @ 8 MHz |
| **Simulator** | SimulIDE 1.x |

---

## 2. Description

The Industrial Motor Controller is a variable-speed drive for a DC motor: the
operator sets a target speed, and the firmware **holds** that speed regardless
of load, while protecting the motor, the drive and the operator.

Three things make this harder than the earlier projects:

1. **Closed-loop control.** Open-loop PWM ("60 % duty ≈ 1800 RPM") collapses the
   moment the shaft is loaded. You will implement a **PI controller in fixed
   point** — no `float` — with anti-windup and output clamping, and tune it
   against a measured step response.

2. **Motion must be sequenced, not commanded.** You cannot jump from full
   forward to full reverse; the H-bridge would see a shoot-through condition and
   the mechanical shock would be violent. Direction changes go through a
   controlled ramp-down, a dead-time pause, and a ramp-up.

3. **The emergency stop must be fail-safe.** The E-stop uses a **normally
   closed** contact, so a *broken wire* trips the drive rather than silently
   disabling the protection. It is wired to an external interrupt and kills the
   PWM in hardware terms, not by asking the scheduler nicely.

Speed, current, bus voltage and motor temperature are shown on the LCD and
streamed over UART. Run hours, start counts and a trip history live in SPI
EEPROM.

---

## 4. Objectives

1. Generate a 20 kHz PWM with Timer1 Fast PWM using `ICR1` as TOP.
2. Measure shaft speed by counting encoder pulses over a fixed window.
3. Implement a PI controller entirely in scaled integer arithmetic, with
   anti-windup and output saturation.
4. Design a start/stop/reverse sequence with ramps and dead time.
5. Build a fail-safe emergency stop using a normally closed contact and an
   external interrupt.
6. Implement multi-level current protection: an inverse-time overload plus an
   instantaneous short-circuit trip.
7. Persist run hours and a trip history that survives power loss.

---

## 4. Learning Outcomes

| ID | Outcome |
|----|---------|
| LO-1 | Configure Timer1 Fast PWM mode 14 with `ICR1` as TOP and compute the resulting frequency and resolution |
| LO-2 | Explain why 20 kHz was chosen over 1 kHz and over 100 kHz for a motor drive |
| LO-3 | Implement a PI controller in Q8 fixed point and explain each shift |
| LO-4 | Describe integral windup, demonstrate it, then fix it with clamping and conditional integration |
| LO-5 | Explain why an E-stop uses a normally closed contact, and prove a broken wire trips the drive |
| LO-6 | Distinguish an inverse-time overload from an instantaneous trip and size both |
| LO-7 | Sequence a direction reversal with ramp-down, dead time and ramp-up, and justify the dead time |

---

## 5. Estimated Duration

| Phase | Hours | Course day |
|-------|:-----:|-----------|
| Requirements analysis & pin freeze | 3 | Day 11 |
| Control design, sequencing, trip curves | 5 | Day 11 |
| Analog channels, H-bridge, LCD | 6 | Day 12 |
| Timer tick, 20 kHz PWM, tacho, PI loop | 8 | Day 13 |
| Protections, EEPROM, UART, trip log | 6 | Day 14 |
| Testing & tuning | 5 | Day 15 |
| Documentation, report, video | 4 | Day 15 + evening |
| **Total** | **37 h** | |

---

## 6. Hardware Components

| # | Component | Qty | SimulIDE part | Purpose |
|---|-----------|:---:|---------------|---------|
| 1 | ATmega32A | 1 | `atmega32` | Controller |
| 2 | Potentiometer 10 kΩ | 1 | `Potentiometer` | Speed setpoint |
| 3 | Potentiometer 10 kΩ | 1 | `Potentiometer` | Motor current sense |
| 4 | Potentiometer 10 kΩ | 1 | `Potentiometer` | DC bus voltage |
| 5 | Potentiometer 10 kΩ | 1 | `Potentiometer` | Motor winding temperature |
| 6 | Variable clock | 1 | `Clock` | Encoder / tacho pulses |
| 7 | H-bridge or DC motor | 1 | `DC Motor` + `H-Bridge` | Load |
| 8 | Switch (SPST, **NC**) | 1 | `Switch` | Emergency stop |
| 9 | Push button | 4 | `Push` | Start, Stop, Reverse, Reset |
| 10 | Switch (SPST) | 1 | `Switch` | Local / Remote |
| 11 | LED (green / amber / red) | 3 | `Led` | Run, direction, fault |
| 12 | LED | 2 | `Led` | FWD / REV indication |
| 13 | Buzzer | 1 | `Buzzer` | Trip annunciation |
| 14 | 16×2 LCD + PCF8574 | 1 | `Lcd` + `I2CToParallel` | Operator panel |
| 15 | 25LC256 SPI EEPROM | 1 | `Memory (SPI)` | Parameters, run hours, trip log |
| 16 | Serial terminal | 1 | `SerialPort` | SCADA / console |

---

## 7. Pin Map

| Signal | Pin | Port bit | Direction | Notes |
|--------|-----|----------|-----------|-------|
| Speed setpoint | 40 | `PA0` / ADC0 | Analog in | 0 – 1023 → 0 – 3000 RPM |
| Motor current | 39 | `PA1` / ADC1 | Analog in | 0 – 1023 → 0 – 20.0 A |
| DC bus voltage | 38 | `PA2` / ADC2 | Analog in | 0 – 1023 → 0 – 60.0 V |
| Motor temperature | 37 | `PA3` / ADC3 | Analog in | 0 – 1023 → 0 – 150 °C |
| H-bridge `IN1` | 1 | `PB0` | Out | Direction A |
| H-bridge `IN2` | 2 | `PB1` | Out | Direction B |
| H-bridge `EN` / brake | 3 | `PB2` | Out | Low = coast, high = enabled |
| Run LED | 4 | `PB3` | Out | Steady = running, blink = ramping |
| SPI `SS` | 5 | `PB4` | Out | EEPROM, active low |
| SPI `MOSI` | 6 | `PB5` | Out | |
| SPI `MISO` | 7 | `PB6` | In | |
| SPI `SCK` | 8 | `PB7` | Out | |
| I2C `SCL` | 22 | `PC0` | Out | 4.7 kΩ pull-up |
| I2C `SDA` | 23 | `PC1` | Bidir | 4.7 kΩ pull-up |
| Fault LED | 24 | `PC2` | Out | Steady = tripped |
| FWD indicator | 25 | `PC3` | Out | |
| REV indicator | 26 | `PC4` | Out | |
| Start button | 27 | `PC5` | In, pull-up | Momentary |
| Stop button | 28 | `PC6` | In, pull-up | Momentary |
| Reverse button | 29 | `PC7` | In, pull-up | Momentary |
| USART `RXD` | 14 | `PD0` | In | 9600 8N1 |
| USART `TXD` | 15 | `PD1` | Out | 9600 8N1 |
| Tacho / encoder | 16 | `PD2` / INT0 | In | Rising edge, counted |
| **Emergency stop** | 17 | `PD3` / INT1 | In, pull-up | **NC contact**, rising edge = trip |
| Local / Remote | 18 | `PD4` | In, pull-up | Low = local |
| Motor PWM | 19 | `PD5` / OC1A | PWM out | 20 kHz |
| Reset / acknowledge | 20 | `PD6` | In, pull-up | Momentary |
| Buzzer | 21 | `PD7` / OC2 | Out | Trip tones |

> `PC2` – `PC7` carry indicators and the operator buttons: **clear the `JTAGEN`
> fuse**, or Start and Stop will not work.

### Emergency-stop wiring — read this twice

```
        +5V
         │
        ┌┴┐ 10 kΩ (internal pull-up is also enabled)
        └┬┘
         ├──────────────▶ PD3 / INT1
         │
        ─┴─  E-STOP button, NORMALLY CLOSED
         │
        GND
```

- **Healthy:** the NC contact is closed → `PD3` reads **low**.
- **Pressed:** contact opens → `PD3` goes **high** → rising-edge interrupt.
- **Broken wire:** the circuit opens → `PD3` goes **high** → *also* trips.

A normally *open* button would read low when pressed **and** low when the wire
breaks — the fault would be silent. This is the difference between a safety
input and an ordinary button, and it is examinable.

---

## 8. Peripherals Used

| Peripheral | Configuration | Role |
|------------|---------------|------|
| **GPIO** | `PB0..PB3`, `PC2..PC4` out; buttons in + pull-up | Bridge, indicators, panel |
| **ADC** | Single conversion, prescaler 64, AVCC ref | 4 channels, current fastest |
| **Timer0** | CTC, prescaler 1024, `OCR0 = 77` | 10 ms system tick |
| **Timer1** | Fast PWM mode 14, `ICR1 = 399`, prescaler 1 | 20 kHz motor PWM on `OC1A` |
| **Timer2** | Fast PWM, OC2 | Buzzer tones |
| **INT0** | Rising edge | Tacho pulse counting |
| **INT1** | Rising edge | **Emergency stop** |
| **USART** | 9600 8N1, RX interrupt | SCADA / console |
| **SPI** | Master, Mode 0, f/16 | 25LC256 |
| **I2C (TWI)** | Master, 100 kHz | PCF8574 → LCD |

### PWM derivation

```
Fast PWM mode 14 (WGM13:0 = 1110), TOP = ICR1, prescaler 1

f_pwm = F_CPU / (N × (1 + TOP)) = 8 000 000 / (1 × 400) = 20 000 Hz
duty resolution = 400 steps  →  0.25 % per step
OCR1A = 0 … 399
```

Why 20 kHz? Below ~16 kHz the motor whines audibly; far above it, switching
losses and the H-bridge's slew rate dominate, and the 400-step resolution would
shrink. State this trade-off in your report.

### Tacho derivation

```
Encoder: 6 pulses per shaft revolution
Window : 100 ms

rev/s = (count × 10) / 6
RPM   = rev/s × 60 = count × 100
```

At 3000 RPM the window collects 30 pulses. Resolution is therefore **100 RPM per
count** — coarse. Discuss in your report how you would improve it (longer
window = slower loop; higher PPR = better) and why 100 ms is the compromise
chosen here.

---

## 9. Software Architecture

### 9.1 Layer view

```
┌───────────────────────────────────────────────────────────────────┐
│ APP                                                               │
│ ┌──────────┐ ┌─────────┐ ┌──────────┐ ┌─────────┐ ┌────────────┐  │
│ │ drive_fsm│ │  pi_ctl │ │  ramp    │ │protect  │ │  console   │  │
│ │          │ │ (Q8)    │ │ generator│ │(trips)  │ │            │  │
│ └────┬─────┘ └────┬────┘ └────┬─────┘ └────┬────┘ └─────┬──────┘  │
│      └────────────┴──── scheduler (10 ms) ─┴────────────┘         │
├───────────────────────────────────────────────────────────────────┤
│ HAL                                                               │
│  bridge.c  tacho.c  analog.c  panel.c  lcd_i2c.c                  │
│  eeprom_spi.c  triplog.c  chime.c                                 │
├───────────────────────────────────────────────────────────────────┤
│ MCAL                                                              │
│  dio.c  adc.c  timer.c  pwm.c  exti.c  usart.c  spi.c  i2c.c      │
├───────────────────────────────────────────────────────────────────┤
│ LIB    STD_TYPES.h  BIT_MATH.h  ring_buffer.c                     │
└───────────────────────────────────────────────────────────────────┘
```

### 9.2 The control chain

```
  setpoint pot ──▶ scale ──▶ ramp generator ──▶ rampedSetpoint
                                                     │
                                    ┌────────────────┤
                                    ▼                │
  encoder ──▶ tacho ──▶ measured ──▶ (−) ──▶ error ──▶ PI ──▶ duty
                                                              │
                                                     clamp 0..399
                                                              │
                              protect.c (trips) ──▶ override ─┤
                                                              ▼
                                                        bridge.c ──▶ OCR1A
```

**Only `bridge.c` writes `OCR1A` and the direction pins.** Every other module
publishes an intent. A trip forces `duty = 0` and `EN = 0` regardless of what
the PI controller wants.

### 9.3 The PI controller in Q8 fixed point

```c
#define Q  8                       /* 8 fractional bits: 1.0 == 256      */

typedef struct {
    int16_t kp;                    /* Q8: kp = 1.5 → 384                 */
    int16_t ki;                    /* Q8, applied per 100 ms sample      */
    int32_t integ;                 /* Q8 accumulator                     */
    int16_t outMin, outMax;        /* 0 .. PWM_TOP                       */
    int16_t lastError;
} Pi_t;

int16_t PI_Step(Pi_t *c, int16_t setRpm, int16_t measRpm)
{
    int16_t error = (int16_t)(setRpm - measRpm);

    int32_t p = ((int32_t)c->kp * error) >> Q;          /* proportional  */

    /* tentative integral */
    int32_t newInteg = c->integ + ((int32_t)c->ki * error);
    int32_t i        = newInteg >> Q;

    int32_t out = p + i;

    /* --- anti-windup: only accept the new integral if the output
           is NOT saturated in the direction the integral is pushing --- */
    if (out > c->outMax) {
        out = c->outMax;
        if (error < 0) c->integ = newInteg;   /* unwinding is allowed    */
    } else if (out < c->outMin) {
        out = c->outMin;
        if (error > 0) c->integ = newInteg;
    } else {
        c->integ = newInteg;
    }

    c->lastError = error;
    return (int16_t)out;
}
```

**Required in your report:** run the controller once with the anti-windup block
removed, capture the overshoot after a long saturated period, then re-enable it
and capture the improvement. That before/after pair is worth more than a
paragraph of theory.

Default gains: `kp = 384` (1.5), `ki = 26` (≈ 0.1). These are a starting point,
not an answer — tune them and record what you changed and why.

### 9.4 Protection ladder

Evaluated **before** the PI output reaches the bridge, in this fixed order:

| Priority | Trip | Condition | Response time |
|:--------:|------|-----------|---------------|
| 1 | `TRIP_ESTOP` | `INT1` rising (button or broken wire) | **≤ 1 ms**, in the ISR |
| 2 | `TRIP_SHORT` | Current ≥ 18.0 A | ≤ 50 ms |
| 3 | `TRIP_OVERLOAD` | Inverse-time curve, §11.4 | 1 – 60 s |
| 4 | `TRIP_OVERTEMP` | Winding ≥ 110 °C for 2 s | ≤ 2.1 s |
| 5 | `TRIP_UNDERVOLT` | Bus < 20.0 V for 500 ms | ≤ 600 ms |
| 6 | `TRIP_OVERVOLT` | Bus > 55.0 V for 200 ms | ≤ 300 ms |
| 7 | `TRIP_STALL` | Duty > 50 % ∧ RPM < 100 for 3 s | ≤ 3.1 s |
| 8 | `TRIP_OVERSPEED` | RPM > setpoint + 500 for 1 s | ≤ 1.1 s |
| 9 | `TRIP_NOFEEDBACK` | Duty > 20 % ∧ zero pulses for 2 s | ≤ 2.1 s |

All trips latch. All require acknowledgement **and** the cause to have cleared.

### 9.5 Module responsibilities

| Module | Owns | Public API (suggested) |
|--------|------|------------------------|
| `drive_fsm` | Drive state, sequencing, latch | `FSM_Init`, `FSM_Run`, `FSM_GetState` |
| `pi_ctl` | The PI controller | `PI_Init`, `PI_Step`, `PI_Reset`, `PI_SetGains` |
| `ramp` | Setpoint ramping, accel/decel limits | `RMP_Set`, `RMP_Step`, `RMP_AtTarget` |
| `protect` | The trip ladder + I²t accumulator | `PRT_Evaluate`, `PRT_Reset`, `PRT_Active` |
| `bridge` | **Only** writer of `OCR1A`, `IN1`, `IN2`, `EN` | `BRG_SetDuty`, `BRG_SetDir`, `BRG_Coast`, `BRG_Brake` |
| `tacho` | INT0 count → RPM, direction sanity | `TAC_OnPulse`, `TAC_Update100ms`, `TAC_GetRpm` |
| `analog` | 4 channels, scaling, filtering | `ANA_Update`, `ANA_CurrentmA`, `ANA_BusmV`, `ANA_TempC`, `ANA_SetpointRpm` |
| `panel` | Buttons, indicators, local/remote | `PNL_Poll`, `PNL_Event` |
| `triplog` | 16-entry trip ring in EEPROM | `TLG_Append`, `TLG_Dump` |

### 9.6 Concurrency contract

- `ISR(INT1_vect)` — the E-stop — performs exactly three actions:
  `OCR1A = 0;` `PORTB &= ~(EN|IN1|IN2);` `g_estop = 1;`
  This is the second documented exception to the layer rule; justify it.
- `ISR(INT0_vect)` increments a `volatile uint16_t` and nothing else.
- The PI controller runs only in the 100 ms task, never in an ISR.
- `OCR1A` is 16-bit: writes from the main context must be atomic.

---

## 10. Data Dictionary (required data)

### 10.1 Runtime data — `DD-01 DriveData_t`

```c
typedef struct {
    int16_t  setpointRpm;      /* from pot or console, 0..3000            */
    int16_t  rampedRpm;        /* after accel/decel limiting              */
    int16_t  measuredRpm;      /* from tacho                              */
    int16_t  errorRpm;         /* ramped - measured                       */
    uint16_t dutyCounts;       /* 0..399, what bridge.c applied           */
    uint8_t  dutyPct;          /* 0..100, for display                     */
    uint16_t currentmA;        /* 0..20000                                */
    uint16_t busmV;            /* 0..60000                                */
    uint8_t  tempC;            /* 0..150                                  */
    uint32_t i2tAccum;         /* thermal replica for the overload curve  */
    uint8_t  dir;              /* Dir_t                                   */
    uint8_t  state;            /* DriveState_t                            */
    uint8_t  activeTrip;       /* Trip_t                                  */
    uint8_t  remote     : 1;   /* 1 = remote (console) control            */
    uint8_t  estopRaw   : 1;   /* live INT1 pin state                     */
    uint8_t  atSetpoint : 1;
    uint8_t  reserved   : 5;
    uint32_t runSeconds;       /* current run                             */
    uint32_t totalRunSec;      /* lifetime                                */
    uint16_t startCount;       /* lifetime starts                         */
    uint32_t upTimeSec;
} DriveData_t;
```

### 10.2 Persisted parameters — `DD-02 DriveCfg_t`

```c
#define DRV_MAGIC   0x4D44u      /* 'M','D'                               */
#define DRV_VERSION 0x01u

typedef struct {
    uint16_t magic;
    uint8_t  version;
    uint16_t maxRpm;             /* full-scale speed        (3000)        */
    uint16_t minRpm;             /* minimum run speed       (200)         */
    uint16_t accelRpmPerSec;     /* ramp up rate            (600)         */
    uint16_t decelRpmPerSec;     /* ramp down rate          (900)         */
    uint16_t deadTimeMs;         /* reversal dead time      (500)         */
    int16_t  kp;                 /* Q8                      (384)         */
    int16_t  ki;                 /* Q8                      (26)          */
    uint16_t ratedCurrentmA;     /* thermal reference       (8000)        */
    uint16_t shortTripmA;        /* instantaneous           (18000)       */
    uint8_t  overTempC;          /* winding trip            (110)         */
    uint16_t underVoltmV;        /* bus low                 (20000)       */
    uint16_t overVoltmV;         /* bus high                (55000)       */
    uint16_t stallSec;           /* stall confirm           (3)           */
    uint32_t totalRunSec;
    uint16_t startCount;
    uint8_t  tripHead;           /* ring index 0..15                      */
    uint8_t  latchedTrip;        /* survives power loss                   */
    uint8_t  checksum;
} DriveCfg_t;                    /* 42 bytes                              */
```

### 10.3 Trip record — `DD-03 TripRec_t`

```c
typedef struct {
    uint8_t  trip;            /* Trip_t                                   */
    uint32_t timeSec;         /* uptime at trip                           */
    int16_t  rpm;             /* snapshot                                 */
    uint16_t currentmA;
    uint16_t busmV;
    uint8_t  tempC;
    uint8_t  dutyPct;
} TripRec_t;                  /* 13 bytes, padded to 14 in EEPROM         */
```

### 10.4 Enumerations — `DD-04`

```c
typedef enum { DS_INIT = 0, DS_STOPPED, DS_STARTING, DS_RUNNING,
               DS_RAMP_DOWN, DS_DEAD_TIME, DS_BRAKING, DS_COASTING,
               DS_TRIPPED, DS_ESTOP }                       DriveState_t;

typedef enum { DIR_STOP = 0, DIR_FWD, DIR_REV }             Dir_t;

typedef enum { TRIP_NONE = 0, TRIP_ESTOP, TRIP_SHORT, TRIP_OVERLOAD,
               TRIP_OVERTEMP, TRIP_UNDERVOLT, TRIP_OVERVOLT,
               TRIP_STALL, TRIP_OVERSPEED, TRIP_NOFEEDBACK } Trip_t;
```

### 10.5 Derived constants — `DD-05`

| Constant | Value | Meaning |
|----------|-------|---------|
| `PWM_TOP` | 399 | `ICR1`, gives 20 kHz and 400 steps |
| `PWM_MIN_RUN` | 40 | 10 % — below this the motor cannot turn |
| `TACHO_PPR` | 6 | Pulses per revolution |
| `TACHO_WINDOW_MS` | 100 | Speed measurement window |
| `RPM_PER_COUNT` | 100 | `(60 000 / TACHO_WINDOW_MS) / TACHO_PPR` |
| `PI_PERIOD_MS` | 100 | Control loop period |
| `Q` | 8 | Fixed-point fractional bits |
| `DEADTIME_TICKS` | 50 | 500 ms between directions |
| `I2T_LIMIT` | 3 600 000 | Overload curve constant, §11.4 |
| `ESTOP_DEBOUNCE_TICKS` | 0 | **None** — the E-stop acts immediately |
| `ACK_HOLD_TICKS` | 100 | 1 s acknowledge press |

> The E-stop is deliberately **not** debounced. A safety input must act on the
> first edge; a bounce that produces a spurious trip is a nuisance, a bounce
> that delays a real trip is an injury. Say this in your report.

---

## 11. System Specifications

### 11.1 Speed

| Parameter | Value |
|-----------|-------|
| Range | 0 – 3000 RPM |
| Minimum run speed | 200 RPM (below this the drive stops rather than crawls) |
| Measurement resolution | 100 RPM |
| Steady-state accuracy | ±100 RPM (one tacho count) at ≥ 500 RPM |
| Setpoint source | Pot in `LOCAL`, console in `REMOTE` |

### 11.2 Ramps

| Phase | Default rate | Range |
|-------|:------------:|-------|
| Acceleration | 600 RPM/s | 100 – 3000 |
| Deceleration | 900 RPM/s | 100 – 3000 |
| Reversal dead time | 500 ms | 200 – 2000 ms |

A 0 → 3000 RPM start therefore takes 5 s; a full reversal takes
3000/900 + 0.5 + 3000/600 = **8.83 s**. Show this on your timing diagram.

### 11.3 Current bands

| Band | Range | Behaviour |
|------|-------|-----------|
| No load | 0.0 – 1.9 A | Normal |
| Normal | 2.0 – 8.0 A | At or below rated |
| Overload | 8.1 – 17.9 A | Inverse-time curve accumulates |
| Short circuit | ≥ 18.0 A | Instantaneous trip |

### 11.4 Inverse-time overload curve

A thermal replica, updated every 100 ms:

```c
/* i2t accumulates when above rated, decays when below */
int32_t excess = (int32_t)currentmA - (int32_t)cfg.ratedCurrentmA;
if (excess > 0) {
    d->i2tAccum += (uint32_t)((excess * excess) / 1000);
} else {
    uint32_t decay = (uint32_t)((-excess * -excess) / 4000);
    d->i2tAccum = (d->i2tAccum > decay) ? (d->i2tAccum - decay) : 0u;
}
if (d->i2tAccum >= I2T_LIMIT) trip(TRIP_OVERLOAD);
```

Resulting approximate trip times (rated 8 A, `I2T_LIMIT` = 3 600 000):

| Current | Excess | Trip time |
|--------:|-------:|----------:|
| 9 A | 1 A | ~ 60 min (effectively never in a demo) |
| 12 A | 4 A | ~ 22 s |
| 16 A | 8 A | ~ 5.6 s |
| 18 A | — | instantaneous (`TRIP_SHORT`) |

Tune `I2T_LIMIT` so the 12 A case trips in roughly 20 s — that makes it
demonstrable inside a video. Record your chosen value and the measured times.

### 11.5 Voltage and temperature

| Channel | Trip | Clear |
|---------|------|-------|
| Bus under-voltage | < 20.0 V for 500 ms | > 22.0 V |
| Bus over-voltage | > 55.0 V for 200 ms | < 53.0 V |
| Winding temperature | ≥ 110 °C for 2 s | ≤ 95 °C |

### 11.6 Control modes

| Mode | Setpoint from | Start/Stop from | Selected by |
|------|---------------|-----------------|-------------|
| `LOCAL` | Pot (ADC0) | Panel buttons | `PD4` low |
| `REMOTE` | Console `SPEED <n>` | Console `RUN` / `STOP` | `PD4` high |

The **Stop button and the E-stop work in both modes, always.** A remote mode
that ignores the local stop button is a design defect.

---

## 12. Inputs & Outputs

### 12.1 Inputs

| ID | Name | Channel | Type | Sample rate |
|----|------|---------|------|-------------|
| IN-1 | Speed setpoint | ADC0 | Analog | 10 Hz |
| IN-2 | Motor current | ADC1 | Analog | 20 Hz |
| IN-3 | Bus voltage | ADC2 | Analog | 10 Hz |
| IN-4 | Winding temperature | ADC3 | Analog | 2 Hz |
| IN-5 | Tacho pulses | `PD2`/INT0 | Pulse count | Window 100 ms |
| IN-6 | **Emergency stop** | `PD3`/INT1 | Digital, edge | Interrupt, no debounce |
| IN-7 | Start / Stop / Reverse | `PC5`…`PC7` | Digital, polled | 100 Hz |
| IN-8 | Reset / acknowledge | `PD6` | Digital, polled | 100 Hz |
| IN-9 | Local / Remote | `PD4` | Digital, polled | 20 Hz |
| IN-10 | Console | USART RX | ASCII line | Interrupt |

### 12.2 Outputs

| ID | Name | Pin | Type | Meaning |
|----|------|-----|------|---------|
| OUT-1 | Motor PWM | `PD5`/OC1A | 20 kHz PWM | 0 – 100 % duty |
| OUT-2 | Direction `IN1` / `IN2` | `PB0`, `PB1` | Digital | Bridge polarity |
| OUT-3 | Bridge enable | `PB2` | Digital | Low = coast |
| OUT-4 | Run LED | `PB3` | Digital | Steady = running, 2 Hz blink = ramping |
| OUT-5 | Fault LED | `PC2` | Digital | Steady = tripped |
| OUT-6 | FWD / REV LEDs | `PC3`, `PC4` | Digital | Direction |
| OUT-7 | Buzzer | `PD7`/OC2 | PWM tone | Trip annunciation |
| OUT-8 | LCD | I2C | 16×2 text | Operator panel |
| OUT-9 | Telemetry | USART TX | ASCII | 1 s frame + events |

---

## 13. Functional Requirements

### FR-01 — PWM generation

The system **shall** generate a 20 kHz PWM on `OC1A` using Timer1 Fast PWM mode
14 with `ICR1 = 399`.

**Acceptance criteria**
- Measured frequency 20 kHz ±1 %.
- Duty resolution 400 steps; `OCR1A = 0` gives a continuously low output (no
  runt pulse) and `OCR1A = 399` gives ≥ 99.5 % duty.
- `OCR1A` is written atomically from the main context.

### FR-02 — Speed measurement

The system **shall** count `INT0` pulses over a **100 ms** window and publish
shaft speed at 10 Hz.

**Acceptance criteria**
- `RPM = count × 100` for 6 pulses per revolution.
- Accuracy ±100 RPM from 300 to 3000 RPM against the injected frequency.
- The counter is read and zeroed atomically; no pulse is lost or double-counted
  across a window boundary.
- With no pulses the published speed is 0, not stale.

### FR-03 — Setpoint acquisition and ramping

The setpoint **shall** be limited by the configured acceleration and
deceleration rates before reaching the controller.

**Acceptance criteria**
- A step from 0 to 3000 RPM on the pot produces a linear ramp taking
  3000/`accelRpmPerSec` seconds ±5 %.
- Deceleration uses `decelRpmPerSec`, which may differ from acceleration.
- The ramp is recomputed every 100 ms in integer maths.
- A setpoint below `minRpm` while running commands a stop, not a crawl.

### FR-04 — Closed-loop PI speed control

The system **shall** hold the measured speed at the ramped setpoint using the PI
controller of §9.3, executed every **100 ms**.

**Acceptance criteria**
- Steady-state error ≤ 100 RPM (one tacho count) at 1500 RPM with a constant
  load.
- A load step that would drop an open-loop drive by 400 RPM is corrected to
  within 100 RPM in ≤ 2 s.
- Overshoot on a 0 → 1500 RPM step is ≤ 15 %.
- The output is clamped to `[PWM_MIN_RUN, PWM_TOP]` while running and forced to 0
  when stopped.
- **No `float` anywhere.** Code inspection will confirm.

### FR-05 — Anti-windup

The integral term **shall** not accumulate while the output is saturated in the
direction the integral is pushing.

**Acceptance criteria**
- Hold the motor stalled (or set an unreachable setpoint) for 30 s, then release:
  the drive must **not** slam to full speed and overshoot wildly.
- The report contains a before/after capture proving the difference.
- `PI_Reset()` clears the integral on every transition into `DS_STARTING`.

### FR-06 — Start sequence

Pressing Start (or `RUN`) from `DS_STOPPED` **shall** run the sequence
`DS_STARTING → DS_RUNNING`.

**Acceptance criteria**
- The direction pins are set **before** any duty is applied.
- `PI_Reset()` is called on entry; the integral starts from zero.
- The Run LED blinks at 2 Hz while ramping and goes steady when the measured
  speed is within 100 RPM of the setpoint for 1 s.
- `startCount` increments and is persisted.
- Starting while a trip is latched is refused with `ERR TRIPPED`.

### FR-07 — Stop sequence

Pressing Stop (or `STOP`) **shall** ramp the speed down to zero, then coast.

**Acceptance criteria**
- Deceleration follows `decelRpmPerSec`.
- At zero speed the bridge is disabled (`EN` low) and both direction pins are
  cleared.
- The Stop button works in `REMOTE` mode as well as `LOCAL`.
- `runSeconds` is added to `totalRunSec` and persisted.

### FR-08 — Direction reversal with dead time

Pressing Reverse while running **shall** run
`DS_RAMP_DOWN → DS_DEAD_TIME → DS_STARTING` in the new direction.

**Acceptance criteria**
- Duty reaches 0 **before** the direction pins change — verified on the scope.
- Both direction pins are low for the whole `deadTimeMs` (default 500 ms); at no
  instant are `IN1` and `IN2` both high.
- The sequence cannot be short-circuited by pressing Reverse repeatedly.
- Total reversal time matches the calculation of §11.2 ±10 %.

### FR-09 — Emergency stop (fail-safe)

A rising edge on `INT1` **shall** stop the drive within **1 ms**, in the ISR.

**Acceptance criteria**
- The ISR sets `OCR1A = 0`, clears `EN`, `IN1` and `IN2`, and sets a flag —
  nothing else.
- Measured time from the edge to the PWM pin going low ≤ 1 ms.
- **Opening the E-stop wire** (simulating a break) trips exactly like pressing
  the button. This is the requirement that proves the NC design.
- `DS_ESTOP` is latched and cannot be cleared until the contact is closed again
  **and** the reset button is pressed.
- The E-stop works in every state, including `DS_INIT`.

### FR-10 — Short-circuit protection

Current ≥ `shortTripmA` (18.0 A) **shall** trip within **50 ms**.

**Acceptance criteria**
- No confirm delay beyond the 50 ms sampling period.
- Trip is latched with a snapshot in the trip log.

### FR-11 — Inverse-time overload protection

The system **shall** implement the thermal replica of §11.4.

**Acceptance criteria**
- 12 A trips in the documented time ±20 %.
- 9 A does not trip within 60 s.
- The accumulator **decays** when the current falls below rated — verified by
  running 12 A for half the trip time, dropping to 4 A for a while, and showing
  the trip time extends.
- The accumulator is displayed as a "thermal capacity used" percentage on the
  LCD.

### FR-12 — Voltage and temperature protection

The system **shall** trip on the conditions of §11.5.

**Acceptance criteria**
- Each has the stated confirm delay; a shorter excursion does not trip.
- Each has a clear-side hysteresis so the trip cannot chatter.

### FR-13 — Stall and feedback-loss detection

The system **shall** trip on stall and on loss of tacho feedback.

**Acceptance criteria**
- `TRIP_STALL`: duty > 50 % with RPM < 100 for 3 s.
- `TRIP_NOFEEDBACK`: duty > 20 % with **zero** pulses for 2 s — this catches a
  disconnected encoder, which would otherwise make the PI controller wind the
  duty to maximum.
- Disconnecting the tacho source while running must trip, not run away. This is
  the most important test in the project.

### FR-14 — Over-speed protection

Measured speed exceeding the setpoint by more than 500 RPM for 1 s **shall**
raise `TRIP_OVERSPEED`.

**Acceptance criteria**
- Catches a runaway caused by a stuck PWM or a mechanical fault.
- Does not fire during normal acceleration overshoot (≤ 15 %).

### FR-15 — Trip latching and acknowledgement

Every trip **shall** latch, drive the outputs safe, and require acknowledgement
plus a cleared cause.

**Acceptance criteria**
- Acknowledgement = 1 s press of Reset, or `ACK`.
- Acknowledging while the cause persists returns `ERR ACTIVE`.
- The buzzer sounds until acknowledged, then goes silent while the trip stays
  latched.
- `latchedTrip` is written to EEPROM immediately, so a power cut cannot clear it.
- Every trip is appended to the 16-entry trip ring with a full snapshot.

### FR-16 — Local / Remote control

The `PD4` switch **shall** select the setpoint and command source per §11.6.

**Acceptance criteria**
- In `REMOTE` the pot is ignored; `SPEED <n>` sets the target.
- In `LOCAL` the console commands `RUN`, `STOP`, `SPEED` return `ERR MODE`.
- The **Stop button and the E-stop work in both modes** — verified explicitly.
- Switching mode while running does not change the running speed until a new
  setpoint arrives.

### FR-17 — LCD operator panel

The LCD **shall** refresh every **250 ms**:

```
Line 1: SET1500 ACT1500 F
Line 2: 62% 6.4A 48V 72C
```

**Acceptance criteria**
- Direction shown as `F`, `R` or `-`.
- In `DS_TRIPPED` line 2 becomes `!TRIP OVERLOAD` alternating with the data line
  every 1.5 s.
- A second page (cycled by holding Reset briefly) shows run hours, start count
  and thermal capacity used.
- Only changed characters are rewritten.

### FR-18 — Run-hour and start accounting

The system **shall** accumulate lifetime run seconds and start count.

**Acceptance criteria**
- Run seconds increment only while the bridge is enabled and the speed is above
  `minRpm`.
- Persisted at every stop and every 5 minutes while running.
- Reported by `HOURS?` as `HOURS=hhhh:mm`.

### FR-19 — Telemetry and console

The system **shall** transmit the frame of §18.1 every **1 s** and accept the
commands of §18.2.

**Acceptance criteria**
- 1 s cadence, not 5 s — a drive is a fast process and the SCADA link needs it.
- `SET KP`/`SET KI` take effect on the next control cycle without a restart.
- Parser robustness per the book standard.

---

## 14. Non-Functional Requirements

| ID | Requirement |
|----|-------------|
| **NFR-01** | Compiles with `avr-gcc -std=c99 -Wall -Wextra -Os`, zero warnings. |
| **NFR-02** | No blocking delay > 10 ms in the super-loop; `_delay_ms` only in `*_Init()`. |
| **NFR-03** | **No floating-point arithmetic anywhere.** The PI controller is Q8 fixed point. |
| **NFR-04** | The E-stop path from edge to PWM low is ≤ 1 ms and does not depend on the scheduler. |
| **NFR-05** | `IN1` and `IN2` are never both high, in any state or transition, including reset. |
| **NFR-06** | Only `bridge.c` writes `OCR1A`, `IN1`, `IN2` and `EN`. |
| **NFR-07** | The PI control loop period is fixed at 100 ms ±1 ms — a jittery loop invalidates the gains. |
| **NFR-08** | Protections are evaluated before the PI output is applied, every cycle. |
| **NFR-09** | Layer rule respected, with the documented `INT1` exception. |
| **NFR-10** | ISRs ≤ 10 lines; no division or multiplication in the tacho ISR. |
| **NFR-11** | 16-bit register accesses are atomic. |
| **NFR-12** | Tick jitter ≤ ±1 ms; CPU load ≤ 60 %, measured on a spare pin. |
| **NFR-13** | `.data + .bss` ≤ 1 KB. |
| **NFR-14** | On any reset the bridge is disabled and the duty is 0 **before** any other initialisation. |
| **NFR-15** | A latched trip survives a power cycle and a watchdog reset. |

---

## 15. Operating Modes

| State | PWM | Direction pins | Bridge `EN` | PI loop |
|-------|-----|----------------|:-----------:|:-------:|
| `DS_INIT` | 0 | Both low | Low | Off |
| `DS_STOPPED` | 0 | Both low | Low | Off |
| `DS_STARTING` | Ramping | Set for direction | High | **On** |
| `DS_RUNNING` | Closed loop | Set for direction | High | **On** |
| `DS_RAMP_DOWN` | Ramping down | Held | High | On |
| `DS_DEAD_TIME` | 0 | **Both low** | Low | Off |
| `DS_BRAKING` | 0 | Both high-side (dynamic brake) | High | Off |
| `DS_COASTING` | 0 | Both low | Low | Off |
| `DS_TRIPPED` | 0 | Both low | Low | Off |
| `DS_ESTOP` | 0 | Both low | Low | Off |

---

## 16. System Flow

```
   ┌──────────────┐
   │  Power ON    │
   └──────┬───────┘
          ▼
   ┌───────────────────────────────────────┐
   │ FIRST: DDRB set, PB0/PB1/PB2 = 0,     │  ← before anything else
   │ OCR1A = 0                             │
   └──────┬────────────────────────────────┘
          ▼
   ┌───────────────────────────────────────┐
   │ MCAL init: ADC, T0, T1 PWM, T2,       │
   │ EXTI (INT1 armed first), USART,       │
   │ SPI, I2C                              │
   └──────┬────────────────────────────────┘
          ▼
   ┌───────────────────────────────────────┐  invalid ┌────────────┐
   │ Load DriveCfg_t, verify checksum      ├─────────▶│ Defaults + │
   └──────┬────────────────────────────────┘          │ write back │
          │ valid                                     └─────┬──────┘
          ▼◀───────────────────────────────────────────────┘
   ┌───────────────────────────────────────┐
   │ E-stop closed?  no → DS_ESTOP         │
   │ latchedTrip?    yes → DS_TRIPPED      │
   │ else                → DS_STOPPED      │
   └──────┬────────────────────────────────┘
          ▼
╔════════════════════════════════════════════════════════════╗
║             SUPER-LOOP (dispatch on 10 ms tick)            ║
║                                                            ║
║   10 ms → panel buttons, drive FSM, E-stop flag            ║
║   50 ms → current ADC, short-circuit check                 ║
║  100 ms → tacho window close, ramp, PROTECT, PI, bridge    ║
║  250 ms → LCD repaint                                      ║
║  500 ms → bus voltage, temperature, i2t decay display      ║
║    1 s  → run-hour accounting, telemetry frame             ║
║    5 m  → periodic run-hour persistence                    ║
║  event  → trip log append, EEPROM latch write              ║
╚════════════════════════════════════════════════════════════╝
```

**Critical ordering inside the 100 ms slot:**
`tacho → ramp → PRT_Evaluate() → PI_Step() → BRG_SetDuty()`.
Protections run *between* the controller and the bridge so a trip can veto the
controller's output in the same cycle.

---

## 17. State Machine

### 17.1 Diagram

```
                    ┌──────────┐
        power on    │ DS_INIT  │  outputs safe
       ────────────▶│          │
                    └────┬─────┘
                         │ E-stop closed, no latched trip
                         ▼
              ┌────────────────────┐
    ┌────────▶│    DS_STOPPED      │◀───────────────┐
    │         └─────────┬──────────┘                │
    │            START  │                           │ speed = 0
    │                   ▼                           │
    │         ┌────────────────────┐        ┌───────────────┐
    │         │    DS_STARTING     │        │ DS_COASTING   │
    │         │  ramp + PI, blink  │        └───────▲───────┘
    │         └─────────┬──────────┘                │
    │        at setpoint│                           │
    │                   ▼                           │
    │         ┌────────────────────┐   STOP  ┌──────────────┐
    │         │     DS_RUNNING     ├────────▶│DS_RAMP_DOWN  │
    │         └───┬────────────┬───┘         └──────┬───────┘
    │     REVERSE │            │ trip               │ speed = 0
    │             ▼            │                    └────────┘
    │  ┌────────────────────┐  │
    │  │   DS_RAMP_DOWN     │  │
    │  └─────────┬──────────┘  │
    │    speed=0 ▼             │
    │  ┌────────────────────┐  │
    │  │   DS_DEAD_TIME     │  │  both direction pins LOW, 500 ms
    │  └─────────┬──────────┘  │
    │            └────▶ DS_STARTING (new direction)
    │                          │
    │       ┌──────────────────┘
    │       ▼
    │  ┌────────────────────┐  ACK && cause cleared
    └──┤    DS_TRIPPED      ├──────────────────────────┐
       └────────────────────┘                          │
                                                       ▼
       ┌────────────────────┐  contact closed &&   DS_STOPPED
       │     DS_ESTOP       ├──── reset pressed ───────┘
       └────────────────────┘
              ▲
              └──── INT1 rising edge, from ANY state ────
```

### 17.2 Transition table

| # | From | Event / guard | To | Actions |
|---|------|---------------|----|---------|
| T1 | `DS_INIT` | E-stop closed ∧ no latched trip | `DS_STOPPED` | Log `!EVT,BOOT` |
| T2 | `DS_INIT` | E-stop open | `DS_ESTOP` | Log `!EVT,ESTOP,BOOT` |
| T3 | `DS_INIT` | Latched trip in EEPROM | `DS_TRIPPED` | Restore cause, log |
| T4 | `DS_STOPPED` | START ∧ no trip ∧ setpoint ≥ `minRpm` | `DS_STARTING` | Set direction, `PI_Reset()`, `EN` high, `startCount++` |
| T5 | `DS_STOPPED` | START ∧ trip latched | `DS_STOPPED` | Refuse, `ERR TRIPPED` |
| T6 | `DS_STARTING` | \|error\| ≤ 100 RPM for 1 s | `DS_RUNNING` | Run LED steady, `atSetpoint = 1` |
| T7 | `DS_RUNNING` ∨ `DS_STARTING` | STOP | `DS_RAMP_DOWN` | Target 0, keep direction |
| T8 | `DS_RAMP_DOWN` | Speed = 0 ∧ reversal not pending | `DS_COASTING` | `EN` low, both dir pins low |
| T9 | `DS_COASTING` | Speed = 0 for 500 ms | `DS_STOPPED` | Persist run seconds |
| T10 | `DS_RUNNING` | REVERSE | `DS_RAMP_DOWN` | Flag reversal pending |
| T11 | `DS_RAMP_DOWN` | Speed = 0 ∧ reversal pending | `DS_DEAD_TIME` | **Both dir pins low**, `EN` low, start 500 ms timer |
| T12 | `DS_DEAD_TIME` | Timer expired | `DS_STARTING` | New direction pins, `PI_Reset()`, `EN` high |
| T13 | any | `PRT_Evaluate() != TRIP_NONE` | `DS_TRIPPED` | Duty 0, `EN` low, latch, persist, log, buzzer |
| T14 | `DS_TRIPPED` | ACK ∧ cause cleared | `DS_STOPPED` | Clear latch, clear EEPROM latch, silence |
| T15 | `DS_TRIPPED` | ACK ∧ cause active | `DS_TRIPPED` | `ERR ACTIVE`, silence buzzer only |
| T16 | **any** | `INT1` rising edge | `DS_ESTOP` | ISR: duty 0, all bridge pins low, flag |
| T17 | `DS_ESTOP` | Contact closed ∧ Reset pressed | `DS_STOPPED` | Clear latch, log `!EVT,ESTOP,CLR` |
| T18 | `DS_ESTOP` | Reset ∧ contact still open | `DS_ESTOP` | `ERR ACTIVE` |

---

## 18. UART Protocol

**Link:** 9600 8N1. Device sends `\r\n`; accepts `\r`, `\n`, `\r\n`.

### 18.1 Telemetry frame (every **1 s**)

```
$MD,SP=1500,RP=1500,D=62,I=6400,V=48200,T=72,DIR=F,ST=RUN,TR=0,I2T=18,RH=41230,SC=87*2E
```

| Field | Meaning | Units |
|-------|---------|-------|
| `SP` | Ramped setpoint | RPM |
| `RP` | Measured speed | RPM |
| `D` | Duty | % |
| `I` | Current | mA |
| `V` | Bus voltage | mV |
| `T` | Winding temperature | °C |
| `DIR` | `F` \| `R` \| `-` | |
| `ST` | `INIT`\|`STOP`\|`STRT`\|`RUN`\|`RDWN`\|`DEAD`\|`BRK`\|`COAST`\|`TRIP`\|`ESTOP` | |
| `TR` | Active trip code | 0 – 9 |
| `I2T` | Thermal capacity used | % |
| `RH` | Lifetime run seconds | s |
| `SC` | Lifetime start count | |
| `*2E` | XOR checksum between `$` and `*` | |

### 18.2 Command set

| Command | Response | Effect |
|---------|----------|--------|
| `STATUS` | telemetry frame | Immediate report |
| `RUN` | `OK` / `ERR MODE` / `ERR TRIPPED` | Start (remote only) |
| `STOP` | `OK` | Stop — **works in both modes** |
| `REV` | `OK` / `ERR MODE` | Reverse (remote only) |
| `SPEED <n>` | `OK` / `ERR RANGE` / `ERR MODE` | 0 – `maxRpm` |
| `SPEED?` | `SPEED=1500,1500` | Setpoint, measured |
| `DIR?` | `DIR=F` | |
| `CFG?` | `CFG=3000,200,600,900,500,384,26,8000,18000,110,20000,55000` | All parameters |
| `SET MAXRPM <n>` | `OK` / `ERR RANGE` | 500 – 6000 |
| `SET MINRPM <n>` | `OK` / `ERR RANGE` | 50 – 1000 |
| `SET ACCEL <n>` | `OK` / `ERR RANGE` | 100 – 3000 RPM/s |
| `SET DECEL <n>` | `OK` / `ERR RANGE` | 100 – 3000 RPM/s |
| `SET DEADTIME <n>` | `OK` / `ERR RANGE` | 200 – 2000 ms |
| `SET KP <n>` | `OK` / `ERR RANGE` | Q8, 0 – 4096; live effect |
| `SET KI <n>` | `OK` / `ERR RANGE` | Q8, 0 – 512; live effect |
| `SET RATED <n>` | `OK` / `ERR RANGE` | 1000 – 15000 mA |
| `SET SHORT <n>` | `OK` / `ERR RANGE` | Must exceed `RATED` |
| `SET OVERTEMP <n>` | `OK` / `ERR RANGE` | 60 – 140 °C |
| `ACK` | `OK` / `ERR ACTIVE` | Acknowledge the latched trip |
| `TRIP?` | `TRIP=3,OVERLOAD` | |
| `TRIPS?` | 16 log lines, newest first | `TRP,n,code,t,rpm,mA,mV,C,duty` |
| `CLRTRIPS` | `OK` | Erase the trip ring |
| `HOURS?` | `HOURS=0011:27,SC=87` | Run time and starts |
| `TUNE?` | `TUNE=384,26,<integ>,<err>` | Live controller internals for tuning |
| `SAVE` | `OK` / `ERR EEPROM` | Force a parameter write |
| `HELP` | command list | |

### 18.3 Asynchronous events

```
!EVT,BOOT
!EVT,START,F,1500
!EVT,ATSPEED,1500
!EVT,STOP,PANEL
!EVT,REVERSE,BEGIN
!EVT,DEADTIME,500
!EVT,REVERSE,DONE,R
!EVT,ESTOP,OPEN
!EVT,ESTOP,CLR
!EVT,TRIP,OVERLOAD,I=12400,I2T=100
!EVT,TRIP,NOFEEDBACK,D=45
!EVT,TRIP,SHORT,I=18600
!EVT,ACK,OK
!EVT,ACK,REFUSED,ACTIVE
!EVT,MODE,REMOTE
!EVT,SAVE,OK
```

---

## 19. EEPROM Data Layout

**Device:** 25LC256, SPI Mode 0, `SS` = `PB4`, page size 64 bytes.

### 19.1 Memory map

| Address | Size | Field | Type | Default |
|---------|:----:|-------|------|:-------:|
| `0x0000` | 2 | `magic` | `uint16_t` | `0x4D44` |
| `0x0002` | 1 | `version` | `uint8_t` | `0x01` |
| `0x0003` | 2 | `maxRpm` | `uint16_t` | 3000 |
| `0x0005` | 2 | `minRpm` | `uint16_t` | 200 |
| `0x0007` | 2 | `accelRpmPerSec` | `uint16_t` | 600 |
| `0x0009` | 2 | `decelRpmPerSec` | `uint16_t` | 900 |
| `0x000B` | 2 | `deadTimeMs` | `uint16_t` | 500 |
| `0x000D` | 2 | `kp` | `int16_t` | 384 |
| `0x000F` | 2 | `ki` | `int16_t` | 26 |
| `0x0011` | 2 | `ratedCurrentmA` | `uint16_t` | 8000 |
| `0x0013` | 2 | `shortTripmA` | `uint16_t` | 18000 |
| `0x0015` | 1 | `overTempC` | `uint8_t` | 110 |
| `0x0016` | 2 | `underVoltmV` | `uint16_t` | 20000 |
| `0x0018` | 2 | `overVoltmV` | `uint16_t` | 55000 |
| `0x001A` | 2 | `stallSec` | `uint16_t` | 3 |
| `0x001C` | 4 | `totalRunSec` | `uint32_t` | 0 |
| `0x0020` | 2 | `startCount` | `uint16_t` | 0 |
| `0x0022` | 1 | `tripHead` | `uint8_t` | 0 |
| `0x0023` | 1 | `checksum` | `uint8_t` | computed |
| `0x0024` – `0x002F` | 12 | reserved (`0xFF`) | — | — |
| `0x0030` | 2 | `latchMagic` | `uint16_t` | `0x4C54` when latched |
| `0x0032` | 1 | `latchedTrip` | `uint8_t` | 0 |
| `0x0033` | 1 | `latchCsum` | `uint8_t` | computed |
| `0x0034` – `0x003F` | 12 | reserved | — | — |
| `0x0040` – `0x00DF` | 160 | Trip ring: 16 × 10 bytes | — | `0xFF` |

### 19.2 Trip record on EEPROM (10 bytes, index *n* at `0x0040 + n*10`)

| Offset | Field | Type |
|:------:|-------|------|
| 0 | `trip` | `uint8_t` |
| 1 – 3 | `timeSec` | 24-bit, LSB first |
| 4 – 5 | `rpm` | `int16_t` |
| 6 – 7 | `currentmA` | `uint16_t` |
| 8 | `tempC` | `uint8_t` |
| 9 | `recCsum` | `uint8_t` |

### 19.3 Write discipline

- Parameters: on `SET` + `SAVE` only.
- `latchedTrip`: written **immediately** on trip and on acknowledgement, in its
  own block with its own checksum — the same rationale as Project 05's lockout
  block.
- Run hours: every stop and every 5 minutes while running.
- Trip ring: immediately on every trip.

---

## 20. Task Scheduling

| ID | Task | Period | Offset | Budget | Work |
|----|------|:------:|:------:|:------:|------|
| T-1 | `Task_Panel` | 10 ms | 0 | 150 µs | Buttons, mode switch, debounce |
| T-2 | `Task_FSM` | 10 ms | 0 | 250 µs | Drive `switch`, E-stop flag |
| T-3 | `Task_Current` | 50 ms | 1 | 300 µs | ADC1 + short-circuit check |
| T-4 | `Task_Control` | **100 ms** | 2 | 900 µs | tacho → ramp → protect → PI → bridge |
| T-5 | `Task_LCD` | 250 ms | 4 | 4 ms | Repaint |
| T-6 | `Task_Slow` | 500 ms | 3 | 700 µs | Bus voltage, temperature |
| T-7 | `Task_1Hz` | 1 s | 5 | 2 ms | Run hours + telemetry frame |
| T-8 | `Task_Console` | 20 ms | 6 | 500 µs | Parse one line |
| T-9 | `Task_EEPROM` | 10 ms | 7 | step | Save state machine |

**T-4 is the loop that matters.** Its period must be exactly 100 ms ±1 ms
(NFR-07). Measure it and put the capture in your report — if it jitters, your
tuned gains are meaningless.

---

## 21. Testing Requirements

| ID | Test | Method | Pass criterion |
|----|------|--------|----------------|
| TC-01 | Safe state on reset | Reset while running | Duty 0, `EN` low, both dir pins low ≤ 1 ms |
| TC-02 | Blank EEPROM boot | Erase, power on | Defaults, no crash |
| TC-03 | Parameter persistence | `SET ACCEL 300`, `SAVE`, power cycle | 300 restored |
| TC-04 | Corrupted config | Flip a byte | Defaults loaded |
| TC-05 | PWM frequency | Scope `PD5` | 20 kHz ±1 % |
| TC-06 | PWM resolution | `OCR1A` 0, 200, 399 | 0 %, ~50 %, ≥ 99.5 % duty |
| TC-07 | PWM zero clean | `OCR1A = 0` | Continuously low, no runt pulse |
| TC-08 | Tacho @ 1500 RPM | Inject 150 Hz | Reads 1500 ±100 |
| TC-09 | Tacho @ 3000 RPM | Inject 300 Hz | Reads 3000 ±100 |
| TC-10 | Tacho zero | Stop the pulses | Reads 0, not stale |
| TC-11 | Ramp up | Step setpoint 0 → 3000 | Linear, 5 s ±5 % |
| TC-12 | Ramp down | Step 3000 → 0 | Linear, 3.3 s ±5 % |
| TC-13 | **Steady-state error** | Hold 1500 RPM, constant load | \|error\| ≤ 100 RPM |
| TC-14 | **Load rejection** | Apply a step load at 1500 RPM | Recovers to ±100 RPM in ≤ 2 s |
| TC-15 | Overshoot | Step 0 → 1500 | ≤ 15 % overshoot |
| TC-16 | **Anti-windup off** | Disable the guard, stall 30 s, release | Capture the large overshoot |
| TC-17 | **Anti-windup on** | Re-enable, repeat | Overshoot markedly reduced; both captures in the report |
| TC-18 | Integral reset | Trip, ACK, restart | Integral starts at 0 |
| TC-19 | No `float` | `grep -R "float\|double" APP HAL` | No hits |
| TC-20 | Loop period | Scope the control-task pin | 100 ms ±1 ms |
| TC-21 | Start refused when tripped | Trip, press Start | `ERR TRIPPED` |
| TC-22 | Direction set before duty | Scope `PB0`/`PB1` vs `PD5` at start | Direction leads duty |
| TC-23 | **Shoot-through never** | Scope `IN1` and `IN2` through a full reversal | Never both high, at any instant |
| TC-24 | Dead time | Time the both-low window on reversal | 500 ms ±20 ms |
| TC-25 | Reversal duration | Full 3000 F → 3000 R | Matches §11.2 ±10 % |
| TC-26 | Reversal spam | Press Reverse 5× rapidly | One clean sequence, no state corruption |
| TC-27 | **E-stop latency** | Scope `PD3` edge vs `PD5` | ≤ 1 ms |
| TC-28 | **E-stop broken wire** | Disconnect the E-stop wire | Trips exactly like a press |
| TC-29 | E-stop in every state | Press during INIT, STARTING, DEAD_TIME | Always `DS_ESTOP` |
| TC-30 | E-stop clear refused | Reset with the contact still open | `ERR ACTIVE` |
| TC-31 | E-stop clear | Close contact, press Reset | `DS_STOPPED` |
| TC-32 | Short circuit | Current to 18.5 A | Trip ≤ 50 ms |
| TC-33 | Overload 12 A | Hold 12 A | Trips at the documented time ±20 % |
| TC-34 | Overload 9 A | Hold 9 A for 60 s | No trip |
| TC-35 | **I²t decay** | 12 A for half the trip time, 4 A for 30 s, back to 12 A | Total trip time extends measurably |
| TC-36 | Over-temperature | 115 °C for 3 s | `TRIP_OVERTEMP` |
| TC-37 | Over-temp confirm | 115 °C for 1 s | No trip |
| TC-38 | Under-voltage | Bus to 18 V for 1 s | `TRIP_UNDERVOLT` |
| TC-39 | Over-voltage | Bus to 58 V for 500 ms | `TRIP_OVERVOLT` |
| TC-40 | Stall | Duty > 50 %, RPM 0, 4 s | `TRIP_STALL` |
| TC-41 | **Feedback loss** | Disconnect the tacho while running at 1500 | `TRIP_NOFEEDBACK` in ≤ 2.1 s; **no runaway** |
| TC-42 | Over-speed | Force RPM to setpoint + 700 for 2 s | `TRIP_OVERSPEED` |
| TC-43 | Trip priority | Force E-stop + overload together | `TRIP_ESTOP` reported |
| TC-44 | Latch persists | Trip, clear the cause | Still latched |
| TC-45 | Latch survives power cut | Trip, power cycle | Boots into `DS_TRIPPED`, same cause |
| TC-46 | Trip log | Cause 4 trips, `TRIPS?` | 4 records with correct snapshots |
| TC-47 | Trip ring wrap | Cause 18 trips | 16 newest kept |
| TC-48 | Local mode guards | `LOCAL`, send `RUN` | `ERR MODE` |
| TC-49 | Remote mode | `REMOTE`, `SPEED 1200`, `RUN` | Runs at 1200 |
| TC-50 | **Stop always works** | `REMOTE`, running, press the panel Stop | Stops |
| TC-51 | Live gain change | `SET KP 200` while running | Takes effect next cycle, no restart |
| TC-52 | Run hours | Run 120 s, `HOURS?` | ≈ 120 s accumulated, persists |
| TC-53 | Telemetry cadence | Capture 60 s | 60 frames ±2, checksums valid |
| TC-54 | Console robustness | `FOO`, 40 chars, `SPEED 9999` | `ERR CMD`, `ERR LONG`, `ERR RANGE` |
| TC-55 | LCD flicker | Watch 60 s | No visible redraw |
| TC-56 | Tick jitter | Scope tick pin | 10 ms ±1 ms |
| TC-57 | CPU load | Spare-pin duty | ≤ 60 % |
| TC-58 | RAM budget | `avr-size -C` | ≤ 1024 B |
| TC-59 | Soak | 15 min of starts, reversals, load steps and trips | No hang, no shoot-through, counters monotonic |

---

## 22. Bonus Features

Maximum **+20**; final score capped at 100.

| # | Feature | Marks | Requirement |
|---|---------|:-----:|-------------|
| B1 | Auto-tune | +15 | Relay-feedback (Åström–Hägglund) step test that measures the ultimate gain and period and proposes `kp`/`ki`; result reported over UART |
| B2 | Step-response capture | +10 | `TRACE` command streams 100 samples of setpoint/speed/duty at 100 ms for plotting |
| B3 | Dynamic braking | +10 | `DS_BRAKING` shorts the motor through the bridge with a current-limited profile; braking time measured and reported |
| B4 | True cooperative scheduler | +15 | Task table with period/offset/order guarantees, overrun counter over UART |
| B5 | Watchdog recovery | +10 | WDT 250 ms; a hang recovers with the bridge safe, the latch preserved and `MCUCSR` logged |
| B6 | Torque estimate | +10 | Estimate shaft torque from current and speed; display and log it |
| B7 | Multi-speed presets | +5 | Three preset speeds selectable from the panel, stored in EEPROM |
| B8 | Modbus-RTU-like framing | +15 | Binary framed protocol with CRC-16 alongside the ASCII console, on the same UART |

---

## 23. Deliverables

| # | Item | Detail |
|---|------|--------|
| 1 | Source code | Layered per §9.1; `bridge.c` the sole writer of the drive outputs |
| 2 | `Simulation/motor.sim1` | Runs unmodified; tacho frequency and load adjustable |
| 3 | `Docs/control_design.md` | PI derivation, Q8 scaling, tuning log, anti-windup before/after captures |
| 4 | `Docs/safety_notes.md` | Why the E-stop is NC, the trip ladder, the shoot-through argument |
| 5 | `Docs/flowchart.png` | Matches §16 |
| 6 | `Docs/state_machine.png` | Matches §17 with the transition table |
| 7 | `Docs/test_report.md` | All 59 `TC` rows with evidence |
| 8 | Final report | 15 – 20 pages incl. PWM and tacho derivations and the I²t curve |
| 9 | Demo video | 5 – 10 min: start, load rejection, full reversal with dead time on the scope, E-stop by broken wire, feedback-loss trip |
| 10 | Live defence | Any member, any file |

---

## 24. Evaluation Rubric

| Item | Marks | Full-mark criteria |
|------|:-----:|--------------------|
| GPIO | 5 | Bridge control correct; `IN1`/`IN2` never both high |
| ADC | 10 | Four channels at three rates; current fast enough for the short-circuit trip |
| Timer | 10 | 20 kHz PWM verified **and** a 100 ms control loop with ≤ 1 ms jitter |
| Interrupts | 5 | E-stop ≤ 1 ms, fail-safe NC proven; tacho ISR minimal |
| USART | 10 | 1 s frame, events and parser per §18; live gain tuning |
| SPI | 10 | Parameters, run hours and trip ring persist; latch survives power loss |
| I2C | 10 | LCD operator panel, both pages, flicker-free |
| Application logic | 20 | PI holds speed under load; anti-windup demonstrated; full protection ladder |
| Architecture | 10 | Single bridge writer; protections between controller and output; layer rule |
| Testing | 10 | 59 cases including TC-17, TC-23, TC-28 and TC-41 |
| Documentation & demo | 10 | Control-design and safety notes present; scope captures shown live |
| **Total** | **100** | Bonus up to +20, capped at 100 |

---

*Prepared by Ahmed Ellamie | ahmed.ellamiee@gmail.com*
================================================

Summary

| **Hardware Design** | Complete |

| **Layer (Service)** | Pending |

| **Layer (Logic)** | Pending | 

| **MCL Layer** | Pending | 

| **HAL Layer** | Pending |
================================================

Shorouk (Modules)

DataTypes

DataManager   |   Complete

PIController  |   Complete

RampGenerator   |   Complete            


Protection   |   Complete

DriveFSM     |   Complete

Scheduler    |    Pending

Console     |    Pending

Telemetry    |   Pending

================================================

Asmaa (drivers)


TIMER      |      Complete

Interrupt    |    Complete

USART       |     Complete

Tachometer    |   Pending

AnalogSensor   |   Pending

Buzzer     |      Pending

main.c      |     Pending
