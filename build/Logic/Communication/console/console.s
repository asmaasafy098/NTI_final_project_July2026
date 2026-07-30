	.file	"console.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	CONSOLE_IsNumber, @function
CONSOLE_IsNumber:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L7
	movw r30,r24
	ld r18,Z
	tst r18
	breq .L7
.L3:
	ld r24,Z+
	cpse r24,__zero_reg__
	rjmp .L4
	ldi r24,lo8(1)
	ret
.L4:
	subi r24,lo8(-(-48))
	cpi r24,lo8(10)
	brlo .L3
.L7:
	ldi r24,0
/* epilogue start */
	ret
	.size	CONSOLE_IsNumber, .-CONSOLE_IsNumber
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\r\n"
.LC1:
	.string	"\r\n> "
	.text
.global	CONSOLE_ProcessChar
	.type	CONSOLE_ProcessChar, @function
CONSOLE_ProcessChar:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	lds r24,g_console+66
	tst r24
	breq .L9
	mov r24,r28
	ldi r25,0
	call USART_TransmitByte
.L9:
	lds r30,g_console+64
	cpi r28,lo8(8)
	breq .L10
	cpi r28,lo8(127)
	brne .L11
.L10:
	tst r30
	breq .L8
	subi r30,lo8(-(-1))
	sts g_console+64,r30
	ldi r31,0
	subi r30,lo8(-(g_console))
	sbci r31,hi8(-(g_console))
	st Z,__zero_reg__
	ldi r24,lo8(32)
	ldi r25,0
	call USART_TransmitByte
	ldi r24,lo8(8)
	ldi r25,0
/* epilogue start */
	pop r28
	jmp USART_TransmitByte
.L11:
	cpi r28,lo8(13)
	breq .L13
	cpi r28,lo8(10)
	brne .L14
.L13:
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	tst r30
	breq .L28
	ldi r31,0
	subi r30,lo8(-(g_console))
	sbci r31,hi8(-(g_console))
	st Z,__zero_reg__
	ldi r24,lo8(1)
	sts g_console+65,r24
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
.L28:
/* epilogue start */
	pop r28
	jmp USART_TransmitString
.L14:
	cpi r30,lo8(63)
	brsh .L8
	ldi r24,lo8(1)
	add r24,r30
	sts g_console+64,r24
	ldi r31,0
	subi r30,lo8(-(g_console))
	sbci r31,hi8(-(g_console))
	st Z,r28
.L8:
/* epilogue start */
	pop r28
	ret
	.size	CONSOLE_ProcessChar, .-CONSOLE_ProcessChar
.global	CONSOLE_SendResponse
	.type	CONSOLE_SendResponse, @function
CONSOLE_SendResponse:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call USART_TransmitString
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	jmp USART_TransmitString
	.size	CONSOLE_SendResponse, .-CONSOLE_SendResponse
	.section	.rodata.str1.1
.LC2:
	.string	"\r\nIndustrial Motor Controller v1.0"
.LC3:
	.string	"\r\nType HELP for commands\r\n> "
	.text
.global	CONSOLE_Init
	.type	CONSOLE_Init, @function
CONSOLE_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_console+64,__zero_reg__
	sts g_console+65,__zero_reg__
	ldi r24,lo8(1)
	sts g_console+66,r24
	ldi r30,lo8(g_console)
	ldi r31,hi8(g_console)
	ldi r24,lo8(64)
	movw r26,r30
	0:
	st X+,__zero_reg__
	dec r24
	brne 0b
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	jmp CONSOLE_SendResponse
	.size	CONSOLE_Init, .-CONSOLE_Init
	.section	.rodata.str1.1
.LC4:
	.string	"ERROR: "
	.text
.global	CONSOLE_SendError
	.type	CONSOLE_SendError, @function
CONSOLE_SendError:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call USART_TransmitString
	movw r24,r28
	call USART_TransmitString
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
/* epilogue start */
	pop r29
	pop r28
	jmp USART_TransmitString
	.size	CONSOLE_SendError, .-CONSOLE_SendError
	.section	.rodata.str1.1
.LC5:
	.string	"$MD,SP=%d,RP=%d,D=%d,I=%d,V=%d,T=%d,DIR=%c,ST=%s,TR=%d,I2T=%d,RH=%lu,SC=%d"
