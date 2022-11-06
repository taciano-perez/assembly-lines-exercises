; Chapter 13 Exercise 2
; generic print subroutine
				org $300
PTR				equ $06		
COUT			equ	$FDED
;
Entry			jsr PrintString
				asc "Hello, World"
				hex 8D00
Done			rts
; prints a string located on the top of stack
PrintString		pla			; pull string address from the stack (LO byte)
				sta PTR		; store LO address in PTR
				pla			; pull string address from the stack (HI byte)
				sta PTR+1	; store HI address in PTR
				ldy	#$01	; start at offset = 1
Loop			lda (PTR),Y	; load next character
				beq Finish	; if character = 00, finish
				jsr COUT	; print character
				iny			; increment offset
				bne Loop	; loop until y <= 255
Finish			clc			; clear carry flag
				tya			; transfer character offset to accumulator
				adc PTR		; add offset to PTR
				sta PTR		; new PTR (LO)
				lda PTR+1	
				adc #$00	; add offset to PTR (HI), in case carry flag is set
				pha			; push PTR (HI) to stack
				lda PTR
				pha			; push PTR (LO) to stack
Exit			rts