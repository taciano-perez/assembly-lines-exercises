; Chapter 16 Exercise 2
;
		org $300
;
PITCH 		equ $06
DURATION 	equ $07
SPKR 		equ $C030
;
COMBYTE 	equ $E74C
;
Entry 		jsr COMBYTE
			stx PITCH
			jsr COMBYTE
			stx DURATION
;
Begin 		ldx DURATION
Loop 		ldy PITCH
			lda SPKR
Delay 		dey
			bne Delay
Drtn 		dex
			bne Loop
Exit 		rts