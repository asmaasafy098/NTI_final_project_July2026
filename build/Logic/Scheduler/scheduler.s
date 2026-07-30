	.file	"scheduler.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	SCHED_Init
	.type	SCHED_Init, @function
SCHED_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(g_tasks)
	ldi r31,hi8(g_tasks)
.L2:
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+5,__zero_reg__
	std Z+4,__zero_reg__
	std Z+7,__zero_reg__
	std Z+6,__zero_reg__
	std Z+8,__zero_reg__
	std Z+9,__zero_reg__
	std Z+10,__zero_reg__
	std Z+11,__zero_reg__
	std Z+12,__zero_reg__
	std Z+13,__zero_reg__
	std Z+14,__zero_reg__
	std Z+15,__zero_reg__
	std Z+17,__zero_reg__
	std Z+16,__zero_reg__
	std Z+24,__zero_reg__
	adiw r30,25
	ldi r24,hi8(g_tasks+250)
	cpi r30,lo8(g_tasks+250)
	cpc r31,r24
	brne .L2
	sts g_taskCount,__zero_reg__
	sts g_idleTime,__zero_reg__
	sts g_idleTime+1,__zero_reg__
	sts g_idleTime+2,__zero_reg__
	sts g_idleTime+3,__zero_reg__
	sts g_busyTime,__zero_reg__
	sts g_busyTime+1,__zero_reg__
	sts g_busyTime+2,__zero_reg__
	sts g_busyTime+3,__zero_reg__
	call TIMER_GetTick
	sts g_lastLoadCheck,r22
	sts g_lastLoadCheck+1,r23
	sts g_lastLoadCheck+2,r24
	sts g_lastLoadCheck+3,r25
	sts g_maxLoad,__zero_reg__
/* epilogue start */
	ret
	.size	SCHED_Init, .-SCHED_Init
.global	SCHED_Run
	.type	SCHED_Run, @function
SCHED_Run:
	push r4
	push r5
	push r6
	push r7
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
/* prologue: function */
/* frame size = 0 */
/* stack size = 14 */
.L__stack_usage = 14
	call TIMER_GetTick
	movw r12,r22
	movw r14,r24
	mov r11,__zero_reg__
	ldi r24,lo8(25)
	mov r10,r24
.L5:
	lds r24,g_taskCount
	cp r11,r24
	brsh .+2
	rjmp .L9
	lds r24,g_lastLoadCheck
	lds r25,g_lastLoadCheck+1
	lds r26,g_lastLoadCheck+2
	lds r27,g_lastLoadCheck+3
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
	brsh .+2
	rjmp .L4
	lds r18,g_busyTime
	lds r19,g_busyTime+1
	lds r20,g_busyTime+2
	lds r21,g_busyTime+3
	lds r4,g_idleTime
	lds r5,g_idleTime+1
	lds r6,g_idleTime+2
	lds r7,g_idleTime+3
	add r4,r18
	adc r5,r19
	adc r6,r20
	adc r7,r21
	cp r4,__zero_reg__
	cpc r5,__zero_reg__
	cpc r6,__zero_reg__
	cpc r7,__zero_reg__
	breq .L11
	ldi r26,lo8(100)
	ldi r27,0
	call __muluhisi3
	movw r20,r6
	movw r18,r4
	call __udivmodsi4
	lds r24,g_maxLoad
	cp r24,r18
	brsh .L11
	sts g_maxLoad,r18
.L11:
	sts g_busyTime,__zero_reg__
	sts g_busyTime+1,__zero_reg__
	sts g_busyTime+2,__zero_reg__
	sts g_busyTime+3,__zero_reg__
	sts g_idleTime,__zero_reg__
	sts g_idleTime+1,__zero_reg__
	sts g_idleTime+2,__zero_reg__
	sts g_idleTime+3,__zero_reg__
	sts g_lastLoadCheck,r12
	sts g_lastLoadCheck+1,r13
	sts g_lastLoadCheck+2,r14
	sts g_lastLoadCheck+3,r15
