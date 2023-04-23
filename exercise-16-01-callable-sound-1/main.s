; Chapter 16 Exercise 1
;
			org $300
;
PITCH 		equ $06
DURATION 	equ $07
SPKR 		equ $C030
;
Entry 		ldx Duration
Loop 		ldy PITCH
			lda SPKR
Delay 		dey
			bne Delay
Duration 	dex
			bne Loop
Exit 		rts