; app.asm
section .note.GNU-stack noalloc noexec nowrite progbits
extern printf, scanf, exit
global main
extern register_adder

section .data
    prompt      db "Enter number: ", 0
    res_msg     db "The sum is: %ld", 10, 0
    final_msg   db "Final sum is: %ld", 10, 0
    input_fmt   db "%ld", 0
    err_msg     db "Invalid input or overflow detected!", 10, 0

section .bss
    input_val   resq 1      ; Reserve 8 bytes for input

section .text
main:
    push    rbp
    mov     rbp, rsp
    
    xor     r12, r12        ; Running sum
    mov     r13, 3          ; Loop counter 

loop_start:
    ; --- Get First Number ---
    mov     rdi, prompt
    xor     rax, rax
    call    printf

    mov     rdi, input_fmt
    mov     rsi, input_val
    xor     rax, rax
    call    scanf
    cmp     rax, 1
    jne     error
    
    ; Bounds check for first number
    mov     rax, [input_val]
    cmp     rax, 1000000
    jg      error
    cmp     rax, -1000000
    jl      error
    mov     rbx, rax        ; Safe to use

    ; --- Get Second Number ---
    mov     rdi, prompt
    xor     rax, rax
    call    printf

    mov     rdi, input_fmt
    mov     rsi, input_val
    xor     rax, rax
    call    scanf
    cmp     rax, 1
    jne     error
    
    ; Bounds check for second number
    mov     rax, [input_val]
    cmp     rax, 1000000
    jg      error
    cmp     rax, -1000000
    jl      error
    mov     rcx, rax        ; Safe to use

    ; --- Calculate ---
    mov     rdi, rbx
    mov     rsi, rcx
    call    register_adder
    
    add     r12, rax        ; Update running sum

    ; Print partial result
    mov     rdi, res_msg
    mov     rsi, rax
    xor     rax, rax
    call    printf

    dec     r13             ; Decrement counter
    jnz     loop_start

    ; --- Final display ---
    mov     rdi, final_msg
    mov     rsi, r12
    xor     rax, rax
    call    printf

    mov     rsp, rbp
    pop     rbp
    ret

error:
    mov     rdi, err_msg
    xor     rax, rax
    call    printf
    mov     rdi, 1
    call    exit