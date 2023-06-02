;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AL19-HIRES ONE DOT PROGRAM   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
			ORG $6000
;
X 			EQU $E0 	; $E0,$E1
Y 			EQU $E2
XV 			EQU $06 	; $06,$07
YV 			EQU $08
TX 			EQU $09 	; $09,$0A
TY 			EQU $0B
;
PREAD 		EQU $FB1E
WAIT 		EQU $FCA8
HCOLOR 		EQU $F6F0
HGR 		EQU $F3E2
HPLOT 		EQU $F457
HPOSN 		EQU $F411
HLIN 		EQU $F53A
  ;
ENTRY 		JSR HGR
			LDX #$03	; WHITE
			JSR HCOLOR
;
BOX 		LDA #$00	; Y = 0
			TAY
			TAX
			JSR HPLOT	; PLOT 0,0
			LDA #23		; 279 MOD 256
			LDX #01		; 279/256
			JSR HLIN	; FROM 0,0 TO 279,0
;
			LDA #23
			LDX #01
			LDY #$9F	; Y = 159
			JSR HLIN	; 279,0 TO 279,159
;
			LDA #$00
			LDX #$00
			LDY #$9F
			JSR HLIN	; 279,159 TO 0,159
;
			LDA #$00
			LDX #$00
			LDY #$00
			JSR HLIN	; 0,159 TO 0,0
;
SET 		LDA #$00
			STA XV+1
			LDA #$01
			STA XV		; XV = 1
			STA YV		; YV = 1
;
POSN 		LDX #$8C
			LDY #$00	; X = 140
			LDA #$50	; Y = 80
			JSR HPOSN	; SET CURSOR AT X,Y
;	
CALC 		CLC
			LDA X
			ADC XV
			STA TX
			LDA X+1
			ADC XV+1
			STA TX+1	; TX = X + XV
;
			CLC
			LDA Y
			ADC YV
			STA TY		; TY = Y + YV
;
CHK 		LDA TX+1
			BNE CHK2
			LDA TX
			CMP #$02
			BCS CHK2
			JSR RVRSX	; TX < 2
;
CHK2 		LDA TX+1
			CMP #$01
			BCC CHK3
			LDA TX
			CMP #$16
			BCC CHK3
			JSR RVRSX	; TX >= $116 (278)
;
CHK3 		LDA TY
			CMP #$02
			BCS CHK4
			JSR RVRSY	; TY < 2
;
CHK4 		LDA TY
			CMP #$9E
			BCC ERASE
			JSR RVRSY	; TY >= $9E (158)
;
ERASE 		LDX #$00	; BLACK = 0
			JSR HCOLOR
			LDX X
			LDY X+1		; GET X,X+1
			LDA Y		; GET Y
			JSR HPLOT	; ERASE POINT
;
PLOT 		LDX #$03	; WHITE1 = 3
			JSR HCOLOR
			LDX TX
			LDY TX+1	; GET TX,TX+1
			LDA TY		; GET TY
			JSR HPLOT	; PLOT POINT
;
DELAY 		LDX #$00	; PDL0
			JSR PREAD
			TYA
			JSR WAIT

; DELAY		LDX #$FF
; LOOP		DEX
; 			BNE LOOP

;
;
GOBACK 		JMP CALC
;
;
RVRSX 		LDA XV+1
			BMI NEGPOSX
;
POSNEGX 	LDA XV
			EOR #$FF
			CLC
			ADC #$01
			STA XV
			LDA XV+1
			EOR #$FF
			ADC #$00
			STA XV+1
			RTS			; XV -> -XV
;
NEGPOSX 	LDA XV
			SEC
			SBC #$01
			EOR #$FF
			STA XV
			LDA XV+1
			SBC #$00
			EOR #$FF
			STA XV+1
DONEX		RTS			; -XV -> XV
;
;
RVRSY 		LDA YV
			BMI NEGPOSY
;
POSNEGY 	LDA YV
			EOR #$FF
			CLC
			ADC #$01
			STA YV
			RTS			; YV -> -YV
;
NEGPOSY 	LDA YV
			SEC
			SBC #$01
			EOR #$FF
			STA YV
DONEY		RTS			; -YV -> YV
;
;
			CHK