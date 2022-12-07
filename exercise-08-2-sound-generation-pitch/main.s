; Chapter 7 Exercise 2
; Sound Routine - pitch
				org $300
PITCH			equ	$06
SPKR			equ $C030
;
Entry			ldy PITCH
				lda SPKR
Loop			dey
				bne Loop
				jmp Entry
;		infinite loop
chk

