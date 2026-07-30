	.file	"dc_motor.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	DC_Motor_PwmPin, @function
DC_Motor_PwmPin:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r26,r22
	movw r30,r20
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L3
	brsh .L4
	sbiw r24,1
	breq .L5
.L2:
	st X,__zero_reg__
	st Z,__zero_reg__
/* epilogue start */
	ret
.L4:
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L6
	sbiw r24,4
	brne .L2
	ldi r24,lo8(3)
	st X,r24
	ldi r24,lo8(7)
	rjmp .L9
.L5:
	ldi r24,lo8(1)
	st X,r24
	ldi r24,lo8(3)
.L9:
	st Z,r24
	ret
.L3:
	ldi r24,lo8(3)
	st X,r24
	ldi r24,lo8(5)
	rjmp .L9
.L6:
	ldi r24,lo8(3)
	st X,r24
	ldi r24,lo8(4)
	rjmp .L9
	.size	DC_Motor_PwmPin, .-DC_Motor_PwmPin
	.type	DC_Motor_PwmSetDuty, @function
DC_Motor_PwmSetDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L12
	brsh .L13
	sbiw r24,1
	breq .L14
	ret
.L13:
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L15
	sbiw r24,4
	breq .L16
	ret
.L14:
	out 0x3c,r22
	ret
.L12:
	ldi r23,0
	out 0x2a+1,r23
	out 0x2a,r22
	ret
.L15:
	ldi r23,0
	out 0x28+1,r23
	out 0x28,r22
	ret
.L16:
	out 0x23,r22
/* epilogue start */
	ret
	.size	DC_Motor_PwmSetDuty, .-DC_Motor_PwmSetDuty
	.type	DC_Motor_ApplyState, @function
DC_Motor_ApplyState:
	push r14
	push r15
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 5 */
.L__stack_usage = 5
	movw r28,r24
	movw r14,r22
	movw r24,r22
	sbiw r24,1
	ldi r17,0
	ldi r20,0
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L18
	movw r30,r24
	subi r30,lo8(-(CSWTCH.16))
	sbci r31,hi8(-(CSWTCH.16))
	ld r20,Z
	movw r30,r24
	subi r30,lo8(-(CSWTCH.17))
	sbci r31,hi8(-(CSWTCH.17))
	ld r17,Z
.L18:
	ldd r18,Y+8
	tst r18
	breq .L19
	sbiw r24,2
	brsh .L19
	mov r24,r20
	mov r20,r17
	mov r17,r24
.L19:
	ldd r22,Y+1
	ld r24,Y
	call GPIO_set_pin_value
	mov r20,r17
	ldd r22,Y+3
	ldd r24,Y+2
	call GPIO_set_pin_value
	std Y+12,r15
	std Y+11,r14
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r15
	pop r14
	ret
	.size	DC_Motor_ApplyState, .-DC_Motor_ApplyState
	.type	DC_Motor_PwmConnect, @function
DC_Motor_PwmConnect:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L26
	brsh .L27
	sbiw r24,1
	breq .L28
	ret
.L27:
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L29
	sbiw r24,4
	breq .L30
	ret
.L28:
	in r24,0x33
	tst r22
	breq .L31
	ori r24,lo8(32)
.L35:
	out 0x33,r24
	ret
.L31:
	andi r24,lo8(-33)
	rjmp .L35
.L26:
	in r24,0x2f
	tst r22
	breq .L32
	ori r24,lo8(-128)
.L37:
	out 0x2f,r24
	ret
.L32:
	andi r24,lo8(127)
	rjmp .L37
.L29:
	in r24,0x2f
	tst r22
	breq .L33
	ori r24,lo8(32)
	rjmp .L37
.L33:
	andi r24,lo8(-33)
	rjmp .L37
.L30:
	in r24,0x25
	tst r22
	breq .L34
	ori r24,lo8(32)
.L36:
	out 0x25,r24
/* epilogue start */
	ret
.L34:
	andi r24,lo8(-33)
	rjmp .L36
	.size	DC_Motor_PwmConnect, .-DC_Motor_PwmConnect
	.type	DC_Motor_ApplySpeed, @function
DC_Motor_ApplySpeed:
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r16,r24
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	movw r30,r24
	ldd r24,Z+6
	ldd r25,Z+7
	sbiw r24,0
	brne .L39
	ldi r20,lo8(1)
	ldd r24,Z+10
	cpse r24,__zero_reg__
	rjmp .L40
	ldi r20,0
.L40:
	movw r30,r16
	ldd r22,Z+5
	ldd r24,Z+4
.L44:
	call GPIO_set_pin_value
.L38:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L39:
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	movw r22,r28
	subi r22,-2
	sbci r23,-1
	call DC_Motor_PwmPin
	movw r30,r16
	ldd r24,Z+10
	ldd r18,Z+6
	ldd r19,Z+7
	cpse r24,__zero_reg__
	rjmp .L42
	ldi r22,0
	movw r24,r18
	call DC_Motor_PwmConnect
	ldi r20,0
	ldd r22,Y+1
	ldd r24,Y+2
	rjmp .L44
