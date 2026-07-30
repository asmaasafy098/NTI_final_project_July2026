	.file	"lcd_aip31068_i2c.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	LCD_Aip31068_SendCommand
	.type	LCD_Aip31068_SendCommand, @function
LCD_Aip31068_SendCommand:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	brne .L2
.L7:
	ldi r28,lo8(1)
	ldi r29,0
.L1:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L2:
	mov r28,r22
	ldi r22,0
	movw r30,r24
	ld r24,Z
	call I2C_WriteAddress
	or r24,r25
	brne .L7
	ldi r24,0
	call I2C_WriteData
	or r24,r25
	breq .L5
.L6:
	call I2C_Stop
	rjmp .L7
.L5:
	mov r24,r28
	call I2C_WriteData
	movw r28,r24
	or r24,r25
	brne .L6
	call I2C_Stop
	rjmp .L1
	.size	LCD_Aip31068_SendCommand, .-LCD_Aip31068_SendCommand
.global	LCD_Aip31068_WriteChar
	.type	LCD_Aip31068_WriteChar, @function
LCD_Aip31068_WriteChar:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	brne .L9
.L14:
	ldi r28,lo8(1)
	ldi r29,0
.L8:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L9:
	mov r28,r22
	ldi r22,0
	movw r30,r24
	ld r24,Z
	call I2C_WriteAddress
	or r24,r25
	brne .L14
	ldi r24,lo8(64)
	call I2C_WriteData
	or r24,r25
	breq .L12
.L13:
	call I2C_Stop
	rjmp .L14
.L12:
	mov r24,r28
	call I2C_WriteData
	movw r28,r24
	or r24,r25
	brne .L13
	call I2C_Stop
	rjmp .L8
	.size	LCD_Aip31068_WriteChar, .-LCD_Aip31068_WriteChar
.global	LCD_Aip31068_WriteString
	.type	LCD_Aip31068_WriteString, @function
LCD_Aip31068_WriteString:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	sbiw r24,0
	brne .L16
.L27:
	ldi r16,lo8(1)
	ldi r17,0
.L15:
	movw r24,r16
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L16:
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L27
	movw r28,r22
	ldi r22,0
	movw r30,r24
	ld r24,Z
	call I2C_WriteAddress
	or r24,r25
	brne .L27
	ldi r24,lo8(64)
	call I2C_WriteData
	movw r16,r24
	or r24,r25
	brne .L19
.L20:
	ld r24,Y+
	cpse r24,__zero_reg__
	rjmp .L21
	call I2C_Stop
	rjmp .L15
.L21:
	call I2C_WriteData
	or r24,r25
	breq .L20
.L19:
	call I2C_Stop
	rjmp .L27
	.size	LCD_Aip31068_WriteString, .-LCD_Aip31068_WriteString
.global	LCD_Aip31068_SetCursor
	.type	LCD_Aip31068_SetCursor, @function
LCD_Aip31068_SetCursor:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+1,__zero_reg__
	ldi r18,lo8(64)
	std Y+2,r18
	sbiw r24,0
	breq .L28
	movw r30,r24
	ldd r18,Z+1
	cp r22,r18
	brsh .L28
	ldd r18,Z+2
	cp r20,r18
	brsh .L28
	movw r30,r28
	add r30,r22
	adc r31,__zero_reg__
	ldd r22,Z+1
	add r22,r20
	ori r22,lo8(-128)
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	jmp LCD_Aip31068_SendCommand
.L28:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	LCD_Aip31068_SetCursor, .-LCD_Aip31068_SetCursor
.global	LCD_Aip31068_WriteStringAt
	.type	LCD_Aip31068_WriteStringAt, @function
LCD_Aip31068_WriteStringAt:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r28,r24
	movw r16,r18
	call LCD_Aip31068_SetCursor
	or r24,r25
	brne .L35
	movw r22,r16
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	jmp LCD_Aip31068_WriteString
.L35:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	LCD_Aip31068_WriteStringAt, .-LCD_Aip31068_WriteStringAt
.global	LCD_Aip31068_Clear
	.type	LCD_Aip31068_Clear, @function
LCD_Aip31068_Clear:
	push r28
	push r29
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
/* stack size = 6 */
.L__stack_usage = 6
	ldi r22,lo8(1)
	call LCD_Aip31068_SendCommand
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	std Y+3,__zero_reg__
	std Y+4,__zero_reg__
.L37:
	ldd r20,Y+1
	ldd r21,Y+2
	ldd r22,Y+3
	ldd r23,Y+4
	cpi r20,-48
	sbci r21,7
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brlo .L38
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L38:
	ldd r20,Y+1
	ldd r21,Y+2
	ldd r22,Y+3
	ldd r23,Y+4
	subi r20,-1
	sbci r21,-1
	sbci r22,-1
	sbci r23,-1
	std Y+1,r20
	std Y+2,r21
	std Y+3,r22
	std Y+4,r23
	rjmp .L37
	.size	LCD_Aip31068_Clear, .-LCD_Aip31068_Clear
