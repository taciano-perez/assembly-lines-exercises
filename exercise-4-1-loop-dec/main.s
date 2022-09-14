; Chapter 4 Exercise 1
; Looping (decrement)

				org $300
Home	      	equ $FC58

Start			jsr Home	; clear screen
				ldx #$FF
Loop			stx $700
				jsr $fbdd	; beep
				dex
				bne	Loop
End				rts
				chk