.L42:
	ldi r31,lo8(-1)
	mul r24,r31
	movw r24,r0
	clr __zero_reg__
	ldi r22,lo8(100)
	ldi r23,0
	call __udivmodhi4
	movw r24,r18
	call DC_Motor_PwmSetDuty
	ldi r22,lo8(1)
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	call DC_Motor_PwmConnect
	rjmp .L38
	.size	DC_Motor_ApplySpeed, .-DC_Motor_ApplySpeed
.global	DC_Motor_Init
	.type	DC_Motor_Init, @function
DC_Motor_Init:
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r30,r24
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	or r24,r25
	brne .L46
.L48:
	ldi r24,lo8(1)
	ldi r25,0
.L45:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L46:
	ld r24,Z
	cpi r24,lo8(4)
	brsh .L48
	ldd r25,Z+2
	cpi r25,lo8(4)
	brsh .L48
	ldd r18,Z+6
	ldd r19,Z+7
	cpi r18,5
	cpc r19,__zero_reg__
	brsh .L48
	movw r16,r30
	ldi r20,lo8(1)
	ldd r22,Z+1
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	movw r30,r16
	ldd r22,Z+3
	ldd r24,Z+2
	call GPIO_set_pin_Direction
	ldi r20,0
	movw r30,r16
	ldd r22,Z+1
	ld r24,Z
	call GPIO_set_pin_value
	ldi r20,0
	movw r30,r16
	ldd r22,Z+3
	ldd r24,Z+2
	call GPIO_set_pin_value
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	sbiw r24,0
	brne .L49
	ldd r24,Z+4
	cpi r24,lo8(4)
	brsh .L48
	ldi r20,lo8(1)
	ldd r22,Z+5
	call GPIO_set_pin_Direction
	ldi r20,0
	movw r30,r16
	ldd r22,Z+5
	ldd r24,Z+4
	call GPIO_set_pin_value
.L50:
	movw r30,r16
	std Z+10,__zero_reg__
	ldi r24,lo8(1)
	std Z+9,r24
	ldi r23,0
	ldi r22,0
	movw r24,r16
	call DC_Motor_ApplyState
	movw r24,r16
	call DC_Motor_ApplySpeed
	ldi r25,0
	ldi r24,0
	rjmp .L45
.L49:
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	movw r22,r28
	subi r22,-2
	sbci r23,-1
	call DC_Motor_PwmPin
	ldi r20,lo8(1)
	ldd r22,Y+1
	ldd r24,Y+2
	call GPIO_set_pin_Direction
	ldi r20,0
	ldd r22,Y+1
	ldd r24,Y+2
	call GPIO_set_pin_value
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	cpi r24,4
	cpc r25,__zero_reg__
	brsh .L52
	cpi r24,2
	cpc r25,__zero_reg__
	brsh .L53
	sbiw r24,1
	breq .L54
.L51:
	ldi r22,0
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	call DC_Motor_PwmConnect
	rjmp .L50
.L52:
	sbiw r24,4
	brne .L51
	ldi r24,lo8(76)
	out 0x25,r24
	out 0x23,__zero_reg__
	rjmp .L51
.L54:
	ldi r24,lo8(75)
	out 0x33,r24
	out 0x3c,__zero_reg__
	rjmp .L51
.L53:
	in r24,0x2f
	ori r24,lo8(1)
	out 0x2f,r24
	in r24,0x2e
	ori r24,lo8(8)
	out 0x2e,r24
	in r24,0x2e
	ori r24,lo8(2)
	out 0x2e,r24
	in r24,0x2e
	ori r24,lo8(1)
	out 0x2e,r24
	rjmp .L51
	.size	DC_Motor_Init, .-DC_Motor_Init
.global	DC_Motor_SetSpeed
	.type	DC_Motor_SetSpeed, @function
DC_Motor_SetSpeed:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L60
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L60
	cpi r22,lo8(101)
	brlo .L58
	ldi r22,lo8(100)
.L58:
	movw r30,r24
	std Z+10,r22
	call DC_Motor_ApplySpeed
	ldi r25,0
	ldi r24,0
	ret
.L60:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	DC_Motor_SetSpeed, .-DC_Motor_SetSpeed
.global	DC_Motor_Forward
	.type	DC_Motor_Forward, @function
DC_Motor_Forward:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	breq .L64
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L64
	movw r28,r24
	ldi r22,lo8(1)
	ldi r23,0
	call DC_Motor_ApplyState
	movw r24,r28
	call DC_Motor_ApplySpeed
	ldi r25,0
	ldi r24,0
.L61:
/* epilogue start */
	pop r29
	pop r28
	ret
.L64:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L61
	.size	DC_Motor_Forward, .-DC_Motor_Forward
