#include "../../Service/STD_Types.h"
#include "data_types.h"
#include "eeprom_stub.h"

Std_ReturnType EEPROM_Init(void) { return E_OK; }
Std_ReturnType TRIPLOG_Init(void) { return E_OK; }
Std_ReturnType EEPROM_LoadConfig(DriveCfg_t *cfg) { (void)cfg; return E_NOK; }  /* force defaults */
void EEPROM_LoadDefaults(DriveCfg_t *cfg) { (void)cfg; }
Std_ReturnType EEPROM_SaveConfig(DriveCfg_t *cfg) { (void)cfg; return E_OK; }
Trip_t EEPROM_LoadLatchTrip(void) { return TRIP_NONE; }