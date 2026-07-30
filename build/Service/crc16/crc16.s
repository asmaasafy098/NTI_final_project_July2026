	.file	"crc16.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	CRC16_Calculate
	.type	CRC16_Calculate, @function
CRC16_Calculate:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	add r22,r24
	adc r23,r25
	ldi r24,lo8(-1)
	ldi r25,lo8(-1)
.L2:
	cp r30,r22
	cpc r31,r23
	brne .L5
/* epilogue start */
	ret
.L5:
	ld r18,Z+
	eor r24,r18
	ldi r18,lo8(8)
.L4:
	movw r20,r24
	andi r20,1
	clr r21
	lsr r25
	ror r24
	or r20,r21
	breq .L3
	ldi r19,1
	eor r24,r19
	ldi r19,160
	eor r25,r19
.L3:
	subi r18,lo8(-(-1))
	brne .L4
	rjmp .L2
	.size	CRC16_Calculate, .-CRC16_Calculate
.global	CRC16_Update
	.type	CRC16_Update, @function
CRC16_Update:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	eor r24,r22
	ldi r18,lo8(8)
.L12:
	movw r20,r24
	andi r20,1
	clr r21
	lsr r25
	ror r24
	or r20,r21
	breq .L11
	ldi r19,1
	eor r24,r19
	ldi r19,160
	eor r25,r19
.L11:
	subi r18,lo8(-(-1))
	brne .L12
/* epilogue start */
	ret
	.size	CRC16_Update, .-CRC16_Update
.global	CRC16_Verify
	.type	CRC16_Verify, @function
CRC16_Verify:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r16,r24
	movw r28,r22
	movw r14,r22
	ldi r24,2
	sub r14,r24
	sbc r15,__zero_reg__
	movw r22,r14
	movw r24,r16
	call CRC16_Calculate
	add r28,r16
	adc r29,r17
	sbiw r28,1
	ld r18,Y
	add r16,r14
	adc r17,r15
	movw r30,r16
	ld r19,Z
	eor r18,r19
	eor r19,r18
	eor r18,r19
	ldi r20,lo8(1)
	cp r18,r24
	cpc r19,r25
	breq .L18
	ldi r20,0
.L18:
	mov r24,r20
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	CRC16_Verify, .-CRC16_Verify
	.ident	"GCC: (GNU) 7.3.0"
