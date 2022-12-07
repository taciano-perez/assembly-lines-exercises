; Chapter 6 Exercise 1b
; Keyboard Input

				org $300
HOME	      	equ $FC58
COUT			equ	$FDED
KYBD			equ $C000
STROBE			equ $C010

Start			jsr HOME	; clear screen
Loop			lda KYBD	; load last pressed key to accumulator
				cmp #$80
				bcc Loop
				;sta STROBE	; clear keyboard strobe
				jsr COUT	; console output contents of accumulator
				jmp Loop
End				rts
				chk