.LC6:
	.string	"*%02X\r\n"
	.text
.global	CONSOLE_SendTelemetry
	.type	CONSOLE_SendTelemetry, @function
CONSOLE_SendTelemetry:
	push r7
	push r8
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
	in r28,__SP_L__
	in r29,__SP_H__
	subi r28,-128
	sbc r29,__zero_reg__
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 128 */
/* stack size = 141 */
.L__stack_usage = 141
	movw r16,r24
	movw r30,r24
	ldd r8,Z+35
	ldd r7,Z+36
	ldd r12,Z+31
	ldd r11,Z+32
	ldd r10,Z+33
	ldd r9,Z+34
	call PROTECT_GetI2TPercent
	mov r13,r24
	movw r30,r16
	ldd r15,Z+24
	ldd r14,Z+25
	call FSM_GetStateString
	movw r30,r16
	ldd r18,Z+20
	ldd r19,Z+21
	cpi r18,1
	cpc r19,__zero_reg__
	brne .+2
	rjmp .L36
	cpi r18,2
	cpc r19,__zero_reg__
	brne .+2
	rjmp .L37
	ldi r18,lo8(45)
.L33:
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push __zero_reg__
	push r13
	push r14
	push r15
	push r25
	push r24
	push __zero_reg__
	push r18
	movw r30,r16
	ldd r24,Z+15
	push __zero_reg__
	push r24
	ldd r24,Z+14
	push r24
	ldd r24,Z+13
	push r24
	ldd r24,Z+12
	push r24
	ldd r24,Z+11
	push r24
	ldd r24,Z+10
	push __zero_reg__
	push r24
	ldd r24,Z+5
	push r24
	ldd r24,Z+4
	push r24
	ldd r24,Z+3
	push r24
	ldd r24,Z+2
	push r24
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	ldi r24,lo8(1)
	ldi r18,0
.L34:
	movw r30,r16
	add r30,r24
	adc r31,__zero_reg__
	ld r25,Z
	cpse r25,__zero_reg__
	rjmp .L35
	movw r30,r16
	0:
	ld __tmp_reg__,Z+
	tst __tmp_reg__
	brne 0b
	movw r24,r30
	push __zero_reg__
	push r18
	ldi r18,lo8(.LC6)
	ldi r19,hi8(.LC6)
	push r19
	push r18
	sbiw r24,1
	push r25
	push r24
	call sprintf
	movw r24,r16
	call USART_TransmitString
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
/* epilogue start */
	subi r28,-128
	sbci r29,-1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
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
	pop r8
	pop r7
	ret
.L36:
	ldi r18,lo8(70)
	rjmp .L33
.L37:
	ldi r18,lo8(82)
	rjmp .L33
.L35:
	eor r18,r25
	subi r24,lo8(-(1))
	rjmp .L34
	.size	CONSOLE_SendTelemetry, .-CONSOLE_SendTelemetry
	.section	.rodata.str1.1
.LC7:
	.string	"!EVT,"
	.text
.global	CONSOLE_SendEvent
	.type	CONSOLE_SendEvent, @function
CONSOLE_SendEvent:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call USART_TransmitString
	movw r24,r28
	call USART_TransmitString
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
/* epilogue start */
	pop r29
	pop r28
	jmp USART_TransmitString
	.size	CONSOLE_SendEvent, .-CONSOLE_SendEvent
	.section	.rodata.str1.1
.LC8:
	.string	"\r\n=== Available Commands ==="
.LC9:
	.string	"STATUS        - Show telemetry"
.LC10:
	.string	"RUN           - Start motor (remote only)"
.LC11:
	.string	"STOP          - Stop motor"
.LC12:
	.string	"REV           - Reverse direction (remote only)"
.LC13:
	.string	"SPEED <n>     - Set speed (0-maxRpm)"
.LC14:
	.string	"SPEED?        - Show current speed"
.LC15:
	.string	"DIR?          - Show direction"
.LC16:
	.string	"CFG?          - Show configuration"
.LC17:
	.string	"SET <param> <value> - Set parameter"
.LC18:
	.string	"ACK           - Acknowledge trip"
.LC19:
	.string	"TRIP?         - Show active trip"
.LC20:
	.string	"TRIPS?        - Show trip log"
.LC21:
	.string	"HOURS?        - Show run hours"
