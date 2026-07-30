	.file	"drive_fsm.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	FSM_TransitionTo, @function
FSM_TransitionTo:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	lds r18,g_fsm
	lds r19,g_fsm+1
	cpi r18,3
	cpc r19,__zero_reg__
	brne .L2
	lds r24,g_driveData+31
	lds r25,g_driveData+31+1
	lds r26,g_driveData+31+2
	lds r27,g_driveData+31+3
	lds r20,g_driveData+27
	lds r21,g_driveData+27+1
	lds r22,g_driveData+27+2
	lds r23,g_driveData+27+3
	add r24,r20
	adc r25,r21
	adc r26,r22
	adc r27,r23
	sts g_driveData+31,r24
	sts g_driveData+31+1,r25
	sts g_driveData+31+2,r26
	sts g_driveData+31+3,r27
	sts g_driveData+27,__zero_reg__
	sts g_driveData+27+1,__zero_reg__
	sts g_driveData+27+2,__zero_reg__
	sts g_driveData+27+3,__zero_reg__
.L2:
	sts g_fsm+2+1,r19
	sts g_fsm+2,r18
	sts g_fsm+1,r29
	sts g_fsm,r28
	sts g_fsm+13,__zero_reg__
	sts g_fsm+13+1,__zero_reg__
	sts g_fsm+13+2,__zero_reg__
	sts g_fsm+13+3,__zero_reg__
	cpi r28,4
	cpc r29,__zero_reg__
	brne .+2
	rjmp .L5
	brsh .L6
	cpi r28,1
	cpc r29,__zero_reg__
	breq .L7
	cpi r28,2
	cpc r29,__zero_reg__
	breq .+2
	rjmp .L4
	lds r24,g_fsm+6
	lds r25,g_fsm+6+1
	sts g_driveData+20+1,r25
	sts g_driveData+20,r24
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_Reset
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_Reset
	lds r24,g_driveData+35
	lds r25,g_driveData+35+1
	adiw r24,1
	sts g_driveData+35+1,r25
	sts g_driveData+35,r24
	sts g_fsm+21,__zero_reg__
	sts g_fsm+21+1,__zero_reg__
	sts g_fsm+21+2,__zero_reg__
	sts g_fsm+21+3,__zero_reg__
	rjmp .L4
.L6:
	cpi r28,5
	cpc r29,__zero_reg__
	breq .L9
	movw r24,r28
	sbiw r24,7
	sbiw r24,3
	brsh .L4
.L9:
	sts g_driveData+20+1,__zero_reg__
	sts g_driveData+20,__zero_reg__
	sts g_driveData+8+1,__zero_reg__
	sts g_driveData+8,__zero_reg__
	sts g_driveData+10,__zero_reg__
	rjmp .L4
.L7:
	sts g_driveData+20+1,__zero_reg__
	sts g_driveData+20,__zero_reg__
	sts g_driveData+8+1,__zero_reg__
	sts g_driveData+8,__zero_reg__
	sts g_driveData+10,__zero_reg__
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_Reset
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_Reset
.L4:
	sts g_driveData+22+1,r29
	sts g_driveData+22,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L5:
	ldi r23,0
	ldi r22,0
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_SetTarget
	rjmp .L4
	.size	FSM_TransitionTo, .-FSM_TransitionTo
	.type	FSM_ExecuteActions, @function
FSM_ExecuteActions:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
	cpi r24,5
	cpc r25,__zero_reg__
	brsh .L15
	sbiw r24,2
	brlo .L17
	lds r24,g_fsm+6
	lds r25,g_fsm+6+1
	call BRIDGE_SetDirection
	jmp BRIDGE_Enable
.L15:
	cpi r24,5
	cpc r25,__zero_reg__
	breq .L17
	sbiw r24,7
	brne .L24
.L17:
	ldi r25,0
	ldi r24,0
	call BRIDGE_SetDirection
	jmp BRIDGE_Disable
.L24:
	jmp BRIDGE_ForceStop
	.size	FSM_ExecuteActions, .-FSM_ExecuteActions
.global	FSM_Init
	.type	FSM_Init, @function
