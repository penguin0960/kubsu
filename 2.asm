.686
include \masm32\include\io.asm

.data
    A   DW  7, -3, 5, 2, 4,
            8, -11, 27, 6, 4,
            11, 1, 12, 55, 16,
            -77, -21
    N   DW  17
    MIN DW  0

.code
LStart:
    
    ; array sort
    
    MOV CX, N
    DEC CX
    XOR EDI, EDI

outer_cycle:
    PUSH CX
    
    MOV ESI, EDI
    inner_cycle:
        ADD ESI, 2
        MOV AX, [A][EDI]
        MOV BX, [A][ESI]
                
        CMP AX, BX
        JGE skip_replace

        MOV [A][EDI], BX
        MOV [A][ESI], AX
        
    skip_replace:
        DEC CX
        JNZ inner_cycle
    
    ADD edi, 2
    
    POP CX
    DEC CX
    JNZ outer_cycle
    
    
    ; replace bites in first 7 numbers
    
    
    MOV CX, 7
    XOR EDI, EDI
    
    
replace_cycle:
  
    PUSH CX
    MOV AX, [A][EDI]
    
    MOV BH, AH
    MOV AH, AL
    MOV AL, BH
    
    MOV [A][EDI], AX
    
    ADD EDI, 2
    
    POP CX
    DEC CX
    JNZ replace_cycle


    ; find min uneven number
    
    
    MOV BX, A
    MOV CX, N
    DEC CX
    MOV EDI, 2
    
min_cycle:
  
    MOV AX, [A][EDI]
    
    TEST AX, 1
    JZ continue_min_cycle
    CMP AX, BX
    JG continue_min_cycle
    MOV BX, AX
    
continue_min_cycle:
    ADD EDI, 2
    DEC CX
    JNZ min_cycle
    
    MOV MIN, BX
    
    
    ; console output


    MOV CX, N
    XOR EDI, EDI

output_cycle:
  
    MOV AX, [A][EDI]
    
    outint AX
    newline
    
    ADD EDI, 2
    
    DEC CX
    JNZ output_cycle
    
    inkey

end LStart