.LC22:
	.string	"TUNE?         - Show PI internals"
.LC23:
	.string	"SAVE          - Save config to EEPROM"
.LC24:
	.string	"HELP          - Show this menu"
.LC25:
	.string	""
	.text
.global	CONSOLE_SendHelp
	.type	CONSOLE_SendHelp, @function
CONSOLE_SendHelp:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC10)
	ldi r25,hi8(.LC10)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC11)
	ldi r25,hi8(.LC11)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC12)
	ldi r25,hi8(.LC12)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC13)
	ldi r25,hi8(.LC13)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC14)
	ldi r25,hi8(.LC14)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC15)
	ldi r25,hi8(.LC15)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC16)
	ldi r25,hi8(.LC16)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC17)
	ldi r25,hi8(.LC17)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC19)
	ldi r25,hi8(.LC19)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC20)
	ldi r25,hi8(.LC20)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC21)
	ldi r25,hi8(.LC21)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC22)
	ldi r25,hi8(.LC22)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC23)
	ldi r25,hi8(.LC23)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC24)
	ldi r25,hi8(.LC24)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC25)
	ldi r25,hi8(.LC25)
	jmp CONSOLE_SendResponse
	.size	CONSOLE_SendHelp, .-CONSOLE_SendHelp
	.section	.rodata.str1.1
.LC26:
	.string	" \t\r\n"
.LC27:
	.string	"STATUS"
.LC28:
	.string	"RUN"
.LC29:
	.string	"ERR MODE"
.LC30:
	.string	"ERR TRIPPED"
.LC31:
	.string	"OK"
.LC32:
	.string	"START,REMOTE"
.LC33:
	.string	"ERR START"
.LC34:
	.string	"STOP"
.LC35:
	.string	"STOP,REMOTE"
.LC36:
	.string	"ERR STOP"
.LC37:
	.string	"REV"
.LC38:
	.string	"REVERSE,REMOTE"
.LC39:
	.string	"ERR REV"
.LC40:
	.string	"SPEED"
.LC41:
	.string	"?"
.LC42:
	.string	"SPEED=%d,%d"
.LC43:
	.string	"ERR ARGS"
.LC44:
	.string	"ERR RANGE"
.LC45:
	.string	"DIR?"
.LC46:
	.string	"DIR=%c"
.LC47:
	.string	"CFG?"
.LC48:
	.string	"CFG=%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d"
.LC49:
	.string	"SET"
.LC50:
	.string	"MAXRPM"
.LC51:
	.string	"MINRPM"
.LC52:
	.string	"ACCEL"
.LC53:
	.string	"DECEL"
.LC54:
	.string	"DEADTIME"
.LC55:
	.string	"KP"
.LC56:
	.string	"KI"
.LC57:
	.string	"RATED"
.LC58:
	.string	"SHORT"
.LC59:
	.string	"OVERTEMP"
.LC60:
	.string	"ERR PARAM"
.LC61:
	.string	"ACK"
.LC62:
	.string	"ACK,OK"
.LC63:
	.string	"ERR ACTIVE"
.LC64:
	.string	"ACK,REFUSED,ACTIVE"
.LC65:
	.string	"TRIP?"
.LC66:
	.string	"TRIP=%d,%s"
.LC67:
	.string	"TRIPS?"
.LC68:
	.string	"=== Trip Log ==="
.LC69:
	.string	"TRP,0,NONE"
.LC70:
	.string	"=== End ==="
.LC71:
	.string	"HOURS?"
.LC72:
	.string	"HOURS=%02lu:%02lu,SC=%d"
.LC73:
	.string	"TUNE?"
.LC74:
	.string	"TUNE=%d,%d,%ld,%d"
.LC75:
	.string	"SAVE"
.LC76:
	.string	"SAVE,OK"
.LC77:
	.string	"HELP"
.LC78:
	.string	"ERR CMD"
.LC79:
	.string	"> "
	.text
.global	CONSOLE_ExecuteCommand
	.type	CONSOLE_ExecuteCommand, @function
CONSOLE_ExecuteCommand:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	subi r28,-128
	sbc r29,__zero_reg__
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 128 */
/* stack size = 134 */
.L__stack_usage = 134
	lds r24,g_console+65
	tst r24
	breq .L40
	sts g_argc,__zero_reg__
	ldi r22,lo8(.LC26)
	ldi r23,hi8(.LC26)
	ldi r24,lo8(g_console)
	ldi r25,hi8(g_console)
