	.file	"Tachometer.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	TACHO_PulseISR
	.type	TACHO_PulseISR, @function
TACHO_PulseISR:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Tacho_PulseCount
	lds r25,Tacho_PulseCount+1
	adiw r24,1
	sts Tacho_PulseCount+1,r25
	sts Tacho_PulseCount,r24
/* epilogue start */
	ret
	.size	TACHO_PulseISR, .-TACHO_PulseISR
.global	TACHO_Init
	.type	TACHO_Init, @function
TACHO_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Tacho_PulseCount+1,__zero_reg__
	sts Tacho_PulseCount,__zero_reg__
	sts Tacho_RPM+1,__zero_reg__
	sts Tacho_RPM,__zero_reg__
	ldi r22,lo8(gs(TACHO_PulseISR))
	ldi r23,hi8(gs(TACHO_PulseISR))
	ldi r25,0
	ldi r24,0
	call EXTI_SetCallBack
	ldi r25,0
	ldi r24,0
	jmp EXTI_Enable
	.size	TACHO_Init, .-TACHO_Init
.global	TACHO_Update
	.type	TACHO_Update, @function
TACHO_Update:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* #APP */
 ;  28 "HAL/Tachometer/Tachometer.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r18,Tacho_PulseCount
	lds r19,Tacho_PulseCount+1
	sts Tacho_PulseCount+1,__zero_reg__
	sts Tacho_PulseCount,__zero_reg__
/* #APP */
 ;  31 "HAL/Tachometer/Tachometer.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ldi r20,lo8(60)
	mul r20,r18
	movw r24,r0
	mul r20,r19
	add r25,r0
	clr __zero_reg__
	sts Tacho_RPM+1,r25
	sts Tacho_RPM,r24
/* epilogue start */
	ret
	.size	TACHO_Update, .-TACHO_Update
.global	TACHO_GetRPM
	.type	TACHO_GetRPM, @function
TACHO_GetRPM:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Tacho_RPM
	lds r25,Tacho_RPM+1
/* epilogue start */
	ret
	.size	TACHO_GetRPM, .-TACHO_GetRPM
	.local	Tacho_RPM
	.comm	Tacho_RPM,2,1
	.local	Tacho_PulseCount
	.comm	Tacho_PulseCount,2,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_clear_bss
