; Chapter 12 Exercise 2
; logical operators AND, BIT
				org $6000
VALUE1			equ $06		; first operand of AND
VALUE2			equ	$07		; second operand of AND
RESULT			equ $08		; resulting value
COUT			equ	$FDED
PRBYTE			equ $FDDA
; main routine
Start			lda #%00000010
				sta VALUE2
				lda #%11000011
				sta VALUE1
				and VALUE2
				sta RESULT
				jsr PrintResult
				lda #$A0
				jsr COUT
				lda #%00000010
				bit RESULT
				bne True
False			lda #$00
				jmp PrintBool
True			lda #$01
PrintBool       jsr PRBYTE
End				rts
; print result to COUT
PrintResult		lda VALUE1
				jsr PRBYTE
				jsr PrintAnd
				lda VALUE2
				jsr PRBYTE
				jsr PrintEq
				lda RESULT
				jsr PRBYTE
				rts
; print ' = '
PrintEq			ldx #$00
EqLoop			lda EQ_STR,X 	; load character from the string
				beq	EqEnd
				jsr COUT	; print character to cout
				inx			; increment character count
				bne EqLoop	; if not, loop again
EqEnd			rts
; print ' AND '
PrintAnd		ldx #$00
AndLoop			lda AND_STR,X 	; load character from the string
				beq AndEnd		; is character <> 0?
				jsr COUT	 	; print character to cout
				inx				; increment character count
				bne AndLoop		; if x <> 0, loop again
AndEnd			rts
; data
AND_STR			asc " AND "
				hex 00
EQ_STR			asc " = "
				hex 00