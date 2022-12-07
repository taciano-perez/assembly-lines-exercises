; AL15-RELOCATABLE JSR SIMULATION

		org $300

PTR		equ $06
BELL 	equ $FF3A
RTRN	equ $FF58
STCK	equ $100
 
ENTRY 	jsr RTRN
		clv
		bvc TEST

DONE 	rts

TEST 	tsx
		dex
		clc
		lda STCK,X
		adc #$03
		sta PTR
		inx
		lda STCK,X
		adc #$00
		sta PTR+1

EXPT 	jsr BELL

FIX		lda PTR+1
		pha
		lda PTR
		pha
FIN 	rts			; returns to DONE