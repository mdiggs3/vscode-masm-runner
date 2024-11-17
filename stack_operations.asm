; Stack Operations in MASM
; Input: Character string "aaaabbbccddd"
; Output: Unique characters: "abcd"

.386
.model flat, stdcall
.stack 4096

.data
inputString db 'aaaabbbccddd', 0       ; Input string with duplicates
outputString db 20 dup(0)             ; Output string (to hold unique chars)
stack db 20 dup(0)                   ; Stack array
stackTop dd -1                       ; Stack top pointer (-1 indicates empty)
tempChar db ?                        ; Temporary variable for processing
len dd ?                             ; Length of input string

.code

main PROC
    ; Initialize stack
    mov esi, offset inputString       ; ESI points to the input string
    lea edi, outputString             ; EDI points to the output string
    mov ecx, 0                        ; Counter for output string

    ; Get length of the input string
    mov eax, esi
    mov len, 0
len_loop:
    cmp byte ptr [eax], 0
    je done_len
    inc len
    inc eax
    jmp len_loop
done_len:

    ; Push characters onto the stack
push_loop:
    mov al, [esi]                    ; Load the character from the input
    cmp al, 0                        ; Check if end of string
    je pop_duplicates                ; Jump to remove duplicates if end
    push_stack al                    ; Push the character onto the stack
    inc esi                          ; Move to next character
    jmp push_loop

; Remove duplicates while popping from the stack
pop_duplicates:
pop_loop:
    call empty_stack                 ; Check if stack is empty
    cmp eax, 1                       ; If empty, exit loop
    je done
    call pop_stack                   ; Pop a character from the stack
    mov tempChar, al                 ; Store popped character

    ; Compare with last added to output
    cmp ecx, 0                       ; If output empty, add directly
    je add_to_output
    mov al, tempChar
    mov bl, [edi + ecx - 1]          ; Last added character
    cmp al, bl                       ; Compare
    je pop_loop                      ; Skip if duplicate

add_to_output:
    mov [edi + ecx], tempChar        ; Add character to output
    inc ecx                          ; Increment output counter
    jmp pop_loop

done:
    mov [edi + ecx], 0               ; Null-terminate output string
    ; Print result (for debug purposes)
    mov edx, offset outputString
    call WriteString

    exit
main ENDP

; Stack Functions

push_stack PROC
    ; Push character onto the stack
    ; Input: AL contains character
    inc stackTop
    mov [stack + stackTop], al
    ret
push_stack ENDP

pop_stack PROC
    ; Pop character from the stack
    ; Output: AL contains popped character
    mov al, [stack + stackTop]
    dec stackTop
    ret
pop_stack ENDP

peek_stack PROC
    ; Peek top character without removing
    ; Output: AL contains top character
    mov al, [stack + stackTop]
    ret
peek_stack ENDP

empty_stack PROC
    ; Check if stack is empty
    ; Output: EAX = 1 if empty, 0 otherwise
    cmp stackTop, -1
    sete al
    movzx eax, al
    ret
empty_stack ENDP

full_stack PROC
    ; Check if stack is full
    ; Output: EAX = 1 if full, 0 otherwise
    cmp stackTop, 19
    sete al
    movzx eax, al
    ret
full_stack ENDP

END main