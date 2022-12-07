; AL15-RELOCATABLE JMP 2
		org $300
BELL 	equ $FF3A
ENTRY 	clv
		bvc STEP
;
FILL1 	nop
;
STEP 	bvc EXPT
;
FILL2 	nop
EXPT 	jsr BELL
DONE 	rts
