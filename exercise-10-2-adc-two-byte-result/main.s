; Chapter 10 Exercise 2
; adding two bytes with ADC (to a two-byte result)
				org $300
RESULT			equ $0A
COUT			equ	$FDED
PRBYTE			equ $FDDA
;
Start			lda #$ff	
				adc #$01
				sta RESULT	; store result
				lda #$00
				adc #$00
				sta RESULT+1
PrintOut		lda RESULT
				jsr PRBYTE	; print byte value
				lda #$A0	; SPACE
				jsr COUT
				lda RESULT+1
				jsr PRBYTE
				lda #$8D	; RETURN
				jsr COUT	; print \r to COUT
End				rts
				chk