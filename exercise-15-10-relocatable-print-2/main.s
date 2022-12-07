; AL15-RELOCATABLE PRINT 2

		org $300

PTR		equ $06
COUT 	equ $FDED
RTRN	equ $FF58
STCK	equ $100
 
ENTRY 	jsr RTRN
		clv
		bvc PRINT

DATA1 	asc "TEST1"
		hex 8D00
		jsr RTRN
		clv
		bvc PRINT

DATA2 	asc "TEST2"

		hex 8D00

DONE 	rts

PRINT 	tsx
		dex
		clc
		lda STCK,X
		adc #$04
		sta PTR
		inx
		lda STCK,X
		adc #$00
		sta PTR+1

PRNT 	ldy #$00
LOOP 	lda (PTR),Y
		beq FIX
		jsr COUT
		iny
		bne LOOP ; ALWAYS UNTIL 255

FIX 	clc
		tya
		adc PTR
		sta PTR
		lda PTR+1
		adc #$00
		pha
		lda PTR
		pha
FIN 	rts
		chk