.L4:
/* epilogue start */
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
	pop r7
	pop r6
	pop r5
	pop r4
	ret
.L9:
	mov r16,r11
	ldi r17,0
	mul r10,r16
	movw r28,r0
	mul r10,r17
	add r29,r0
	clr __zero_reg__
	subi r28,lo8(-(g_tasks))
	sbci r29,hi8(-(g_tasks))
	ldd r24,Y+24
	tst r24
	brne .+2
	rjmp .L6
	ld r24,Y
	ldd r25,Y+1
	or r24,r25
	brne .+2
	rjmp .L6
	ldd r24,Y+12
	ldd r25,Y+13
	ldd r26,Y+14
	ldd r27,Y+15
	cp r12,r24
	cpc r13,r25
	cpc r14,r26
	cpc r15,r27
	brsh .+2
	rjmp .L6
	call TIMER_GetTick
	movw r4,r22
	movw r6,r24
	std Y+20,r4
	std Y+21,r5
	std Y+22,r6
	std Y+23,r7
	ld r30,Y
	ldd r31,Y+1
	icall
	call TIMER_GetTick
	movw r26,r24
	movw r24,r22
	sub r24,r4
	sbc r25,r5
	sbc r26,r6
	sbc r27,r7
	ldd r4,Y+18
	ldd r5,Y+19
	mov r7,__zero_reg__
	mov r6,__zero_reg__
	cp r4,r24
	cpc r5,r25
	cpc r6,r26
	cpc r7,r27
	brsh .L7
	std Y+19,r25
	std Y+18,r24
.L7:
	lds r4,g_busyTime
	lds r5,g_busyTime+1
	lds r6,g_busyTime+2
	lds r7,g_busyTime+3
	add r4,r24
	adc r5,r25
	adc r6,r26
	adc r7,r27
	sts g_busyTime,r4
	sts g_busyTime+1,r5
	sts g_busyTime+2,r6
	sts g_busyTime+3,r7
	mul r10,r16
	movw r30,r0
	mul r10,r17
	add r31,r0
	clr __zero_reg__
	subi r30,lo8(-(g_tasks))
	sbci r31,hi8(-(g_tasks))
	ldd r18,Z+4
	ldd r19,Z+5
	ldd r24,Z+8
	ldd r25,Z+9
	ldd r26,Z+10
	ldd r27,Z+11
	movw r22,r14
	movw r20,r12
	sub r20,r24
	sbc r21,r25
	sbc r22,r26
	sbc r23,r27
	movw r24,r18
	adiw r24,5
	ldi r27,0
	ldi r26,0
	cp r24,r20
	cpc r25,r21
	cpc r26,r22
	cpc r27,r23
	brsh .L8
	ldd r24,Z+16
	ldd r25,Z+17
	adiw r24,1
	std Z+17,r25
	std Z+16,r24
.L8:
	mul r10,r16
	movw r30,r0
	mul r10,r17
	add r31,r0
	clr __zero_reg__
	subi r30,lo8(-(g_tasks))
	sbci r31,hi8(-(g_tasks))
	std Z+8,r12
	std Z+9,r13
	std Z+10,r14
	std Z+11,r15
	movw r26,r14
	movw r24,r12
	add r24,r18
	adc r25,r19
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	std Z+12,r24
	std Z+13,r25
	std Z+14,r26
	std Z+15,r27
.L6:
	inc r11
	rjmp .L5
	.size	SCHED_Run, .-SCHED_Run
.global	SCHED_AddTask
	.type	SCHED_AddTask, @function
