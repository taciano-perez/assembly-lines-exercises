; Chapter 17 Exercise 3
; Read String variable from BASIC
;
		org $300
;
CHKCOM 	equ $DEBE
FRMEVL	equ	$DD7B
CHKSTR	equ $DD6C
FACMO 	equ $A0
FACLO 	equ $A1			; FAC+5
VARPNT	equ $83
DATA 	equ $380		; DECIMAL 896
;
Entry 	jsr CHKCOM 		; CHK COMMA
		jsr FRMEVL 		; EVALUATE 
						; (FACMO, LO) -> DESCRIPTOR
		jsr CHKSTR 		; VAR = $?
		ldy #$00
		lda (FACMO),Y	; LEN of $
		tax				; SAVE LEN
		iny				; Y = 1
		lda (FACMO),Y	; ADDR LO BYTE
		sta VARPNT
		iny				; Y = 2
		lda (FACMO),Y	; ADDR HI BYTE
		sta VARPNT+1
		txa				; RETRIEVE LEN
		tay
;
Loop	dey
		lda (VARPNT),Y	; GET CHR
		sta DATA,Y
		cpy #$00
		bne Loop
;
Done 	rts
		chk