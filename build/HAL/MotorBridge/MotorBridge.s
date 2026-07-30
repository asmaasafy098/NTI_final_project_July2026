	.file	"MotorBridge.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	BRIDGE_ApplyOutput, @function
BRIDGE_ApplyOutput:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,masterEnabled
	lds r25,masterEnabled+1
	or r24,r25
	breq .L2
	lds r24,lastDutyPct
	lds r25,lastDutyPct+1
	ldi r20,lo8(1)
	sbiw r24,10
	brsh .L6
.L2:
	ldi r20,0
.L6:
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	jmp GPIO_set_pin_value
	.size	BRIDGE_ApplyOutput, .-BRIDGE_ApplyOutput
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
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	sts masterEnabled+1,__zero_reg__
	sts masterEnabled,__zero_reg__
	sts lastDutyPct+1,__zero_reg__
	sts lastDutyPct,__zero_reg__
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
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
	breq .L10
	sbiw r24,2
	breq .L11
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,0
	rjmp .L15
.L10:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,lo8(1)
	ldi r22,0
.L14:
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
.L11:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,lo8(1)
.L15:
	ldi r22,lo8(1)
	rjmp .L14
	.size	BRIDGE_SetDirection, .-BRIDGE_SetDirection
.global	BRIDGE_SetDuty
	.type	BRIDGE_SetDuty, @function
BRIDGE_SetDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts lastDutyPct+1,r25
	sts lastDutyPct,r24
	call BRIDGE_ApplyOutput
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	BRIDGE_SetDuty, .-BRIDGE_SetDuty
.global	BRIDGE_Enable
	.type	BRIDGE_Enable, @function
BRIDGE_Enable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	ldi r25,0
	sts masterEnabled+1,r25
	sts masterEnabled,r24
	call BRIDGE_ApplyOutput
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
	sts masterEnabled+1,__zero_reg__
	sts masterEnabled,__zero_reg__
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
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
	call GPIO_set_pin_value
	sts masterEnabled+1,__zero_reg__
	sts masterEnabled,__zero_reg__
	sts lastDutyPct+1,__zero_reg__
	sts lastDutyPct,__zero_reg__
/* epilogue start */
	ret
	.size	BRIDGE_ForceStop, .-BRIDGE_ForceStop
	.local	lastDutyPct
	.comm	lastDutyPct,2,1
	.local	masterEnabled
	.comm	masterEnabled,2,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