SCHED_AddTask:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r26,r24
	lds r25,g_taskCount
	cpi r25,lo8(10)
	brsh .L24
	sbiw r26,0
	breq .L24
	ldi r24,lo8(25)
	mul r25,r24
	movw r30,r0
	clr __zero_reg__
	subi r30,lo8(-(g_tasks))
	sbci r31,hi8(-(g_tasks))
	std Z+1,r27
	st Z,r26
	std Z+3,r23
	std Z+2,r22
	std Z+5,r21
	std Z+4,r20
	std Z+7,r19
	std Z+6,r18
	std Z+8,__zero_reg__
	std Z+9,__zero_reg__
	std Z+10,__zero_reg__
	std Z+11,__zero_reg__
	movw r20,r18
	ldi r23,0
	ldi r22,0
	std Z+12,r20
	std Z+13,r21
	std Z+14,r22
	std Z+15,r23
	std Z+17,__zero_reg__
	std Z+16,__zero_reg__
	std Z+19,__zero_reg__
	std Z+18,__zero_reg__
	ldi r24,lo8(1)
	std Z+24,r24
	subi r25,lo8(-(1))
	sts g_taskCount,r25
	ret
.L24:
	ldi r24,0
/* epilogue start */
	ret
	.size	SCHED_AddTask, .-SCHED_AddTask
.global	SCHED_GetOverrun
	.type	SCHED_GetOverrun, @function
SCHED_GetOverrun:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,g_taskCount
	cp r24,r25
	brsh .L27
	ldi r25,lo8(25)
	mul r24,r25
	movw r30,r0
	clr __zero_reg__
	subi r30,lo8(-(g_tasks))
	sbci r31,hi8(-(g_tasks))
	ldd r24,Z+16
	ldd r25,Z+17
	ret
.L27:
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	SCHED_GetOverrun, .-SCHED_GetOverrun
.global	SCHED_GetLoadPercent
	.type	SCHED_GetLoadPercent, @function
SCHED_GetLoadPercent:
	push r12
	push r13
	push r14
	push r15
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	call TIMER_GetTick
	lds r12,g_lastLoadCheck
	lds r13,g_lastLoadCheck+1
	lds r14,g_lastLoadCheck+2
	lds r15,g_lastLoadCheck+3
	sub r22,r12
	sbc r23,r13
	sbc r24,r14
	sbc r25,r15
	cpi r22,-24
	sbci r23,3
	cpc r24,__zero_reg__
	cpc r25,__zero_reg__
	brlo .L29
	call SCHED_Run
.L29:
	lds r18,g_busyTime
	lds r19,g_busyTime+1
	lds r20,g_busyTime+2
	lds r21,g_busyTime+3
	lds r12,g_idleTime
	lds r13,g_idleTime+1
	lds r14,g_idleTime+2
	lds r15,g_idleTime+3
	add r12,r18
	adc r13,r19
	adc r14,r20
	adc r15,r21
	ldi r24,0
	cp r12,__zero_reg__
	cpc r13,__zero_reg__
	cpc r14,__zero_reg__
	cpc r15,__zero_reg__
	breq .L28
	ldi r26,lo8(100)
	ldi r27,0
	call __muluhisi3
	movw r20,r14
	movw r18,r12
	call __udivmodsi4
	mov r24,r18
.L28:
/* epilogue start */
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	SCHED_GetLoadPercent, .-SCHED_GetLoadPercent
.global	SCHED_GetMaxLoadPercent
	.type	SCHED_GetMaxLoadPercent, @function
SCHED_GetMaxLoadPercent:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_maxLoad
/* epilogue start */
	ret
	.size	SCHED_GetMaxLoadPercent, .-SCHED_GetMaxLoadPercent
.global	SCHED_ReportStatus
	.type	SCHED_ReportStatus, @function
SCHED_ReportStatus:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	ret
	.size	SCHED_ReportStatus, .-SCHED_ReportStatus
	.local	g_maxLoad
	.comm	g_maxLoad,1,1
	.local	g_lastLoadCheck
	.comm	g_lastLoadCheck,4,1
	.local	g_busyTime
	.comm	g_busyTime,4,1
	.local	g_idleTime
	.comm	g_idleTime,4,1
	.local	g_taskCount
	.comm	g_taskCount,1,1
	.local	g_tasks
	.comm	g_tasks,250,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
