; AL15-RELOCATABLE PRINT 2

		org $300

PTR 	equ $06
COUT 	equ $FDED
RTRN 	equ $FF58
STCK 	equ $100
 
ENTRY 	jsr RTRN
		clv
		bvc CONT

DATA 	asc "TEST"

		hex 8D00

CONT 	tsx
		dex
		clc
		lda STCK,X
		adc #$04
		sta PTR
		inx
		lda STCK,X
		adc #$00
STA 	PTR+1

PRNT 	ldy #$00
LOOP 	lda (PTR),Y
		beq FIN
		jsr COUT
		iny
		bne LOOP ; ALWAYS UNTIL 255

FIN 	rts
		chk