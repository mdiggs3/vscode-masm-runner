INCLUDE Irvine32.inc
.data
hello BYTE "Hello Assembly!", 0
.code
main PROC
    MOV EDX, OFFSET hello    ; Print the Hello Message
    CALL WriteString
    CALL CrLf
    EXIT
main ENDP
END main