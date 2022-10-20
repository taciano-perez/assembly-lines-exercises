; Chapter 8 Exercise 2
; printing a byte using the stack
				org $300
PRBYTE			equ $FDDA
COUT			equ	$FDED
KYBD			equ $C000
STROBE			equ $C010

Start			lda KYBD	; load last pressed key to accumulator
				cmp #$80
				bcc Start
				sta STROBE	; clear keyboard strobe
				pha			; push the accumulator value to the stack
				jsr PRBYTE	; print byte value (destroys accumulator)
				lda #$A0	; SPACE
				jsr COUT
				pla			; pull the accumulator value from the stack
				jsr COUT
				lda #$8D	; RETURN
				jsr COUT
End				rts
				chk