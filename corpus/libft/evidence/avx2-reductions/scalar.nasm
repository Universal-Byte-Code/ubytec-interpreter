module_646961676E6F737469635F6B65726E656C73_dc1ff9b599874e71a624d0d01bfe602b_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:19:05Z
  ; Module UUID: dc1ff9b5-9987-4e71-a624-d0d01bfe602b


  section .bss

  section .text

  func_446961674964656E74697479_c945406617ed4b8ca8ed788a1426ff9e_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_c945406617ed4b8ca8ed788a1426ff9e_end
  func_446961674964656E74697479_c945406617ed4b8ca8ed788a1426ff9e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; loop-reductions: scalar bytes, observable stack retained
  mov rdx, qword [rbp + 24]
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_start_byte_reduce_done
  mov qword [rsp - 8], r9
  mov qword [rsp - 24], r8
  mov rcx, r8
    mov rax, rdx
    add rax, rcx
  mov qword [rsp - 16], rax
    lea rsp, [rsp - 8]
  movzx eax, byte [rax]
  mov qword [rsp - 8], rax
    add r9, rax
  mov qword [rbp - 16], r9
  inc r8
  mov qword [rbp - 8], r8
  lea rsp, [rsp + 8]
    mov qword [rsp - 8], r8
    jmp func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_start_byte_reduce
  func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_end
  func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_da2ea3c042ba4f40b2f0a80dbb7fde1a_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_edddc51bb0bc40d1b26a8aca9355bb9e: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_26c774b66f074ba4ad5062dc53308346
  push r9
  mov rax, qword [rbp + 24]
    push rax
  push r8
  mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    imul rax, rcx
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000000010
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r9, rax
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_edddc51bb0bc40d1b26a8aca9355bb9e ; Reevaluate WHILE condition
  end_while_26c774b66f074ba4ad5062dc53308346: ; END of while_edddc51bb0bc40d1b26a8aca9355bb9e
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_da2ea3c042ba4f40b2f0a80dbb7fde1a_end
  func_446961675265636F726473_da2ea3c042ba4f40b2f0a80dbb7fde1a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_82b749f1bc1e41ad84fe9ecf4dd53071_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 32], rax
  ; frame-registers: write-through leaf values
  mov r10, qword [rbp + 16]
  mov r9, qword [rbp - 8]
  mov r8, qword [rbp - 16]
  while_5673554710b547839b943684f46b157a: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_2afa1684c617418eb7f299940fc61281
  mov rax, qword [rbp + 40]
    push rax
  push r9
  mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    imul rax, rcx
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 24], rax
  mov rax, qword [rbp - 24]
    push rax
  mov rax, 0x0000000000000008
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
    push rax
  mov qword [rsp - 8], r10
  mov rcx, r10
    pop rax
    cmp rax, rcx
    sete al
    movzx eax, al
    push rax
  if_0ff0d5af96f248578add767432696f51: ; IF start
  pop rax
    test rax, rax
    je end_if_3b2a9a836d3c469791f611e34db4af2c
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_1ba3dc6e7dd94969bc544340ca136e5f: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_96f867eb5afd4d7ab1dcfb94427445e9
  mov rax, qword [rbp - 32]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    cmp rax, rcx
    setne al
    movzx eax, al
    push rax
  if_97173e17a9ed4bc2948e3a7a7bdbb025: ; IF start
  pop rax
    test rax, rax
    je end_if_b59fd1fb1e7d417e9778874af5deb838
  jmp end_while_96f867eb5afd4d7ab1dcfb94427445e9 ; BREAK
  end_if_b59fd1fb1e7d417e9778874af5deb838: ; END of if_97173e17a9ed4bc2948e3a7a7bdbb025
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_1ba3dc6e7dd94969bc544340ca136e5f ; Reevaluate WHILE condition
  end_while_96f867eb5afd4d7ab1dcfb94427445e9: ; END of while_1ba3dc6e7dd94969bc544340ca136e5f
  if_19af8c97e80b42bebfb038f594104a3e: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_2f882cf4040b4c7097181984f884f0da
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_82b749f1bc1e41ad84fe9ecf4dd53071_end
  end_if_2f882cf4040b4c7097181984f884f0da: ; END of if_19af8c97e80b42bebfb038f594104a3e
  end_if_3b2a9a836d3c469791f611e34db4af2c: ; END of if_0ff0d5af96f248578add767432696f51
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_5673554710b547839b943684f46b157a ; Reevaluate WHILE condition
  end_while_2afa1684c617418eb7f299940fc61281: ; END of while_5673554710b547839b943684f46b157a
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_82b749f1bc1e41ad84fe9ecf4dd53071_end
  func_446961674C6F6F6B7570_82b749f1bc1e41ad84fe9ecf4dd53071_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_dc1ff9b599874e71a624d0d01bfe602b_end:
section .text
global ubytec_host_loop_DiagBytes
ubytec_host_loop_DiagBytes:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
sub rsp, 8
push rdi
push rsi
call func_446961674279746573_5fe7564d77c54ed5923760b040fcaded_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
