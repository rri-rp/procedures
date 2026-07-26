# Procedures Lab

## Objective

Generate English uppercase characters from `A` to `Z`, with a line feed after each character, using procedures and a loop.

## Flowchart

![Flowchart](flowchart.png)

## Assembly Code

```asm
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
```

## Challenges

The main challenge was preserving the current character while the output procedures used the system-call registers. Storing the character in memory solved this problem because each procedure could use `EAX`, `EBX`, `ECX`, and `EDX` without losing the current letter.

Another challenge was stopping the loop after printing `Z`. The program compares the current character with `Z` after it is displayed, exits when they match, and otherwise increments the character and repeats.

## Compile and Run

```bash
nasm -f elf32 procedures.asm -o procedures.o
ld -m elf_i386 procedures.o -o procedures
./procedures
```

## Expected Output

```text
A
B
C
D
E
...
Z
```