.L105:
	call strtok
	lds r15,g_argc
	sbiw r24,0
	breq .L43
	ldi r18,lo8(7)
	cp r18,r15
	brsh .L44
.L43:
	sts g_console+65,__zero_reg__
	sts g_console+64,__zero_reg__
	ldi r30,lo8(g_console)
	ldi r31,hi8(g_console)
	ldi r24,lo8(64)
	movw r26,r30
	0:
	st X+,__zero_reg__
	dec r24
	brne 0b
	tst r15
	breq .L45
	lds r16,g_argv
	lds r17,g_argv+1
	ldi r22,lo8(.LC27)
	ldi r23,hi8(.LC27)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L46
	ldi r24,lo8(g_driveData)
	ldi r25,hi8(g_driveData)
	call CONSOLE_SendTelemetry
.L45:
	ldi r24,lo8(.LC79)
	ldi r25,hi8(.LC79)
	call USART_TransmitString
.L40:
/* epilogue start */
	subi r28,-128
	sbci r29,-1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L44:
	ldi r18,lo8(1)
	add r18,r15
	sts g_argc,r18
	mov r30,r15
	ldi r31,0
	lsl r30
	rol r31
	subi r30,lo8(-(g_argv))
	sbci r31,hi8(-(g_argv))
	std Z+1,r25
	st Z,r24
	ldi r22,lo8(.LC26)
	ldi r23,hi8(.LC26)
	ldi r25,0
	ldi r24,0
	rjmp .L105
.L46:
	ldi r22,lo8(.LC28)
	ldi r23,hi8(.LC28)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L47
	lds r24,g_driveData+26
	sbrc r24,0
	rjmp .L48
.L54:
	ldi r24,lo8(.LC29)
	ldi r25,hi8(.LC29)
.L107:
	call CONSOLE_SendError
	rjmp .L45
.L48:
	call FSM_IsTripped
	tst r24
	breq .L49
	ldi r24,lo8(.LC30)
	ldi r25,hi8(.LC30)
	rjmp .L107
.L49:
	call FSM_RequestStart
	tst r24
	breq .L50
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC32)
	ldi r25,hi8(.LC32)
.L111:
	call CONSOLE_SendEvent
	rjmp .L45
.L50:
	ldi r24,lo8(.LC33)
	ldi r25,hi8(.LC33)
	rjmp .L107
.L47:
	ldi r22,lo8(.LC34)
	ldi r23,hi8(.LC34)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L51
	call FSM_RequestStop
	tst r24
	breq .L52
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC35)
	ldi r25,hi8(.LC35)
	rjmp .L111
.L52:
	ldi r24,lo8(.LC36)
	ldi r25,hi8(.LC36)
	rjmp .L107
.L51:
	ldi r22,lo8(.LC37)
	ldi r23,hi8(.LC37)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L53
	lds r24,g_driveData+26
	sbrs r24,0
	rjmp .L54
	call FSM_RequestReverse
	tst r24
	breq .L55
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC38)
	ldi r25,hi8(.LC38)
	rjmp .L111
.L55:
	ldi r24,lo8(.LC39)
	ldi r25,hi8(.LC39)
	rjmp .L107
.L53:
	ldi r22,lo8(.LC40)
	ldi r23,hi8(.LC40)
	movw r24,r16
	call strcmp
	or r24,r25
	breq .+2
	rjmp .L56
	ldi r27,lo8(1)
	cp r27,r15
	brsh .L57
	ldi r22,lo8(.LC41)
	ldi r23,hi8(.LC41)
	lds r24,g_argv+2
	lds r25,g_argv+2+1
	call strcmp
	or r24,r25
	brne .L57
	lds r24,g_driveData+5
	push r24
	lds r24,g_driveData+4
	push r24
	lds r24,g_driveData+3
	push r24
	lds r24,g_driveData+2
	push r24
	ldi r24,lo8(.LC42)
	ldi r25,hi8(.LC42)
.L112:
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	rjmp .L116
.L57:
	lds r24,g_driveData+26
	sbrs r24,0
	rjmp .L54
	ldi r25,lo8(1)
	cp r25,r15
	brlo .L58
