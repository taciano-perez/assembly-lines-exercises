; Chapter 12 Exercise 1
; Shift operators
				org $6000
VALUE			equ $06		; the value being shifted
RESULT			equ	$07		; the result after shift
CARRY			equ $08		; is the carry flag on/off?
SIGN			equ $09		; is the sign flag on/off?
ZERO			equ $A0		; is the zero flag on/off
SET				equ #$01	; flag value = SET
CLEAR			equ #$00	; flag value = CLEAR
COUT			equ	$FDED
PRBYTE			equ $FDDA
; main routine
Start			jsr PrintHeader
				lda #%00000000
				jsr Shift
				lda #%00000001
				jsr Shift
				lda #%10000000
				jsr Shift
				lda #%10000001
				jsr Shift
				lda #%11111111
				jsr Shift
End				rts
; shift the accumulator and store the output
Shift 			sta VALUE
				asl				; shift left
				sta	RESULT		; store in RESULT
				bcs CarrySet
				ldx CLEAR
				jmp StoreCarry
CarrySet		ldx	SET
StoreCarry		stx CARRY		; store in CARRY
				lda VALUE
				asl				; shift left
				bmi SignSet
				ldx CLEAR
				jmp StoreSign
SignSet			ldx	SET
StoreSign		stx SIGN		; store in SIGN
				lda VALUE
				asl				; shift left
				beq ZeroSet
				ldx CLEAR
				jmp StoreZero
ZeroSet			ldx	SET
StoreZero		stx ZERO		; store in ZERO
				jsr PrintRow
				rts
; Print Two Spaces to COUT
PrintSpaces		lda #$A0	; SPACE
				jsr COUT
				jsr COUT
				rts
; Print CR to COUT
PrintCR			lda #$8D	; CARRIAGE RETURN
				jsr COUT
				rts
; Print row with data from each shift
PrintRow		lda VALUE		; val
				jsr PRBYTE
				jsr PrintSpaces
				lda RESULT		; res
				jsr PRBYTE
				jsr PrintSpaces
CarryFlag		ldx CARRY		; cry
				cpx SET
				bcs CarryOn		
				jsr PrintOff
				jmp SignFlag
CarryOn			jsr PrintOn
SignFlag		ldx SIGN		; sgn
				cpx SET
				bcs SignOn
				jsr PrintOff
				jmp ZeroFlag
SignOn			jsr PrintOn
ZeroFlag		ldx ZERO		; zro
				cpx SET
				bcs ZeroOn
				jsr PrintOff
				jmp EndRow
ZeroOn			jsr PrintOn
EndRow			jsr PrintCR
				rts
; print header 'VAL RES CRY SGN ZRO'
PrintHeader		ldx #$00
HeaderLoop		lda HEADER,X 	; load character from the string
				beq HeaderEnd 	; is character = 0?
				jsr COUT	 	; print character to cout
				inx			 	; increment character count
				bne HeaderLoop	; if x <> 0, loop again
HeaderEnd		jsr PrintCR	 	; print CR to cout
				rts
; print 'ON  '
PrintOn			ldx #$00
OnLoop			lda ON,X 	; load character from the string
				beq OnEnd	; is character = 0?
				jsr COUT	; print character to cout
				inx			; increment character count
				bne OnLoop	; if x <> zero, loop again
OnEnd			rts
; print 'OFF '
PrintOff		ldx #$00
OffLoop			lda OFF,X 	; load character from the string
				beq OffEnd	; is character = 0?
				jsr COUT	; print character to cout
				inx			; increment character count
				bne OffLoop	; if x <> zero, loop again
OffEnd				rts
; data
HEADER			asc "VAL RES CRY SGN ZRO"
				hex 00
ON				asc "ON  "
				hex 00
OFF				asc "OFF "
				hex 00