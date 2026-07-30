	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.rodata
.LC0:
	.word	1
	.word	2
.LC1:
	.byte	-128
	.byte	37
	.byte	0
	.byte	0
	.word	3
	.word	0
	.word	0
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,20
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 20 */
/* stack size = 22 */
.L__stack_usage = 22
	call BRIDGE_Init
	ldi r24,lo8(1)
	std Y+19,r24
	ldi r24,lo8(7)
	std Y+20,r24
	lds r24,.LC0
	lds r25,.LC0+1
	lds r26,.LC0+2
	lds r27,.LC0+3
	std Y+15,r24
	std Y+16,r25
	std Y+17,r26
	std Y+18,r27
	std Y+12,__zero_reg__
	std Y+11,__zero_reg__
	ldi r24,lo8(3)
	ldi r25,0
	std Y+14,r25
	std Y+13,r24
	ldi r24,lo8(10)
	ldi r30,lo8(.LC1)
	ldi r31,hi8(.LC1)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	movw r24,r28
	adiw r24,19
	call ADC_Init
	call Timer0_Init
	call Timer1_Init
	call Timer2_Init
	movw r24,r28
	adiw r24,15
	call EXTI_Init
	movw r24,r28
	adiw r24,11
	call EXTI_Init
	movw r24,r28
	adiw r24,1
	call UART_Init
	call PANEL_Init
.L2:
	ldi r22,0
	ldi r24,lo8(1)
	call PANEL_SetRunLED
	rjmp .L2
	.size	main, .-main
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"ERR START"
.LC3:
	.string	"ERR REV"
.LC4:
	.string	"ERR ACTIVE"
	.text
.global	Task_Panel
	.type	Task_Panel, @function
Task_Panel:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call PANEL_Poll
	call PANEL_GetEvent
	cpi r24,2
	cpc r25,__zero_reg__
<<<<<<< HEAD
=======
	breq .L3
	brsh .L4
	sbiw r24,1
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	breq .L5
	brsh .L6
	sbiw r24,1
	breq .L7
.L4:
	call FSM_GetState
	ldi r22,0
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L27
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L14
	sbiw r24,4
	brne .L15
.L14:
	ldi r22,lo8(1)
<<<<<<< HEAD
.L27:
	ldi r24,lo8(1)
.L24:
=======
.L25:
	ldi r24,lo8(1)
.L22:
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call PANEL_SetRunLED
	call FSM_IsTripped
	tst r24
	breq .L16
	ldi r24,lo8(1)
<<<<<<< HEAD
.L25:
=======
.L23:
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call PANEL_SetFaultLED
	call FSM_GetDirection
	call PANEL_SetDirectionLEDs
	call PANEL_IsLocalMode
	lds r25,g_driveData+26
	tst r24
<<<<<<< HEAD
	breq .L18
	andi r25,lo8(~(1<<0))
.L26:
	sts g_driveData+26,r25
/* epilogue start */
	ret
.L6:
	cpi r24,4
	cpc r25,__zero_reg__
	breq .L8
	sbiw r24,5
	brne .L4
=======
	breq .L16
	andi r25,lo8(~(1<<0))
.L24:
	sts g_driveData+26,r25
/* epilogue start */
	ret
.L4:
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L6
	sbiw r24,4
	brne .L2
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call FSM_RequestReset
	cpse r24,__zero_reg__
	rjmp .L4
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	rjmp .L23
.L7:
	call FSM_RequestStart
	cpse r24,__zero_reg__
	rjmp .L4
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
.L23:
	call CONSOLE_SendError
	rjmp .L4
.L5:
	call FSM_RequestStop
	rjmp .L4
.L8:
	call FSM_RequestReverse
	cpse r24,__zero_reg__
	rjmp .L4
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
<<<<<<< HEAD
	rjmp .L23
.L15:
	ldi r22,0
	ldi r24,0
=======
	rjmp .L21
.L13:
	ldi r22,0
	ldi r24,0
	rjmp .L22
.L14:
	ldi r24,0
	rjmp .L23
