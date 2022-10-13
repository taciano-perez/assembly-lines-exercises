; Chapter 7 Exercise 4
; Sound Routine - keyboard input
				org $300
KEYBOARD		equ $C000
STROBE			equ $C10
SPKR			equ $C030
;
Entry			lda KEYBOARD
				sta STROBE
				cmp #$80
				beq Exit
				tay
Loop			lda SPKR
Delay			dey
				bne Delay
				jmp Entry
Exit			rts
chk
