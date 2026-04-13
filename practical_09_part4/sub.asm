; Filename: sub.asm
global sub

section .text

sub:
    mov eax, [esp + 4]   ; Get 1st argument (50)
    sub eax, [esp + 8]   ; Subtract 2nd argument (20)
    ret                  ; Result is returned in EAX