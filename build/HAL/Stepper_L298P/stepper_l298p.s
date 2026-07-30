	.file	"stepper_l298p.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	Stepper_TableEntry, @function
Stepper_TableEntry:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L3
	sbiw r24,2
	breq .L4
	andi r22,lo8(3)
	mov r30,r22
	ldi r31,0
	subi r30,lo8(-(STEPPER_FULL_TABLE))
	sbci r31,hi8(-(STEPPER_FULL_TABLE))
	rjmp .L7
.L3:
	andi r22,lo8(3)
	mov r30,r22
	ldi r31,0
	subi r30,lo8(-(STEPPER_WAVE_TABLE))
	sbci r31,hi8(-(STEPPER_WAVE_TABLE))
.L7:
	ld r24,Z
/* epilogue start */
	ret
.L4:
	andi r22,lo8(7)
	mov r30,r22
	ldi r31,0
	subi r30,lo8(-(STEPPER_HALF_TABLE))
	sbci r31,hi8(-(STEPPER_HALF_TABLE))
	rjmp .L7
	.size	Stepper_TableEntry, .-Stepper_TableEntry
	.type	Stepper_ApplyPattern, @function
Stepper_ApplyPattern:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r28,r24
	mov r17,r22
	mov r20,r22
<<<<<<< HEAD
	andi r20,1
	ldd r22,Y+1
	ldi r23,0
	ld r24,Y
	ldi r21,0
	ldi r25,0
=======
	andi r20,lo8(1)
	ldd r22,Y+1
	ld r24,Y
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
	bst r17,1
	clr r20
	bld r20,0
	ldd r22,Y+3
<<<<<<< HEAD
	ldi r23,0
	ldd r24,Y+2
	ldi r21,0
	ldi r25,0
=======
	ldd r24,Y+2
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
	bst r17,2
	clr r20
	bld r20,0
	ldd r22,Y+5
<<<<<<< HEAD
	ldi r23,0
	ldd r24,Y+4
	ldi r21,0
	ldi r25,0
=======
	ldd r24,Y+4
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
	bst r17,3
	clr r20
	bld r20,0
	ldd r22,Y+7
<<<<<<< HEAD
	ldi r23,0
	ldd r24,Y+6
	ldi r21,0
	ldi r25,0
=======
	ldd r24,Y+6
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
	ldi r24,lo8(1)
	cpse r17,__zero_reg__
	rjmp .L9
	ldi r24,0
.L9:
	std Y+21,r24
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
	.size	Stepper_ApplyPattern, .-Stepper_ApplyPattern
.global	Stepper_L298P_Init
	.type	Stepper_L298P_Init, @function
Stepper_L298P_Init:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	brne .+2
	rjmp .L15
	movw r30,r24
	ldd r18,Z+15
	ldd r19,Z+16
	or r18,r19
	brne .+2
	rjmp .L15
	movw r28,r24
	ldi r20,lo8(1)
	ldd r22,Z+1
	ld r24,Z
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldd r22,Y+3
	ldd r24,Y+2
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldd r22,Y+5
	ldd r24,Y+4
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldd r22,Y+7
	ldd r24,Y+6
	call GPIO_set_pin_Direction
	ldd r24,Y+12
	tst r24
	breq .L12
	ldi r20,lo8(1)
	ldd r22,Y+9
	ldd r24,Y+8
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldd r22,Y+11
	ldd r24,Y+10
	call GPIO_set_pin_Direction
<<<<<<< HEAD
	ldd r22,Y+9
	ldi r23,0
	ldd r24,Y+8
	ldi r20,lo8(1)
	ldi r21,0
	ldi r25,0
	call GPIO_set_pin_value
	ldd r22,Y+11
	ldi r23,0
	ldd r24,Y+10
	ldi r20,lo8(1)
	ldi r21,0
	ldi r25,0
=======
	ldi r20,lo8(1)
	ldd r22,Y+9
	ldd r24,Y+8
	call GPIO_set_pin_value
	ldi r20,lo8(1)
	ldd r22,Y+11
	ldd r24,Y+10
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
.L12:
	ldd r24,Y+17
	ldd r25,Y+18
	or r24,r25
	brne .L13
	ldi r24,lo8(1)
	ldi r25,0
	std Y+18,r25
	std Y+17,r24