.L65:
	ldi r24,lo8(.LC43)
	ldi r25,hi8(.LC43)
	rjmp .L107
.L58:
	lds r16,g_argv+2
	lds r17,g_argv+2+1
	movw r24,r16
	call CONSOLE_IsNumber
	cpse r24,__zero_reg__
	rjmp .L59
.L60:
	ldi r24,lo8(.LC44)
	ldi r25,hi8(.LC44)
	rjmp .L107
.L59:
	movw r24,r16
	call atoi
	sbrc r25,7
	rjmp .L60
	lds r18,g_driveCfg+3
	lds r19,g_driveCfg+3+1
	cp r18,r24
	cpc r19,r25
	brlo .L60
	sts g_driveData+1,r25
	sts g_driveData,r24
	movw r22,r24
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_SetTarget
.L109:
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
.L113:
	call CONSOLE_SendResponse
	rjmp .L45
.L56:
	ldi r22,lo8(.LC45)
	ldi r23,hi8(.LC45)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L61
	lds r24,g_driveData+20
	lds r25,g_driveData+20+1
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L85
	sbiw r24,2
	brne .L86
	ldi r24,lo8(82)
.L62:
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC46)
	ldi r25,hi8(.LC46)
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	movw r24,r16
	call CONSOLE_SendResponse
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	rjmp .L45
.L85:
	ldi r24,lo8(70)
	rjmp .L62
.L86:
	ldi r24,lo8(45)
	rjmp .L62
.L61:
	ldi r22,lo8(.LC47)
	ldi r23,hi8(.LC47)
	movw r24,r16
	call strcmp
	or r24,r25
	breq .+2
	rjmp .L63
	lds r24,g_driveCfg+25
	push r24
	lds r24,g_driveCfg+24
	push r24
	lds r24,g_driveCfg+23
	push r24
	lds r24,g_driveCfg+22
	push r24
	lds r24,g_driveCfg+21
	push __zero_reg__
	push r24
	lds r24,g_driveCfg+20
	push r24
	lds r24,g_driveCfg+19
	push r24
	lds r24,g_driveCfg+18
	push r24
	lds r24,g_driveCfg+17
	push r24
	lds r24,g_driveCfg+16
	push r24
	lds r24,g_driveCfg+15
	push r24
	lds r24,g_driveCfg+14
	push r24
	lds r24,g_driveCfg+13
	push r24
	lds r24,g_driveCfg+12
	push r24
	lds r24,g_driveCfg+11
	push r24
	lds r24,g_driveCfg+10
	push r24
	lds r24,g_driveCfg+9
	push r24
	lds r24,g_driveCfg+8
	push r24
	lds r24,g_driveCfg+7
	push r24
	lds r24,g_driveCfg+6
	push r24
	lds r24,g_driveCfg+5
	push r24
	lds r24,g_driveCfg+4
	push r24
	lds r24,g_driveCfg+3
	push r24
	ldi r24,lo8(.LC48)
	ldi r25,hi8(.LC48)
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
.L116:
	movw r24,r16
	call CONSOLE_SendResponse
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	rjmp .L45
.L63:
	ldi r22,lo8(.LC49)
	ldi r23,hi8(.LC49)
	movw r24,r16
	call strcmp
	or r24,r25
	breq .+2
	rjmp .L64
	ldi r27,lo8(2)
	cp r27,r15
	brlo .+2
	rjmp .L65
	lds r16,g_argv+4
	lds r17,g_argv+4+1
	movw r24,r16
	call CONSOLE_IsNumber
	tst r24
	brne .+2
	rjmp .L60
	lds r14,g_argv+2
	lds r15,g_argv+2+1
	movw r24,r16
	call atoi
	movw r16,r24
	ldi r22,lo8(.LC50)
	ldi r23,hi8(.LC50)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L66
	movw r24,r16
	subi r24,-12
	sbci r25,1
	cpi r24,125
	sbci r25,21
	brlo .+2
	rjmp .L60
	sts g_driveCfg+3+1,r17
	sts g_driveCfg+3,r16
	rjmp .L109
.L66:
	ldi r22,lo8(.LC51)
	ldi r23,hi8(.LC51)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L67
	movw r24,r16
	sbiw r24,50
	cpi r24,-73
	sbci r25,3
	brlo .+2
	rjmp .L60
	sts g_driveCfg+5+1,r17
	sts g_driveCfg+5,r16
	rjmp .L109
