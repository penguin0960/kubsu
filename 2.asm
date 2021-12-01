.686
include \masm32\include\io.asm

.data
    A	DB	40	    ; при умножении на 2 получится слово
	B 	DB	8	    ; при умножении на 35 поулчится слово
	CC 	DW	1076	; При делении на слово получится слово
	RESULT DW 0

.code
    LStart:
    
    MOV AL, 2 ; 4
	MUL A	; 118-133
	ADD AX, 145 ; 13
	MOV BL, 5 ; 4
	DIV BL ; 144-162
	XOR AH, AH ; 3

	PUSH AX ; 15
	
	MOV AL, 35 ; 4
	MUL B ; 118-133
	SUB AX, 11 ; 3

	MOV BX, AX ; 4
	MOV AX, CC ; 4
	XOR DX, DX ; 3
	DIV BX ; 144-162
	
	POP BX ; 12
	SUB BX, AX ; 3
	
	XOR AX, AX ; 3
	MOV AX, 1 ; 4
	MOV CL, 10 ; 4
	SHL AX, CL ; 8 + 4 * 10 = 48
	AND AX, DX ; 3
	SHR AX, CL ; 48
	MOV RESULT, AX ; 13

end LStart
