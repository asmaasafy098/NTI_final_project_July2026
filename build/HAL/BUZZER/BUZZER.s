	.file	"BUZZER.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	BUZZER_Init
	.type	BUZZER_Init, @function
BUZZER_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Buzzer_CurrentMode+1,__zero_reg__
	sts Buzzer_CurrentMode,__zero_reg__
	sts Buzzer_TickCounter+1,__zero_reg__
	sts Buzzer_TickCounter,__zero_reg__
	jmp Timer2_Init
	.size	BUZZER_Init, .-BUZZER_Init
.global	BUZZER_SetMode
	.type	BUZZER_SetMode, @function
BUZZER_SetMode:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Buzzer_CurrentMode+1,r25
	sts Buzzer_CurrentMode,r24
	sts Buzzer_TickCounter+1,__zero_reg__
	sts Buzzer_TickCounter,__zero_reg__
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L4
	brlo .L5
	sbiw r24,4
	brlo .L7
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L5:
	ldi r25,0
	ldi r24,0
.L8:
	jmp Timer2_SetTone
.L4:
	ldi r24,lo8(-106)
	ldi r25,0
	rjmp .L8
.L7:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L8
	.size	BUZZER_SetMode, .-BUZZER_SetMode
.global	BUZZER_Update
	.type	BUZZER_Update, @function
BUZZER_Update:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Buzzer_CurrentMode
	lds r25,Buzzer_CurrentMode+1
	sbiw r24,0
	breq .L9
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L9
	ldi r20,lo8(10)
	ldi r21,0
	cpi r24,1
	cpc r25,__zero_reg__
	brne .L13
	ldi r20,lo8(50)
	ldi r21,0
.L13:
	lds r18,Buzzer_TickCounter
	lds r19,Buzzer_TickCounter+1
	subi r18,-1
	sbci r19,-1
	cp r18,r20
	cpc r19,r21
	brsh .L14
	sts Buzzer_TickCounter+1,r19
	sts Buzzer_TickCounter,r18
	ret
.L14:
	sts Buzzer_TickCounter+1,__zero_reg__
	sts Buzzer_TickCounter,__zero_reg__
<<<<<<< HEAD
	lds r18,soundOn.1487
=======
	lds r18,soundOn.1485
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	tst r18
	breq .L15
	ldi r25,0
	ldi r24,0
.L17:
	call Timer2_SetTone
	ldi r24,lo8(1)
<<<<<<< HEAD
	lds r25,soundOn.1487
	cpse r25,__zero_reg__
	ldi r24,0
.L18:
	sts soundOn.1487,r24
=======
	lds r25,soundOn.1485
	cpse r25,__zero_reg__
	ldi r24,0
.L18:
	sts soundOn.1485,r24
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
.L9:
/* epilogue start */
	ret
.L15:
	sbiw r24,1
	breq .L20
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L17
.L20:
	ldi r24,lo8(-106)
	ldi r25,0
	rjmp .L17
	.size	BUZZER_Update, .-BUZZER_Update
	.data
<<<<<<< HEAD
	.type	soundOn.1487, @object
	.size	soundOn.1487, 1
soundOn.1487:
=======
	.type	soundOn.1485, @object
	.size	soundOn.1485, 1
soundOn.1485:
>>>>>>> d5517793cc5f97094d7b5f65a675596bffebcd3f
	.byte	1
.global	Buzzer_TickCounter
	.section .bss
	.type	Buzzer_TickCounter, @object
	.size	Buzzer_TickCounter, 2
Buzzer_TickCounter:
	.zero	2
.global	Buzzer_CurrentMode
	.type	Buzzer_CurrentMode, @object
	.size	Buzzer_CurrentMode, 2
Buzzer_CurrentMode:
	.zero	2
	.ident	"GCC: (GNU) 7.3.0"
.global __do_copy_data
.global __do_clear_bss
