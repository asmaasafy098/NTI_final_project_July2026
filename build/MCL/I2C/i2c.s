	.file	"i2c.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	I2C_Init
	.type	I2C_Init, @function
I2C_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(32)
	out 0,r24
	cbi 0x1,0
	cbi 0x1,1
	in r24,0x36
	ori r24,lo8(4)
	out 0x36,r24
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	I2C_Init, .-I2C_Init
.global	I2C_InitMaster
	.type	I2C_InitMaster, @function
I2C_InitMaster:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp I2C_Init
	.size	I2C_InitMaster, .-I2C_InitMaster
.global	I2C_Start
	.type	I2C_Start, @function
I2C_Start:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
.L4:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L4
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(8)
	brne .L5
	ldi r19,0
	ldi r18,0
.L5:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_Start, .-I2C_Start
.global	I2C_Stop
	.type	I2C_Stop, @function
I2C_Stop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-108)
	out 0x36,r24
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	I2C_Stop, .-I2C_Stop
.global	I2C_WriteByte
	.type	I2C_WriteByte, @function
I2C_WriteByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
.L10:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L10
	in r18,0x1
	andi r18,lo8(-8)
	cpi r18,lo8(24)
	breq .L14
	cpi r18,lo8(40)
	breq .L14
	ldi r24,lo8(1)
	ldi r25,0
	cpi r18,lo8(64)
	brne .L9
	ldi r24,0
	ret
.L14:
	ldi r24,0
	ldi r25,0
.L9:
/* epilogue start */
	ret
	.size	I2C_WriteByte, .-I2C_WriteByte
.global	I2C_WriteAddress
	.type	I2C_WriteAddress, @function
I2C_WriteAddress:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	mov r29,r24
	mov r28,r22
	call I2C_Start
	sbiw r24,0
	brne .L17
	mov r24,r29
	lsl r24
	andi r28,lo8(1)
	or r24,r28
/* epilogue start */
	pop r29
	pop r28
	jmp I2C_WriteByte
.L17:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	I2C_WriteAddress, .-I2C_WriteAddress
.global	I2C_WriteData
	.type	I2C_WriteData, @function
I2C_WriteData:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp I2C_WriteByte
	.size	I2C_WriteData, .-I2C_WriteData
	.ident	"GCC: (GNU) 7.3.0"
