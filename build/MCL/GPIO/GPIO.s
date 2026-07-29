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
	brsh .L8
	cpi r22,lo8(8)
	brsh .L8
	tst r20
	breq .L3
	cpi r20,lo8(1)
	breq .L4
.L8:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L3:
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_DDRx))
	sbci r31,hi8(-(GPIO_DDRx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	ld r18,Z
	ldi r24,lo8(1)
	ldi r25,0
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r24,r18
.L9:
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L4:
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_DDRx))
	sbci r31,hi8(-(GPIO_DDRx))
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
	or r24,r18
	rjmp .L9
	.size	GPIO_set_pin_Direction, .-GPIO_set_pin_Direction
.global	GPIO_set_pin_value
	.type	GPIO_set_pin_value, @function
GPIO_set_pin_value:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L17
	cpi r22,lo8(8)
	brsh .L17
	tst r20
	breq .L12
	cpi r20,lo8(1)
	breq .L13
.L17:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L12:
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_PORTx))
	sbci r31,hi8(-(GPIO_PORTx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	ld r18,Z
	ldi r24,lo8(1)
	ldi r25,0
	rjmp 2f
	1:
	lsl r24
	2:
	dec r22
	brpl 1b
	com r24
	and r24,r18
.L18:
	st Z,r24
	ldi r25,0
	ldi r24,0
	ret
.L13:
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
	or r24,r18
	rjmp .L18
	.size	GPIO_set_pin_value, .-GPIO_set_pin_value
.global	GPIO_pin_toggle
	.type	GPIO_pin_toggle, @function
GPIO_pin_toggle:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L22
	cpi r22,lo8(8)
	brsh .L22
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
.L22:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_pin_toggle, .-GPIO_pin_toggle
.global	GPIO_set_port_Direction
	.type	GPIO_set_port_Direction, @function
GPIO_set_port_Direction:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L27
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_DDRx))
	sbci r31,hi8(-(GPIO_DDRx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	cpse r22,__zero_reg__
	rjmp .L25
	st Z,__zero_reg__
.L28:
	ldi r25,0
	ldi r24,0
	ret
.L25:
	cpi r22,lo8(1)
	brne .L26
	ldi r24,lo8(-1)
	st Z,r24
	rjmp .L28
.L26:
	st Z,r22
	rjmp .L28
.L27:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_set_port_Direction, .-GPIO_set_port_Direction
.global	GPIO_set_port_value
	.type	GPIO_set_port_value, @function
GPIO_set_port_value:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L33
	mov r30,r24
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(GPIO_PORTx))
	sbci r31,hi8(-(GPIO_PORTx))
	ld __tmp_reg__,Z+
	ld r31,Z
	mov r30,__tmp_reg__
	cpse r22,__zero_reg__
	rjmp .L31
	st Z,__zero_reg__
.L34:
	ldi r25,0
	ldi r24,0
	ret
.L31:
	cpi r22,lo8(1)
	brne .L32
	ldi r24,lo8(-1)
	st Z,r24
	rjmp .L34
.L32:
	st Z,r22
	rjmp .L34
.L33:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_set_port_value, .-GPIO_set_port_value
.global	GPIO_get_pin_status
	.type	GPIO_get_pin_status, @function
GPIO_get_pin_status:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L39
	cpi r22,lo8(8)
	brsh .L39
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L39
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
.L39:
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
	brsh .L43
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L43
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
.L43:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	GPIO_get_port_status, .-GPIO_get_port_status
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
