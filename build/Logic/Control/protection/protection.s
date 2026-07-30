	.file	"protection.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	PROTECT_Init
	.type	PROTECT_Init, @function
PROTECT_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(g_protect)
	ldi r31,hi8(g_protect)
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+3,__zero_reg__
	std Z+2,__zero_reg__
	std Z+4,__zero_reg__
	std Z+5,__zero_reg__
	std Z+6,__zero_reg__
	std Z+7,__zero_reg__
	std Z+8,__zero_reg__
	std Z+9,__zero_reg__
	ldi r24,lo8(-128)
	ldi r25,lo8(-18)
	std Z+11,r25
	std Z+10,r24
	std Z+12,__zero_reg__
	std Z+13,__zero_reg__
	std Z+14,__zero_reg__
	std Z+15,__zero_reg__
	std Z+16,__zero_reg__
	std Z+17,__zero_reg__
/* epilogue start */
	ret
	.size	PROTECT_Init, .-PROTECT_Init
.global	PROTECT_Evaluate
	.type	PROTECT_Evaluate, @function
PROTECT_Evaluate:
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r30,r24
	movw r26,r22
	ldd r24,Z+26
	sbrc r24,1
	rjmp .L17
	ldd r18,Z+11
	ldd r19,Z+12
	adiw r26,19
	ld r24,X+
	ld r25,X
	sbiw r26,19+1
	cp r18,r24
	cpc r19,r25
	brlo .+2
	rjmp .L18
	lds r20,g_protect+10
	lds r21,g_protect+10+1
	ldi r23,0
	ldi r22,0
	lds r16,g_protect+6
	lds r17,g_protect+6+1
	lds r18,g_protect+6+2
	lds r19,g_protect+6+3
	cp r16,r20
	cpc r17,r21
	cpc r18,r22
	cpc r19,r23
	brlo .+2
	rjmp .L19
	ldd r25,Z+15
	adiw r26,21
	ld r24,X
	sbiw r26,21
	cp r25,r24
	brsh .+2
	rjmp .L4
	lds r24,g_protect+12
	subi r24,lo8(-(1))
	sts g_protect+12,r24
	cpi r24,lo8(20)
	brlo .+2
	rjmp .L20
.L5:
	ldd r18,Z+13
	ldd r19,Z+14
	adiw r26,22
	ld r24,X+
	ld r25,X
	sbiw r26,22+1
	cp r18,r24
	cpc r19,r25
	brlo .+2
	rjmp .L6
	lds r24,g_protect+13
	subi r24,lo8(-(1))
	sts g_protect+13,r24
	cpi r24,lo8(5)
	brlo .+2
	rjmp .L21
.L7:
	adiw r26,24
	ld r24,X+
	ld r25,X
	cp r24,r18
	cpc r25,r19
	brlo .+2
	rjmp .L8
	lds r24,g_protect+14
	subi r24,lo8(-(1))
	sts g_protect+14,r24
	cpi r24,lo8(2)
	brlo .+2
	rjmp .L22
.L9:
	ldd r20,Z+10
	ldd r18,Z+4
	ldd r19,Z+5
	cpi r20,lo8(51)
	brlo .L10
	cpi r18,100
	cpc r19,__zero_reg__
	brge .L10
	lds r24,g_protect+15
	subi r24,lo8(-(1))
	sts g_protect+15,r24
	cpi r24,lo8(30)
	brlo .+2
	rjmp .L23
.L11:
	ld r24,Z
	ldd r25,Z+1
	subi r24,12
	sbci r25,-2
	cp r24,r18
	cpc r25,r19
	brge .L12
	lds r24,g_protect+16
	subi r24,lo8(-(1))
	sts g_protect+16,r24
	cpi r24,lo8(10)
	brlo .+2
	rjmp .L24
.L13:
	cpi r20,lo8(21)
	brlo .L14
	or r18,r19
	brne .L14
	lds r24,g_protect+17
	subi r24,lo8(-(1))
	sts g_protect+17,r24
	cpi r24,lo8(20)
	brsh .L25