.L13:
	std Y+20,__zero_reg__
	std Y+22,__zero_reg__
	std Y+23,__zero_reg__
	std Y+24,__zero_reg__
	std Y+25,__zero_reg__
	std Y+21,__zero_reg__
	ldi r22,0
	movw r24,r28
	call Stepper_ApplyPattern
	ldi r24,lo8(1)
	std Y+19,r24
	ldi r25,0
	ldi r24,0
.L10:
/* epilogue start */
	pop r29
	pop r28
	ret
.L15:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L10
	.size	Stepper_L298P_Init, .-Stepper_L298P_Init
.global	Stepper_L298P_SetStepMode
	.type	Stepper_L298P_SetStepMode, @function
Stepper_L298P_SetStepMode:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L23
	ldd r24,Z+19
	tst r24
	breq .L23
	cpi r22,3
	cpc r23,__zero_reg__
	brsh .L23
	std Z+14,r23
	std Z+13,r22
	std Z+20,__zero_reg__
	ldi r25,0
	ldi r24,0
	ret
.L23:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Stepper_L298P_SetStepMode, .-Stepper_L298P_SetStepMode
.global	Stepper_L298P_SetStepDelay
	.type	Stepper_L298P_SetStepDelay, @function
Stepper_L298P_SetStepDelay:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L28
	movw r30,r24
	ldd r18,Z+19
	tst r18
	breq .L28
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	brne .L26
	ldi r22,lo8(1)
	ldi r23,0
.L26:
	movw r30,r24
	std Z+18,r23
	std Z+17,r22
	ldi r25,0
	ldi r24,0
	ret
.L28:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Stepper_L298P_SetStepDelay, .-Stepper_L298P_SetStepDelay
.global	Stepper_L298P_SetSpeedRpm
	.type	Stepper_L298P_SetSpeedRpm, @function
Stepper_L298P_SetSpeedRpm:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	breq .L35
	ldd r24,Y+19
	tst r24
	breq .L35
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L35
	ldd r18,Y+15
	ldd r19,Y+16
	ldi r21,0
	ldi r20,0
	ldd r24,Y+13
	ldd r25,Y+14
	sbiw r24,2
	brne .L31
	lsl r18
	rol r19
	rol r20
	rol r21
.L31:
	movw r26,r22
	call __muluhisi3
	movw r18,r22
	movw r20,r24
	ldi r22,lo8(96)
	ldi r23,lo8(-22)
	ldi r24,0
	ldi r25,0
	call __udivmodsi4
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	cpc r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L35
	std Y+18,r19
	std Y+17,r18
	ldi r25,0
	ldi r24,0
.L29:
/* epilogue start */
	pop r29
	pop r28
	ret
.L35:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L29
	.size	Stepper_L298P_SetSpeedRpm, .-Stepper_L298P_SetSpeedRpm
.global	Stepper_L298P_StepOnce
	.type	Stepper_L298P_StepOnce, @function
Stepper_L298P_StepOnce:
	push r12
	push r13
	push r14
	push r15
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r28,r24
	movw r20,r22
	or r24,r25
	brne .+2
	rjmp .L43
	ldd r24,Y+19
	tst r24
	breq .L43
	cpi r22,2
	cpc r23,__zero_reg__
	brsh .L43
	ldd r18,Y+13
	ldd r19,Y+14
	ldi r22,lo8(4)
	cpi r18,2
	cpc r19,__zero_reg__
	brne .L38
	ldi r22,lo8(8)
.L38:
	ldd r24,Y+20
	ldi r23,0
	ldd r12,Y+22
	ldd r13,Y+23
	ldd r14,Y+24
	ldd r15,Y+25
	ldi r25,0
	or r20,r21
	brne .L39
	adiw r24,1
	call __udivmodhi4
	std Y+20,r24
	ldi r24,-1
	sub r12,r24
	sbc r13,r24
	sbc r14,r24
	sbc r15,r24
.L45:
	std Y+22,r12
	std Y+23,r13
	std Y+24,r14
	std Y+25,r15
	ldd r22,Y+20
	movw r24,r18
	call Stepper_TableEntry
	mov r22,r24
	movw r24,r28
	call Stepper_ApplyPattern
	ldi r25,0
	ldi r24,0
.L36:
/* epilogue start */
	pop r29
	pop r28
	pop r15
	pop r14
	pop r13
	pop r12
	ret
