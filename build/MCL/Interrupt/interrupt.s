	.file	"interrupt.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	EXTI_Enable
	.type	EXTI_Enable, @function
EXTI_Enable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L6
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L4
	sbiw r24,2
	breq .L5
	in r24,0x3b
	ori r24,lo8(64)
.L7:
	out 0x3b,r24
	ldi r25,0
	ldi r24,0
	ret
.L4:
	in r24,0x3b
	ori r24,lo8(-128)
	rjmp .L7
.L5:
	in r24,0x3b
	ori r24,lo8(32)
	rjmp .L7
.L6:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_Enable, .-EXTI_Enable
.global	EXTI_Disable
	.type	EXTI_Disable, @function
EXTI_Disable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L13
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L11
	sbiw r24,2
	breq .L12
	in r24,0x3b
	andi r24,lo8(-65)
.L14:
	out 0x3b,r24
	ldi r25,0
	ldi r24,0
	ret
.L11:
	in r24,0x3b
	andi r24,lo8(127)
	rjmp .L14
.L12:
	in r24,0x3b
	andi r24,lo8(-33)
	rjmp .L14
.L13:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_Disable, .-EXTI_Disable
.global	EXTI_SetSenseControl
	.type	EXTI_SetSenseControl, @function
EXTI_SetSenseControl:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L30
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L18
	sbiw r24,2
	breq .L19
	in r24,0x35
	andi r24,lo8(-2)
	out 0x35,r24
	in r24,0x35
	andi r24,lo8(-3)
	out 0x35,r24
	cpi r22,1
	cpc r23,__zero_reg__
	breq .L21
	brlo .L31
	cpi r22,2
	cpc r23,__zero_reg__
	breq .L34
	cpi r22,3
	cpc r23,__zero_reg__
	breq .L24
.L30:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L21:
	in r24,0x35
	ori r24,lo8(1)
.L32:
	out 0x35,r24
.L31:
	ldi r25,0
	ldi r24,0
	ret
.L24:
	in r24,0x35
	ori r24,lo8(1)
	out 0x35,r24
.L34:
	in r24,0x35
	ori r24,lo8(2)
	rjmp .L32
.L18:
	in r24,0x35
	andi r24,lo8(-5)
	out 0x35,r24
	in r24,0x35
	andi r24,lo8(-9)
	out 0x35,r24
	cpi r22,1
	cpc r23,__zero_reg__
	breq .L25
	brlo .L31
	cpi r22,2
	cpc r23,__zero_reg__
	breq .L33
	cpi r22,3
	cpc r23,__zero_reg__
	brne .L30
	in r24,0x35
	ori r24,lo8(4)
	out 0x35,r24
.L33:
	in r24,0x35
	ori r24,lo8(8)
	rjmp .L32
.L25:
	in r24,0x35
	ori r24,lo8(4)
	rjmp .L32
.L19:
	cpi r22,2
	cpc r23,__zero_reg__
	breq .L28
	cpi r22,3
	cpc r23,__zero_reg__
	brne .L30
	in r24,0x34
	ori r24,lo8(64)
	rjmp .L35
.L28:
	in r24,0x34
	andi r24,lo8(-65)
.L35:
	out 0x34,r24
	rjmp .L31
	.size	EXTI_SetSenseControl, .-EXTI_SetSenseControl
.global	EXTI_Init
	.type	EXTI_Init, @function
EXTI_Init:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	breq .L45
	ld r24,Y
	ldd r25,Y+1
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L45
	ldd r22,Y+2
	ldd r23,Y+3
	call EXTI_SetSenseControl
	sbiw r24,0
	brne .L36
	ld r24,Y
	ldd r25,Y+1
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L38
	brlo .L39
	sbiw r24,2
	breq .L40
.L45:
	ldi r24,lo8(1)
	ldi r25,0
.L36:
/* epilogue start */
	pop r29
	pop r28
	ret
.L39:
	in r24,0x3a
	ori r24,lo8(64)
.L46:
	out 0x3a,r24
	ld r24,Y
	ldd r25,Y+1
/* epilogue start */
	pop r29
	pop r28
	jmp EXTI_Enable
.L38:
	in r24,0x3a
	ori r24,lo8(-128)
	rjmp .L46
.L40:
	in r24,0x3a
	ori r24,lo8(32)
	rjmp .L46
	.size	EXTI_Init, .-EXTI_Init
.global	EXTI_SetCallBack
	.type	EXTI_SetCallBack, @function
EXTI_SetCallBack:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,3
	brsh .L50
	ldi r24,lo8(1)
	ldi r25,0
	or r22,r23
	breq .L47
	ldi r24,0
	ret
.L50:
	ldi r24,lo8(1)
	ldi r25,0
.L47:
/* epilogue start */
	ret
	.size	EXTI_SetCallBack, .-EXTI_SetCallBack
.global	EXTI_EnableGlobalInterrupt
	.type	EXTI_EnableGlobalInterrupt, @function
EXTI_EnableGlobalInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	ori r24,lo8(-128)
	out __SREG__,r24
/* epilogue start */
	ret
	.size	EXTI_EnableGlobalInterrupt, .-EXTI_EnableGlobalInterrupt
.global	EXTI_DisableGlobalInterrupt
	.type	EXTI_DisableGlobalInterrupt, @function
EXTI_DisableGlobalInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	andi r24,lo8(127)
	out __SREG__,r24
/* epilogue start */
	ret
	.size	EXTI_DisableGlobalInterrupt, .-EXTI_DisableGlobalInterrupt
	.ident	"GCC: (GNU) 7.3.0"
