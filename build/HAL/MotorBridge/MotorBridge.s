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
	lds r18,lastDutyPct
	lds r19,lastDutyPct+1
	cpi r18,10
	cpc r19,__zero_reg__
	brlo .L2
	ldi r26,lo8(-113)
	ldi r27,lo8(1)
	call __umulhisi3
	ldi r18,lo8(100)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	cpi r18,-112
	ldi r24,1
	cpc r19,r24
	brlo .L3
	ldi r18,lo8(-113)
	ldi r19,lo8(1)
.L3:
	out 0x2a+1,r19
	out 0x2a,r18
	ldi r20,lo8(1)
.L7:
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	jmp GPIO_set_pin_value
.L2:
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
	ldi r20,0
	rjmp .L7
	.size	BRIDGE_ApplyOutput, .-BRIDGE_ApplyOutput
.global	BRIDGE_Init
	.type	BRIDGE_Init, @function
BRIDGE_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,bridgeInitialized
	cpse r24,__zero_reg__
	rjmp .L9
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
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldi r24,lo8(3)
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
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(3)
	call GPIO_set_pin_value
	in r24,0x2f
	ori r24,lo8(2)
	out 0x2f,r24
	in r24,0x2e
	ori r24,lo8(8)
	out 0x2e,r24
	in r24,0x2e
	ori r24,lo8(16)
	out 0x2e,r24
	in r24,0x2f
	andi r24,lo8(-2)
	out 0x2f,r24
	in r24,0x2f
	ori r24,lo8(-128)
	out 0x2f,r24
	in r24,0x2f
	andi r24,lo8(-65)
	out 0x2f,r24
	ldi r24,lo8(-113)
	ldi r25,lo8(1)
	out 0x26+1,r25
	out 0x26,r24
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
	in r24,0x2e
	ori r24,lo8(1)
	out 0x2e,r24
	in r24,0x2e
	andi r24,lo8(-3)
	out 0x2e,r24
	in r24,0x2e
	andi r24,lo8(-5)
	out 0x2e,r24
	sts masterEnabled+1,__zero_reg__
	sts masterEnabled,__zero_reg__
	sts lastDutyPct+1,__zero_reg__
	sts lastDutyPct,__zero_reg__
	ldi r24,lo8(1)
	sts bridgeInitialized,r24
.L9:
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
	breq .L12
	sbiw r24,2
	breq .L13
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,0
	rjmp .L17
.L12:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,lo8(1)
	ldi r22,0
.L16:
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
.L13:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_set_pin_value
	ldi r20,lo8(1)
.L17:
	ldi r22,lo8(1)
	rjmp .L16
	.size	BRIDGE_SetDirection, .-BRIDGE_SetDirection
.global	BRIDGE_SetDuty
	.type	BRIDGE_SetDuty, @function
BRIDGE_SetDuty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,101
	cpc r25,__zero_reg__
	brlo .L19
	ldi r24,lo8(100)
	ldi r25,0
.L19:
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
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
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
	out 0x2a+1,__zero_reg__
	out 0x2a,__zero_reg__
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
.global	BRIDGE_IsEnabled
	.type	BRIDGE_IsEnabled, @function
BRIDGE_IsEnabled:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,masterEnabled
/* epilogue start */
	ret
	.size	BRIDGE_IsEnabled, .-BRIDGE_IsEnabled
	.local	bridgeInitialized
	.comm	bridgeInitialized,1,1
	.local	lastDutyPct
	.comm	lastDutyPct,2,1
	.local	masterEnabled
	.comm	masterEnabled,2,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
