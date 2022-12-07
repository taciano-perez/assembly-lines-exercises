; Chapter 7 Exercise 1a
; Screen clear
				org $300
PTR				equ	$06
;
Entry	lda #$04	; sets PTR (6,7) to $400
		sta PTR+1
		ldy #$00
		sty PTR
;
Start	lda #$A0
Loop	sta (PTR),Y
		iny
		bne Loop
Next	inc PTR+1
		lda PTR+1
		cmp #$00
		bcc Start
		chk