.L15:
	sts g_protect+1,__zero_reg__
	sts g_protect,__zero_reg__
	ldi r25,0
	ldi r24,0
.L2:
/* epilogue start */
	pop r17
	pop r16
	ret
.L4:
	sts g_protect+12,__zero_reg__
	rjmp .L5
.L6:
	sts g_protect+13,__zero_reg__
	rjmp .L7
.L8:
	sts g_protect+14,__zero_reg__
	rjmp .L9
.L10:
	sts g_protect+15,__zero_reg__
	rjmp .L11
.L12:
	sts g_protect+16,__zero_reg__
	rjmp .L13
.L14:
	sts g_protect+17,__zero_reg__
	rjmp .L15
.L17:
	ldi r24,lo8(1)
	ldi r25,0
.L3:
	sts g_protect+1,r25
	sts g_protect,r24
	ldi r18,lo8(1)
	sts g_protect+4,r18
	rjmp .L2
.L18:
	ldi r24,lo8(2)
	ldi r25,0
	rjmp .L3
.L19:
	ldi r24,lo8(3)
	ldi r25,0
	rjmp .L3
.L20:
	ldi r24,lo8(4)
	ldi r25,0
	rjmp .L3
.L21:
	ldi r24,lo8(5)
	ldi r25,0
	rjmp .L3
.L22:
	ldi r24,lo8(6)
	ldi r25,0
	rjmp .L3
.L23:
	ldi r24,lo8(7)
	ldi r25,0
	rjmp .L3
.L24:
	ldi r24,lo8(8)
	ldi r25,0
	rjmp .L3
.L25:
	ldi r24,lo8(9)
	ldi r25,0
	rjmp .L3
	.size	PROTECT_Evaluate, .-PROTECT_Evaluate
.global	PROTECT_UpdateI2T
	.type	PROTECT_UpdateI2T, @function
PROTECT_UpdateI2T:
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
/* prologue: function */
/* frame size = 0 */
/* stack size = 8 */
.L__stack_usage = 8
	ldi r27,0
	ldi r26,0
	movw r12,r24
	movw r14,r26
	sub r12,r22
	sbc r13,r23
	sbc r14,__zero_reg__
	sbc r15,__zero_reg__
	movw r20,r14
	movw r18,r12
	movw r24,r14
	movw r22,r12
	call __mulsi3
	lds r8,g_protect+6
	lds r9,g_protect+6+1
	lds r10,g_protect+6+2
	lds r11,g_protect+6+3
	cp __zero_reg__,r12
	cpc __zero_reg__,r13
	cpc __zero_reg__,r14
	cpc __zero_reg__,r15
	brge .L27
	ldi r18,lo8(-24)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __divmodsi4
	add r8,r18
	adc r9,r19
	adc r10,r20
	adc r11,r21
.L30:
	sts g_protect+6,r8
	sts g_protect+6+1,r9
	sts g_protect+6+2,r10
	sts g_protect+6+3,r11
.L26:
/* epilogue start */
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ret
.L27:
	ldi r18,lo8(-96)
	ldi r19,lo8(15)
	ldi r20,0
	ldi r21,0
	call __divmodsi4
	cp r18,r8
	cpc r19,r9
	cpc r20,r10
	cpc r21,r11
	brsh .L29
	sub r8,r18
	sbc r9,r19
	sbc r10,r20
	sbc r11,r21
	rjmp .L30
.L29:
	sts g_protect+6,__zero_reg__
	sts g_protect+6+1,__zero_reg__
	sts g_protect+6+2,__zero_reg__
	sts g_protect+6+3,__zero_reg__
	rjmp .L26
	.size	PROTECT_UpdateI2T, .-PROTECT_UpdateI2T
.global	PROTECT_Reset
	.type	PROTECT_Reset, @function
PROTECT_Reset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(g_protect)
	ldi r31,hi8(g_protect)
	std Z+4,__zero_reg__
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	std Z+12,__zero_reg__
	std Z+13,__zero_reg__
	std Z+14,__zero_reg__
	std Z+15,__zero_reg__
	std Z+16,__zero_reg__
	std Z+17,__zero_reg__
