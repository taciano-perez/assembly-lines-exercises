; Chapter 5 Exercise 3
; Console Output - ASCII table (forward order)

				org $300
Home	      	equ $FC58
COUT			equ	$FDED
CTR				equ	$06

Start			jsr Home	; clear screen
				lda #$00	; load accumulator with zero
				sta CTR		; store the accumulator to address CTR
Loop			lda CTR		; load memory address CTR to accumulator
				jsr COUT	; console output contents of accumulator
				inc CTR		; increment CTR			
				beq End
				jmp Loop
End				rts
				chk