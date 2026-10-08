bits 64
section .text
global ubytec_host_bad_length, ubytec_host_bad_version, ubytec_host_delegate
ubytec_host_bad_length:
    lea rsi,[rel bad_length]
    jmp send_frame
ubytec_host_bad_version:
    lea rsi,[rel bad_version]
    jmp send_frame
ubytec_host_delegate:
    lea rsi,[rel delegate]
send_frame:
    mov eax,1
    mov edi,3
    mov edx,40
    syscall
    sub rsp,40
    xor eax,eax
    mov edi,3
    mov rsi,rsp
    mov edx,40
    syscall
    mov eax,[rsp+20]
    add rsp,40
    ret
section .rodata
bad_length: dd 2,1,1000,1,0xffffffff,0x55424331
    dq 0,0
bad_version: dd 2,1,1000,1,16,0
    dq 0,0
delegate: dd 2,1,1000,1,16,0x55424331
    dq 0,0
section .note.GNU-stack noalloc noexec nowrite progbits
