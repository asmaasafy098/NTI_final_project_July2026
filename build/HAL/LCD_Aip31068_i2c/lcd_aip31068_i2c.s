	.file	"lcd_aip31068_i2c.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	LCD_DelayUs, @function
LCD_DelayUs:
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
	ldi r18,2
	1:
	lsl r22
	rol r23
	rol r24
	rol r25
	dec r18
	brne 1b
	std Y+1,r22
	std Y+2,r23
	std Y+3,r24
	std Y+4,r25
.L2:
	ldd r24,Y+1
	ldd r25,Y+2
	ldd r26,Y+3
	ldd r27,Y+4
	movw r20,r24
	movw r22,r26
	subi r20,1
	sbc r21,__zero_reg__
	sbc r22,__zero_reg__
	sbc r23,__zero_reg__
	std Y+1,r20
	std Y+2,r21
	std Y+3,r22
	std Y+4,r23
	or r24,r25
	or r24,r26
	or r24,r27
	brne .L3
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L3:
/* #APP */
 ;  19 "HAL/LCD_Aip31068_i2c/lcd_aip31068_i2c.c" 1
	nop
 ;  0 "" 2
/* #NOAPP */
	rjmp .L2
	.size	LCD_DelayUs, .-LCD_DelayUs
	.type	LCD_SendBytes, @function
LCD_SendBytes:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	sbiw r24,0
	brne .L5
.L18:
	clr r14
	inc r14
	mov r15,__zero_reg__
.L4:
	movw r24,r14
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L5:
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L18
	tst r18
	breq .L18
	mov r28,r18
	movw r16,r20
	mov r29,r22
	movw r14,r24
	call I2C_Start
	or r24,r25
	brne .L18
	movw r30,r14
	ld r24,Z
	lsl r24
	call I2C_WriteByte
	or r24,r25
	breq .L8
.L9:
	call I2C_Stop
	rjmp .L18
.L8:
	mov r24,r29
	call I2C_WriteByte
	movw r14,r24
	add r28,r16
	mov r29,r17
	adc r29,__zero_reg__
	or r24,r25
	brne .L9
.L10:
	cp r16,r28
	cpc r17,r29
	brne .L11
	call I2C_Stop
	rjmp .L4
.L11:
	movw r30,r16
	ld r24,Z+
	movw r16,r30
	call I2C_WriteByte
	or r24,r25
	breq .L10
	rjmp .L9
	.size	LCD_SendBytes, .-LCD_SendBytes
.global	LCD_Aip31068_SendCommand
	.type	LCD_Aip31068_SendCommand, @function
LCD_Aip31068_SendCommand:
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	std Y+1,r22
	ldi r18,lo8(1)
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	ldi r22,0
	call LCD_SendBytes
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	LCD_Aip31068_SendCommand, .-LCD_Aip31068_SendCommand
.global	LCD_Aip31068_WriteChar
	.type	LCD_Aip31068_WriteChar, @function
LCD_Aip31068_WriteChar:
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	std Y+1,r22
	ldi r18,lo8(1)
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	ldi r22,lo8(64)
	call LCD_SendBytes
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	LCD_Aip31068_WriteChar, .-LCD_Aip31068_WriteChar
.global	LCD_Aip31068_WriteString
	.type	LCD_Aip31068_WriteString, @function
LCD_Aip31068_WriteString:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r20,r22
	sbiw r24,0
	breq .L21
	ldi r18,0
	or r22,r23
	brne .L23
.L21:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L24:
	subi r18,lo8(-(1))
.L23:
	movw r30,r20
	add r30,r18
	adc r31,__zero_reg__
	ld r19,Z
	cpse r19,__zero_reg__
	rjmp .L24
	ldi r22,lo8(64)
	jmp LCD_SendBytes
	.size	LCD_Aip31068_WriteString, .-LCD_Aip31068_WriteString
.global	LCD_Aip31068_WriteNumber
	.type	LCD_Aip31068_WriteNumber, @function
LCD_Aip31068_WriteNumber:
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,12
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 12 */
/* stack size = 27 */
.L__stack_usage = 27
	movw r12,r24
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brne .L30
	ldi r22,lo8(48)
	call LCD_Aip31068_WriteChar
