.686
include \masm32\include\io.asm

.data
    A   DW  7, -3, 5, 2, 4,
            8, -11, 27, 6, 4,
            11, 1, 12, 55, 16,
            -77, -21
    N   DW  17
    MIN DW  0
    M   DW  1000 dup(0)

.code
LStart:
    
    ; array sort
    
    MOV CX, N ; 4
    DEC CX ; 2
    XOR EDI, EDI  ; 3

outer_cycle:
    PUSH CX ; 15
    
    MOV ESI, EDI ; 4
    inner_cycle:
        ADD ESI, 2 ; 13
        MOV AX, [A][EDI] ; 4
        MOV BX, [A][ESI] ; 4
                
        CMP AX, BX ; 3
        JGE skip_replace ; 15

        MOV [A][EDI], BX ; 13
        MOV [A][ESI], AX ; 13
        
    skip_replace:
        DEC CX ; 2
        JNZ inner_cycle ; 15
    
    ADD EDI, 2 ; 13
    
    POP CX ; 12
    DEC CX ; 2
    JNZ outer_cycle ; 15
    
    ; replace bites in first 7 numbers
    
    
    MOV CX, 7 ; 4
    XOR EDI, EDI ; 3
    
replace_cycle:
    MOV AX, [A][EDI] ; 4
    
    MOV BH, AH ; 4
    MOV AH, AL ; 4
    MOV AL, BH ; 4
    
    MOV [A][EDI], AX ; 13
    
    ADD EDI, 2 ; 13
    
    DEC CX ; 2
    JNZ replace_cycle ; 15

    ; find min uneven number
    
    MOV BX, A  ; 4
    MOV CX, N ; 4
    DEC CX ; 2
    MOV EDI, 2 ; 4
    
min_cycle:
    MOV AX, [A][EDI] ; 4
    
    TEST AX, 1 ; 4
    JZ continue_min_cycle ; 15
    CMP AX, BX ; 3
    JG continue_min_cycle ; 15
    MOV BX, AX ; 4
    
continue_min_cycle:
    ADD EDI, 2 ; 13
    DEC CX ; 2
    JNZ min_cycle ; 15
    
    MOV MIN, BX ; 4

end LStart
