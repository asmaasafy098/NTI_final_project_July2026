	.file	"telemetry.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	TELEMETRY_Init
	.type	TELEMETRY_Init, @function
TELEMETRY_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	sts g_telemetryEnabled,r24
	call TIMER_GetTick
	sts g_lastSendTime,r22
	sts g_lastSendTime+1,r23
	sts g_lastSendTime+2,r24
	sts g_lastSendTime+3,r25
/* epilogue start */
	ret
	.size	TELEMETRY_Init, .-TELEMETRY_Init
.global	TELEMETRY_Update
	.type	TELEMETRY_Update, @function
TELEMETRY_Update:
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
	lds r18,g_telemetryEnabled
	tst r18
	breq .L2
	movw r28,r24
	call TIMER_GetTick
	movw r12,r22
	movw r14,r24
	lds r24,g_lastSendTime
	lds r25,g_lastSendTime+1
	lds r26,g_lastSendTime+2
	lds r27,g_lastSendTime+3
	movw r20,r14
	movw r18,r12
	sub r18,r24
	sbc r19,r25
	sbc r20,r26
	sbc r21,r27
	movw r26,r20
	movw r24,r18
	cpi r24,-24
	sbci r25,3
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brlo .L2
	movw r24,r28
	call CONSOLE_SendTelemetry
	sts g_lastSendTime,r12
	sts g_lastSendTime+1,r13
	sts g_lastSendTime+2,r14
	sts g_lastSendTime+3,r15
.L2:
/* epilogue start */
	pop r29
	pop r28
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	TELEMETRY_Update, .-TELEMETRY_Update
.global	TELEMETRY_SendStatus
	.type	TELEMETRY_SendStatus, @function
TELEMETRY_SendStatus:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp CONSOLE_SendTelemetry
	.size	TELEMETRY_SendStatus, .-TELEMETRY_SendStatus
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"TRIP,%s,I=%d,I2T=%d"
	.text
.global	TELEMETRY_SendTripEvent
	.type	TELEMETRY_SendTripEvent, @function
TELEMETRY_SendTripEvent:
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
	subi r28,64
	sbc r29,__zero_reg__
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 64 */
/* stack size = 72 */
.L__stack_usage = 72
	movw r12,r24
	movw r16,r22
	call PROTECT_GetI2TPercent
	mov r14,r24
	movw r30,r16
	ldd r15,Z+11
	ldd r17,Z+12
	movw r24,r12
	call PROTECT_GetTripString
	push __zero_reg__
	push r14
	push r17
	push r15
	push r25
	push r24
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	movw r24,r16
	call CONSOLE_SendEvent
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* epilogue start */
	subi r28,-64
	sbci r29,-1
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
	ret
	.size	TELEMETRY_SendTripEvent, .-TELEMETRY_SendTripEvent
.global	TELEMETRY_SetEnabled
	.type	TELEMETRY_SetEnabled, @function
TELEMETRY_SetEnabled:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_telemetryEnabled,r24
/* epilogue start */
	ret
	.size	TELEMETRY_SetEnabled, .-TELEMETRY_SetEnabled
.global	TELEMETRY_IsEnabled
	.type	TELEMETRY_IsEnabled, @function
TELEMETRY_IsEnabled:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_telemetryEnabled
/* epilogue start */
	ret
	.size	TELEMETRY_IsEnabled, .-TELEMETRY_IsEnabled
	.local	g_lastSendTime
	.comm	g_lastSendTime,4,1
	.data
	.type	g_telemetryEnabled, @object
	.size	g_telemetryEnabled, 1
g_telemetryEnabled:
	.byte	1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