FSM_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(g_fsm)
	ldi r31,hi8(g_fsm)
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+7,__zero_reg__
	std Z+6,__zero_reg__
	std Z+9,__zero_reg__
	std Z+8,__zero_reg__
	std Z+10,__zero_reg__
	std Z+11,__zero_reg__
	std Z+12,__zero_reg__
	std Z+13,__zero_reg__
	std Z+14,__zero_reg__
	std Z+15,__zero_reg__
	std Z+16,__zero_reg__
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	ldi r26,0
	ldi r27,0
	std Z+17,r24
	std Z+18,r25
	std Z+19,r26
	std Z+20,r27
	std Z+21,__zero_reg__
	std Z+22,__zero_reg__
	std Z+23,__zero_reg__
	std Z+24,__zero_reg__
	std Z+25,__zero_reg__
	std Z+26,__zero_reg__
	std Z+27,__zero_reg__
	std Z+28,__zero_reg__
	ldi r24,lo8(1)
	std Z+29,r24
/* epilogue start */
	ret
	.size	FSM_Init, .-FSM_Init
.global	FSM_GetState
	.type	FSM_GetState, @function
FSM_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
/* epilogue start */
	ret
	.size	FSM_GetState, .-FSM_GetState
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"UNKN"
	.text
.global	FSM_GetStateString
	.type	FSM_GetStateString, @function
FSM_GetStateString:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
	cpi r24,10
	cpc r25,__zero_reg__
	brsh .L29
	lsl r24
	rol r25
	movw r30,r24
	subi r30,lo8(-(CSWTCH.13))
	sbci r31,hi8(-(CSWTCH.13))
	ld r24,Z
	ldd r25,Z+1
	ret
.L29:
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
/* epilogue start */
	ret
	.size	FSM_GetStateString, .-FSM_GetStateString
.global	FSM_GetDirection
	.type	FSM_GetDirection, @function
FSM_GetDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm+6
	lds r25,g_fsm+6+1
/* epilogue start */
	ret
	.size	FSM_GetDirection, .-FSM_GetDirection
.global	FSM_IsRunning
	.type	FSM_IsRunning, @function
FSM_IsRunning:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_fsm
	lds r19,g_fsm+1
	subi r18,2
	sbc r19,__zero_reg__
	ldi r24,lo8(1)
	cpi r18,2
	cpc r19,__zero_reg__
	brlo .L32
	ldi r24,0
.L32:
/* epilogue start */
	ret
	.size	FSM_IsRunning, .-FSM_IsRunning
.global	FSM_IsTripped
	.type	FSM_IsTripped, @function
FSM_IsTripped:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_fsm
	lds r19,g_fsm+1
	subi r18,8
	sbc r19,__zero_reg__
	ldi r24,lo8(1)
	cpi r18,2
	cpc r19,__zero_reg__
	brlo .L34
	ldi r24,0
.L34:
/* epilogue start */
	ret
	.size	FSM_IsTripped, .-FSM_IsTripped
.global	FSM_RequestStart
	.type	FSM_RequestStart, @function
FSM_RequestStart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
	cpi r24,1
	cpc r25,__zero_reg__
	brne .L38
	lds r20,g_driveData
	lds r21,g_driveData+1
	lds r18,g_driveCfg+5
	lds r19,g_driveCfg+5+1
	cp r20,r18
	cpc r21,r19
	brlo .L38
	sts g_fsm+6+1,r25
	sts g_fsm+6,r24
	ldi r24,lo8(2)
	ldi r25,0
	call FSM_TransitionTo
	ldi r24,lo8(1)
	ret
.L38:
	ldi r24,0
/* epilogue start */
	ret
	.size	FSM_RequestStart, .-FSM_RequestStart
.global	FSM_RequestStop
	.type	FSM_RequestStop, @function
FSM_RequestStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
	sbiw r24,2
	sbiw r24,2
	brsh .L41
	ldi r24,lo8(4)
	ldi r25,0
	call FSM_TransitionTo
	ldi r24,lo8(1)
	ret
.L41:
	ldi r24,0
/* epilogue start */
	ret
	.size	FSM_RequestStop, .-FSM_RequestStop
.global	FSM_RequestReverse
	.type	FSM_RequestReverse, @function
FSM_RequestReverse:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
	sbiw r24,3
	brne .L47
	lds r24,g_fsm+10
	cpse r24,__zero_reg__
	rjmp .L47
	lds r24,g_fsm+6
	lds r25,g_fsm+6+1
	sbiw r24,1
	brne .L44
	ldi r24,lo8(2)
	ldi r25,0
