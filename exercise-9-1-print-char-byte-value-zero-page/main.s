; Chapter 9 Exercise 1
; printing a byte using a zero page address
				org $300
CHR				equ $06
PRBYTE			equ $FDDA
COUT			equ	$FDED
KYBD			equ $C000
STROBE			equ $C010

Start			lda KYBD	; load last pressed key to accumulator
				cmp #$80
				bcc Start
				sta STROBE	; clear keyboard strobe
				sta CHR		; store the key in CHR
				jsr PRBYTE	; print byte value (destroys accumulator)
				lda #$A0	; SPACE
				jsr COUT
				lda CHR		; CHAR
				jsr COUT
				lda #$8D	; RETURN
				jsr COUT
End				rts
				chk