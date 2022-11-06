; Chapter 13 Exercise 3
; generic input string subroutine
				org $4000
GETLN			equ $FD6F
BUFF			equ $200
PTR				equ $06
COUT			equ	$FDF0
;
Start			jsr InputString
				jsr PrintString
End				rts
; gets keyboard input and stores at address pointed by PTR
InputString		ldx #$00
				jsr GETLN
Clear 			txa				; x = string length
				tay
				lda #$00
				sta BUFFER,Y		; put EOF marker
				dey					; y-1 for proper indexing
C2				lda BUFF,Y
				sta BUFFER,Y		; put in new loc
				lda #$00
				sta BUFF,Y			; clear buffer
				dey
				cpy #$FF
				bne C2
Done			rts
; prints string on address set on PTR
PrintString		ldy	#$00	; start at offset = 0
Loop			lda BUFFER,Y	; load next character
				beq Exit	; if character = 00, finish
				jsr COUT	; print character
				iny			; increment offset
				bne Loop	; loop until y <= 255
Exit			rts
; data
BUFFER			ds	256
EoF				brk