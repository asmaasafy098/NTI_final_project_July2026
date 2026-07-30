	.file	"uart_modified.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	UART_ReceiveByte.part.0, @function
UART_ReceiveByte.part.0:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L2:
	lds r20,UART_RxHead
	lds r21,UART_RxHead+1
	lds r18,UART_RxTail
	lds r19,UART_RxTail+1
	cp r20,r18
	cpc r21,r19
	breq .L2
	lds r30,UART_RxTail
	lds r31,UART_RxTail+1
	subi r30,lo8(-(UART_RxBuf))
	sbci r31,hi8(-(UART_RxBuf))
	ld r18,Z
	movw r30,r24
	st Z,r18
	lds r24,UART_RxTail
	lds r25,UART_RxTail+1
	adiw r24,1
	andi r24,63
	clr r25
	sts UART_RxTail+1,r25
	sts UART_RxTail,r24
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	UART_ReceiveByte.part.0, .-UART_ReceiveByte.part.0
.global	UART_Init
	.type	UART_Init, @function
UART_Init:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	brne .+2
	rjmp .L9
	ld r24,Y
	ldd r25,Y+1
	ldd r26,Y+2
	ldd r27,Y+3
	sbiw r24,0
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brne .+2
	rjmp .L9
	movw r18,r24
	movw r20,r26
	ldi r24,4
	1:
	lsl r18
	rol r19
	rol r20
	rol r21
	dec r24
	brne 1b
	ldi r22,0
	ldi r23,lo8(36)
	ldi r24,lo8(-12)
	ldi r25,0
	call __udivmodsi4
	subi r18,1
	sbc r19,__zero_reg__
	mov r24,r19
	andi r24,lo8(15)
	out 0x20,r24
	out 0x9,r18
	ldd r24,Y+6
	swap r24
	andi r24,lo8(48)
	ldd r25,Y+8
	lsl r25
	lsl r25
	lsl r25
	andi r25,lo8(8)
	or r24,r25
	ori r24,lo8(-128)
	ldd r25,Y+4
	lsl r25
	andi r25,lo8(6)
	or r24,r25
	out 0x20,r24
	ldd r24,Y+4
	ldd r25,Y+5
	sbiw r24,7
	brne .L6
	sbi 0xa,2
.L7:
	sbi 0xa,3
	sbi 0xa,4
	sbi 0xa,7
	sts UART_TxHead+1,__zero_reg__
	sts UART_TxHead,__zero_reg__
	sts UART_TxTail+1,__zero_reg__
	sts UART_TxTail,__zero_reg__
	sts UART_RxHead+1,__zero_reg__
	sts UART_RxHead,__zero_reg__
	sts UART_RxTail+1,__zero_reg__
	sts UART_RxTail,__zero_reg__
	ldi r25,0
	ldi r24,0
.L4:
/* epilogue start */
	pop r29
	pop r28
	ret
.L6:
	cbi 0xa,2
	rjmp .L7
.L9:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L4
	.size	UART_Init, .-UART_Init
.global	UART_DeInit
	.type	UART_DeInit, @function
UART_DeInit:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cbi 0xa,3
	cbi 0xa,4
	cbi 0xa,7
	cbi 0xa,6
	cbi 0xa,5
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	UART_DeInit, .-UART_DeInit
.global	UART_SendByte
	.type	UART_SendByte, @function
UART_SendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,UART_TxHead
	lds r19,UART_TxHead+1
	subi r18,-1
	sbci r19,-1
	andi r18,127
	clr r19
.L12:
	lds r20,UART_TxTail
	lds r21,UART_TxTail+1
	cp r20,r18
	cpc r21,r19
	breq .L12
	lds r30,UART_TxHead
	lds r31,UART_TxHead+1
	subi r30,lo8(-(UART_TxBuf))
	sbci r31,hi8(-(UART_TxBuf))
	st Z,r24
	sts UART_TxHead+1,r19
	sts UART_TxHead,r18
	sbi 0xa,5
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	UART_SendByte, .-UART_SendByte
.global	UART_ReceiveByte
	.type	UART_ReceiveByte, @function
UART_ReceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L15
	jmp UART_ReceiveByte.part.0
