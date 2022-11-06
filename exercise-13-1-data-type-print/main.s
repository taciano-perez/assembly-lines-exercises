; Chapter 13 Exercise 1
; data-type print
				org $300
COUT			equ	$FDED
;
Entry			ldx #$00
Loop			lda DATA,X	; load character from the string
				beq	Done	; if character = 0, done
				jsr COUT	; print character to cout
				inx			; increment character count
				bne Loop	; if x <= 255, loop again
Done			rts
; data
DATA			asc "Hello, world"
				hex 8D00
EoF				brk
