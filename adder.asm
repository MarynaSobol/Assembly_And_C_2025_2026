; adder.asm
section .note.GNU-stack noalloc noexec nowrite progbits ;
global register_adder

section .text
register_adder:
    push    rbp
    mov     rbp, rsp
    
    mov     rax, rdi
    add     rax, rsi
    
    pop     rbp
    ret