.L15:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_ReceiveByte, .-UART_ReceiveByte
.global	UART_ReceiveByteNonBlocking
	.type	UART_ReceiveByteNonBlocking, @function
UART_ReceiveByteNonBlocking:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L19
	lds r20,UART_RxHead
	lds r21,UART_RxHead+1
	lds r18,UART_RxTail
	lds r19,UART_RxTail+1
	cp r20,r18
	cpc r21,r19
	breq .L19
	lds r30,UART_RxTail
	lds r31,UART_RxTail+1
	subi r30,lo8(-(UART_RxBuf))
	sbci r31,hi8(-(UART_RxBuf))
	ld r18,Z
	movw r30,r24
	st Z,r18
	lds r24,UART_RxTail
	lds r25,UART_RxTail+1
	adiw r24,1
	andi r24,63
	clr r25
	sts UART_RxTail+1,r25
	sts UART_RxTail,r24
	ldi r25,0
	ldi r24,0
	ret
.L19:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_ReceiveByteNonBlocking, .-UART_ReceiveByteNonBlocking
.global	UART_SendString
	.type	UART_SendString, @function
UART_SendString:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	brne .L22
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L20
.L23:
	call UART_SendByte
.L22:
	ld r24,Y+
	cpse r24,__zero_reg__
	rjmp .L23
	ldi r25,0
	ldi r24,0
.L20:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	UART_SendString, .-UART_SendString
.global	UART_ReceiveString
	.type	UART_ReceiveString, @function
UART_ReceiveString:
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
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 12 */
.L__stack_usage = 12
	std Y+1,__zero_reg__
	sbiw r24,0
	brne .L26
.L28:
	ldi r24,lo8(1)
	ldi r25,0
.L25:
/* epilogue start */
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
	ret
.L26:
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L28
	mov r9,r20
	movw r12,r24
	movw r10,r24
	ldi r17,0
	ldi r16,0
	movw r14,r22
	ldi r24,1
	sub r14,r24
	sbc r15,__zero_reg__
.L29:
	cp r16,r14
	cpc r17,r15
	brsh .L32
	movw r24,r28
	adiw r24,1
	call UART_ReceiveByte.part.0
	or r24,r25
	brne .L28
	ldd r24,Y+1
	cpse r24,r9
	rjmp .L30
.L32:
	add r16,r12
	adc r17,r13
	movw r30,r16
	st Z,__zero_reg__
	ldi r25,0
	ldi r24,0
	rjmp .L25
.L30:
	movw r30,r10
	st Z+,r24
	movw r10,r30
	subi r16,-1
	sbci r17,-1
	rjmp .L29
	.size	UART_ReceiveString, .-UART_ReceiveString
.global	UART_SetRxCallBack
	.type	UART_SetRxCallBack, @function
UART_SetRxCallBack:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	or r24,r25
	breq .L38
	sbi 0xa,7
	ldi r25,0
	ldi r24,0
	ret
.L38:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SetRxCallBack, .-UART_SetRxCallBack
.global	UART_TxBusy
	.type	UART_TxBusy, @function
UART_TxBusy:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,UART_TxHead
	lds r19,UART_TxHead+1
	lds r24,UART_TxTail
	lds r25,UART_TxTail+1
	cp r18,r24
	cpc r19,r25
	brne .L41
	ldi r25,0
	ldi r24,0
	ret
.L41:
	ldi r24,lo8(2)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_TxBusy, .-UART_TxBusy
.global	USART_TransmitByte
	.type	USART_TransmitByte, @function
USART_TransmitByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp UART_SendByte
	.size	USART_TransmitByte, .-USART_TransmitByte
.global	USART_TransmitString
	.type	USART_TransmitString, @function
USART_TransmitString:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp UART_SendString
	.size	USART_TransmitString, .-USART_TransmitString
	.local	UART_RxTail
	.comm	UART_RxTail,2,1
	.local	UART_RxHead
	.comm	UART_RxHead,2,1
	.local	UART_RxBuf
	.comm	UART_RxBuf,64,1
	.local	UART_TxTail
	.comm	UART_TxTail,2,1
	.local	UART_TxHead
	.comm	UART_TxHead,2,1
	.local	UART_TxBuf
	.comm	UART_TxBuf,128,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
