
; AL15-LOCATOR 1
		org $300
;
PTR		equ $06
RTRN 	equ $FF58
STCK 	equ $100
;
ENTRY 	jsr RTRN
		tsx
		lda STCK,X
		sta PTR+1
		dex
		lda STCK,X
		sta PTR
DONE 	rts