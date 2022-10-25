; Chapter 10 Exercise 1
; adding two bytes with ADC (to a single result byte)
				org $300
RESULT			equ $0A
COUT			equ	$FDED
PRBYTE			equ $FDDA
;
Start			lda #$00	; load 00 into accumulator
				adc #$01	; add 01 to accumulator
				sta RESULT	; store result
PrintOut		lda RESULT	; load result into accumulator
				jsr PRBYTE	; print accumulator byte value
				lda #$8D	; RETURN
				jsr COUT	; print \r to COUT
End				rts
				chk