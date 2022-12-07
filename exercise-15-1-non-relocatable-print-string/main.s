; AL15-NON-RELOCATABLE PRINT DEMO
		org $300
COUT 	equ $FDED
ENTRY 	jsr PRNT
DONE 	jmp EXIT
DATA 	asc "TEST"
		hex 8D00
EXIT 	rts
PRNT 	ldx #$00
LOOP 	lda DATA,X
		beq DONE
		jsr COUT
		inx
		bne LOOP
FIN		RTS