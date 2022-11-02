; Chapter 11 Exercise 1
; create a new file "ABC" and write some text to it
				org $6000
CMD_CREAT		equ #$C0
CMD_OPEN		equ #$C8
CMD_WRITE		equ #$CB
CMD_CLOSE		equ #$CC
COUT			equ	$FDED
PRBYTE			equ $FDDA
FULL_ACCESS		equ #$C3
TYPE_TXT		equ #$04
ST_TYP_FILE		equ #$01
; create file "ABC"
CreateFile		lda #$07		; num of params
				sta PARAMS
				lda #<NAME		; low byte of name address
				sta PARAMS+1
				lda #>NAME		; high byte of name address
				sta PARAMS+2
				lda FULL_ACCESS	; access privileges
				sta PARAMS+3
				lda TYPE_TXT	; file type
				sta PARAMS+4
				lda #$01		; record len (low)
				sta PARAMS+5
				lda #$00		; record len (high)
				sta PARAMS+6
				lda ST_TYP_FILE	; storage type = file
				sta PARAMS+7
				lda #$00		; creation date (low)
				sta PARAMS+8
				lda #$00		; creation date (high)
				sta PARAMS+9
				lda #$00		; creation time (low)
				sta PARAMS+10
				lda #$00		; creation time (high)
				sta PARAMS+11
				lda CMD_CREAT	; MLI command = CREATE
				sta MLI+3	; put command in MLI call table
				jsr MLI		; create the file
				bcs HandleError	; in case of error
				;jsr PrintMLI	; print MLI call info
				jsr PrintOut	; print MSG
; open file "ABC"
OpenFile		lda #$03		; num of params
				sta PARAMS
				; name is already set from previous command
				lda #$00		; file buffer address (LO)
				sta PARAMS+3
				lda #$80		; file buffer address (HI), use file 0
				sta PARAMS+4
				lda CMD_OPEN	; MLI command = OPEN
				sta MLI+3	; put command in MLI call table
				jsr MLI		; create the file
				bcs HandleError	; in case of error
; write CONTENT to file
WriteFile    	lda #$04		; num of params
    			sta PARAMS
				; name is already set from previous command
				; buffer is already set from previous command
    			lda PARAMS+5	; get reference number returned by open
    			sta PARAMS+1	; and put in for write
    			sta REF			; and save for close
    			lda #<CONTENT	; pointer to data (LO)  
    			sta PARAMS+2       
				lda #>CONTENT	; pointer to data (HI)
    			sta PARAMS+3
    			lda #$05		; number of bytes to write (LO)
    			sta PARAMS+4
    			lda #$00		; number of bytes to write (HI)
    			sta PARAMS+5
    			lda CMD_WRITE	; MLI command = WRITE
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
End				rts
; call ProDOS machine language interface (MLI)
MLI				jsr $BF00	; call ProDOS
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
POLoop			lda MSG,X ; load character from the string
				jsr COUT	 ; print character to cout
				inx			 ; increment character count
				cpx #$10	; is len = 16?
				bcc POLoop	; if not, loop again
				jsr PrintCR	; print CR to cout
				rts
; data
NAME			dfb #$B				; filename len
				asc "/SYSTEM/ABC"	; filename
CONTENT			asc "Hello"
REF				dfb 0				; file reference (returned by OPEN)
PARAMS			ds 12				; 12 bytes long
ERROR			asc " ERROR CODE"	; error message
MSG				asc "Created file ABC"