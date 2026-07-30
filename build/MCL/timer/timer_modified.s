	.file	"timer_modified.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	Timer0_Init
	.type	Timer0_Init, @function
Timer0_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x33
	andi r24,lo8(-65)
	out 0x33,r24
	in r24,0x33
	ori r24,lo8(8)
	out 0x33,r24
	out 0x32,__zero_reg__
	ldi r24,lo8(77)
	out 0x3c,r24
	in r24,0x33
	ori r24,lo8(4)
	out 0x33,r24
	in r24,0x33
	andi r24,lo8(-3)
	out 0x33,r24
	in r24,0x33
	ori r24,lo8(1)
	out 0x33,r24
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	Timer0_Init, .-Timer0_Init
.global	Timer0_EnableInterrupt
	.type	Timer0_EnableInterrupt, @function
Timer0_EnableInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	or r24,r25
	brne .L5
	in r24,0x39
	ldi r25,lo8(1)
	or r22,r23
	breq .L4
	ldi r25,lo8(2)
.L4:
	or r24,r25
	out 0x39,r24
	ldi r25,0
	ldi r24,0
	ret
.L5:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Timer0_EnableInterrupt, .-Timer0_EnableInterrupt
.global	Timer0_DisableInterrupt
	.type	Timer0_DisableInterrupt, @function
Timer0_DisableInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	or r24,r25
	brne .L10
	in r24,0x39
	ldi r25,lo8(-2)
	or r22,r23
	breq .L9
	ldi r25,lo8(-3)
.L9:
	and r24,r25
	out 0x39,r24
	ldi r25,0
	ldi r24,0
	ret
.L10:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Timer0_DisableInterrupt, .-Timer0_DisableInterrupt
.global	Timer_SetCallBack
	.type	Timer_SetCallBack, @function
Timer_SetCallBack:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L14
	sts Timer0_CompareMatch_CallBack+1,r21
	sts Timer0_CompareMatch_CallBack,r20
	ldi r25,0
	ldi r24,0
	ret
.L14:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Timer_SetCallBack, .-Timer_SetCallBack
.global	__vector_10
	.type	__vector_10, @function
__vector_10:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r30,Timer0_CompareMatch_CallBack
	lds r31,Timer0_CompareMatch_CallBack+1
	sbiw r30,0
	breq .L15
	icall
.L15:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_10, .-__vector_10
.global	Timer1_Init
	.type	Timer1_Init, @function
Timer1_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x2f
	andi r24,lo8(-2)
	out 0x2f,r24
	in r24,0x2f
	ori r24,lo8(2)
	out 0x2f,r24
	in r24,0x2e
	ori r24,lo8(8)
	out 0x2e,r24
	in r24,0x2e
	ori r24,lo8(16)
	out 0x2e,r24
	in r24,0x2f
	andi r24,lo8(-65)
	out 0x2f,r24
	in r24,0x2f
	ori r24,lo8(-128)
	out 0x2f,r24
	out 0x2c+1,__zero_reg__
	out 0x2c,__zero_reg__
	ldi r24,lo8(-113)
	ldi r25,lo8(1)
	out 0x26+1,r25
	out 0x26,r24
	in r24,0x2e
	andi r24,lo8(-5)
	out 0x2e,r24
	in r24,0x2e
	andi r24,lo8(-3)
	out 0x2e,r24
	in r24,0x2e
	ori r24,lo8(1)
	out 0x2e,r24
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,lo8(3)
	call GPIO_set_pin_Direction
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	Timer1_Init, .-Timer1_Init
.global	Timer1_SetDuty
	.type	Timer1_SetDuty, @function
Timer1_SetDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,101
	cpc r25,__zero_reg__
	brsh .L24
	sbiw r24,0
	brne .L23
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
.L25:
	ldi r25,0
	ldi r24,0
	ret
.L23:
	movw r18,r24
	ldi r26,lo8(-112)
	ldi r27,lo8(1)
	call __umulhisi3
	ldi r18,lo8(100)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	subi r18,1
	sbc r19,__zero_reg__
	out 0x2a+1,r19
	out 0x2a,r18
	rjmp .L25
.L24:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Timer1_SetDuty, .-Timer1_SetDuty
.global	Timer2_Init
	.type	Timer2_Init, @function
Timer2_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x25
	andi r24,lo8(-65)
	out 0x25,r24
	in r24,0x25
	ori r24,lo8(8)
	out 0x25,r24
	out 0x24,__zero_reg__
	in r24,0x25
	ori r24,lo8(4)
	out 0x25,r24
	in r24,0x25
	andi r24,lo8(-3)
	out 0x25,r24
	in r24,0x25
	ori r24,lo8(1)
	out 0x25,r24
	in r24,0x25
	andi r24,lo8(-33)
	out 0x25,r24
	in r24,0x25
	ori r24,lo8(16)
	out 0x25,r24
	ldi r20,lo8(1)
	ldi r22,lo8(7)
	ldi r24,lo8(3)
	call GPIO_set_pin_Direction
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	Timer2_Init, .-Timer2_Init
.global	Timer2_SetTone
	.type	Timer2_SetTone, @function
Timer2_SetTone:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,-1
	cpc r25,__zero_reg__
	breq .+2
	brsh .L29
	out 0x23,r24
	ldi r25,0
	ldi r24,0
	ret
.L29:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Timer2_SetTone, .-Timer2_SetTone
.global	Timer_EnableGlobalInterrupt
	.type	Timer_EnableGlobalInterrupt, @function
Timer_EnableGlobalInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	ori r24,lo8(-128)
	out __SREG__,r24
/* epilogue start */
	ret
	.size	Timer_EnableGlobalInterrupt, .-Timer_EnableGlobalInterrupt
.global	Timer_DisableGlobalInterrupt
	.type	Timer_DisableGlobalInterrupt, @function
Timer_DisableGlobalInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	andi r24,lo8(127)
	out __SREG__,r24
/* epilogue start */
	ret
	.size	Timer_DisableGlobalInterrupt, .-Timer_DisableGlobalInterrupt
	.local	Timer0_CompareMatch_CallBack
	.comm	Timer0_CompareMatch_CallBack,2,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
