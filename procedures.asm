section .data
    character db 'A'
    newline   db 10

section .text
    global _start

_start:
print_loop:
    call print_character
    call print_newline

    cmp byte [character], 'Z'
    je exit_program

    inc byte [character]
    jmp print_loop

print_character:
    mov eax, 4
    mov ebx, 1
    mov ecx, character
    mov edx, 1
    int 0x80
    ret

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

exit_program:
    mov eax, 1
    mov ebx, 0
    int 0x80