.L16:
	ori r25,lo8(1<<0)
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	rjmp .L24
.L16:
	ldi r24,0
	rjmp .L25
.L18:
	ori r25,lo8(1<<0)
	rjmp .L26
	.size	Task_Panel, .-Task_Panel
.global	Task_Current
	.type	Task_Current, @function
Task_Current:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	call ANALOG_GetCurrent
	movw r28,r24
	sts g_driveData+11+1,r25
	sts g_driveData+11,r24
	lds r22,g_driveCfg+17
	lds r23,g_driveCfg+17+1
	call PROTECT_UpdateI2T
	lds r24,g_driveCfg+19
	lds r25,g_driveCfg+19+1
	cp r28,r24
	cpc r29,r25
	brlo .L28
	ldi r24,lo8(2)
	ldi r25,0
	call FSM_RequestTrip
	ldi r22,lo8(g_driveData)
	ldi r23,hi8(g_driveData)
	ldi r24,lo8(2)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	jmp TELEMETRY_SendTripEvent
.L28:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	Task_Current, .-Task_Current
.global	Task_Control
	.type	Task_Control, @function
Task_Control:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	call TACHO_Update
	call TACHO_GetRPM
	sts g_driveData+4+1,r25
	sts g_driveData+4,r24
	lds r24,g_driveData+26
	sbrs r24,0
	rjmp .L31
	lds r24,g_driveData
	lds r25,g_driveData+1
.L32:
	movw r22,r24
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_SetTarget
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_Step
	sts g_driveData+2+1,r25
	sts g_driveData+2,r24
	lds r18,g_driveData+4
	lds r19,g_driveData+4+1
	sub r24,r18
	sbc r25,r19
	sts g_driveData+6+1,r25
	sts g_driveData+6,r24
	ldi r22,lo8(g_driveCfg)
	ldi r23,hi8(g_driveCfg)
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	call PROTECT_Evaluate
	movw r28,r24
	sbiw r24,0
	breq .L33
	call FSM_RequestTrip
	call BRIDGE_ForceStop
	ldi r22,lo8(g_driveData)
	ldi r23,hi8(g_driveData)
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	jmp TELEMETRY_SendTripEvent
.L31:
	call ANALOG_GetSetpoint
	sts g_driveData+1,r25
	sts g_driveData,r24
	rjmp .L32
.L33:
	call FSM_IsRunning
	tst r24
	breq .L34
	lds r20,g_driveData+4
	lds r21,g_driveData+4+1
	lds r22,g_driveData+2
	lds r23,g_driveData+2+1
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_Step
	movw r28,r24
.L35:
	movw r24,r28
	call DataManager_UpdateDuty
	movw r24,r28
	call BRIDGE_SetDuty
	lds r24,g_driveData+20
	lds r25,g_driveData+20+1
	call BRIDGE_SetDirection
	call FSM_Run
/* epilogue start */
	pop r29
	pop r28
	jmp DataManager_UpdateError
.L34:
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_Reset
	ldi r29,0
	ldi r28,0
	rjmp .L35
	.size	Task_Control, .-Task_Control
.global	Task_LCD
	.type	Task_LCD, @function
Task_LCD:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call FSM_IsTripped
	tst r24
	breq .L37
	lds r24,g_driveData+24
	lds r25,g_driveData+24+1
	jmp LCD_ShowTrip
.L37:
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	jmp LCD_Update
	.size	Task_LCD, .-Task_LCD
.global	Task_SlowSensors
	.type	Task_SlowSensors, @function
Task_SlowSensors:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	call ANALOG_GetBusVoltage
	ldi r28,lo8(g_driveData)
	ldi r29,hi8(g_driveData)
	std Y+14,r25
	std Y+13,r24
	call ANALOG_GetTemperature
	std Y+15,r24
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	Task_SlowSensors, .-Task_SlowSensors
.global	Task_Telemetry
	.type	Task_Telemetry, @function
