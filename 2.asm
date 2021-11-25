.686
include \masm32\include\io.asm

.data
    A	DB	7	; ïðè óìíîæåíèè íà 2 ïîëó÷èòñÿ ñëîâî
	B 	DB	4	; ïðè óìíîæåíèè íà 35 ïîóë÷èòñÿ ñëîâî
	CC 	DD	31	; Ïðè äåëåíèè íà ñëîâî ïîëó÷èòñÿ ñëîâî

.code
    LStart:
    
    MOV AL, 2
	MUL A			; ÷èñëèòåëü â àêêóìóëÿòîðå
	ADD AX, 145
	MOV BL, 5
	DIV BL
	CBW
	newline
	outint AX
	PUSH AX
	
	MOV AL, 35
	MUL B
	SUB AX, 11
	newline
	outint AX
	MOV BX, AX
	MOV DX, 0
	CWD
	DIV BX
	newline
	outint AX
	newline
	inkey
	;MOV AX, B
	;MOV BL, 195
	;DIV BL
	;ADD ÀL, C
	;XOR AH, AH		; ðàñøèðåíèå ïîëó÷åííîé ñóììû äî ñëîâà
	;MOV BX, 529
	;SUB BX, AX
	;POP AX
	;XOR DX, DX		; ðàñøèðåíèå ÷èñëèòåëÿ äî äâîéíîãî ñëîâà
	;DIV BX		; ðåçóëüòàò â àêêóìóëÿòîðå
end LStart
