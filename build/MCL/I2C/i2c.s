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
.global	I2C_Start
	.type	I2C_Start, @function
I2C_Start:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
.L3:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L3
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(8)
	brne .L4
	ldi r19,0
	ldi r18,0
.L4:
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
.L9:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L9
	in r18,0x1
	andi r18,lo8(-8)
	cpi r18,lo8(24)
	breq .L13
	cpi r18,lo8(40)
	breq .L13
	ldi r24,lo8(1)
	ldi r25,0
	cpi r18,lo8(64)
	brne .L8
	ldi r24,0
	ret
.L13:
	ldi r24,0
	ldi r25,0
.L8:
/* epilogue start */
	ret
	.size	I2C_WriteByte, .-I2C_WriteByte
	.ident	"GCC: (GNU) 7.3.0"
