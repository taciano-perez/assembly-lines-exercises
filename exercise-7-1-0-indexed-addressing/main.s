; Chapter 7 Exercise 1
; Printing APPLE to the screen
				org $300
COUT			equ	$FDED
;
Start			ldx #$00
Loop			lda DATA,X	; load character from data
				jsr COUT	; print character to cout
				inx			; increment character count
				cpx #$05	; is character = 'E' ?
				bcc Loop	; if not, loop again
				lda #$8D	; CR character
				jsr COUT	; print CR to cout
Exit			rts
;
DATA			hex	C1D0D0CCC5	; "APPLE"
;
chk