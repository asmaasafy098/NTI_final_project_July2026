	.file	"UserPanel.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	PANEL_Init
	.type	PANEL_Init, @function
PANEL_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(2)
	call GPIO_set_pin_Direction
	ldi r20,0
	ldi r22,lo8(6)
	ldi r24,lo8(2)
	call GPIO_set_pin_Direction
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_set_pin_Direction
	ldi r20,0
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_set_pin_Direction
	ldi r20,0
	ldi r22,lo8(4)
	ldi r24,lo8(3)
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(5)
	ldi r23,0
	ldi r24,lo8(2)
	ldi r25,0
	call GPIO_set_pull_up
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(2)
	ldi r25,0
	call GPIO_set_pull_up
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(7)
	ldi r23,0
	ldi r24,lo8(2)
	ldi r25,0
	call GPIO_set_pull_up
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(3)
	ldi r25,0
	call GPIO_set_pull_up
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(3)
	ldi r25,0
	call GPIO_set_pull_up
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldi r24,lo8(2)
	call GPIO_set_pin_Direction
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_write_pin
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_write_pin
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_write_pin
	ldi r20,0
	ldi r22,lo8(4)
	ldi r24,lo8(2)
	call GPIO_write_pin
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	PANEL_Init, .-PANEL_Init
	.section	.rodata
.LC0:
	.word	1
	.word	2
	.word	3
	.word	4
	.text
.global	PANEL_Poll
	.type	PANEL_Poll, @function
PANEL_Poll:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,12
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 12 */
/* stack size = 18 */
.L__stack_usage = 18
	ldi r22,lo8(5)
	ldi r24,lo8(2)
	call GPIO_read_pin
	mov r15,r24
	ldi r22,lo8(6)
	ldi r24,lo8(2)
	call GPIO_read_pin
	mov r16,r24
	ldi r22,lo8(7)
	ldi r24,lo8(2)
	call GPIO_read_pin
	mov r17,r24
	ldi r22,lo8(6)
	ldi r24,lo8(3)
	call GPIO_read_pin
	ldi r25,lo8(1)
	cpse r15,__zero_reg__
	ldi r25,0
.L3:
	std Y+9,r25
	ldi r25,lo8(1)
	cpse r16,__zero_reg__
	ldi r25,0
.L4:
	std Y+10,r25
	ldi r25,lo8(1)
	cpse r17,__zero_reg__
	ldi r25,0
.L5:
	std Y+11,r25
	ldi r25,lo8(1)
	cpse r24,__zero_reg__
	ldi r25,0
.L6:
	std Y+12,r25
	ldi r24,lo8(8)
	ldi r30,lo8(.LC0)
	ldi r31,hi8(.LC0)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	lds r20,g_lastEvent
	lds r21,g_lastEvent+1
	movw r22,r28
	subi r22,-9
	sbci r23,-1
	ldi r30,lo8(g_previousStates)
	mov r14,r30
	ldi r30,hi8(g_previousStates)
	mov r15,r30
	ldi r30,lo8(g_debounceCounters)
	ldi r31,hi8(g_debounceCounters)
	ldi r25,0
	ldi r24,0
.L10:
	movw r26,r22
	ld r18,X+
	movw r22,r26
	movw r26,r14
	ld r19,X+
	movw r14,r26
	cp r18,r19
	breq .L7
	st Z,__zero_reg__
	movw r16,r26
	subi r16,1
	sbc r17,__zero_reg__
	movw r26,r16
	st X,r18
.L8:
	adiw r24,1
	adiw r30,1
	cpi r24,4
	cpc r25,__zero_reg__
	brne .L10
	sts g_lastEvent+1,r21
	sts g_lastEvent,r20
/* epilogue start */
	adiw r28,12
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
	ret
.L7:
	cpi r18,lo8(1)
	brne .L9
	ld r19,Z
	subi r19,lo8(-(1))
	st Z,r19
	cpi r19,lo8(5)
	brlo .L8
	movw r16,r24
	subi r16,lo8(-(g_buttonStates))
	sbci r17,hi8(-(g_buttonStates))
	movw r26,r16
	ld r19,X
	cpse r19,__zero_reg__
	rjmp .L8
	st X,r18
	movw r18,r24
	lsl r18
	rol r19
	ldi r20,lo8(1)
	ldi r21,0
	add r20,r28
	adc r21,r29
	add r18,r20
	adc r19,r21
	movw r26,r18
	ld r20,X+
	ld r21,X
	rjmp .L8
.L9:
	st Z,__zero_reg__
	movw r18,r24
	subi r18,lo8(-(g_buttonStates))
	sbci r19,hi8(-(g_buttonStates))
	movw r26,r18
	st X,__zero_reg__
	rjmp .L8
	.size	PANEL_Poll, .-PANEL_Poll
.global	PANEL_GetEvent
	.type	PANEL_GetEvent, @function
PANEL_GetEvent:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_lastEvent
	lds r25,g_lastEvent+1
	sts g_lastEvent+1,__zero_reg__
	sts g_lastEvent,__zero_reg__
/* epilogue start */
	ret
	.size	PANEL_GetEvent, .-PANEL_GetEvent
.global	PANEL_IsLocalMode
	.type	PANEL_IsLocalMode, @function
PANEL_IsLocalMode:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(4)
	ldi r24,lo8(3)
	call GPIO_read_pin
	ldi r25,lo8(1)
	cpse r24,__zero_reg__
	ldi r25,0
.L26:
	mov r24,r25
/* epilogue start */
	ret
	.size	PANEL_IsLocalMode, .-PANEL_IsLocalMode
.global	PANEL_SetRunLED
	.type	PANEL_SetRunLED, @function
PANEL_SetRunLED:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	tst r22
	breq .L31
	lds r24,g_blinkCounter
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brsh .L32
	sts g_blinkCounter,r24
/* epilogue start */
	ret
.L32:
	sts g_blinkCounter,__zero_reg__
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	jmp GPIO_toggle_pin
.L31:
	ldi r20,lo8(1)
	cpse r24,__zero_reg__
	rjmp .L34
	ldi r20,0
.L34:
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	jmp GPIO_write_pin
	.size	PANEL_SetRunLED, .-PANEL_SetRunLED
.global	PANEL_SetFaultLED
	.type	PANEL_SetFaultLED, @function
PANEL_SetFaultLED:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	cpse r24,__zero_reg__
	rjmp .L37
	ldi r20,0
.L37:
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	jmp GPIO_write_pin
	.size	PANEL_SetFaultLED, .-PANEL_SetFaultLED
.global	PANEL_SetDirectionLEDs
	.type	PANEL_SetDirectionLEDs, @function
PANEL_SetDirectionLEDs:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L40
	sbiw r24,2
	breq .L41
	ldi r20,0
	rjmp .L43
.L40:
	ldi r20,lo8(1)
.L43:
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_write_pin
	ldi r20,0
	rjmp .L44
.L41:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_write_pin
	ldi r20,lo8(1)
.L44:
	ldi r22,lo8(4)
	ldi r24,lo8(2)
	jmp GPIO_write_pin
	.size	PANEL_SetDirectionLEDs, .-PANEL_SetDirectionLEDs
	.local	g_blinkCounter
	.comm	g_blinkCounter,1,1
	.local	g_previousStates
	.comm	g_previousStates,4,1
	.local	g_debounceCounters
	.comm	g_debounceCounters,4,1
	.local	g_buttonStates
	.comm	g_buttonStates,4,1
	.local	g_lastEvent
	.comm	g_lastEvent,2,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
