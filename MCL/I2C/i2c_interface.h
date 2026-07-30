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

typedef struct {
    uint32_t sclFrequency;   /* pass I2C_SCL_100KHZ or I2C_SCL_400KHZ */
} I2C_MasterConfigType;
/* ================================================================================
 *  FUNCTION PROTOTYPES
 * ============================================================================== */
Std_ReturnType I2C_Init(void);

Std_ReturnType I2C_Start(void);

Std_ReturnType I2C_Stop(void);

Std_ReturnType I2C_WriteByte(uint8_t data);
/**
 * @brief  Sends a START condition followed by the slave address + R/W bit.
 * @param  address  7-bit slave address (unshifted).
 * @param  rw_bit   0 = write, 1 = read.
 * @return Std_ReturnType  E_OK/E_NOK.
 */
Std_ReturnType I2C_WriteAddress(uint8_t address, uint8_t rw_bit);

/**
 * @brief  Sends one data byte on the bus (must be called after I2C_WriteAddress).
 * @param  data  Byte to send.
 * @return Std_ReturnType  E_OK/E_NOK.
 */
Std_ReturnType I2C_WriteData(uint8_t data);
Std_ReturnType I2C_InitMaster(const I2C_MasterConfigType *config);
#endif /* I2C_INTERFACE_H */
