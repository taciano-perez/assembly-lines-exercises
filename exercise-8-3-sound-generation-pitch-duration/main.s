; Chapter 7 Exercise 3
; Sound Routine - pitch and duration
				org $300
PITCH			equ	$06
DURATION		equ $07
SPKR			equ $C030
;
Entry			ldx DURATION
Loop			ldy PITCH
				lda SPKR
Delay			dey
				bne Delay
Duration		dex
				bne Loop
Exit			rts
;		infinite loop
chk

