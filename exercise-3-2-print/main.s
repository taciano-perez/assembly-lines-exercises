; Chapter 3 Exercise 2
; Printing Characters

				org $300
Home	      	equ $FC58
CH_A			equ #$C1
CH_P			equ #$D0
CH_L			equ #$CC
CH_E			equ #$C5

Start			jsr Home	; clear screen
				lda CH_A
				sta $700
				lda CH_P
				sta $701
				sta $702
				lda CH_L
				sta $703
				lda CH_E
				sta $704
End				rts
				chk