.global	LCD_Aip31068_Home
	.type	LCD_Aip31068_Home, @function
LCD_Aip31068_Home:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(2)
	jmp LCD_Aip31068_SendCommand
	.size	LCD_Aip31068_Home, .-LCD_Aip31068_Home
.global	LCD_Aip31068_DisplayOnOff
	.type	LCD_Aip31068_DisplayOnOff, @function
LCD_Aip31068_DisplayOnOff:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r18,r24
	lds r25,g_displayControl
	tst r22
	breq .L41
	ori r25,lo8(4)
.L43:
	sts g_displayControl,r25
	lds r22,g_displayControl
	ori r22,lo8(8)
	movw r24,r18
	jmp LCD_Aip31068_SendCommand
.L41:
	andi r25,lo8(-5)
	rjmp .L43
	.size	LCD_Aip31068_DisplayOnOff, .-LCD_Aip31068_DisplayOnOff
.global	LCD_Aip31068_Init
	.type	LCD_Aip31068_Init, @function
LCD_Aip31068_Init:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	brne .L45
.L47:
	ldi r24,lo8(1)
	ldi r25,0
.L44:
/* epilogue start */
	pop r29
	pop r28
	ret
.L45:
	movw r28,r24
	ldi r22,lo8(56)
	call LCD_Aip31068_SendCommand
	or r24,r25
	brne .L47
	ldi r24,lo8(12)
	sts g_displayControl,r24
	ldi r22,lo8(12)
	movw r24,r28
	call LCD_Aip31068_SendCommand
	or r24,r25
	brne .L47
	movw r24,r28
	call LCD_Aip31068_Clear
	or r24,r25
	brne .L47
	ldi r22,lo8(6)
	movw r24,r28
	call LCD_Aip31068_SendCommand
	ldi r19,lo8(1)
	ldi r18,0
	or r24,r25
	brne .L48
	ldi r19,0
.L48:
	mov r24,r19
	mov r25,r18
	rjmp .L44
	.size	LCD_Aip31068_Init, .-LCD_Aip31068_Init
.global	LCD_InitDefault
	.type	LCD_InitDefault, @function
LCD_InitDefault:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(g_lcdHandle)
	ldi r31,hi8(g_lcdHandle)
	ldi r24,lo8(62)
	st Z,r24
	ldi r24,lo8(2)
	std Z+1,r24
	ldi r24,lo8(16)
	std Z+2,r24
	movw r24,r30
	jmp LCD_Aip31068_Init
	.size	LCD_InitDefault, .-LCD_InitDefault
.global	LCD_Update
	.type	LCD_Update, @function
LCD_Update:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,40
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 40 */
/* stack size = 46 */
.L__stack_usage = 46
	sbiw r24,0
	brne .+2
	rjmp .L65
	movw r14,r24
	ldi r24,lo8(83)
	std Y+18,r24
	ldi r24,lo8(69)
	std Y+19,r24
	ldi r24,lo8(84)
	std Y+20,r24
	ldi r20,lo8(4)
	movw r22,r28
	subi r22,-35
	sbci r23,-1
	movw r26,r14
	adiw r26,2
	ld r24,X+
	ld r25,X
	call UTL_IntToStr
	ldi r16,lo8(3)
.L52:
	ldi r30,lo8(-3)
	add r30,r16
	ldi r18,lo8(35)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ld r18,Z
	ldi r30,lo8(1)
	add r30,r16
	mov r24,r16
	ldi r25,0
	ldi r20,lo8(18)
	ldi r21,0
	add r20,r28
	adc r21,r29
	add r24,r20
	adc r25,r21
	cpse r18,__zero_reg__
	rjmp .L53
	ldi r18,lo8(32)
	movw r26,r24
	st X,r18
	movw r18,r20
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ldi r24,lo8(65)
	st Z,r24
	ldi r30,lo8(2)
	add r30,r16
	ldi r20,lo8(18)
	ldi r21,0
	add r20,r28
	adc r21,r29
	add r20,r30
	adc r21,__zero_reg__
	movw r30,r20
	ldi r24,lo8(67)
	st Z,r24
	ldi r17,lo8(4)
	add r17,r16
	ldi r30,lo8(3)
	add r30,r16
	ldi r22,lo8(18)
	ldi r23,0
	add r22,r28
	adc r23,r29
	add r22,r30
	adc r23,__zero_reg__
	movw r30,r22
	ldi r24,lo8(84)
	st Z,r24
	ldi r20,lo8(4)
	movw r22,r28
	subi r22,-35
	sbci r23,-1
	movw r26,r14
	adiw r26,4
	ld r24,X+
	ld r25,X
	call UTL_IntToStr
	ldi r25,lo8(-4)
	sub r25,r16
