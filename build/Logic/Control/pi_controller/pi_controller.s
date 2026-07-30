	.file	"pi_controller.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	PI_Init
	.type	PI_Init, @function
PI_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+1,r23
	st Z,r22
	std Z+3,r21
	std Z+2,r20
	std Z+4,__zero_reg__
	std Z+5,__zero_reg__
	std Z+6,__zero_reg__
	std Z+7,__zero_reg__
	std Z+9,__zero_reg__
	std Z+8,__zero_reg__
	ldi r24,lo8(-113)
	ldi r25,lo8(1)
	std Z+11,r25
	std Z+10,r24
	std Z+13,__zero_reg__
	std Z+12,__zero_reg__
	std Z+15,__zero_reg__
	std Z+14,__zero_reg__
	ldi r24,lo8(1)
	std Z+16,r24
/* epilogue start */
	ret
	.size	PI_Init, .-PI_Init
.global	PI_InitLimits
	.type	PI_InitLimits, @function
PI_InitLimits:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+9,r23
	std Z+8,r22
	std Z+11,r21
	std Z+10,r20
/* epilogue start */
	ret
	.size	PI_InitLimits, .-PI_InitLimits
.global	PI_Step
	.type	PI_Step, @function
PI_Step:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r30,r24
	movw r24,r22
	sub r24,r20
	sbc r25,r21
	movw r20,r24
	ldd r26,Z+2
	ldd r27,Z+3
	movw r18,r24
	call __mulhisi3
	ldd r16,Z+4
	ldd r17,Z+5
	ldd r18,Z+6
	ldd r19,Z+7
	movw r12,r22
	movw r14,r24
	add r12,r16
	adc r13,r17
	adc r14,r18
	adc r15,r19
	ld r26,Z
	ldd r27,Z+1
	movw r18,r20
	call __mulhisi3
	mov r16,r23
	mov r17,r24
	mov r18,r25
	clr r19
	sbrc r18,7
	dec r19
	clr r27
	sbrc r15,7
	dec r27
	mov r26,r15
	mov r25,r14
	mov r24,r13
	add r16,r24
	adc r17,r25
	adc r18,r26
	adc r19,r27
	ldd r24,Z+10
	ldd r25,Z+11
	mov __tmp_reg__,r25
	lsl r0
	sbc r26,r26
	sbc r27,r27
	cp r24,r16
	cpc r25,r17
	cpc r26,r18
	cpc r27,r19
	brge .L4
	sbrs r21,7
	rjmp .L5
.L15:
	ldd r18,Z+16
	tst r18
	breq .L5
	std Z+4,r12
	std Z+5,r13
	std Z+6,r14
	std Z+7,r15
	rjmp .L5
.L4:
	ldd r24,Z+8
	ldd r25,Z+9
	mov __tmp_reg__,r25
	lsl r0
	sbc r26,r26
	sbc r27,r27
	cp r16,r24
	cpc r17,r25
	cpc r18,r26
	cpc r19,r27
	brge .L6
	cp __zero_reg__,r20
	cpc __zero_reg__,r21
	brlt .L15
.L5:
	std Z+13,r21
	std Z+12,r20
	std Z+15,r25
	std Z+14,r24
/* epilogue start */
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
.L6:
	std Z+4,r12
	std Z+5,r13
	std Z+6,r14
	std Z+7,r15
	movw r24,r16
	rjmp .L5
	.size	PI_Step, .-PI_Step
.global	PI_Reset
	.type	PI_Reset, @function
PI_Reset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+4,__zero_reg__
	std Z+5,__zero_reg__
	std Z+6,__zero_reg__
	std Z+7,__zero_reg__
	std Z+13,__zero_reg__
	std Z+12,__zero_reg__
	std Z+15,__zero_reg__
	std Z+14,__zero_reg__
/* epilogue start */
	ret
	.size	PI_Reset, .-PI_Reset
.global	PI_SetGains
	.type	PI_SetGains, @function
PI_SetGains:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+1,r23
	st Z,r22
	std Z+3,r21
	std Z+2,r20
/* epilogue start */
	ret
	.size	PI_SetGains, .-PI_SetGains
.global	PI_GetIntegral
	.type	PI_GetIntegral, @function
PI_GetIntegral:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r22,Z+4
	ldd r23,Z+5
	ldd r24,Z+6
	ldd r25,Z+7
/* epilogue start */
	ret
	.size	PI_GetIntegral, .-PI_GetIntegral
.global	PI_GetError
	.type	PI_GetError, @function
PI_GetError:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r24,Z+12
	ldd r25,Z+13
/* epilogue start */
	ret
	.size	PI_GetError, .-PI_GetError
	.ident	"GCC: (GNU) 7.3.0"
