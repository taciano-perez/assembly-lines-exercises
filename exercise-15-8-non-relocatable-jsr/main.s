; AL15-NON-RELOCATABLE JSR DEMO

		org $300

BELL 	equ $FF3A
 
ENTRY 	jsr TEST

DONE 	rts

TEST 	nop

EXPT 	jsr BELL
FIN 	rts			; returns to DONE