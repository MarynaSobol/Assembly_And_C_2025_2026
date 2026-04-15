; Filename: add.asm
global add

section .text

add:
    mov eax, [esp + 4]   ; Get 1st argument (10)
    add eax, [esp + 8]   ; Add 2nd argument (20)
    add eax, [esp + 12]  ; Add 3rd argument (30)
    ret                  ; Result is returned in EAX