.L48:
	sts g_fsm+8+1,r25
	sts g_fsm+8,r24
	ldi r24,lo8(1)
	sts g_fsm+10,r24
	ldi r24,lo8(4)
	ldi r25,0
	call FSM_TransitionTo
	ldi r24,lo8(1)
	ret
.L44:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L48
.L47:
	ldi r24,0
/* epilogue start */
	ret
	.size	FSM_RequestReverse, .-FSM_RequestReverse
.global	FSM_RequestReset
	.type	FSM_RequestReset, @function
FSM_RequestReset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
	cpi r24,8
	cpc r25,__zero_reg__
	brne .L50
	call PROTECT_GetActiveTrip
	or r24,r25
	breq .L51
.L53:
	ldi r24,0
	ret
.L51:
	sts g_fsm+11,__zero_reg__
.L54:
	ldi r24,lo8(1)
	ldi r25,0
	call FSM_TransitionTo
	ldi r24,lo8(1)
/* epilogue start */
	ret
.L50:
	sbiw r24,9
	brne .L53
	lds r24,g_driveData+26
	sbrc r24,1
	rjmp .L53
	rjmp .L54
	.size	FSM_RequestReset, .-FSM_RequestReset
.global	FSM_RequestEmergencyStop
	.type	FSM_RequestEmergencyStop, @function
FSM_RequestEmergencyStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm
	lds r25,g_fsm+1
	sbiw r24,9
	breq .L57
	ldi r24,lo8(1)
	sts g_fsm+12,r24
	ldi r24,lo8(9)
	ldi r25,0
	call FSM_TransitionTo
	ldi r24,lo8(1)
	ret
.L57:
	ldi r24,0
/* epilogue start */
	ret
	.size	FSM_RequestEmergencyStop, .-FSM_RequestEmergencyStop
.global	FSM_Run
	.type	FSM_Run, @function
FSM_Run:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_fsm+29
	cpse r24,__zero_reg__
	rjmp .L59
	jmp FSM_Init
.L59:
	lds r24,g_fsm+13
	lds r25,g_fsm+13+1
	lds r26,g_fsm+13+2
	lds r27,g_fsm+13+3
	adiw r24,10
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts g_fsm+13,r24
	sts g_fsm+13+1,r25
	sts g_fsm+13+2,r26
	sts g_fsm+13+3,r27
	lds r30,g_fsm
	lds r31,g_fsm+1
	lds r18,g_driveData+26
	sbrs r18,1
	rjmp .L60
	sbiw r30,9
	breq .L61
	call FSM_RequestEmergencyStop
.L61:
	jmp FSM_ExecuteActions
.L62:
	lds r24,g_driveCfg+35
	lds r25,g_driveCfg+35+1
	or r24,r25
	brne .L63
.L75:
	ldi r24,lo8(1)
	ldi r25,0
.L84:
	call FSM_TransitionTo
	rjmp .L61
.L63:
	ldi r24,lo8(8)
	ldi r25,0
	rjmp .L84
.L64:
	sts g_driveData+8+1,__zero_reg__
	sts g_driveData+8,__zero_reg__
	sts g_driveData+10,__zero_reg__
	rjmp .L61
.L65:
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_AtTarget
	tst r24
	breq .L66
	lds r24,g_driveData+4
	lds r25,g_driveData+4+1
	lds r18,g_driveData+2
	lds r19,g_driveData+2+1
	sub r24,r18
	sbc r25,r19
	subi r24,-100
	sbci r25,-1
	cpi r24,-55
	cpc r25,__zero_reg__
	brsh .L66
	lds r24,g_fsm+21
	lds r25,g_fsm+21+1
	lds r26,g_fsm+21+2
	lds r27,g_fsm+21+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts g_fsm+21,r24
	sts g_fsm+21+1,r25
	sts g_fsm+21+2,r26
	sts g_fsm+21+3,r27
	cpi r24,100
	cpc r25,__zero_reg__
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brsh .+2
	rjmp .L61
	ldi r24,lo8(3)
	ldi r25,0
	call FSM_TransitionTo
.L66:
	sts g_fsm+21,__zero_reg__
	sts g_fsm+21+1,__zero_reg__
	sts g_fsm+21+2,__zero_reg__
	sts g_fsm+21+3,__zero_reg__
	rjmp .L61
.L68:
	lds r18,g_driveData
	lds r19,g_driveData+1
	lds r24,g_driveCfg+5
	lds r25,g_driveCfg+5+1
	cp r18,r24
	cpc r19,r25
	brlo .+2
	rjmp .L61
	call FSM_RequestStop
	rjmp .L61
