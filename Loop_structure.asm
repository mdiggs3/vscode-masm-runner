; Program to input, display, and process an array of 10 DWORD values

INCLUDE Irvine32.inc    ; Include Irvine32 library for input/output functions

.data
array DWORD 10 DUP(0)   ; Define an array with space for 10 DWORDs
prompt BYTE "Enter number: ", 0 ; Prompt for user input
output BYTE "[", 0               ; Start of array output format
comma BYTE ", ", 0               ; Comma separator
closeBracket BYTE "]", 0         ; Closing bracket
sumMsg BYTE "Sum of the array: ", 0

.code
main PROC
    ; Input to an array
    mov ECX, 10               ; Set loop counter to 10
    lea ESI, array            ; Load address of the array into ESI
input_loop:
    mov edx, OFFSET prompt    ; Address of the input prompt
    call WriteString          ; Display the prompt
    call ReadInt              ; Read an integer from the user
    mov [ESI], EAX            ; Store the input in the array
    add ESI, 4                ; Move to the next DWORD in the array
    loop input_loop           ; Decrement ECX and loop if not zero

    ; Display the array
    mov ECX, 10               ; Set loop counter to 10
    lea ESI, array            ; Reload the array's starting address
    mov edx, OFFSET output    ; Output starting bracket
    call WriteString

display_loop:
    mov EAX, [ESI]            ; Load the current array element
    call WriteDec             ; Display the element as a decimal
    add ESI, 4                ; Move to the next DWORD
    dec ECX                   ; Decrement counter
    jz display_done           ; If ECX is zero, end the loop
    mov edx, OFFSET comma     ; Otherwise, display a comma
    call WriteString
    jmp display_loop

display_done:
    mov edx, OFFSET closeBracket ; Display closing bracket
    call WriteString
    call Crlf                    ; Move to a new line

    ; Process the array - compute the sum
    mov ECX, 10               ; Set loop counter to 10
    lea ESI, array            ; Reload the array's starting address
    xor EAX, EAX              ; Clear EAX to use as a sum accumulator

sum_loop:
    add EAX, [ESI]            ; Add the current array element to EAX
    add ESI, 4                ; Move to the next DWORD
    loop sum_loop             ; Decrement ECX and loop if not zero

    mov edx, OFFSET sumMsg    ; Display the sum message
    call WriteString
    call WriteDec             ; Display the sum in EAX
    call Crlf                 ; Move to a new line

    exit                      ; Exit the program
main ENDP

END main