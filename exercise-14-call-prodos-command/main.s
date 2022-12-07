; Chapter 14 Exercise 1
; call ProDOS command
				org $300
COUT			equ	$FDED
GETLN1    		equ $FD6F
DOSCMD			equ	$BE03	; BASIC Interpreter
PRBYTE			equ $FDDA
PRERR			equ $BE0C
KEYB_BUFFER		equ $200
;
Entry			ldx #$00
Loop			lda DATA,X			; load character from the string
				beq	Done			; if character = 0, done
				;ora #%1000000		; set high bit
				sta KEYB_BUFFER,X	; copy to keyboard buffer
				jsr COUT			; output to console
				inx					; else, increment character count
				bne Loop			; if x <= 255, loop again
				;jsr GETLN1
				jsr DOSCMD			; call BASIC interpreter
				BIT $C010         	; CLEAR STROBE
				bcs Error
Done			rts
; Error Handler
Error			jsr PRERR			; print err message
				clc
				rts
; data
DATA			asc "cat"
				hex 8D00
EoF				brk
