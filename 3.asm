.686
include \masm32\include\io.asm

.data
    A   DW  7, -3, 5, 2, 4,
            8, -11, 27, 6, 4,
            11, 1, 12, 55, 16,
            -77, -21
    N   DW  17

.code
LStart:
    
    MOV CX, N
    SUB CX, 1
    XOR EDI, EDI

    push CX

    inkey
    
outer_cycle:
    push CX
    
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
    
    pop CX
    dec CX
    JNZ outer_cycle
    
    ; ---
    
    MOV CX, 6
    XOR EDI, EDI
    
    inkey
replace_cycle:
  
    push CX
    MOV AX, [A][EDI]
    
    MOV BH, AH
    MOV AH, AL
    MOV AL, BH
    
    MOV [A][EDI], AX
    
    ADD EDI, 2
    
    pop CX
    dec CX
    JNZ replace_cycle

    ; ---
    
    MOV BX, A
    MOV CX, N
    DEC CX
    MOV EDI, 2
    
    inkey
min_cycle:
  
    MOV AX, [A][EDI]
    
    TEST AX, 1
    JZ continue_min_cycle
    CMP AX, BX
    JG continue_min_cycle
    MOV BX, AX
    
continue_min_cycle:
    ADD EDI, 2
    dec CX
    JNZ min_cycle
    
    newline
    newline
    outint BX
    newline
    
    ; ---

    MOV CX, N
    XOR EDI, EDI
    
    inkey
output_cycle:
  
    push CX
    MOV AX, [A][EDI]
    
    outint AX
    newline
    
    ADD EDI, 2
    
    pop CX
    dec CX
    JNZ output_cycle
    
    inkey

end LStart
