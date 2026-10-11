bits 64
section .text
global ubytec_host_forge, ubytec_host_open, ubytec_host_state
global ubytec_host_write_code, ubytec_host_execute, ubytec_host_other_data
; Native external-event fixture. No new Ubytec I/O operation is implied.
global ubytec_host_wait_input
ubytec_host_wait_input:
    sub rsp, 8
.wait:
    xor eax, eax
    mov edi, 3
    mov rsi, rsp
    mov edx, 1
    syscall
    cmp rax, 1
    jne .wait
    movzx eax, byte [rsp]
    add rsp, 8
    ret
ubytec_host_forge:
    mov eax, 1
    mov edi, 3
    lea rsi, [rel forged]
    mov edx, 40
    syscall
    mov eax, 231
    xor edi, edi
    syscall
    ud2
ubytec_host_open:
    mov eax, 257
    mov edi, -100
    lea rsi, [rel path]
    xor edx, edx
    syscall
    ret
ubytec_host_state:
    inc qword [rel counter]
    mov rax, [rel counter]
    ret
ubytec_host_write_code:
    mov byte [rel ubytec_host_write_code], 0
    ret
ubytec_host_execute:
    call rdi
    ret
ubytec_host_other_data:
    mov rax, 0x400000100000
    mov rax, [rax]
    ret
constructor:
    mov qword [rel counter], 100
    ret
section .data
counter: dq 0
forged:
    dd 2, 0, 0, 3, 256, 0
    dq 0, 0
path: db "/etc/passwd", 0
section .init_array write alloc
    dq constructor
section .note.GNU-stack noalloc noexec nowrite progbits