.L67:
	ldi r22,lo8(.LC52)
	ldi r23,hi8(.LC52)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L68
	movw r24,r16
	subi r24,100
	sbc r25,__zero_reg__
	cpi r24,85
	sbci r25,11
	brlo .+2
	rjmp .L60
	sts g_driveCfg+7+1,r17
	sts g_driveCfg+7,r16
	lds r20,g_driveCfg+9
	lds r21,g_driveCfg+9+1
	movw r22,r16
.L114:
	ldi r24,lo8(g_ramp)
	ldi r25,hi8(g_ramp)
	call RAMP_SetRates
	rjmp .L109
.L68:
	ldi r22,lo8(.LC53)
	ldi r23,hi8(.LC53)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L69
	movw r24,r16
	subi r24,100
	sbc r25,__zero_reg__
	cpi r24,85
	sbci r25,11
	brlo .+2
	rjmp .L60
	sts g_driveCfg+9+1,r17
	sts g_driveCfg+9,r16
	lds r22,g_driveCfg+7
	lds r23,g_driveCfg+7+1
	movw r20,r16
	rjmp .L114
.L69:
	ldi r22,lo8(.LC54)
	ldi r23,hi8(.LC54)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L70
	movw r24,r16
	subi r24,-56
	sbc r25,__zero_reg__
	cpi r24,9
	sbci r25,7
	brlo .+2
	rjmp .L60
	sts g_driveCfg+11+1,r17
	sts g_driveCfg+11,r16
	movw r22,r16
	lsl r17
	sbc r24,r24
	sbc r25,r25
	call FSM_SetDeadTime
	rjmp .L109
.L70:
	ldi r22,lo8(.LC55)
	ldi r23,hi8(.LC55)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L71
	cpi r16,1
	ldi r27,16
	cpc r17,r27
	brlo .+2
	rjmp .L60
	sts g_driveCfg+13+1,r17
	sts g_driveCfg+13,r16
	lds r20,g_driveCfg+15
	lds r21,g_driveCfg+15+1
	movw r22,r16
.L115:
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_SetGains
	rjmp .L109
.L71:
	ldi r22,lo8(.LC56)
	ldi r23,hi8(.LC56)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L72
	cpi r16,1
	ldi r18,2
	cpc r17,r18
	brlo .+2
	rjmp .L60
	sts g_driveCfg+15+1,r17
	sts g_driveCfg+15,r16
	lds r22,g_driveCfg+13
	lds r23,g_driveCfg+13+1
	movw r20,r16
	rjmp .L115
.L72:
	ldi r22,lo8(.LC57)
	ldi r23,hi8(.LC57)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L73
	movw r24,r16
	subi r24,-24
	sbci r25,3
	cpi r24,-79
	sbci r25,54
	brlo .+2
	rjmp .L60
	sts g_driveCfg+17+1,r17
	sts g_driveCfg+17,r16
	rjmp .L109
.L73:
	ldi r22,lo8(.LC58)
	ldi r23,hi8(.LC58)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L74
	lds r24,g_driveCfg+17
	lds r25,g_driveCfg+17+1
	cp r24,r16
	cpc r25,r17
	brlo .+2
	rjmp .L60
	sts g_driveCfg+19+1,r17
	sts g_driveCfg+19,r16
	rjmp .L109
.L74:
	ldi r22,lo8(.LC59)
	ldi r23,hi8(.LC59)
	movw r24,r14
	call strcmp
	or r24,r25
	brne .L75
	movw r24,r16
	sbiw r24,60
	cpi r24,81
	cpc r25,__zero_reg__
	brlo .+2
	rjmp .L60
	sts g_driveCfg+21,r16
	rjmp .L109
.L75:
	ldi r24,lo8(.LC60)
	ldi r25,hi8(.LC60)
	rjmp .L107
.L64:
	ldi r22,lo8(.LC61)
	ldi r23,hi8(.LC61)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L76
	call FSM_RequestReset
	tst r24
	breq .L77
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC62)
	ldi r25,hi8(.LC62)
	rjmp .L111
.L77:
	ldi r24,lo8(.LC63)
	ldi r25,hi8(.LC63)
	call CONSOLE_SendError
	ldi r24,lo8(.LC64)
	ldi r25,hi8(.LC64)
	rjmp .L111
