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
	brsh .L16
	cpi r22,lo8(8)
	brsh .L16
	tst r20
	breq .L3
	cpi r20,lo8(1)
	breq .L4
.L16:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L3:
	ldi r18,lo8(1)
	ldi r19,0
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	com r18
	cpi r24,lo8(2)
	breq .L6
	cpi r24,lo8(3)
	breq .L7
	cpi r24,lo8(1)
	breq .L8
	in r24,0x1a
	and r18,r24
.L19:
	out 0x1a,r18
	rjmp .L17
.L8:
	in r24,0x17
	and r18,r24
.L18:
	out 0x17,r18
.L17:
	ldi r25,0
	ldi r24,0
	ret
.L6:
	in r24,0x14
	and r18,r24
.L20:
	out 0x14,r18
	rjmp .L17
.L7:
	in r24,0x11
	and r18,r24
.L21:
	out 0x11,r18
	rjmp .L17
.L4:
	ldi r18,lo8(1)
	ldi r19,0
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L10
	cpi r24,lo8(3)
	breq .L11
	cpi r24,lo8(1)
	breq .L12
	in r24,0x1a
	or r18,r24
	rjmp .L19
.L12:
	in r24,0x17
	or r18,r24
	rjmp .L18
.L10:
	in r24,0x14
	or r18,r24
	rjmp .L20
.L11:
	in r24,0x11
	or r18,r24
	rjmp .L21
	.size	GPIO_set_pin_Direction, .-GPIO_set_pin_Direction
.global	GPIO_set_pin_value
	.type	GPIO_set_pin_value, @function
GPIO_set_pin_value:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L37
	cpi r22,lo8(8)
	brsh .L37
	tst r20
	breq .L24
	cpi r20,lo8(1)
	breq .L25
.L37:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L24:
	ldi r18,lo8(1)
	ldi r19,0
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	com r18
	cpi r24,lo8(2)
	breq .L27
	cpi r24,lo8(3)
	breq .L28
	cpi r24,lo8(1)
	breq .L29
	in r24,0x1b
	and r18,r24
.L40:
	out 0x1b,r18
	rjmp .L38
.L29:
	in r24,0x18
	and r18,r24
.L39:
	out 0x18,r18
.L38:
	ldi r25,0
	ldi r24,0
	ret
.L27:
	in r24,0x15
	and r18,r24
.L41:
	out 0x15,r18
	rjmp .L38
.L28:
	in r24,0x12
	and r18,r24
.L42:
	out 0x12,r18
	rjmp .L38
.L25:
	ldi r18,lo8(1)
	ldi r19,0
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L31
	cpi r24,lo8(3)
	breq .L32
	cpi r24,lo8(1)
	breq .L33
	in r24,0x1b
	or r18,r24
	rjmp .L40
.L33:
	in r24,0x18
	or r18,r24
	rjmp .L39
.L31:
	in r24,0x15
	or r18,r24
	rjmp .L41
.L32:
	in r24,0x12
	or r18,r24
	rjmp .L42
	.size	GPIO_set_pin_value, .-GPIO_set_pin_value
.global	GPIO_pin_toggle
	.type	GPIO_pin_toggle, @function
GPIO_pin_toggle:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L50
	cpi r22,lo8(8)
	brsh .L50
	ldi r18,lo8(1)
	ldi r19,0
	rjmp 2f
	1:
	lsl r18
	2:
	dec r22
	brpl 1b
	cpi r24,lo8(2)
	breq .L46
	cpi r24,lo8(3)
	breq .L47
	cpi r24,lo8(1)
	breq .L48
	in r24,0x1b
	eor r18,r24
	out 0x1b,r18
.L51:
	ldi r25,0
	ldi r24,0
	ret
.L48:
	in r24,0x18
	eor r18,r24
	out 0x18,r18
	rjmp .L51
.L46:
	in r24,0x15
	eor r18,r24
	out 0x15,r18
	rjmp .L51
.L47:
	in r24,0x12
	eor r18,r24
	out 0x12,r18
	rjmp .L51
.L50:
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
	brsh .L58
	cpi r24,lo8(2)
	breq .L55
	cpi r24,lo8(3)
	breq .L56
	cpi r24,lo8(1)
	breq .L57
	out 0x1a,r22
.L59:
	ldi r25,0
	ldi r24,0
	ret
.L57:
	out 0x17,r22
	rjmp .L59
.L55:
	out 0x14,r22
	rjmp .L59
.L56:
	out 0x11,r22
	rjmp .L59
.L58:
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
	brsh .L66
	cpi r24,lo8(2)
	breq .L63
	cpi r24,lo8(3)
	breq .L64
	cpi r24,lo8(1)
	breq .L65
	out 0x1b,r22
.L67:
	ldi r25,0
	ldi r24,0
	ret
.L65:
	out 0x18,r22
	rjmp .L67
.L63:
	out 0x15,r22
	rjmp .L67
.L64:
	out 0x12,r22
	rjmp .L67
.L66:
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
	brsh .L75
	cpi r22,lo8(8)
	brsh .L75
	cpi r24,lo8(2)
	breq .L71
	cpi r24,lo8(3)
	breq .L72
	cpi r24,lo8(1)
	breq .L73
	in r24,0x19
.L76:
	ldi r25,0
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r22
	brpl 1b
	andi r24,lo8(1)
.L69:
	ldi r25,0
/* epilogue start */
	ret
.L73:
	in r24,0x16
	rjmp .L76
.L71:
	in r24,0x13
	rjmp .L76
.L72:
	in r24,0x10
	rjmp .L76
.L75:
	ldi r24,0
	rjmp .L69
	.size	GPIO_get_pin_status, .-GPIO_get_pin_status
.global	GPIO_get_port_status
	.type	GPIO_get_port_status, @function
GPIO_get_port_status:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L83
	cpi r24,lo8(2)
	breq .L80
	cpi r24,lo8(3)
	breq .L81
	cpi r24,lo8(1)
	breq .L82
	in r24,0x19
.L78:
	ldi r25,0
/* epilogue start */
	ret
.L82:
	in r24,0x16
	rjmp .L78
.L80:
	in r24,0x13
	rjmp .L78
.L81:
	in r24,0x10
	rjmp .L78
.L83:
	ldi r24,0
	rjmp .L78
	.size	GPIO_get_port_status, .-GPIO_get_port_status
	.ident	"GCC: (GNU) 7.3.0"
