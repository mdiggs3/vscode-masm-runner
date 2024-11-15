; This program demonstrates accessing and modifying array elements

.data
array BYTE 10 DUP(0)           ; Define a BYTE array of length 10 initialized to 0
value1 BYTE 5                  ; Some values to add to specific array elements
value2 BYTE 10
value3 BYTE 15
result1 BYTE ?                 ; Variables to store the results
result2 BYTE ?
result3 BYTE ?

.code
main PROC
    ; Load values into array using direct-offset indexing

    ; Access array[0] and add value1
    mov al, array[0]           ; Move the value at array[0] into AL
    add al, value1             ; Add value1 to AL
    mov result1, al            ; Store the result in result1

    ; Access array[2] and add value2 (note: array + 2 refers to the third element, array[2])
    mov al, array[2]           ; Move the value at array[2] into AL
    add al, value2             ; Add value2 to AL
    mov result2, al            ; Store the result in result2

    ; Access array[4] and add value3 (note: array + 4 refers to the fifth element, array[4])
    mov al, array[4]           ; Move the value at array[4] into AL
    add al, value3             ; Add value3 to AL
    mov result3, al            ; Store the result in result3

    ; Exit program (if using Irvine's library, use invoke ExitProcess, 0; otherwise use OS exit)
    invoke ExitProcess, 0
main ENDP
END main