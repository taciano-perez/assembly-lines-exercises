; Chapter 10 Exercise 3
; subtracting two bytes with SBC
				org $300
RESULT			equ $0A
COUT			equ	$FDED
PRBYTE			equ $FDDA
;
Start			lda #$ff	
				sbc #$00
				sta RESULT	; store result
PrintOut		lda RESULT
				jsr PRBYTE	; print byte value
				lda #$8D	; RETURN
				jsr COUT	; print \r to COUT
End				rts
				chk