.L29:
/* epilogue start */
	adiw r28,12
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
	pop r13
	pop r12
	pop r11
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	ret
.L30:
	mov r11,__zero_reg__
	sbrs r23,7
	rjmp .L32
	com r23
	com r22
	com r21
	neg r20
	sbci r21,lo8(-1)
	sbci r22,lo8(-1)
	sbci r23,lo8(-1)
	clr r11
	inc r11
.L32:
	ldi r16,0
	movw r24,r28
	adiw r24,1
	movw r14,r24
	ldi r24,lo8(10)
	mov r4,r24
	mov r5,__zero_reg__
	mov r6,__zero_reg__
	mov r7,__zero_reg__
	rjmp .L33
.L39:
	mov r16,r17
.L33:
	ldi r17,lo8(1)
	add r17,r16
	movw r8,r14
	add r8,r16
	adc r9,__zero_reg__
	movw r24,r22
	movw r22,r20
	movw r20,r6
	movw r18,r4
	call __divmodsi4
	mov r25,r20
	mov r24,r21
	subi r22,lo8(-(48))
	movw r30,r8
	st Z,r22
	movw r20,r18
	mov r22,r25
	mov r23,r24
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	brne .L39
	tst r11
	breq .L35
	movw r30,r14
	add r30,r17
	adc r31,__zero_reg__
	ldi r24,lo8(45)
	st Z,r24
	ldi r17,lo8(2)
	add r17,r16
.L35:
	mov r18,r17
	lsr r18
	mov r24,r17
	ldi r25,0
	movw r26,r14
	add r26,r24
	adc r27,r25
	movw r16,r14
.L36:
	sbiw r26,1
	mov r19,r16
	sub r19,r14
	cp r19,r18
	brlo .L37
	add r24,r14
	adc r25,r15
	movw r30,r24
	st Z,__zero_reg__
	movw r22,r14
	movw r24,r12
	call LCD_Aip31068_WriteString
	rjmp .L29
.L37:
	movw r30,r16
	ld r19,Z+
	movw r16,r30
	ld r22,X
	movw r20,r30
	subi r20,1
	sbc r21,__zero_reg__
	movw r30,r20
	st Z,r22
	st X,r19
	rjmp .L36
	.size	LCD_Aip31068_WriteNumber, .-LCD_Aip31068_WriteNumber
.global	LCD_Aip31068_SetCursor
	.type	LCD_Aip31068_SetCursor, @function
LCD_Aip31068_SetCursor:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L44
	movw r30,r24
	ldd r18,Z+1
	cp r22,r18
	brsh .L44
	ldd r18,Z+2
	cp r20,r18
	brsh .L44
	mov r30,r22
	ldi r31,0
	subi r30,lo8(-(rowOffsets.1648))
	sbci r31,hi8(-(rowOffsets.1648))
	ld r18,Z
	add r18,r20
	movw r30,r24
	std Z+6,r22
	std Z+7,r20
	mov r22,r18
	ori r22,lo8(-128)
	jmp LCD_Aip31068_SendCommand
.L44:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
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
	brne .L51
	movw r22,r16
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	jmp LCD_Aip31068_WriteString
.L51:
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
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r22,lo8(1)
	call LCD_Aip31068_SendCommand
	movw r28,r24
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	LCD_Aip31068_Clear, .-LCD_Aip31068_Clear
.global	LCD_Aip31068_Init
	.type	LCD_Aip31068_Init, @function
LCD_Aip31068_Init:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r28,r24
	or r24,r25
	brne .L54
.L56:
	ldi r16,lo8(1)
	ldi r17,0
.L53:
	movw r24,r16
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L54:
	ld r24,Y
	sbrc r24,7
	rjmp .L56
	ldd r24,Y+1
	tst r24
	breq .L56
	ldd r24,Y+2
	ldi r17,0
	ldi r16,0
	tst r24
	breq .L56
