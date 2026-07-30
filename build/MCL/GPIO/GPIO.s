	.file	"GPIO.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	GPIO_set_pin_Direction
	.type	GPIO_set_pin_Direction, @function
GPIO_set_pin_Direction:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L5
	cpi r22,lo8(8)
	brsh .L5
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_DDRx))
	sbci r31,hi8(-(GPIO_DDRx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	ldi r24,lo8(1)
	ldi r25,0
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	ld r25,Z
	cpi r20,lo8(1)
	brne .L3
	or r24,r25
.L6:
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L3:
	com r24
	and r24,r25
	rjmp .L6
.L5:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_set_pin_Direction, .-GPIO_set_pin_Direction
.global	GPIO_get_pin_status
	.type	GPIO_get_pin_status, @function
GPIO_get_pin_status:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L11
	cpi r22,lo8(8)
	brsh .L11
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L11
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_PINx))
	sbci r31,hi8(-(GPIO_PINx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	ld r24,Z
	ldi r25,0
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r22
	brpl 1b
	andi r24,lo8(1)
	movw r30,r20
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L11:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_get_pin_status, .-GPIO_get_pin_status
.global	GPIO_get_port_status
	.type	GPIO_get_port_status, @function
GPIO_get_port_status:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L15
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L15
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_PINx))
	sbci r31,hi8(-(GPIO_PINx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	ld r24,Z
	movw r30,r22
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L15:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_get_port_status, .-GPIO_get_port_status
.global	GPIO_write_pin
	.type	GPIO_write_pin, @function
GPIO_write_pin:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L20
	cpi r22,lo8(8)
	brsh .L20
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_PORTx))
	sbci r31,hi8(-(GPIO_PORTx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	ldi r24,lo8(1)
	ldi r25,0
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	ld r25,Z
	cpi r20,lo8(1)
	brne .L18
	or r24,r25
.L21:
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L18:
	com r24
	and r24,r25
	rjmp .L21
.L20:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_write_pin, .-GPIO_write_pin
.global	GPIO_set_pin_value
	.type	GPIO_set_pin_value, @function
GPIO_set_pin_value:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp GPIO_write_pin
	.size	GPIO_set_pin_value, .-GPIO_set_pin_value
.global	GPIO_read_pin
	.type	GPIO_read_pin, @function
GPIO_read_pin:
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	std Y+1,__zero_reg__
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	call GPIO_get_pin_status
	ldd r24,Y+1
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	GPIO_read_pin, .-GPIO_read_pin
.global	GPIO_toggle_pin
	.type	GPIO_toggle_pin, @function
GPIO_toggle_pin:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L27
	cpi r22,lo8(8)
	brsh .L27
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_PORTx))
	sbci r31,hi8(-(GPIO_PORTx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	ld r24,Z
	ldi r18,lo8(1)
	ldi r19,0
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	eor r24,r18
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L27:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_toggle_pin, .-GPIO_toggle_pin
.global	GPIO_set_pull_up
	.type	GPIO_set_pull_up, @function
GPIO_set_pull_up:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,lo8(1)
	cpse r20,__zero_reg__
	rjmp .L29
	ldi r25,0
.L29:
	mov r20,r25
	jmp GPIO_write_pin
	.size	GPIO_set_pull_up, .-GPIO_set_pull_up
	.section	.rodata
	.type	GPIO_PINx, @object
	.size	GPIO_PINx, 8
GPIO_PINx:
	.word	57
	.word	54
	.word	51
	.word	48
	.type	GPIO_PORTx, @object
	.size	GPIO_PORTx, 8
GPIO_PORTx:
	.word	59
	.word	56
	.word	53
	.word	50
	.type	GPIO_DDRx, @object
	.size	GPIO_DDRx, 8
GPIO_DDRx:
	.word	58
	.word	55
	.word	52
	.word	49
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
