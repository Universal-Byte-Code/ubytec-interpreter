module_69736F6C6174696F6E5F61747461636B73_65db2a3f8f0a4a6489d9a6033c99096e_start:
; Module: isolation_attacks v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-04 23:59:02Z
  ; Module UUID: 65db2a3f-8f0a-4a64-89d9-a6033c99096e


  section .bss

  section .text

  func_52656164_47a7c39ffe8d41e7b074a4d684befb4e_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_595748c9ec5c429184348079512088d0: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_32b817a821bd40ceaeac5d9a5c22abb3
  
  mov rax, qword [rbp - 16]
    push rax
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    mov qword [rbp - 16], rax
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_595748c9ec5c429184348079512088d0 ; Reevaluate WHILE condition
  end_while_32b817a821bd40ceaeac5d9a5c22abb3: ; END of while_595748c9ec5c429184348079512088d0
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_52656164_47a7c39ffe8d41e7b074a4d684befb4e_end
  func_52656164_47a7c39ffe8d41e7b074a4d684befb4e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5772697465_ad02215b88a94636a9300ff569a5387b_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_b139125e72534ba2bf3692c313e9fdfe: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_a487e1bf491d4237849faef96aa17624
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x000000000000005A
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_b139125e72534ba2bf3692c313e9fdfe ; Reevaluate WHILE condition
  end_while_a487e1bf491d4237849faef96aa17624: ; END of while_b139125e72534ba2bf3692c313e9fdfe
  
  mov rax, 0x0000000100000001
    push rax
  pop rax
    
    jmp func_5772697465_ad02215b88a94636a9300ff569a5387b_end
  func_5772697465_ad02215b88a94636a9300ff569a5387b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_526561644F6E6C795772697465_49b05bda733f47ce945786fa9080ce6c_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_d442372cae4946369189b5dc4c014d7b: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_23f6a27021204ea699479527e78e7eef
  
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x000000000000005A
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, qword [rbp - 8]
    push rax
  pop rax
    inc rax
    push rax
  pop rax
    
    mov qword [rbp - 8], rax
    jmp while_d442372cae4946369189b5dc4c014d7b ; Reevaluate WHILE condition
  end_while_23f6a27021204ea699479527e78e7eef: ; END of while_d442372cae4946369189b5dc4c014d7b
  
  mov rax, 0x0000000100000001
    push rax
  pop rax
    
    jmp func_526561644F6E6C795772697465_49b05bda733f47ce945786fa9080ce6c_end
  func_526561644F6E6C795772697465_49b05bda733f47ce945786fa9080ce6c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_466F726569676E_dead15d25e654375b12c906778eaa64e_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 24]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    jmp func_466F726569676E_dead15d25e654375b12c906778eaa64e_end
  func_466F726569676E_dead15d25e654375b12c906778eaa64e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4D6F6E69746F72_eb20ea9cc9ef4078a81aa1e9758792d2_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4D6F6E69746F72_eb20ea9cc9ef4078a81aa1e9758792d2_end
  func_4D6F6E69746F72_eb20ea9cc9ef4078a81aa1e9758792d2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4E65696768626F72_f205d2a6e4c54db2b09f8d0a16bc81e3_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, 0x0000000000000FFF
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x0000000000001000
    push rax
  pop rcx
    pop rax
    cqo
    idiv rcx
    push rax
  mov rax, 0x0000000000001000
    push rax
  pop rcx
    pop rax
    imul rax, rcx
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  mov rax, 0x00000000000000FF
    push rax
  pop rcx
    pop rax
    mov byte [rax], cl
  mov rax, 0x0000000000000000
    push rax
  pop rax
    
    jmp func_4E65696768626F72_f205d2a6e4c54db2b09f8d0a16bc81e3_end
  func_4E65696768626F72_f205d2a6e4c54db2b09f8d0a16bc81e3_end:
    mov rsp, rbp
    pop rbp
    ret
  func_537461636B4F766572666C6F77_bfb3b11c97224df9a918f3c6f79eb420_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  call func_537461636B4F766572666C6F77_bfb3b11c97224df9a918f3c6f79eb420_start
    add rsp, 32
    push rax
  mov rax, 0x0000000000000001
    push rax
  pop rcx
    pop rax
    add rax, rcx
    push rax
  pop rax
    
    jmp func_537461636B4F766572666C6F77_bfb3b11c97224df9a918f3c6f79eb420_end
  func_537461636B4F766572666C6F77_bfb3b11c97224df9a918f3c6f79eb420_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5370696E_c1db6cded0bf4df99927733b21d25c02_start:
  push rbp
    mov rbp, rsp
  loop_a5c2ec4b69674052851bbe62d912331b: ; LOOP start
    jmp loop_a5c2ec4b69674052851bbe62d912331b ; LOOP: continue iteration
  end_loop_ef666afa255f4f07b8cb4efb89fd3491: ; END of loop_a5c2ec4b69674052851bbe62d912331b
  
  func_5370696E_c1db6cded0bf4df99927733b21d25c02_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5374616C65_22d6d70d770c45cea6f71a64cff18965_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    movzx eax, byte [rax]
    push rax
  pop rax
    
    jmp func_5374616C65_22d6d70d770c45cea6f71a64cff18965_end
  func_5374616C65_22d6d70d770c45cea6f71a64cff18965_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_ba7a39a0b6234c23b87867effedbb7fd_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  mov rax, qword [rbp + 16]
    push rax
  ; tail call: reuse incoming argument cells
  pop rax
    mov qword [rbp + 16], rax
  pop rax
    mov qword [rbp + 24], rax
  pop rax
    mov qword [rbp + 32], rax
  pop rax
    mov qword [rbp + 40], rax
  mov rsp, rbp
    pop rbp
  jmp func_5772697465_ad02215b88a94636a9300ff569a5387b_start
  
  func_436F7079_ba7a39a0b6234c23b87867effedbb7fd_end:
    mov rsp, rbp
    pop rbp
    ret
module_69736F6C6174696F6E5F61747461636B73_65db2a3f8f0a4a6489d9a6033c99096e_end:
section .text
global ubytec_host_read
ubytec_host_read:
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
push rdx
push rcx
call func_52656164_47a7c39ffe8d41e7b074a4d684befb4e_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_write
ubytec_host_write:
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
push rdx
push rcx
call func_5772697465_ad02215b88a94636a9300ff569a5387b_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_read_only_write
ubytec_host_read_only_write:
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
push rdx
push rcx
call func_526561644F6E6C795772697465_49b05bda733f47ce945786fa9080ce6c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_foreign
ubytec_host_foreign:
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
push rdx
push rcx
call func_466F726569676E_dead15d25e654375b12c906778eaa64e_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_monitor
ubytec_host_monitor:
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
push rdx
push rcx
call func_4D6F6E69746F72_eb20ea9cc9ef4078a81aa1e9758792d2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_neighbor
ubytec_host_neighbor:
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
push rdx
push rcx
call func_4E65696768626F72_f205d2a6e4c54db2b09f8d0a16bc81e3_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_stack_overflow
ubytec_host_stack_overflow:
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
push rdx
push rcx
call func_537461636B4F766572666C6F77_bfb3b11c97224df9a918f3c6f79eb420_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_loop
ubytec_host_loop:
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
push rdx
push rcx
call func_5370696E_c1db6cded0bf4df99927733b21d25c02_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_stale
ubytec_host_stale:
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
push rdx
push rcx
call func_5374616C65_22d6d70d770c45cea6f71a64cff18965_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_copy
ubytec_host_copy:
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
push rdx
push rcx
call func_436F7079_ba7a39a0b6234c23b87867effedbb7fd_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
