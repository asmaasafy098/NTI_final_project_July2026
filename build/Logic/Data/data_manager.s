	.file	"data_manager.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	DataManager_Init
	.type	DataManager_Init, @function
DataManager_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	sts g_data+1,r25
	sts g_data,r24
	sts g_cfg+1,r23
	sts g_cfg,r22
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+5,__zero_reg__
	std Z+4,__zero_reg__
	std Z+7,__zero_reg__
	std Z+6,__zero_reg__
	std Z+9,__zero_reg__
	std Z+8,__zero_reg__
	std Z+10,__zero_reg__
	std Z+12,__zero_reg__
	std Z+11,__zero_reg__
	std Z+14,__zero_reg__
	std Z+13,__zero_reg__
	std Z+15,__zero_reg__
	std Z+16,__zero_reg__
	std Z+17,__zero_reg__
	std Z+18,__zero_reg__
	std Z+19,__zero_reg__
	std Z+21,__zero_reg__
	std Z+20,__zero_reg__
	std Z+23,__zero_reg__
	std Z+22,__zero_reg__
	std Z+25,__zero_reg__
	std Z+24,__zero_reg__
	ldd r24,Z+26
	andi r24,lo8(-4)
	andi r24,lo8(~(1<<2))
	std Z+26,r24
	std Z+27,__zero_reg__
	std Z+28,__zero_reg__
	std Z+29,__zero_reg__
	std Z+30,__zero_reg__
	std Z+31,__zero_reg__
	std Z+32,__zero_reg__
	std Z+33,__zero_reg__
	std Z+34,__zero_reg__
	std Z+36,__zero_reg__
	std Z+35,__zero_reg__
	std Z+37,__zero_reg__
	std Z+38,__zero_reg__
	std Z+39,__zero_reg__
	std Z+40,__zero_reg__
/* epilogue start */
	ret
	.size	DataManager_Init, .-DataManager_Init
.global	DataManager_GetData
	.type	DataManager_GetData, @function
DataManager_GetData:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_data
	lds r25,g_data+1
/* epilogue start */
	ret
	.size	DataManager_GetData, .-DataManager_GetData
.global	DataManager_GetConfig
	.type	DataManager_GetConfig, @function
DataManager_GetConfig:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_cfg
	lds r25,g_cfg+1
/* epilogue start */
	ret
	.size	DataManager_GetConfig, .-DataManager_GetConfig
.global	DataManager_UpdateSensors
	.type	DataManager_UpdateSensors, @function
DataManager_UpdateSensors:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,g_data
	lds r31,g_data+1
	std Z+5,r25
	std Z+4,r24
	std Z+12,r23
	std Z+11,r22
	std Z+14,r21
	std Z+13,r20
	std Z+15,r18
/* epilogue start */
	ret
	.size	DataManager_UpdateSensors, .-DataManager_UpdateSensors
.global	DataManager_UpdateSetpoint
	.type	DataManager_UpdateSetpoint, @function
DataManager_UpdateSetpoint:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,g_cfg
	lds r31,g_cfg+1
	ldd r21,Z+3
	ldd r20,Z+4
	lds r30,g_data
	lds r31,g_data+1
	ldi r19,0
	ldi r18,0
	sbrc r25,7
	rjmp .L6
	mov r18,r21
	mov r19,r20
	cp r24,r18
	cpc r25,r19
	brge .L6
	movw r18,r24
.L6:
	std Z+1,r19
	st Z,r18
/* epilogue start */
	ret
	.size	DataManager_UpdateSetpoint, .-DataManager_UpdateSetpoint
.global	DataManager_UpdateDuty
	.type	DataManager_UpdateDuty, @function
DataManager_UpdateDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,g_data
	lds r31,g_data+1
	cpi r24,-112
	ldi r18,1
	cpc r25,r18
	brlt .L10
	ldi r24,lo8(-113)
	ldi r25,lo8(1)
.L10:
	sbrs r25,7
	rjmp .L11
	ldi r25,0
	ldi r24,0
.L11:
	std Z+9,r25
	std Z+8,r24
	ldi r20,lo8(100)
	mul r20,r24
	movw r18,r0
	mul r20,r25
	add r19,r0
	clr __zero_reg__
	movw r24,r18
	ldi r22,lo8(-113)
	ldi r23,lo8(1)
	call __udivmodhi4
	std Z+10,r22
/* epilogue start */
	ret
	.size	DataManager_UpdateDuty, .-DataManager_UpdateDuty
.global	DataManager_UpdateError
	.type	DataManager_UpdateError, @function
DataManager_UpdateError:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,g_data
	lds r31,g_data+1
	ldd r24,Z+2
	ldd r25,Z+3
	ldd r18,Z+4
	ldd r19,Z+5
	sub r24,r18
	sbc r25,r19
	std Z+7,r25
	std Z+6,r24
/* epilogue start */
	ret
	.size	DataManager_UpdateError, .-DataManager_UpdateError
.global	DataManager_IncrementRunSeconds
	.type	DataManager_IncrementRunSeconds, @function
DataManager_IncrementRunSeconds:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,g_data
	lds r31,g_data+1
	ldd r24,Z+27
	ldd r25,Z+28
	ldd r26,Z+29
	ldd r27,Z+30
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	std Z+27,r24
	std Z+28,r25
	std Z+29,r26
	std Z+30,r27
	ldd r24,Z+31
	ldd r25,Z+32
	ldd r26,Z+33
	ldd r27,Z+34
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	std Z+31,r24
	std Z+32,r25
	std Z+33,r26
	std Z+34,r27
/* epilogue start */
	ret
	.size	DataManager_IncrementRunSeconds, .-DataManager_IncrementRunSeconds
.global	DataManager_Persist
	.type	DataManager_Persist, @function
DataManager_Persist:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_persistCounter
	lds r25,g_persistCounter+1
	lds r26,g_persistCounter+2
	lds r27,g_persistCounter+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	cpi r24,44
	ldi r18,1
	cpc r25,r18
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brsh .L15
	sts g_persistCounter,r24
	sts g_persistCounter+1,r25
	sts g_persistCounter+2,r26
	sts g_persistCounter+3,r27
	ret
.L15:
	sts g_persistCounter,__zero_reg__
	sts g_persistCounter+1,__zero_reg__
	sts g_persistCounter+2,__zero_reg__
	sts g_persistCounter+3,__zero_reg__
	lds r26,g_data
	lds r27,g_data+1
	lds r30,g_cfg
	lds r31,g_cfg+1
	adiw r26,31
	ld r20,X+
	ld r21,X+
	ld r22,X+
	ld r23,X
	sbiw r26,31+3
	std Z+28,r20
	std Z+29,r21
	std Z+30,r22
	std Z+31,r23
	adiw r26,35
	ld r24,X+
	ld r25,X
	std Z+33,r25
	std Z+32,r24
/* epilogue start */
	ret
	.size	DataManager_Persist, .-DataManager_Persist
	.local	g_persistCounter
	.comm	g_persistCounter,4,1
	.local	g_cfg
	.comm	g_cfg,2,1
	.local	g_data
	.comm	g_data,2,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
