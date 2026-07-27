	.file	"ADC.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	ADC_Init
	.type	ADC_Init, @function
ADC_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L21
	ld r24,Z
	cpi r24,lo8(1)
	breq .L3
	brlo .L4
	cpi r24,lo8(3)
	breq .L5
.L21:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L4:
	cbi 0x7,6
.L22:
	cbi 0x7,7
.L6:
	cbi 0x7,5
	cbi 0x7,0
	cbi 0x7,1
	cbi 0x7,2
	cbi 0x7,3
	cbi 0x7,4
	cbi 0x6,0
	cbi 0x6,1
	cbi 0x6,2
	ldd r24,Z+1
	sbrc r24,0
	sbi 0x6,0
.L7:
	ldd r24,Z+1
	sbrc r24,1
	sbi 0x6,1
.L8:
	ldd r24,Z+1
	sbrc r24,2
	sbi 0x6,2
.L9:
	sbi 0x6,7
	ldi r25,0
	ldi r24,0
	ret
.L3:
	sbi 0x7,6
	rjmp .L22
.L5:
	sbi 0x7,6
	sbi 0x7,7
	rjmp .L6
	.size	ADC_Init, .-ADC_Init
.global	ADC_DeInit
	.type	ADC_DeInit, @function
ADC_DeInit:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cbi 0x6,7
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	ADC_DeInit, .-ADC_DeInit
.global	ADC_StartConversion
	.type	ADC_StartConversion, @function
ADC_StartConversion:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(8)
	brsh .L29
	cbi 0x7,0
	cbi 0x7,1
	cbi 0x7,2
	cbi 0x7,3
	cbi 0x7,4
	sbrc r24,0
	sbi 0x7,0
.L26:
	sbrc r24,1
	sbi 0x7,1
.L27:
	lsr r24
	lsr r24
	breq .L28
	sbi 0x7,2
.L28:
	sbi 0x6,6
	ldi r25,0
	ldi r24,0
	ret
.L29:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_StartConversion, .-ADC_StartConversion
.global	ADC_IsConversionComplete
	.type	ADC_IsConversionComplete, @function
ADC_IsConversionComplete:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x6
	swap r24
	lsr r24
	lsr r24
	andi r24,lo8(3)
	com r24
	andi r24,lo8(1)
/* epilogue start */
	ret
	.size	ADC_IsConversionComplete, .-ADC_IsConversionComplete
.global	ADC_ReadResult
	.type	ADC_ReadResult, @function
ADC_ReadResult:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L42
	in r19,0x4
	in r18,0x5
	eor r18,r19
	eor r19,r18
	eor r18,r19
	movw r30,r24
	std Z+1,r19
	st Z,r18
	ldi r25,0
	ldi r24,0
	ret
.L42:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	ADC_ReadResult, .-ADC_ReadResult
.global	ADC_ReadChannelBlocking
	.type	ADC_ReadChannelBlocking, @function
ADC_ReadChannelBlocking:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r22
	call ADC_StartConversion
	sbiw r24,0
	brne .L43
.L45:
	call ADC_IsConversionComplete
	tst r24
	breq .L45
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	jmp ADC_ReadResult
.L43:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	ADC_ReadChannelBlocking, .-ADC_ReadChannelBlocking
	.ident	"GCC: (GNU) 7.3.0"
