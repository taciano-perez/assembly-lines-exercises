; Chapter 17 Exercise 5
; Write Real variable from assembly to BASIC
;
		org $300
;
CHKCOM 	equ $DEBE
PTRGET	equ	$DFE3
CHKNUM 	equ $DD6A
GIVAYF	equ $E2F2
MOVMF	equ $EB2B
DATA 	equ $380		; DECIMAL 896
;
Entry 	jsr CHKCOM 		; CHK COMMA
		ldy DATA
		lda DATA+1
		jsr GIVAYF 		; DATA -> FAC
		jsr PTRGET		; GET VARIABLE POINTER
		jsr CHKNUM		; VAR = NUM?
						; Y,A = ADDRESS OF VARIABLE DATA
		tax
		jsr MOVMF			; FAC -> MEMORY
Done 	rts
		chk