.L76:
	ldi r22,lo8(.LC65)
	ldi r23,hi8(.LC65)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L78
	call PROTECT_GetActiveTrip
	movw r16,r24
	or r24,r25
	brne .L79
	call PROTECT_GetLatchedTrip
	movw r16,r24
.L79:
	movw r24,r16
	call PROTECT_GetTripString
	push r25
	push r24
	push r17
	push r16
	ldi r24,lo8(.LC66)
	ldi r25,hi8(.LC66)
	rjmp .L112
.L78:
	ldi r22,lo8(.LC67)
	ldi r23,hi8(.LC67)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L80
	ldi r24,lo8(.LC68)
	ldi r25,hi8(.LC68)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC69)
	ldi r25,hi8(.LC69)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC70)
	ldi r25,hi8(.LC70)
	rjmp .L113
.L80:
	ldi r22,lo8(.LC71)
	ldi r23,hi8(.LC71)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L81
	lds r22,g_driveData+31
	lds r23,g_driveData+31+1
	lds r24,g_driveData+31+2
	lds r25,g_driveData+31+3
	lds r18,g_driveData+36
	push r18
	lds r18,g_driveData+35
	push r18
	ldi r18,lo8(16)
	ldi r19,lo8(14)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	mov r17,r18
	mov r16,r19
	mov r15,r20
	mov r14,r21
	ldi r18,lo8(60)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	push r21
	push r20
	push r19
	push r18
	push r14
	push r15
	push r16
	push r17
	ldi r24,lo8(.LC72)
	ldi r25,hi8(.LC72)
.L117:
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	rjmp .L116
.L81:
	ldi r22,lo8(.LC73)
	ldi r23,hi8(.LC73)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L82
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_GetError
	mov r17,r24
	mov r16,r25
	ldi r24,lo8(g_pi)
	ldi r25,hi8(g_pi)
	call PI_GetIntegral
	push r16
	push r17
	push r25
	push r24
	push r23
	push r22
	lds r24,g_driveCfg+16
	push r24
	lds r24,g_driveCfg+15
	push r24
	lds r24,g_driveCfg+14
	push r24
	lds r24,g_driveCfg+13
	push r24
	ldi r24,lo8(.LC74)
	ldi r25,hi8(.LC74)
	rjmp .L117
.L82:
	ldi r22,lo8(.LC75)
	ldi r23,hi8(.LC75)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L83
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
	call CONSOLE_SendResponse
	ldi r24,lo8(.LC76)
	ldi r25,hi8(.LC76)
	rjmp .L111
.L83:
	ldi r22,lo8(.LC77)
	ldi r23,hi8(.LC77)
	movw r24,r16
	call strcmp
	or r24,r25
	brne .L84
	call CONSOLE_SendHelp
	rjmp .L45
.L84:
	ldi r24,lo8(.LC78)
	ldi r25,hi8(.LC78)
	rjmp .L107
	.size	CONSOLE_ExecuteCommand, .-CONSOLE_ExecuteCommand
.global	CONSOLE_IsCommandReady
	.type	CONSOLE_IsCommandReady, @function
CONSOLE_IsCommandReady:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_console+65
/* epilogue start */
	ret
	.size	CONSOLE_IsCommandReady, .-CONSOLE_IsCommandReady
.global	CONSOLE_GetCommand
	.type	CONSOLE_GetCommand, @function
CONSOLE_GetCommand:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(g_console)
	ldi r25,hi8(g_console)
/* epilogue start */
	ret
	.size	CONSOLE_GetCommand, .-CONSOLE_GetCommand
.global	CONSOLE_ClearCommand
	.type	CONSOLE_ClearCommand, @function
CONSOLE_ClearCommand:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_console+65,__zero_reg__
	sts g_console+64,__zero_reg__
	ldi r30,lo8(g_console)
	ldi r31,hi8(g_console)
	ldi r24,lo8(64)
	movw r26,r30
	0:
	st X+,__zero_reg__
	dec r24
	brne 0b
/* epilogue start */
	ret
	.size	CONSOLE_ClearCommand, .-CONSOLE_ClearCommand
	.local	g_argc
	.comm	g_argc,1,1
	.local	g_argv
	.comm	g_argv,16,1
	.local	g_console
	.comm	g_console,67,1
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
