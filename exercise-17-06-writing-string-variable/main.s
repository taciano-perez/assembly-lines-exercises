; Chapter 17 Exercise 6
; write string variable from assembly
; and read on BASIC
;
		org $300
;
CHKCOM 	equ $DEBE
PTRGET	equ $DFE3
CHKSTR	equ $DD6C
FORPNT	equ $85
MAKSTR	equ	$E3E9
SAVD	equ	$DA9A
DATA 	equ $380		; DECIMAL 896
;
Entry	jsr CHKCOM 		; CHK COMMA
		jsr PTRGET 		; GET VAR POINTER
		jsr CHKSTR 		; VAR = $?
		sta FORPNT
		sty FORPNT+1	; ADDR OF DESCR
		lda #$80
		ldy #$03		; A,Y = $380
		ldx #$00		; DELIMITER ='00'
		jsr MAKSTR		; DATA -> MEMORY
		jsr SAVD		; VARPNT = NEW $
;
Done 	rts
		chk