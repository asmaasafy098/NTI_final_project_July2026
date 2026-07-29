#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "i2c_registers.h"
#include "i2c_interface.h"


Std_ReturnType I2C_Init(void)
{
    /* Set bit rate for 100kHz @ F_CPU=8MHz, prescaler=1 */
    I2C_TWBR_REG = 32;   /* SCL = F_CPU / (16 + 2*TWBR*Prescaler) */
    CLR_BIT(I2C_TWSR_REG, I2C_TWPS0_BIT);
    CLR_BIT(I2C_TWSR_REG, I2C_TWPS1_BIT);

    SET_BIT(I2C_TWCR_REG, I2C_TWEN_BIT);  /* enable TWI */

    return E_OK;
}


Std_ReturnType I2C_Start(void)
{
    I2C_TWCR_REG = (1 << I2C_TWINT_BIT) | (1 << I2C_TWSTA_BIT) | (1 << I2C_TWEN_BIT);
    while (GET_BIT(I2C_TWCR_REG, I2C_TWINT_BIT) == 0) { /* wait */ }

    if ((I2C_TWSR_REG & 0xF8) != 0x08)   /* START not sent */
    {
        return E_NOK;
    }
    return E_OK;
}


Std_ReturnType I2C_Stop(void)
{
    I2C_TWCR_REG = (1 << I2C_TWINT_BIT) | (1 << I2C_TWSTO_BIT) | (1 << I2C_TWEN_BIT);
    return E_OK;
}


Std_ReturnType I2C_WriteByte(uint8_t data)
{
    I2C_TWDR_REG = data;
    I2C_TWCR_REG = (1 << I2C_TWINT_BIT) | (1 << I2C_TWEN_BIT);
    while (GET_BIT(I2C_TWCR_REG, I2C_TWINT_BIT) == 0) { /* wait */ }

    uint8_t status = I2C_TWSR_REG & 0xF8;
    if ((status != 0x18) && (status != 0x28) && (status != 0x40))
    {
        return E_NOK;   /* not ACKed */
    }
    return E_OK;
}