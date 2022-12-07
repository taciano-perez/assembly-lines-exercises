; Chapter 5 Exercise 2
; Looping (decrement) - BEQ

				org $300
Home	      	equ $FC58

Start			jsr Home	; clear screen
				ldx #$FF
Loop			stx $700
				jsr $fbdd	; beep
				dex
				beq End
				jmp Loop
End				rts
				chk