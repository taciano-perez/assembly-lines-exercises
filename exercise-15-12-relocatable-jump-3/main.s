; AL15-RELOCATABLE JUMP 3

		org $300

PTR		equ $06
BELL 	equ $FF3A
RTRN	equ $FF58
STCK	equ $100
 
ENTRY 	jsr RTRN

PRINT 	tsx
		dex
		clc
		lda STCK,X
		adc #$17
		sta PTR
		inx
		lda STCK,X
		adc #$00
		sta PTR+1
		jmp (PTR)	; to EXPT

FILL	nop

EXPT	jsr BELL

DONE	rts