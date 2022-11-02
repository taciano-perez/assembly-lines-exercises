; Chapter 11 Exercise 2
; read file "ABC" and print contents to console
				org $6000
CMD_OPEN		equ #$C8
CMD_READ		equ #$CA
CMD_CLOSE		equ #$CC
COUT			equ	$FDED
PRBYTE			equ $FDDA
; open file "ABC"
OpenFile		lda #$03		; num of params
				sta PARAMS
				lda #<NAME		; low byte of name address
				sta PARAMS+1
				lda #>NAME		; high byte of name address
				sta PARAMS+2
				lda #$00		; file buffer address (LO)
				sta PARAMS+3
				lda #$80		; file buffer address (HI), use file 0
				sta PARAMS+4
				lda CMD_OPEN	; MLI command = OPEN
				sta MLI+3	; put command in MLI call table
				jsr MLI		; create the file
				bcs HandleError	; in case of error
; read CONTENT from file
ReadFile    	lda #$04		; num of params
    			sta PARAMS
				; name is already set from previous command
				; buffer is already set from previous command
    			lda PARAMS+5	; get reference number returned by open
    			sta PARAMS+1	; and put in for read
    			sta REF			; and save for close
    			lda #<BUFFER	; pointer to buffer (LO)  
    			sta PARAMS+2       
				lda #>BUFFER	; pointer to buffer (HI)
    			sta PARAMS+3
    			lda #$05		; number of bytes to read (LO)
    			sta PARAMS+4
    			lda #$00		; number of bytes to read (HI)
    			sta PARAMS+5
    			lda CMD_READ	; MLI command = READ
    			sta MLI+3
    			jsr MLI			; write the data
				bcs HandleError	; in case of error
; close file "ABC"
CloseFile    	lda #$01		; num of params
    			sta PARAMS
				lda REF			; put in reference number
    			sta PARAMS+1
    			lda CMD_CLOSE	; MLI command = CLOSE
    			sta MLI+3
    			jsr MLI			; close the file
				bcs HandleError	; in case of error
				jsr PrintOut	; print CONTENT
End				rts
; call ProDOS machine language interface (MLI)
MLI			jsr $BF00	; call ProDOS
				dfb $00		; command number
    			dw PARAMS	; address of parameter table
    			rts
; handle MLI error
HandleError		jsr PRBYTE		; print error code
				jsr PrintErr	; print ' ERROR CODE'
				rts
; Print Space to COUT
PrintSpace		lda #$A0	; SPACE
				jsr COUT
				rts
; Print CR to COUT
PrintCR			lda #$8D	; CARRIAGE RETURN
				jsr COUT
				rts
; print MLI call to COUT
PrintMLI 		ldx #$00
PMLoop			lda MLI,X
				jsr PRBYTE
				jsr PrintSpace
				inx			; increment character count
				cpx #$06	; is len = 6?
				bcc PMLoop	; if not, loop again
				jsr PrintCR	; print \r to COUT
				rts
; print ERROR to COUT
PrintErr		ldx #$00
ErrLoop			lda ERROR,X ; load character from the string
				jsr COUT	 ; print character to cout
				inx			 ; increment character count
				cpx #$0B	; is len = 11?
				bcc ErrLoop	; if not, loop again
				jsr PrintCR	; print CR to cout
				rts
; print MSG to COUT
PrintOut		ldx #$00
POLoop			lda BUFFER,X ; load character from the string
				jsr COUT	 ; print character to cout
				inx			 ; increment character count
				cpx #$05	; is len = 5?
				bcc POLoop	; if not, loop again
				jsr PrintCR	; print CR to cout
				rts
; data
NAME			dfb #$B				; filename len
				asc "/SYSTEM/ABC"	; filename
REF				dfb 0				; file reference (returned by OPEN)
PARAMS			ds 12				; 12 bytes long
ERROR			asc " ERROR CODE"	; error message
BUFFER			ds 512				; 512 bytes long