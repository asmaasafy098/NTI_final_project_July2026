	.file	"MotorBridge.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	BRIDGE_Init
	.type	BRIDGE_Init, @function
BRIDGE_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_set_pin_Direction
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_set_pin_Direction
	jmp Timer1_Init
	.size	BRIDGE_Init, .-BRIDGE_Init
.global	BRIDGE_SetDirection
	.type	BRIDGE_SetDirection, @function
BRIDGE_SetDirection:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L4
	sbiw r24,2
	breq .L5
<<<<<<< HEAD
	ldi r21,0
=======
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	ldi r20,0
	rjmp .L8
.L4:
	ldi r20,lo8(1)
<<<<<<< HEAD
	ldi r21,0
.L8:
	ldi r23,0
	ldi r22,0
	ldi r24,lo8(1)
	ldi r25,0
	call GPIO_set_pin_value
	ldi r21,0
	ldi r20,0
	rjmp .L9
.L5:
	ldi r21,0
	ldi r20,0
	ldi r23,0
	ldi r22,0
	ldi r24,lo8(1)
	ldi r25,0
	call GPIO_set_pin_value
	ldi r20,lo8(1)
	ldi r21,0
.L9:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(1)
	ldi r25,0
=======
.L8:
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,0
	rjmp .L9
.L5:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,lo8(1)
.L9:
	ldi r22,lo8(1)
	ldi r24,lo8(1)
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	BRIDGE_SetDirection, .-BRIDGE_SetDirection
.global	BRIDGE_SetDuty
	.type	BRIDGE_SetDuty, @function
BRIDGE_SetDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp Timer1_SetDuty
	.size	BRIDGE_SetDuty, .-BRIDGE_SetDuty
.global	BRIDGE_Enable
	.type	BRIDGE_Enable, @function
BRIDGE_Enable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
<<<<<<< HEAD
	ldi r21,0
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(1)
	ldi r25,0
=======
	ldi r22,lo8(2)
	ldi r24,lo8(1)
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	BRIDGE_Enable, .-BRIDGE_Enable
.global	BRIDGE_Disable
	.type	BRIDGE_Disable, @function
BRIDGE_Disable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
<<<<<<< HEAD
	ldi r21,0
	ldi r20,0
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(1)
	ldi r25,0
=======
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	call GPIO_set_pin_value
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	BRIDGE_Disable, .-BRIDGE_Disable
.global	BRIDGE_ForceStop
	.type	BRIDGE_ForceStop, @function
BRIDGE_ForceStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
	ldi r24,0
	call Timer1_SetDuty
<<<<<<< HEAD
	ldi r21,0
	ldi r20,0
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(1)
	ldi r25,0
	call GPIO_set_pin_value
	ldi r21,0
	ldi r20,0
	ldi r23,0
	ldi r22,0
	ldi r24,lo8(1)
	ldi r25,0
	call GPIO_set_pin_value
	ldi r21,0
	ldi r20,0
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(1)
	ldi r25,0
=======
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	jmp GPIO_set_pin_value
	.size	BRIDGE_ForceStop, .-BRIDGE_ForceStop
	.ident	"GCC: (GNU) 7.3.0"
