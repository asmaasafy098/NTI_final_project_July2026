#ifndef I2C_INTERFACE_H
#define I2C_INTERFACE_H

#include "../../Service/STD_Types.h"
#include "i2c_registers.h"

/* ================================================================================
 *  I2C (TWI) DRIVER - PUBLIC INTERFACE (ATmega32)
 *  ------------------------------------------------------------------------------
 *  Two-Wire Interface driver. Provides both low-level primitives (START, STOP,
 *  write byte, read byte with/without ACK, read status) and high-level helpers
 *  for a master to write/read a buffer to/from an addressed slave.
 *
 *  Slave addresses passed to this API are 7-bit; the driver appends the R/W bit
 *  internally when forming SLA+W / SLA+R.
 * ============================================================================== */

/* ---------------- Bus Speed (SCL frequency) ---------------- */
/**
 * @brief Common SCL clock frequencies. The driver converts the requested speed
 *        and F_CPU into a TWBR value at init time.
 */
#define I2C_SCL_100KHZ        100000UL   /* Standard mode */
#define I2C_SCL_400KHZ        400000UL   /* Fast mode     */

/**
 * @brief CPU clock in Hz used to compute the bit-rate register. Adjust to match
 *        the target board.
 */
#ifndef I2C_F_CPU
#define I2C_F_CPU             8000000UL
#endif

/* ---------------- Acknowledge Selection ---------------- */
/**
 * @brief Whether the master returns ACK or NACK after receiving a data byte.
 *  - I2C_ACK  : keep reading (more bytes to come).
 *  - I2C_NACK : signal the last byte (master will STOP next).
 */
typedef enum
{
    I2C_NACK = 0,
    I2C_ACK  = 1
} I2C_AckType;

/* ---------------- Master Configuration Structure ---------------- */
/**
 * @brief Parameters consumed by I2C_InitMaster().
 * @var I2C_MasterConfigType::sclFrequency  Target SCL clock in Hz (e.g. I2C_SCL_100KHZ).
 */
typedef struct
{
    uint32_t sclFrequency;
} I2C_MasterConfigType;

/* ---------------- Slave Configuration Structure ---------------- */
/**
 * @brief Parameters consumed by I2C_InitSlave().
 * @var I2C_SlaveConfigType::ownAddress        This device's own 7-bit slave address.
 * @var I2C_SlaveConfigType::enableGeneralCall Non-zero to also answer general-call (0x00).
 */
typedef struct
{
    uint8_t ownAddress;
    uint8_t enableGeneralCall;
} I2C_SlaveConfigType;

/* ================================================================================
 *  FUNCTION PROTOTYPES
 * ============================================================================== */
Std_ReturnType I2C_Init(void);

Std_ReturnType I2C_Start(void);

Std_ReturnType I2C_Stop(void);

Std_ReturnType I2C_WriteByte(uint8_t data);

#endif /* I2C_INTERFACE_H */
