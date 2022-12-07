
; AL15-LOCATOR 2
		org $300
;
PTR		equ $06
RTRN 	equ $FF58
STCK 	equ $100
;
ENTRY 	jsr RTRN
		tsx
		dex
		lda STCK,X
		sta PTR
		inx
		lda STCK,X
		sta PTR+1
DONE 	rts