.L39:
	add r24,r22
	adc r25,r23
	sbiw r24,1
	call __udivmodhi4
	std Y+20,r24
	ldi r24,1
	sub r12,r24
	sbc r13,__zero_reg__
	sbc r14,__zero_reg__
	sbc r15,__zero_reg__
	rjmp .L45
.L43:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L36
	.size	Stepper_L298P_StepOnce, .-Stepper_L298P_StepOnce
.global	Stepper_L298P_Step
	.type	Stepper_L298P_Step, @function
Stepper_L298P_Step:
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
/* stack size = 22 */
.L__stack_usage = 22
	sbiw r24,0
	brne .+2
	rjmp .L56
	movw r30,r24
	ldd r18,Z+19
	tst r18
	brne .+2
	rjmp .L56
	cpi r20,2
	cpc r21,__zero_reg__
	brlo .+2
	rjmp .L56
	movw r14,r20
	movw r2,r22
	movw r16,r24
	mov r13,__zero_reg__
	mov r12,__zero_reg__
	ldi r24,lo8(-96)
	mov r4,r24
	ldi r24,lo8(15)
	mov r5,r24
	mov r6,__zero_reg__
	mov r7,__zero_reg__
.L48:
	cp r2,r12
	cpc r3,r13
	brne .L53
	ldi r25,0
	ldi r24,0
.L46:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	ret
.L53:
	movw r22,r14
	movw r24,r16
	call Stepper_L298P_StepOnce
	movw r30,r16
	ldd r24,Z+17
	ldd r25,Z+18
.L49:
	sbiw r24,0
	brne .L52
	ldi r18,-1
	sub r12,r18
	sbc r13,r18
	rjmp .L48
.L52:
	std Y+1,r4
	std Y+2,r5
	std Y+3,r6
	std Y+4,r7
.L50:
	ldd r20,Y+1
	ldd r21,Y+2
	ldd r22,Y+3
	ldd r23,Y+4
	movw r8,r20
	movw r10,r22
	ldi r31,1
	sub r8,r31
	sbc r9,__zero_reg__
	sbc r10,__zero_reg__
	sbc r11,__zero_reg__
	std Y+1,r8
	std Y+2,r9
	std Y+3,r10
	std Y+4,r11
	or r20,r21
	or r20,r22
	or r20,r23
	brne .L51
	sbiw r24,1
	rjmp .L49
.L51:
/* #APP */
 ;  62 "HAL/Stepper_L298P/stepper_l298p.c" 1
	nop
 ;  0 "" 2
/* #NOAPP */
	rjmp .L50
.L56:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L46
	.size	Stepper_L298P_Step, .-Stepper_L298P_Step
.global	Stepper_L298P_RotateAngle
	.type	Stepper_L298P_RotateAngle, @function
Stepper_L298P_RotateAngle:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r28,r24
	movw r16,r20
	or r24,r25
	breq .L57
	ldd r24,Y+19
	tst r24
	breq .L57
	ldd r18,Y+15
	ldd r19,Y+16
	ldi r21,0
	ldi r20,0
	ldd r24,Y+13
	ldd r25,Y+14
	sbiw r24,2
	brne .L59
	lsl r18
	rol r19
	rol r20
	rol r21
.L59:
	movw r26,r22
	call __muluhisi3
	ldi r18,lo8(104)
	ldi r19,lo8(1)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r22,r18
	movw r20,r16
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	jmp Stepper_L298P_Step
.L57:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	Stepper_L298P_RotateAngle, .-Stepper_L298P_RotateAngle
.global	Stepper_L298P_Hold
	.type	Stepper_L298P_Hold, @function
Stepper_L298P_Hold:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	breq .L68
	movw r30,r24
	ldd r18,Z+19
	tst r18
	breq .L68
	movw r28,r24
	ldd r24,Z+12
	tst r24
	breq .L66
<<<<<<< HEAD
	ldd r22,Z+9
	ldi r23,0
	ldd r24,Z+8
	ldi r20,lo8(1)
	ldi r21,0
	ldi r25,0
	call GPIO_set_pin_value
	ldd r22,Y+11
	ldi r23,0
	ldd r24,Y+10
	ldi r20,lo8(1)
	ldi r21,0
	ldi r25,0
