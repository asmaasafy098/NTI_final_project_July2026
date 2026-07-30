#ifndef EEPROM_STUB_H
#define EEPROM_STUB_H

#include "../../Service/STD_Types.h"
#include "data_types.h"

Std_ReturnType EEPROM_Init(void);
Std_ReturnType TRIPLOG_Init(void);
Std_ReturnType EEPROM_LoadConfig(DriveCfg_t *cfg);
void EEPROM_LoadDefaults(DriveCfg_t *cfg);
Std_ReturnType EEPROM_SaveConfig(DriveCfg_t *cfg);
Trip_t EEPROM_LoadLatchTrip(void);

#endif /* EEPROM_STUB_H */