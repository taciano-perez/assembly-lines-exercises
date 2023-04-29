; Chapter 17 Exercise 1
; Read Integer variable from BASIC
		org $300
;
CHKCOM 	equ $DEBE
PTRGET 	equ $DFE3
VARPNT 	equ $83
MOVFM 	equ $EAF9
CHKNUM 	equ $DD6A
DATA 	equ $380		; DECIMAL 896
;
Entry 	jsr CHKCOM 		; CHK COMMA
		jsr PTRGET 		; GET POINTER TO VARIABLE
						; Y,A = ADDRESS OF VALUE
		jsr MOVFM 		; MOV VAL -> FAC
		jsr CHKNUM 		; FAC = NUM?
		ldy #$00
		lda (VARPNT),Y
		sta DATA+1
		iny
		lda (VARPNT),Y
		sta DATA
		;
		; NOTE! HIGH BYTE FIRST!
		;
Done 	rts
		chk