.L57:
	subi r16,-1
	sbci r17,-1
	cpi r16,51
	cpc r17,__zero_reg__
	brne .L58
	ldi r22,lo8(40)
	movw r24,r28
	call LCD_Aip31068_SendCommand
	or r24,r25
	brne .L56
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	ldi r24,lo8(4)
	std Y+4,r24
	ldi r22,lo8(12)
	movw r24,r28
	call LCD_Aip31068_SendCommand
	or r24,r25
	brne .L56
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	movw r24,r28
	call LCD_Aip31068_Clear
	or r24,r25
	brne .L56
	ldi r24,lo8(2)
	std Y+5,r24
	ldi r22,lo8(6)
	movw r24,r28
	call LCD_Aip31068_SendCommand
	movw r16,r24
	or r24,r25
	breq .+2
	rjmp .L56
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	ldi r24,lo8(1)
	std Y+3,r24
	rjmp .L53
.L58:
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	rjmp .L57
	.size	LCD_Aip31068_Init, .-LCD_Aip31068_Init
.global	LCD_Aip31068_Home
	.type	LCD_Aip31068_Home, @function
LCD_Aip31068_Home:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r22,lo8(2)
	call LCD_Aip31068_SendCommand
	movw r28,r24
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	ldi r24,0
	ldi r25,0
	call LCD_DelayUs
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	LCD_Aip31068_Home, .-LCD_Aip31068_Home
.global	LCD_Aip31068_DisplayOnOff
	.type	LCD_Aip31068_DisplayOnOff, @function
LCD_Aip31068_DisplayOnOff:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r25,Z+4
	tst r22
	breq .L67
	ori r25,lo8(4)
.L69:
	std Z+4,r25
	ldd r22,Z+4
	ori r22,lo8(8)
	movw r24,r30
	jmp LCD_Aip31068_SendCommand
.L67:
	andi r25,lo8(-5)
	rjmp .L69
	.size	LCD_Aip31068_DisplayOnOff, .-LCD_Aip31068_DisplayOnOff
.global	LCD_Aip31068_CursorOnOff
	.type	LCD_Aip31068_CursorOnOff, @function
LCD_Aip31068_CursorOnOff:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r25,Z+4
	tst r22
	breq .L71
	ori r25,lo8(2)
.L73:
	std Z+4,r25
	ldd r22,Z+4
	ori r22,lo8(8)
	movw r24,r30
	jmp LCD_Aip31068_SendCommand
.L71:
	andi r25,lo8(-3)
	rjmp .L73
	.size	LCD_Aip31068_CursorOnOff, .-LCD_Aip31068_CursorOnOff
.global	LCD_Aip31068_BlinkOnOff
	.type	LCD_Aip31068_BlinkOnOff, @function
LCD_Aip31068_BlinkOnOff:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r25,Z+4
	tst r22
	breq .L75
	ori r25,lo8(1)
.L77:
	std Z+4,r25
	ldd r22,Z+4
	ori r22,lo8(8)
	movw r24,r30
	jmp LCD_Aip31068_SendCommand
.L75:
	andi r25,lo8(-2)
	rjmp .L77
	.size	LCD_Aip31068_BlinkOnOff, .-LCD_Aip31068_BlinkOnOff
.global	LCD_Aip31068_ShiftDisplay
	.type	LCD_Aip31068_ShiftDisplay, @function
LCD_Aip31068_ShiftDisplay:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpse r22,__zero_reg__
	rjmp .L80
	ldi r22,lo8(24)
.L79:
	jmp LCD_Aip31068_SendCommand
.L80:
	ldi r22,lo8(28)
	rjmp .L79
	.size	LCD_Aip31068_ShiftDisplay, .-LCD_Aip31068_ShiftDisplay
.global	LCD_Aip31068_CreateCustomChar
	.type	LCD_Aip31068_CreateCustomChar, @function
LCD_Aip31068_CreateCustomChar:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	sbiw r24,0
	breq .L81
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L81
	cpi r22,lo8(8)
	brsh .L81
	movw r16,r20
	movw r28,r24
	ldi r24,lo8(8)
	mul r22,r24
	movw r22,r0
	clr __zero_reg__
	ori r22,lo8(64)
	movw r24,r28
	call LCD_Aip31068_SendCommand
	movw r14,r16
	ldi r30,8
	add r14,r30
	adc r15,__zero_reg__
.L83:
	movw r30,r16
	ld r22,Z+
	movw r16,r30
	movw r24,r28
	call LCD_Aip31068_WriteChar
	cp r16,r14
	cpc r17,r15
	brne .L83
	ldi r20,0
	ldi r22,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	jmp LCD_Aip31068_SetCursor
