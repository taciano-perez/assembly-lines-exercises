; AL15-RELOCATABLE PRINT 3

		org $300

PTR		equ $06
COUT 	equ $FDED
RTRN	equ $FF58
STCK	equ $100
 
ENTRY 	jsr RTRN
		clv
		bvc PRINT

DATA 	asc "TEST"
		hex 8D00

PRNT 	ldx #$00
LOOP	lda DATA,X
		beq DONE
		jsr COUT
		inx
		bne LOOP	; UNTIL 255

DONE	rts

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

FIX 	ldy #$09	; len of $ + 5
		lda PTR
		sta (PTR),Y
		iny
		lda PTR+1
		sta (PTR),Y	; rewrite DATA address
		clv
		bvc PRNT
		chk