/* epilogue start */
	ret
	.size	PROTECT_Reset, .-PROTECT_Reset
.global	PROTECT_ResetTrip
	.type	PROTECT_ResetTrip, @function
PROTECT_ResetTrip:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_protect+2
	lds r19,g_protect+2+1
	cp r18,r24
	cpc r19,r25
	brne .L32
	sts g_protect+2+1,__zero_reg__
	sts g_protect+2,__zero_reg__
	sts g_protect+5,__zero_reg__
	jmp PROTECT_Reset
.L32:
/* epilogue start */
	ret
	.size	PROTECT_ResetTrip, .-PROTECT_ResetTrip
.global	PROTECT_IsTripped
	.type	PROTECT_IsTripped, @function
PROTECT_IsTripped:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_protect+4
	cpse r24,__zero_reg__
	rjmp .L37
	ldi r24,lo8(1)
	lds r25,g_protect+5
	cpse r25,__zero_reg__
	rjmp .L35
	ldi r24,0
	ret
.L37:
	ldi r24,lo8(1)
.L35:
/* epilogue start */
	ret
	.size	PROTECT_IsTripped, .-PROTECT_IsTripped
.global	PROTECT_GetActiveTrip
	.type	PROTECT_GetActiveTrip, @function
PROTECT_GetActiveTrip:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_protect
	lds r25,g_protect+1
/* epilogue start */
	ret
	.size	PROTECT_GetActiveTrip, .-PROTECT_GetActiveTrip
.global	PROTECT_GetLatchedTrip
	.type	PROTECT_GetLatchedTrip, @function
PROTECT_GetLatchedTrip:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_protect+2
	lds r25,g_protect+2+1
/* epilogue start */
	ret
	.size	PROTECT_GetLatchedTrip, .-PROTECT_GetLatchedTrip
.global	PROTECT_GetI2TPercent
	.type	PROTECT_GetI2TPercent, @function
PROTECT_GetI2TPercent:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,g_protect+10
	lds r31,g_protect+10+1
	sbiw r30,0
	breq .L42
	lds r18,g_protect+6
	lds r19,g_protect+6+1
	lds r20,g_protect+6+2
	lds r21,g_protect+6+3
	ldi r26,lo8(100)
	ldi r27,0
	call __muluhisi3
	movw r18,r30
	ldi r21,0
	ldi r20,0
	call __udivmodsi4
	mov r24,r18
	ret
.L42:
	ldi r24,0
/* epilogue start */
	ret
	.size	PROTECT_GetI2TPercent, .-PROTECT_GetI2TPercent
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"UNKNOWN"
	.text
.global	PROTECT_GetTripString
	.type	PROTECT_GetTripString, @function
PROTECT_GetTripString:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,10
	cpc r25,__zero_reg__
	brsh .L45
	lsl r24
	rol r25
	movw r30,r24
	subi r30,lo8(-(CSWTCH.11))
	sbci r31,hi8(-(CSWTCH.11))
	ld r24,Z
	ldd r25,Z+1
	ret
.L45:
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
/* epilogue start */
	ret
	.size	PROTECT_GetTripString, .-PROTECT_GetTripString
	.section	.rodata.str1.1
.LC1:
	.string	"NONE"
.LC2:
	.string	"ESTOP"
.LC3:
	.string	"SHORT"
.LC4:
	.string	"OVERLOAD"
.LC5:
	.string	"OVERTEMP"
.LC6:
	.string	"UNDERVOLT"
.LC7:
	.string	"OVERVOLT"
.LC8:
	.string	"STALL"
.LC9:
	.string	"OVERSPEED"
.LC10:
	.string	"NOFEEDBACK"
	.section	.rodata
	.type	CSWTCH.11, @object
	.size	CSWTCH.11, 20
CSWTCH.11:
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
	.local	g_protect
	.comm	g_protect,18,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