.L70:
	lds r24,g_driveData+4
	lds r25,g_driveData+4+1
	cp __zero_reg__,r24
	cpc __zero_reg__,r25
	brlt .L71
	lds r24,g_fsm+25
	lds r25,g_fsm+25+1
	lds r26,g_fsm+25+2
	lds r27,g_fsm+25+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts g_fsm+25,r24
	sts g_fsm+25+1,r25
	sts g_fsm+25+2,r26
	sts g_fsm+25+3,r27
	sbiw r24,3
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brsh .+2
	rjmp .L61
	lds r24,g_fsm+10
	tst r24
	breq .L72
	ldi r24,lo8(5)
	ldi r25,0
.L83:
	call FSM_TransitionTo
.L71:
	sts g_fsm+25,__zero_reg__
	sts g_fsm+25+1,__zero_reg__
	sts g_fsm+25+2,__zero_reg__
	sts g_fsm+25+3,__zero_reg__
	rjmp .L61
.L72:
	ldi r24,lo8(7)
	ldi r25,0
	rjmp .L83
.L73:
	lds r20,g_fsm+17
	lds r21,g_fsm+17+1
	lds r22,g_fsm+17+2
	lds r23,g_fsm+17+3
	cp r24,r20
	cpc r25,r21
	cpc r26,r22
	cpc r27,r23
	brsh .+2
	rjmp .L61
	lds r24,g_fsm+8
	lds r25,g_fsm+8+1
	sts g_fsm+6+1,r25
	sts g_fsm+6,r24
	sts g_fsm+10,__zero_reg__
	ldi r24,lo8(2)
	ldi r25,0
	rjmp .L84
.L74:
	cpi r24,-12
	sbci r25,1
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brsh .+2
	rjmp .L61
	rjmp .L75
.L60:
	cpi r30,8
	cpc r31,__zero_reg__
	brlo .+2
	rjmp .L61
	subi r30,lo8(-(gs(.L76)))
	sbci r31,hi8(-(gs(.L76)))
	jmp __tablejump2__
	.p2align	1
.L76:
	.word gs(.L62)
	.word gs(.L64)
	.word gs(.L65)
	.word gs(.L68)
	.word gs(.L70)
	.word gs(.L73)
	.word gs(.L61)
	.word gs(.L74)
	.size	FSM_Run, .-FSM_Run
.global	FSM_RequestTrip
	.type	FSM_RequestTrip, @function
FSM_RequestTrip:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_fsm
	lds r19,g_fsm+1
	cpi r18,8
	cpc r19,__zero_reg__
	breq .L87
	ldi r18,lo8(1)
	sts g_fsm+11,r18
	sts g_driveData+24+1,r25
	sts g_driveData+24,r24
	ldi r24,lo8(8)
	ldi r25,0
	call FSM_TransitionTo
	ldi r24,lo8(1)
	ret
.L87:
	ldi r24,0
/* epilogue start */
	ret
	.size	FSM_RequestTrip, .-FSM_RequestTrip
.global	FSM_SetDeadTime
	.type	FSM_SetDeadTime, @function
FSM_SetDeadTime:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_fsm+17,r22
	sts g_fsm+17+1,r23
	sts g_fsm+17+2,r24
	sts g_fsm+17+3,r25
/* epilogue start */
	ret
	.size	FSM_SetDeadTime, .-FSM_SetDeadTime
.global	FSM_GetStateTime
	.type	FSM_GetStateTime, @function
FSM_GetStateTime:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r22,g_fsm+13
	lds r23,g_fsm+13+1
	lds r24,g_fsm+13+2
	lds r25,g_fsm+13+3
/* epilogue start */
	ret
	.size	FSM_GetStateTime, .-FSM_GetStateTime
	.section	.rodata.str1.1
.LC1:
	.string	"INIT"
.LC2:
	.string	"STOP"
.LC3:
	.string	"STRT"
.LC4:
	.string	"RUN"
.LC5:
	.string	"RDWN"
.LC6:
	.string	"DEAD"
.LC7:
	.string	"BRK"
.LC8:
	.string	"COAST"
.LC9:
	.string	"TRIP"
.LC10:
	.string	"ESTOP"
	.section	.rodata
	.type	CSWTCH.13, @object
	.size	CSWTCH.13, 20
CSWTCH.13:
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.local	g_fsm
	.comm	g_fsm,30,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
