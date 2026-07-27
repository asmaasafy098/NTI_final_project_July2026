	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,0
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_set_pin_Direction
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_set_pin_Direction
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	call GPIO_set_pin_Direction
.L2:
	ldi r22,lo8(3)
	ldi r24,lo8(2)
	call GPIO_get_pin_status
	mov r29,r24
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	call GPIO_get_pin_status
	mov r28,r24
	ldi r20,lo8(1)
	cpi r29,lo8(1)
	breq .L8
	ldi r20,0
.L8:
	ldi r22,lo8(3)
	ldi r24,0
	call GPIO_set_pin_value
	ldi r20,lo8(1)
	cpse r28,__zero_reg__
	ldi r20,0
.L7:
	ldi r22,lo8(3)
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	rjmp .L2
	.size	main, .-main
	.ident	"GCC: (GNU) 7.3.0"
