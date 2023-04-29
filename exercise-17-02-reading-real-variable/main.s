; Chapter 17 Exercise 2
; Read Real variable from BASIC
		org $300
;
CHKCOM 	equ $DEBE
FRMNUM	equ	$DD67
GETADR 	equ $E752
LINNUM 	equ $50
DATA 	equ $380		; DECIMAL 896
;
Entry 	jsr CHKCOM 		; CHK COMMA
		jsr FRMNUM 		; EVALUATE NUM
		jsr GETADR 		; MOV FAC -> INT
		lda LINNUM
		sta DATA
		lda LINNUM+1
		sta DATA+1
Done 	rts
		chk