Task_Telemetry:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call FSM_IsRunning
	tst r24
	breq .L40
	lds r18,g_driveData+4
	lds r19,g_driveData+4+1
	lds r24,g_driveCfg+5
	lds r25,g_driveCfg+5+1
	cp r18,r24
	cpc r19,r25
	brlo .L40
	call DataManager_IncrementRunSeconds
.L40:
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	jmp TELEMETRY_Update
	.size	Task_Telemetry, .-Task_Telemetry
<<<<<<< HEAD
=======
.global	Task_Current
	.type	Task_Current, @function
Task_Current:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	call ANALOG_GetCurrent
	movw r28,r24
	sts g_driveData+11+1,r25
	sts g_driveData+11,r24
	lds r22,g_driveCfg+17
	lds r23,g_driveCfg+17+1
	call PROTECT_UpdateI2T
	lds r24,g_driveCfg+19
	lds r25,g_driveCfg+19+1
	cp r28,r24
	cpc r29,r25
	brlo .L32
	ldi r24,lo8(2)
	ldi r25,0
	call FSM_RequestTrip
	ldi r22,lo8(g_driveData)
	ldi r23,hi8(g_driveData)
	ldi r24,lo8(2)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	jmp TELEMETRY_SendTripEvent
.L32:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	Task_Current, .-Task_Current
.global	Task_Control
	.type	Task_Control, @function
Task_Control:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	call TACHO_Update
	call TACHO_GetRPM
	sts g_driveData+4+1,r25
	sts g_driveData+4,r24
	lds r24,g_driveData+26
	sbrs r24,0
	rjmp .L35
	lds r24,g_driveData
	lds r25,g_driveData+1
.L36:
	movw r22,r24
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_SetTarget
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_Step
	sts g_driveData+2+1,r25
	sts g_driveData+2,r24
	lds r18,g_driveData+4
	lds r19,g_driveData+4+1
	sub r24,r18
	sbc r25,r19
	sts g_driveData+6+1,r25
	sts g_driveData+6,r24
	ldi r22,lo8(g_driveCfg)
	ldi r23,hi8(g_driveCfg)
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	call PROTECT_Evaluate
	movw r28,r24
	sbiw r24,0
	breq .L37
	call FSM_RequestTrip
	call BRIDGE_ForceStop
	ldi r22,lo8(g_driveData)
	ldi r23,hi8(g_driveData)
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	jmp TELEMETRY_SendTripEvent
.L35:
	call ANALOG_GetSetpoint
	sts g_driveData+1,r25
	sts g_driveData,r24
	rjmp .L36
.L37:
	call FSM_IsRunning
	tst r24
	breq .L38
	lds r20,g_driveData+4
	lds r21,g_driveData+4+1
	lds r22,g_driveData+2
	lds r23,g_driveData+2+1
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_Step
	movw r28,r24
.L39:
	movw r24,r28
	call DataManager_UpdateDuty
	movw r24,r28
	call BRIDGE_SetDuty
	lds r24,g_driveData+20
	lds r25,g_driveData+20+1
	call BRIDGE_SetDirection
	call FSM_Run
/* epilogue start */
	pop r29
	pop r28
	jmp DataManager_UpdateError
.L38:
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_Reset
	ldi r29,0
	ldi r28,0
	rjmp .L39
	.size	Task_Control, .-Task_Control
.global	Task_LCD
	.type	Task_LCD, @function
Task_LCD:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call FSM_IsTripped
	tst r24
	breq .L41
	lds r24,g_driveData+24
	lds r25,g_driveData+24+1
	jmp LCD_ShowTrip
.L41:
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	jmp LCD_Update
	.size	Task_LCD, .-Task_LCD
	.section	.rodata.str1.1
.LC5:
	.string	"Panel"
.LC6:
	.string	"Current"
.LC7:
	.string	"Control"
.LC8:
	.string	"LCD"
.LC9:
	.string	"SlowSensors"
.LC10:
	.string	"Telemetry"
	.section	.rodata
.LC0:
	.word	1
	.word	2
