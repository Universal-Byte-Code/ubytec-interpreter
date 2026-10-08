module_696E646570656E64656E745F64617461_5589129ab31f4b629c34b2e02a42c9b5_start:
; Module: independent_data v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 00:03:23Z
  ; Module UUID: 5589129a-b31f-4b62-9c34-b2e02a42c9b5


  section .bss

  section .text

  func_52656164_05146997d0c142a5951b39bcacafcae8_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  while_01dac186a1b9488787697d76236b3a22: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_e02bb21e94c4454797a77f9cd1040ef9
  
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
    jmp while_01dac186a1b9488787697d76236b3a22 ; Reevaluate WHILE condition
  end_while_e02bb21e94c4454797a77f9cd1040ef9: ; END of while_01dac186a1b9488787697d76236b3a22
  
  mov rax, qword [rbp - 16]
    push rax
  pop rax
    
    jmp func_52656164_05146997d0c142a5951b39bcacafcae8_end
  func_52656164_05146997d0c142a5951b39bcacafcae8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5772697465_f5e7cb63611f46b5b2d6688df351e026_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  while_0cffd28055aa408dbc411e99fd7a379c: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_62cd2f76909149b8b84a6c3a608f9b9d
  
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
    jmp while_0cffd28055aa408dbc411e99fd7a379c ; Reevaluate WHILE condition
  end_while_62cd2f76909149b8b84a6c3a608f9b9d: ; END of while_0cffd28055aa408dbc411e99fd7a379c
  
  mov rax, 0x0000000100000001
    push rax
  pop rax
    
    jmp func_5772697465_f5e7cb63611f46b5b2d6688df351e026_end
  func_5772697465_f5e7cb63611f46b5b2d6688df351e026_end:
    mov rsp, rbp
    pop rbp
    ret
  func_436F7079_208895293edf45f98094dc19fb4adb7d_start:
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
  jmp func_5772697465_f5e7cb63611f46b5b2d6688df351e026_start
  
  func_436F7079_208895293edf45f98094dc19fb4adb7d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_526561644F776E44617461_7346f4d8c3814358af5cb4e7e58a6100_start:
  push rbp
    mov rbp, rsp
  mov rax, 0x0000400000100000
    push rax
  pop rax
    mov rax, qword [rax]
    push rax
  pop rax
    
    jmp func_526561644F776E44617461_7346f4d8c3814358af5cb4e7e58a6100_end
  func_526561644F776E44617461_7346f4d8c3814358af5cb4e7e58a6100_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5461696C53656C66_173d3001f63b4bd385ca7c6ea84cfea2_start:
  push rbp
    mov rbp, rsp
  mov rax, 0x0000000000030D40
    push rax
  mov rax, 0x0000000000000000
    push rax
  mov rax, 0x0000000000000000
    push rax
  mov rax, 0x0000000000000000
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
  jmp func_416363756D756C617465_224d9e22191f439387773aedb6e5d91d_start
  
  func_5461696C53656C66_173d3001f63b4bd385ca7c6ea84cfea2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_416363756D756C617465_224d9e22191f439387773aedb6e5d91d_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000007
    mov qword [rbp - 8], rax
  if_98935fb642e24ea2a68f4ebcb5be9dcf: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_71180e8a6d8f41e5b7972718d0127a83
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_416363756D756C617465_224d9e22191f439387773aedb6e5d91d_end
  end_if_71180e8a6d8f41e5b7972718d0127a83: ; END of if_98935fb642e24ea2a68f4ebcb5be9dcf
  
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    dec rax
    push rax
  mov rax, qword [rbp + 32]
    push rax
  mov rax, qword [rbp - 8]
    push rax
  pop rcx
    pop rax
    add rax, rcx
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
  jmp func_416363756D756C617465_224d9e22191f439387773aedb6e5d91d_start
  
  func_416363756D756C617465_224d9e22191f439387773aedb6e5d91d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5461696C4D757475616C_5dfa5e82191b496283372fd9e185d066_start:
  push rbp
    mov rbp, rsp
  mov rax, 0x0000000000030D40
    push rax
  mov rax, 0x0000000000000000
    push rax
  mov rax, 0x0000000000000007
    push rax
  mov rax, 0x0000000000000009
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
  jmp func_416C7465726E617465_f11778774ce543edb1259b5f91a491bd_start
  
  func_5461696C4D757475616C_5dfa5e82191b496283372fd9e185d066_end:
    mov rsp, rbp
    pop rbp
    ret
  func_416C7465726E617465_f11778774ce543edb1259b5f91a491bd_start:
  push rbp
    mov rbp, rsp
  if_d0ac6f5ec9bb4fd1bcc40511160171b7: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 40]
    cmp rax, rcx
    jne end_if_66a07d8dc50f4905a97d8d7476b37e8f
  
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    
    jmp func_416C7465726E617465_f11778774ce543edb1259b5f91a491bd_end
  end_if_66a07d8dc50f4905a97d8d7476b37e8f: ; END of if_d0ac6f5ec9bb4fd1bcc40511160171b7
  
  mov rax, qword [rbp + 40]
    push rax
  pop rax
    dec rax
    push rax
  mov rax, qword [rbp + 32]
    push rax
  pop rax
    inc rax
    push rax
  mov rax, qword [rbp + 16]
    push rax
  mov rax, qword [rbp + 24]
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
  jmp func_4F74686572_42c24aef3ac64aa68620d5459beeb0c3_start
  
  func_416C7465726E617465_f11778774ce543edb1259b5f91a491bd_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4F74686572_42c24aef3ac64aa68620d5459beeb0c3_start:
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
  jmp func_416C7465726E617465_f11778774ce543edb1259b5f91a491bd_start
  
  func_4F74686572_42c24aef3ac64aa68620d5459beeb0c3_end:
    mov rsp, rbp
    pop rbp
    ret
  func_5461696C496E66696E697465_2ddd33b197474c6aaae1125e8ebcd304_start:
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
  jmp func_5461696C496E66696E697465_2ddd33b197474c6aaae1125e8ebcd304_start
  
  func_5461696C496E66696E697465_2ddd33b197474c6aaae1125e8ebcd304_end:
    mov rsp, rbp
    pop rbp
    ret
module_696E646570656E64656E745F64617461_5589129ab31f4b629c34b2e02a42c9b5_end:
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
call func_52656164_05146997d0c142a5951b39bcacafcae8_start
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
call func_5772697465_f5e7cb63611f46b5b2d6688df351e026_start
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
call func_436F7079_208895293edf45f98094dc19fb4adb7d_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_own_data
ubytec_host_own_data:
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
call func_526561644F776E44617461_7346f4d8c3814358af5cb4e7e58a6100_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_tail_self
ubytec_host_tail_self:
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
call func_5461696C53656C66_173d3001f63b4bd385ca7c6ea84cfea2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_tail_mutual
ubytec_host_tail_mutual:
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
call func_5461696C4D757475616C_5dfa5e82191b496283372fd9e185d066_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_tail_infinite
ubytec_host_tail_infinite:
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
call func_5461696C496E66696E697465_2ddd33b197474c6aaae1125e8ebcd304_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
