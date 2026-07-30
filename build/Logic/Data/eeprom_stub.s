	.file	"eeprom_stub.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	EEPROM_Init
	.type	EEPROM_Init, @function
EEPROM_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	EEPROM_Init, .-EEPROM_Init
.global	TRIPLOG_Init
	.type	TRIPLOG_Init, @function
TRIPLOG_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	TRIPLOG_Init, .-TRIPLOG_Init
.global	EEPROM_LoadConfig
	.type	EEPROM_LoadConfig, @function
EEPROM_LoadConfig:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EEPROM_LoadConfig, .-EEPROM_LoadConfig
.global	EEPROM_LoadDefaults
	.type	EEPROM_LoadDefaults, @function
EEPROM_LoadDefaults:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	ret
	.size	EEPROM_LoadDefaults, .-EEPROM_LoadDefaults
.global	EEPROM_SaveConfig
	.type	EEPROM_SaveConfig, @function
EEPROM_SaveConfig:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	EEPROM_SaveConfig, .-EEPROM_SaveConfig
.global	EEPROM_LoadLatchTrip
	.type	EEPROM_LoadLatchTrip, @function
EEPROM_LoadLatchTrip:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	EEPROM_LoadLatchTrip, .-EEPROM_LoadLatchTrip
	.ident	"GCC: (GNU) 7.3.0"