=======
	ldi r20,lo8(1)
	ldd r22,Z+9
	ldd r24,Z+8
	call GPIO_set_pin_value
	ldi r20,lo8(1)
	ldd r22,Y+11
	ldd r24,Y+10
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
.L66:
	ldd r22,Y+20
	ldd r24,Y+13
	ldd r25,Y+14
	call Stepper_TableEntry
	mov r22,r24
	movw r24,r28
	call Stepper_ApplyPattern
	ldi r25,0
	ldi r24,0
.L64:
/* epilogue start */
	pop r29
	pop r28
	ret
.L68:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L64
	.size	Stepper_L298P_Hold, .-Stepper_L298P_Hold
.global	Stepper_L298P_Release
	.type	Stepper_L298P_Release, @function
Stepper_L298P_Release:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	breq .L76
	movw r30,r24
	ldd r18,Z+19
	tst r18
	breq .L76
	movw r28,r24
	ldi r22,0
	call Stepper_ApplyPattern
	ldd r24,Y+12
	tst r24
	breq .L74
<<<<<<< HEAD
	ldd r22,Y+9
	ldi r23,0
	ldd r24,Y+8
	ldi r21,0
	ldi r20,0
	ldi r25,0
	call GPIO_set_pin_value
	ldd r22,Y+11
	ldi r23,0
	ldd r24,Y+10
	ldi r21,0
	ldi r20,0
	ldi r25,0
=======
	ldi r20,0
	ldd r22,Y+9
	ldd r24,Y+8
	call GPIO_set_pin_value
	ldi r20,0
	ldd r22,Y+11
	ldd r24,Y+10
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
.L74:
	std Y+21,__zero_reg__
	ldi r25,0
	ldi r24,0
.L72:
/* epilogue start */
	pop r29
	pop r28
	ret
.L76:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L72
	.size	Stepper_L298P_Release, .-Stepper_L298P_Release
.global	Stepper_L298P_GetPosition
	.type	Stepper_L298P_GetPosition, @function
Stepper_L298P_GetPosition:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L84
	movw r30,r24
	ldd r18,Z+19
	tst r18
	breq .L84
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L84
	ldd r24,Z+22
	ldd r25,Z+23
	ldd r26,Z+24
	ldd r27,Z+25
	movw r30,r22
	st Z,r24
	std Z+1,r25
	std Z+2,r26
	std Z+3,r27
	ldi r25,0
	ldi r24,0
	ret
.L84:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Stepper_L298P_GetPosition, .-Stepper_L298P_GetPosition
.global	Stepper_L298P_ResetPosition
	.type	Stepper_L298P_ResetPosition, @function
Stepper_L298P_ResetPosition:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L88
	movw r30,r24
	ldd r18,Z+19
	tst r18
	breq .L88
	std Z+22,__zero_reg__
	std Z+23,__zero_reg__
	std Z+24,__zero_reg__
	std Z+25,__zero_reg__
	ldi r25,0
	ldi r24,0
	ret
.L88:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Stepper_L298P_ResetPosition, .-Stepper_L298P_ResetPosition
.global	Stepper_L298P_GetStepsPerRev
	.type	Stepper_L298P_GetStepsPerRev, @function
Stepper_L298P_GetStepsPerRev:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	breq .L94
	ldd r24,Z+19
	tst r24
	breq .L94
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L94
	ldd r18,Z+15
	ldd r19,Z+16
	ldd r24,Z+13
	ldd r25,Z+14
	sbiw r24,2
	brne .L91
	lsl r18
	rol r19
.L91:
	movw r30,r22
	std Z+1,r19
	st Z,r18
	ldi r25,0
	ldi r24,0
	ret
.L94:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Stepper_L298P_GetStepsPerRev, .-Stepper_L298P_GetStepsPerRev
	.section	.rodata
	.type	STEPPER_HALF_TABLE, @object
	.size	STEPPER_HALF_TABLE, 8
STEPPER_HALF_TABLE:
	.byte	1
	.byte	3
	.byte	2
	.byte	6
	.byte	4
	.byte	12
	.byte	8
	.byte	9
	.type	STEPPER_FULL_TABLE, @object
	.size	STEPPER_FULL_TABLE, 4
STEPPER_FULL_TABLE:
	.byte	3
	.byte	6
	.byte	12
	.byte	9
	.type	STEPPER_WAVE_TABLE, @object
	.size	STEPPER_WAVE_TABLE, 4
STEPPER_WAVE_TABLE:
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
