; Chapter 5 Exercise 2B
; Console Output - ASCII table (reverse order)

				org $300
Home	      	equ $FC58
COUT			equ	$FDED
CTR				equ	$06

Start			jsr Home	; clear screen
				lda #$FF	; load accumulator with $FF
				sta CTR		; store the accumulator to address CTR
Loop			lda CTR		; load memory address CTR to accumulator
				jsr COUT	; console output contents of accumulator
				dec CTR		; decrement CTR			
				beq End
				jmp Loop
End				rts
				chk