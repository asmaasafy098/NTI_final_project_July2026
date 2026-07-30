	.file	"ramp_generator.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	RAMP_Init
	.type	RAMP_Init, @function
RAMP_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+5,__zero_reg__
	std Z+4,__zero_reg__
	ldi r24,lo8(88)
	ldi r25,lo8(2)
	std Z+7,r25
	std Z+6,r24
	ldi r24,lo8(-124)
	ldi r25,lo8(3)
	std Z+9,r25
	std Z+8,r24
	ldi r24,lo8(-56)
	ldi r25,0
	std Z+11,r25
	std Z+10,r24
	ldi r24,lo8(-72)
	ldi r25,lo8(11)
	std Z+13,r25
	std Z+12,r24
	ldi r24,lo8(1)
	std Z+14,r24
/* epilogue start */
	ret
	.size	RAMP_Init, .-RAMP_Init
.global	RAMP_SetTarget
	.type	RAMP_SetTarget, @function
RAMP_SetTarget:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r25,Z+12
	ldd r24,Z+13
	ldd r18,Z+10
	ldd r19,Z+11
	cp r22,r18
	cpc r23,r19
	brlt .L3
	mov r18,r25
	mov r19,r24
	cp r22,r18
	cpc r23,r19
	brge .L3
	movw r18,r22
.L3:
	std Z+1,r19
	st Z,r18
	std Z+14,__zero_reg__
/* epilogue start */
	ret
	.size	RAMP_SetTarget, .-RAMP_SetTarget
.global	RAMP_SetLimits
	.type	RAMP_SetLimits, @function
RAMP_SetLimits:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+11,r23
	std Z+10,r22
	std Z+13,r21
	std Z+12,r20
/* epilogue start */
	ret
	.size	RAMP_SetLimits, .-RAMP_SetLimits
.global	RAMP_SetRates
	.type	RAMP_SetRates, @function
RAMP_SetRates:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+7,r23
	std Z+6,r22
	std Z+9,r21
	std Z+8,r20
/* epilogue start */
	ret
	.size	RAMP_SetRates, .-RAMP_SetRates
.global	RAMP_Step
	.type	RAMP_Step, @function
RAMP_Step:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r30,r24
	ld r28,Z
	ldd r29,Z+1
	ldd r16,Z+2
	ldd r17,Z+3
	movw r18,r28
	sub r18,r16
	sbc r19,r17
	cp __zero_reg__,r18
	cpc __zero_reg__,r19
	brge .L8
	ldd r20,Z+6
	ldd r21,Z+7
	ldi r22,lo8(100)
	mul r22,r20
	movw r24,r0
	mul r22,r21
	add r25,r0
	clr __zero_reg__
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	call __udivmodhi4
	cp r22,r18
	cpc r23,r19
	brge .L9
	movw r18,r22
.L9:
	add r18,r16
	adc r19,r17
	std Z+3,r19
	std Z+2,r18
.L10:
	ldd r21,Z+12
	ldd r20,Z+13
	ldd r24,Z+10
	ldd r25,Z+11
	ldd r18,Z+2
	ldd r19,Z+3
	cp r18,r24
	cpc r19,r25
	brlt .L12
	mov r24,r21
	mov r25,r20
	cp r18,r24
	cpc r19,r25
	brge .L12
	movw r24,r18
.L12:
	std Z+3,r25
	std Z+2,r24
	std Z+5,r25
	std Z+4,r24
	cp r28,r24
	cpc r29,r25
	brne .L7
	ldi r18,lo8(1)
	std Z+14,r18
.L7:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L8:
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L10
	ldd r20,Z+8
	ldd r21,Z+9
	ldi r22,lo8(100)
	mul r22,r20
	movw r24,r0
	mul r22,r21
	add r25,r0
	clr __zero_reg__
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	call __udivmodhi4
	neg r19
	neg r18
	sbc r19,__zero_reg__
	cp r22,r18
	cpc r23,r19
	brge .L11
	movw r18,r22
.L11:
	sub r16,r18
	sbc r17,r19
	std Z+3,r17
	std Z+2,r16
	rjmp .L10
	.size	RAMP_Step, .-RAMP_Step
.global	RAMP_GetOutput
	.type	RAMP_GetOutput, @function
RAMP_GetOutput:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r24,Z+4
	ldd r25,Z+5
/* epilogue start */
	ret
	.size	RAMP_GetOutput, .-RAMP_GetOutput
.global	RAMP_AtTarget
	.type	RAMP_AtTarget, @function
RAMP_AtTarget:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldd r24,Z+14
/* epilogue start */
	ret
	.size	RAMP_AtTarget, .-RAMP_AtTarget
.global	RAMP_Reset
	.type	RAMP_Reset, @function
RAMP_Reset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+5,__zero_reg__
	std Z+4,__zero_reg__
	std Z+14,__zero_reg__
/* epilogue start */
	ret
	.size	RAMP_Reset, .-RAMP_Reset
.global	RAMP_GetTimeToTarget
	.type	RAMP_GetTimeToTarget, @function
RAMP_GetTimeToTarget:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ld r18,Z
	ldd r19,Z+1
	ldd r24,Z+2
	ldd r25,Z+3
	sub r18,r24
	sbc r19,r25
	cp __zero_reg__,r18
	cpc __zero_reg__,r19
	brge .L22
	ldd r22,Z+6
	ldd r23,Z+7
.L23:
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L21
	ldi r20,lo8(-24)
	ldi r21,lo8(3)
	mul r18,r20
	movw r24,r0
	mul r18,r21
	add r25,r0
	mul r19,r20
	add r25,r0
	clr r1
	call __udivmodhi4
.L21:
	movw r24,r22
/* epilogue start */
	ret
.L22:
	ldi r23,0
	ldi r22,0
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L21
	ldd r22,Z+8
	ldd r23,Z+9
	neg r19
	neg r18
	sbc r19,__zero_reg__
	rjmp .L23
	.size	RAMP_GetTimeToTarget, .-RAMP_GetTimeToTarget
	.ident	"GCC: (GNU) 7.3.0"