.global	DC_Motor_Backward
	.type	DC_Motor_Backward, @function
DC_Motor_Backward:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	breq .L68
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L68
	movw r28,r24
	ldi r22,lo8(2)
	ldi r23,0
	call DC_Motor_ApplyState
	movw r24,r28
	call DC_Motor_ApplySpeed
	ldi r25,0
	ldi r24,0
.L65:
/* epilogue start */
	pop r29
	pop r28
	ret
.L68:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L65
	.size	DC_Motor_Backward, .-DC_Motor_Backward
.global	DC_Motor_SetDirection
	.type	DC_Motor_SetDirection, @function
DC_Motor_SetDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L69
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L69
	cpi r22,2
	cpc r23,__zero_reg__
	brsh .L69
	or r22,r23
	brne .L71
	jmp DC_Motor_Forward
.L71:
	jmp DC_Motor_Backward
.L69:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	DC_Motor_SetDirection, .-DC_Motor_SetDirection
.global	DC_Motor_Stop
	.type	DC_Motor_Stop, @function
DC_Motor_Stop:
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 6 */
.L__stack_usage = 6
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	sbiw r24,0
	breq .L81
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L81
	movw r16,r24
	ldi r23,0
	ldi r22,0
	call DC_Motor_ApplyState
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	sbiw r24,0
	brne .L79
	ldi r20,0
	ldd r22,Z+5
	ldd r24,Z+4
.L82:
	call GPIO_set_pin_value
	ldi r25,0
	ldi r24,0
.L77:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L79:
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	movw r22,r28
	subi r22,-2
	sbci r23,-1
	call DC_Motor_PwmPin
	ldi r22,0
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	call DC_Motor_PwmConnect
	ldi r20,0
	ldd r22,Y+1
	ldd r24,Y+2
	rjmp .L82
.L81:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L77
	.size	DC_Motor_Stop, .-DC_Motor_Stop
.global	DC_Motor_Brake
	.type	DC_Motor_Brake, @function
DC_Motor_Brake:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	breq .L87
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L87
	movw r28,r24
	ldi r22,lo8(3)
	ldi r23,0
	call DC_Motor_ApplyState
	ldd r24,Y+6
	ldd r25,Y+7
	sbiw r24,0
	brne .L85
	ldi r20,lo8(1)
	ldd r22,Y+5
	ldd r24,Y+4
	call GPIO_set_pin_value
.L88:
	ldi r25,0
	ldi r24,0
.L83:
/* epilogue start */
	pop r29
	pop r28
	ret
.L85:
	ldi r22,lo8(-1)
	call DC_Motor_PwmSetDuty
	ldi r22,lo8(1)
	ldd r24,Y+6
	ldd r25,Y+7
	call DC_Motor_PwmConnect
	rjmp .L88
.L87:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L83
	.size	DC_Motor_Brake, .-DC_Motor_Brake
.global	DC_Motor_GetState
	.type	DC_Motor_GetState, @function
DC_Motor_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L93
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L93
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L93
	ldd r24,Z+11
	ldd r25,Z+12
	movw r30,r22
	std Z+1,r25
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L93:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	DC_Motor_GetState, .-DC_Motor_GetState
.global	DC_Motor_GetSpeed
	.type	DC_Motor_GetSpeed, @function
DC_Motor_GetSpeed:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L98
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L98
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L98
	ldd r24,Z+10
	movw r30,r22
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L98:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	DC_Motor_GetSpeed, .-DC_Motor_GetSpeed
.global	DC_Motor_DeInit
	.type	DC_Motor_DeInit, @function
DC_Motor_DeInit:
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 6 */
.L__stack_usage = 6
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	sbiw r24,0
	breq .L103
	movw r30,r24
	ldd r18,Z+9
	tst r18
	breq .L103
	movw r16,r24
	call DC_Motor_Stop
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	sbiw r24,0
	breq .L101
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	movw r22,r28
	subi r22,-2
	sbci r23,-1
	call DC_Motor_PwmPin
	ldi r22,0
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	call DC_Motor_PwmConnect
	ldi r22,0
	movw r30,r16
	ldd r24,Z+6
	ldd r25,Z+7
	call DC_Motor_PwmSetDuty
	ldi r20,0
	ldd r22,Y+1
	ldd r24,Y+2
	call GPIO_set_pin_value
.L101:
	movw r30,r16
	std Z+10,__zero_reg__
	std Z+9,__zero_reg__
	ldi r25,0
	ldi r24,0
.L99:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L103:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L99
	.size	DC_Motor_DeInit, .-DC_Motor_DeInit
	.section	.rodata
	.type	CSWTCH.17, @object
	.size	CSWTCH.17, 3
CSWTCH.17:
	.byte	0
	.byte	1
	.byte	1
	.type	CSWTCH.16, @object
	.size	CSWTCH.16, 3
CSWTCH.16:
	.byte	1
	.byte	0
	.byte	1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