.L81:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	LCD_Aip31068_CreateCustomChar, .-LCD_Aip31068_CreateCustomChar
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"RPM:"
.LC1:
	.string	"SET:"
	.text
.global	LCD_Update
	.type	LCD_Update, @function
LCD_Update:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
	call LCD_Aip31068_Clear
	ldi r18,lo8(.LC0)
	ldi r19,hi8(.LC0)
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
	call LCD_Aip31068_WriteStringAt
	ldd r20,Y+4
	ldd r21,Y+5
	mov __tmp_reg__,r21
	lsl r0
	sbc r22,r22
	sbc r23,r23
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
	call LCD_Aip31068_WriteNumber
	ldi r18,lo8(.LC1)
	ldi r19,hi8(.LC1)
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
	call LCD_Aip31068_WriteStringAt
	ld r20,Y
	ldd r21,Y+1
	mov __tmp_reg__,r21
	lsl r0
	sbc r22,r22
	sbc r23,r23
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
/* epilogue start */
	pop r29
	pop r28
	jmp LCD_Aip31068_WriteNumber
	.size	LCD_Update, .-LCD_Update
	.section	.rodata.str1.1
.LC2:
	.string	"FAULT"
.LC3:
	.string	"E-STOP"
.LC4:
	.string	"SHORT"
.LC5:
	.string	"OVERLOAD"
.LC6:
	.string	"OVERTEMP"
.LC7:
	.string	"UNDERVOLT"
.LC8:
	.string	"OVERVOLT"
.LC9:
	.string	"STALL"
.LC10:
	.string	"OVERSPEED"
.LC11:
	.string	"NO FEEDBACK"
.LC12:
	.string	"UNKNOWN"
	.text
.global	LCD_ShowTrip
	.type	LCD_ShowTrip, @function
LCD_ShowTrip:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
	call LCD_Aip31068_Clear
	ldi r18,lo8(.LC2)
	ldi r19,hi8(.LC2)
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
	call LCD_Aip31068_WriteStringAt
	movw r30,r28
	sbiw r30,1
	ldi r18,lo8(.LC12)
	ldi r19,hi8(.LC12)
	cpi r30,9
	cpc r31,__zero_reg__
	brsh .L103
	subi r30,lo8(-(gs(.L94)))
	sbci r31,hi8(-(gs(.L94)))
	jmp __tablejump2__
	.p2align	1
.L94:
	.word gs(.L93)
	.word gs(.L95)
	.word gs(.L96)
	.word gs(.L97)
	.word gs(.L98)
	.word gs(.L99)
	.word gs(.L100)
	.word gs(.L101)
	.word gs(.L102)
.L93:
	ldi r18,lo8(.LC3)
	ldi r19,hi8(.LC3)
.L103:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(lcd)
	ldi r25,hi8(lcd)
/* epilogue start */
	pop r29
	pop r28
	jmp LCD_Aip31068_WriteStringAt
.L95:
	ldi r18,lo8(.LC4)
	ldi r19,hi8(.LC4)
	rjmp .L103
.L96:
	ldi r18,lo8(.LC5)
	ldi r19,hi8(.LC5)
	rjmp .L103
.L97:
	ldi r18,lo8(.LC6)
	ldi r19,hi8(.LC6)
	rjmp .L103
.L98:
	ldi r18,lo8(.LC7)
	ldi r19,hi8(.LC7)
	rjmp .L103
.L99:
	ldi r18,lo8(.LC8)
	ldi r19,hi8(.LC8)
	rjmp .L103
.L100:
	ldi r18,lo8(.LC9)
	ldi r19,hi8(.LC9)
	rjmp .L103
.L101:
	ldi r18,lo8(.LC10)
	ldi r19,hi8(.LC10)
	rjmp .L103
.L102:
	ldi r18,lo8(.LC11)
	ldi r19,hi8(.LC11)
	rjmp .L103
	.size	LCD_ShowTrip, .-LCD_ShowTrip
	.section	.rodata
	.type	rowOffsets.1648, @object
	.size	rowOffsets.1648, 4
rowOffsets.1648:
	.byte	0
	.byte	64
	.byte	20
	.byte	84
	.data
	.type	lcd, @object
	.size	lcd, 8
lcd:
	.byte	62
	.byte	2
	.byte	16
	.zero	5
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
