	.file	"ANALOG_SENSOR.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	ANALOG_Init
	.type	ANALOG_Init, @function
ANALOG_Init:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	movw r24,r28
	adiw r24,1
	call ADC_Init
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	ANALOG_Init, .-ANALOG_Init
.global	ANALOG_GetSetpoint
	.type	ANALOG_GetSetpoint, @function
ANALOG_GetSetpoint:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,0
	call ADC_ReadChannelBlocking
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(-72)
	ldi r27,lo8(11)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	ANALOG_GetSetpoint, .-ANALOG_GetSetpoint
.global	ANALOG_GetCurrent
	.type	ANALOG_GetCurrent, @function
ANALOG_GetCurrent:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(1)
	call ADC_ReadChannelBlocking
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(32)
	ldi r27,lo8(78)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	ANALOG_GetCurrent, .-ANALOG_GetCurrent
.global	ANALOG_GetBusVoltage
	.type	ANALOG_GetBusVoltage, @function
ANALOG_GetBusVoltage:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(2)
	call ADC_ReadChannelBlocking
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(96)
	ldi r27,lo8(-22)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	ANALOG_GetBusVoltage, .-ANALOG_GetBusVoltage
.global	ANALOG_GetTemperature
	.type	ANALOG_GetTemperature, @function
ANALOG_GetTemperature:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(3)
	call ADC_ReadChannelBlocking
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(-106)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	mov r24,r18
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	ANALOG_GetTemperature, .-ANALOG_GetTemperature
	.ident	"GCC: (GNU) 7.3.0"