.L54:
	mov r30,r25
	add r30,r17
	ldi r18,lo8(35)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ld r20,Z
	ldi r24,lo8(1)
	add r24,r17
	mov r18,r17
	ldi r19,0
	cpse r20,__zero_reg__
	rjmp .L55
	movw r26,r14
	adiw r26,20
	ld r20,X+
	ld r21,X
	ldi r25,lo8(70)
	cpi r20,1
	cpc r21,__zero_reg__
	breq .L58
	ldi r25,lo8(82)
	cpi r20,2
	cpc r21,__zero_reg__
	breq .L58
	ldi r25,lo8(45)
.L58:
	ldi r30,lo8(18)
	ldi r31,0
	add r30,r28
	adc r31,r29
	add r18,r30
	adc r19,r31
	movw r26,r18
	st X,r25
	ldi r30,lo8(18)
	ldi r31,0
	add r30,r28
	adc r31,r29
	add r30,r24
	adc r31,__zero_reg__
	ldi r25,lo8(32)
.L59:
	cpi r24,lo8(16)
	brsh .+2
	rjmp .L60
	std Y+34,__zero_reg__
	movw r30,r14
	ldd r24,Z+10
	ldi r20,lo8(2)
	movw r22,r28
	subi r22,-35
	sbci r23,-1
	ldi r25,0
	call UTL_UIntToStr
	ldd r24,Y+35
	std Y+18,r24
	ldd r24,Y+36
	std Y+19,r24
	ldi r24,lo8(37)
	std Y+20,r24
	ldi r24,lo8(32)
	std Y+21,r24
	movw r26,r14
	adiw r26,11
	ld r24,X+
	ld r25,X
	ldi r22,lo8(100)
	ldi r23,0
	call __udivmodhi4
	movw r24,r22
	movw r22,r28
	subi r22,-35
	sbci r23,-1
	call UTL_IntToStr1Dec
	ldi r17,lo8(4)
.L61:
	ldi r30,lo8(-4)
	add r30,r17
	ldi r18,lo8(35)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ld r18,Z
	ldi r30,lo8(1)
	add r30,r17
	mov r24,r17
	ldi r25,0
	ldi r20,lo8(18)
	ldi r21,0
	add r20,r28
	adc r21,r29
	add r24,r20
	adc r25,r21
	cpse r18,__zero_reg__
	rjmp .L62
	ldi r18,lo8(65)
	movw r26,r24
	st X,r18
	movw r18,r20
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ldi r16,lo8(32)
	st Z,r16
	movw r26,r14
	adiw r26,13
	ld r24,X+
	ld r25,X
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	call __udivmodhi4
	movw r24,r22
	ldi r20,lo8(2)
	movw r22,r28
	subi r22,-35
	sbci r23,-1
	call UTL_UIntToStr
	ldi r30,lo8(2)
	add r30,r17
	ldi r18,lo8(18)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ldd r24,Y+35
	st Z,r24
	ldi r30,lo8(3)
	add r30,r17
	ldi r20,lo8(18)
	ldi r21,0
	add r20,r28
	adc r21,r29
	add r20,r30
	adc r21,__zero_reg__
	movw r30,r20
	ldd r24,Y+36
	st Z,r24
	ldi r30,lo8(4)
	add r30,r17
	ldi r22,lo8(18)
	ldi r23,0
	add r22,r28
	adc r23,r29
	add r22,r30
	adc r23,__zero_reg__
	movw r30,r22
	ldi r24,lo8(86)
	st Z,r24
	ldi r30,lo8(5)
	add r30,r17
	ldi r24,lo8(18)
	ldi r25,0
	add r24,r28
	adc r25,r29
	add r24,r30
	adc r25,__zero_reg__
	movw r30,r24
	st Z,r16
	movw r26,r14
	adiw r26,15
	ld r24,X
	ldi r20,lo8(2)
	movw r22,r28
	subi r22,-35
	sbci r23,-1
	ldi r25,0
	call UTL_UIntToStr
	ldi r30,lo8(6)
	add r30,r17
	ldi r18,lo8(18)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ldd r24,Y+35
	st Z,r24
	ldi r30,lo8(7)
	add r30,r17
	ldi r20,lo8(18)
	ldi r21,0
	add r20,r28
	adc r21,r29
	add r20,r30
	adc r21,__zero_reg__
	movw r30,r20
	ldd r24,Y+36
	st Z,r24
	ldi r24,lo8(9)
	add r24,r17
	ldi r30,lo8(8)
	add r30,r17
	ldi r22,lo8(18)
	ldi r23,0
	add r22,r28
	adc r23,r29
	add r22,r30
	adc r23,__zero_reg__
	movw r30,r22
	ldi r25,lo8(67)
	st Z,r25
	ldi r30,lo8(18)
	ldi r31,0
	add r30,r28
	adc r31,r29
	add r30,r24
	adc r31,__zero_reg__
	ldi r25,lo8(32)
