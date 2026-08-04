#include "../../Service/STD_Types.h"
#include "../../Service/Bit_Math.h"
#include "i2c_registers.h"
#include "i2c_interface.h"


Std_ReturnType I2C_Init(void)
{
    /* Set bit rate for 100kHz @ F_CPU=8MHz, prescaler=1 */
    I2C_TWBR_REG  = 72;   /* SCL = F_CPU / (16 + 2*TWBR*Prescaler) */
    CLR_BIT(I2C_TWSR_REG, I2C_TWPS0_BIT);
    CLR_BIT(I2C_TWSR_REG, I2C_TWPS1_BIT);

    SET_BIT(I2C_TWCR_REG, I2C_TWEN_BIT);  /* enable TWI */

    return E_OK;
}


Std_ReturnType I2C_InitMaster(const I2C_MasterConfigType *config)
{
    /* Frequency is currently fixed at 100kHz inside I2C_Init(); the config
       is accepted for interface compatibility with main.c's call site. */
    (void)config;
    return I2C_Init();
}


#define I2C_TIMEOUT  10000U // قيمة تجريبية للانتظار

Std_ReturnType I2C_Start(void)
{
    uint32_t timeout = 0;

    I2C_TWCR_REG = (1 << I2C_TWINT_BIT) | (1 << I2C_TWSTA_BIT) | (1 << I2C_TWEN_BIT);

    // حماية بواسطة الـ Timeout لعدم التهنيج
    while (GET_BIT(I2C_TWCR_REG, I2C_TWINT_BIT) == 0) 
    {
        timeout++;
        if (timeout > I2C_TIMEOUT)
        {
            return E_NOK; // خروج بفشل بدلاً من التعليق للأبد
        }
    }

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
    uint32_t timeout = 0U;
    uint8_t status;

    I2C_TWDR_REG = data;

    I2C_TWCR_REG =
        (1U << I2C_TWINT_BIT) |
        (1U << I2C_TWEN_BIT);

    while (GET_BIT(I2C_TWCR_REG, I2C_TWINT_BIT) == 0U)
    {
        timeout++;

        if (timeout > I2C_TIMEOUT)
        {
            return E_NOK;
        }
    }

    status = I2C_TWSR_REG & 0xF8U;

    /*
     * 0x18 = SLA+W transmitted, ACK received
     * 0x28 = DATA transmitted, ACK received
     */
    if ((status == 0x18U) || (status == 0x28U))
    {
        return E_OK;
    }

    return E_NOK;
}

Std_ReturnType I2C_WriteAddress(uint8_t address, uint8_t rw_bit)
{
    Std_ReturnType local_Status;

    local_Status = I2C_Start();

    if (local_Status != E_OK)
    {
        return local_Status;
    }

    local_Status = I2C_WriteByte(
        (uint8_t)((address << 1) | (rw_bit & 0x01U))
    );

    if (local_Status != E_OK)
    {
        I2C_Stop();
        return E_NOK;
    }

    return E_OK;
}

Std_ReturnType I2C_WriteData(uint8_t data)
{
    return I2C_WriteByte(data);
}