.LC1:
	.byte	-128
	.byte	37
	.byte	0
	.byte	0
	.word	3
	.word	0
	.word	0
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,20
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 20 */
/* stack size = 22 */
.L__stack_usage = 22
	call BRIDGE_Init
	clr r15
	inc r15
	std Y+19,r15
	ldi r24,lo8(7)
	std Y+20,r24
	lds r24,.LC0
	lds r25,.LC0+1
	lds r26,.LC0+2
	lds r27,.LC0+3
	std Y+15,r24
	std Y+16,r25
	std Y+17,r26
	std Y+18,r27
	std Y+12,__zero_reg__
	std Y+11,__zero_reg__
	ldi r16,lo8(3)
	ldi r17,0
	std Y+14,r17
	std Y+13,r16
	ldi r24,lo8(10)
	ldi r30,lo8(.LC1)
	ldi r31,hi8(.LC1)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	movw r24,r28
	adiw r24,19
	call ADC_Init
	call Timer0_Init
	call Timer1_Init
	call Timer2_Init
	movw r24,r28
	adiw r24,15
	call EXTI_Init
	movw r24,r28
	adiw r24,11
	call EXTI_Init
	movw r24,r28
	adiw r24,1
	call UART_Init
	call I2C_Init
	call TACHO_Init
	call ANALOG_Init
	call PANEL_Init
	call BUZZER_Init
	ldi r24,lo8(68)
	ldi r25,lo8(77)
	sts g_driveCfg+1,r25
	sts g_driveCfg,r24
	sts g_driveCfg+2,r15
	ldi r24,lo8(-72)
	ldi r25,lo8(11)
	sts g_driveCfg+3+1,r25
	sts g_driveCfg+3,r24
	ldi r24,lo8(-56)
	ldi r25,0
	sts g_driveCfg+5+1,r25
	sts g_driveCfg+5,r24
	ldi r24,lo8(88)
	ldi r25,lo8(2)
	sts g_driveCfg+7+1,r25
	sts g_driveCfg+7,r24
	ldi r24,lo8(-124)
	ldi r25,lo8(3)
	sts g_driveCfg+9+1,r25
	sts g_driveCfg+9,r24
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	sts g_driveCfg+11+1,r25
	sts g_driveCfg+11,r24
	ldi r24,lo8(-128)
	ldi r25,lo8(1)
	sts g_driveCfg+13+1,r25
	sts g_driveCfg+13,r24
	ldi r24,lo8(26)
	ldi r25,0
	sts g_driveCfg+15+1,r25
	sts g_driveCfg+15,r24
	ldi r24,lo8(64)
	ldi r25,lo8(31)
	sts g_driveCfg+17+1,r25
	sts g_driveCfg+17,r24
	ldi r24,lo8(80)
	ldi r25,lo8(70)
	sts g_driveCfg+19+1,r25
	sts g_driveCfg+19,r24
	ldi r24,lo8(110)
	sts g_driveCfg+21,r24
	ldi r24,lo8(32)
	ldi r25,lo8(78)
	sts g_driveCfg+22+1,r25
	sts g_driveCfg+22,r24
	ldi r24,lo8(-40)
	ldi r25,lo8(-42)
	sts g_driveCfg+24+1,r25
	sts g_driveCfg+24,r24
	sts g_driveCfg+26+1,r17
	sts g_driveCfg+26,r16
	sts g_driveCfg+28,__zero_reg__
	sts g_driveCfg+28+1,__zero_reg__
	sts g_driveCfg+28+2,__zero_reg__
	sts g_driveCfg+28+3,__zero_reg__
	sts g_driveCfg+32+1,__zero_reg__
	sts g_driveCfg+32,__zero_reg__
	sts g_driveCfg+34,__zero_reg__
	sts g_driveCfg+35+1,__zero_reg__
	sts g_driveCfg+35,__zero_reg__
	sts g_driveCfg+37,__zero_reg__
	ldi r22,lo8(g_driveCfg)
	ldi r23,hi8(g_driveCfg)
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	call DataManager_Init
	lds r20,g_driveCfg+15
	lds r21,g_driveCfg+15+1
	lds r22,g_driveCfg+13
	lds r23,g_driveCfg+13+1
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_Init
	ldi r20,lo8(-113)
	ldi r21,lo8(1)
	ldi r22,lo8(40)
	ldi r23,0
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_InitLimits
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_Init
	lds r20,g_driveCfg+3
	lds r21,g_driveCfg+3+1
	lds r22,g_driveCfg+5
	lds r23,g_driveCfg+5+1
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_SetLimits
	lds r20,g_driveCfg+9
	lds r21,g_driveCfg+9+1
	lds r22,g_driveCfg+7
	lds r23,g_driveCfg+7+1
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_SetRates
	call PROTECT_Init
	call FSM_Init
	lds r22,g_driveCfg+11
	lds r23,g_driveCfg+11+1
	ldi r25,0
	ldi r24,0
	call FSM_SetDeadTime
	call CONSOLE_Init
	call TELEMETRY_Init
	call SCHED_Init
	ldi r19,0
	ldi r18,0
	ldi r20,lo8(10)
	ldi r21,0
	ldi r22,lo8(.LC5)
	ldi r23,hi8(.LC5)
	ldi r24,lo8(gs(Task_Panel))
	ldi r25,hi8(gs(Task_Panel))
	call SCHED_AddTask
	ldi r18,lo8(1)
	ldi r19,0
	ldi r20,lo8(50)
	ldi r21,0
	ldi r22,lo8(.LC6)
	ldi r23,hi8(.LC6)
	ldi r24,lo8(gs(Task_Current))
	ldi r25,hi8(gs(Task_Current))
	call SCHED_AddTask
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(100)
	ldi r21,0
	ldi r22,lo8(.LC7)
	ldi r23,hi8(.LC7)
	ldi r24,lo8(gs(Task_Control))
	ldi r25,hi8(gs(Task_Control))
	call SCHED_AddTask
	ldi r18,lo8(4)
	ldi r19,0
	ldi r20,lo8(-6)
	ldi r21,0
	ldi r22,lo8(.LC8)
	ldi r23,hi8(.LC8)
	ldi r24,lo8(gs(Task_LCD))
	ldi r25,hi8(gs(Task_LCD))
	call SCHED_AddTask
	ldi r18,lo8(3)
	ldi r19,0
	ldi r20,lo8(-12)
	ldi r21,lo8(1)
	ldi r22,lo8(.LC9)
	ldi r23,hi8(.LC9)
	ldi r24,lo8(gs(Task_SlowSensors))
	ldi r25,hi8(gs(Task_SlowSensors))
	call SCHED_AddTask
	ldi r18,lo8(5)
	ldi r19,0
	ldi r20,lo8(-24)
	ldi r21,lo8(3)
	ldi r22,lo8(.LC10)
	ldi r23,hi8(.LC10)
	ldi r24,lo8(gs(Task_Telemetry))
	ldi r25,hi8(gs(Task_Telemetry))
	call SCHED_AddTask
/* #APP */
 ;  163 "Src/main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.L43:
	call SCHED_Run
	call CONSOLE_IsCommandReady
	tst r24
	breq .L43
	call CONSOLE_ExecuteCommand
	rjmp .L43
	.size	main, .-main
	.text
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
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
	call TACHO_PulseISR
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
	.size	__vector_1, .-__vector_1
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
	cbi 0x18,2
	cbi 0x18,1
	cbi 0x18,0
	ldi r24,lo8(1)
	sts g_estopFlag,r24
/* epilogue start */
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_2, .-__vector_2
.global	__vector_13
	.type	__vector_13, @function
__vector_13:
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
	in r24,0xc
	call CONSOLE_ProcessChar
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
	.size	__vector_13, .-__vector_13
.global	g_estopFlag
	.section .bss
	.type	g_estopFlag, @object
	.size	g_estopFlag, 1
g_estopFlag:
	.zero	1
	.comm	g_ramp,15,1
	.comm	g_pi,17,1
	.comm	g_driveCfg,38,1
	.comm	g_driveData,41,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