.L63:
	cpi r24,lo8(16)
	brlo .L64
	std Y+17,__zero_reg__
	movw r18,r28
	subi r18,-18
	sbci r19,-1
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(g_lcdHandle)
	ldi r25,hi8(g_lcdHandle)
	call LCD_Aip31068_WriteStringAt
	movw r18,r28
	subi r18,-1
	sbci r19,-1
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(g_lcdHandle)
	ldi r25,hi8(g_lcdHandle)
	call LCD_Aip31068_WriteStringAt
	ldi r25,0
	ldi r24,0
.L50:
/* epilogue start */
	adiw r28,40
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L53:
	movw r26,r24
	st X,r18
	mov r16,r30
	rjmp .L52
.L55:
	ldi r30,lo8(18)
	ldi r31,0
	add r30,r28
	adc r31,r29
	add r18,r30
	adc r19,r31
	movw r26,r18
	st X,r20
	mov r17,r24
	rjmp .L54
.L60:
	subi r24,lo8(-(1))
	st Z+,r25
	rjmp .L59
.L62:
	movw r26,r24
	st X,r18
	mov r17,r30
	rjmp .L61
.L64:
	subi r24,lo8(-(1))
	st Z+,r25
	rjmp .L63
.L65:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L50
	.size	LCD_Update, .-LCD_Update
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"!! TRIPPED !!   "
	.text
.global	LCD_ShowTrip
	.type	LCD_ShowTrip, @function
LCD_ShowTrip:
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,21
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 21 */
/* stack size = 25 */
.L__stack_usage = 25
	movw r16,r24
	lds r24,blinkCounter.1687
	lds r25,blinkCounter.1687+1
	adiw r24,1
	cpi r24,15
	cpc r25,__zero_reg__
	brlo .+2
	rjmp .L69
	sts blinkCounter.1687+1,r25
	sts blinkCounter.1687,r24
.L70:
	ldi r18,lo8(.LC0)
	ldi r19,hi8(.LC0)
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(g_lcdHandle)
	ldi r25,hi8(g_lcdHandle)
	call LCD_Aip31068_WriteStringAt
	lds r24,blinkState.1688
	tst r24
	brne .+2
	rjmp .L72
	ldi r24,lo8(33)
	std Y+1,r24
	ldi r24,lo8(84)
	std Y+2,r24
	ldi r24,lo8(82)
	std Y+3,r24
	ldi r24,lo8(73)
	std Y+4,r24
	ldi r24,lo8(80)
	std Y+5,r24
	ldi r24,lo8(61)
	std Y+6,r24
	ldi r20,lo8(2)
	movw r22,r28
	subi r22,-18
	sbci r23,-1
	movw r24,r16
	call UTL_UIntToStr
	ldi r24,lo8(6)
.L73:
	ldi r30,lo8(-6)
	add r30,r24
	ldi r18,lo8(18)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ld r25,Z
	mov r30,r24
	ldi r31,0
	ldi r18,lo8(1)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r30,r18
	adc r31,r19
	cpse r25,__zero_reg__
	rjmp .L74
	ldi r25,lo8(32)
.L75:
	cpi r24,lo8(16)
	brlo .L76
	std Y+17,__zero_reg__
	movw r18,r28
	subi r18,-1
	sbci r19,-1
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(g_lcdHandle)
	ldi r25,hi8(g_lcdHandle)
	call LCD_Aip31068_WriteStringAt
.L77:
	ldi r25,0
	ldi r24,0
/* epilogue start */
	adiw r28,21
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L69:
	sts blinkCounter.1687+1,__zero_reg__
	sts blinkCounter.1687,__zero_reg__
	ldi r24,lo8(1)
	lds r25,blinkState.1688
	cpse r25,__zero_reg__
	ldi r24,0
.L71:
	sts blinkState.1688,r24
	rjmp .L70
.L74:
	st Z,r25
	subi r24,lo8(-(1))
	rjmp .L73
.L76:
	subi r24,lo8(-(1))
	st Z+,r25
	rjmp .L75
.L72:
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	call LCD_Update
	rjmp .L77
	.size	LCD_ShowTrip, .-LCD_ShowTrip
	.local	blinkState.1688
	.comm	blinkState.1688,1,1
	.local	blinkCounter.1687
	.comm	blinkCounter.1687,2,1
	.data
	.type	g_displayControl, @object
	.size	g_displayControl, 1
g_displayControl:
	.byte	12
	.local	g_lcdHandle
	.comm	g_lcdHandle,8,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
