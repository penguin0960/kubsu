.686
include \masm32\include\io.asm

.data
    A	DB	7	; 
	B 	DB	4	; 
	CC 	DW	645	; 

.code
    LStart:
    
    MOV AL, 2
	MUL A
	ADD AX, 145
	MOV BL, 5
	DIV BL
	CBW
	PUSH AX
	
	MOV AL, 35
	MUL B
	SUB AX, 11
    
	MOV BX, AX
	
	MOV EAX, OFFSET CC
	MOV AX, WORD PTR [CC]
	
	XOR DX, DX
	DIV BX
	
	POP BX
	SUB BX, AX
	
	newline
    outint BX

	newline
	inkey
end LStart
