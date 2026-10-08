module_6566666563745F6661756C7473_eda9f9a1024c46d9b8821232a9c176d8_start:
; Module: effect_faults v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:59:46Z
  ; Module UUID: eda9f9a1-024c-46d9-b882-1232a9c176d8


  section .bss

  section .text

  func_45666665637452656164_cf3dc96c269849a0936bcc787fe234bc_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000007
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000009
    mov qword [rbp - 24], rax
  mov rax, 0x000000000000000B
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000018
    push rax
  mov rax, 0x0000000000000019
    push rax
  mov rax, 0x000000000000001A
    push rax
  add rsp, 8
  add rsp, 8
  add rsp, 8
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    jmp func_45666665637452656164_cf3dc96c269849a0936bcc787fe234bc_end
  func_45666665637452656164_cf3dc96c269849a0936bcc787fe234bc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563745772697465_978bd01bdde6403f8768775af245b6b0_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000007
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000009
    mov qword [rbp - 24], rax
  mov rax, 0x000000000000000B
    mov qword [rbp - 32], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_c318d6a3f0bd429896ae507a8a75eb39: ; WHILE start
  mov rcx, 1
    mov rax, r8
    cmp rax, rcx
    jae end_while_17a90fd452b24012be7a60a0048f9aeb
  mov rax, 0x0000000000000018
    push rax
  mov rax, 0x0000000000000019
    push rax
  mov rax, 0x000000000000001A
    push rax
  add rsp, 8
  add rsp, 8
  add rsp, 8
  push r10
  mov qword [rsp - 8], r9
  mov rcx, r9
    pop rax
    mov qword [rax], rcx
  ; effect-registers: reload after STORE
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_c318d6a3f0bd429896ae507a8a75eb39 ; Reevaluate WHILE condition
  end_while_17a90fd452b24012be7a60a0048f9aeb: ; END of while_c318d6a3f0bd429896ae507a8a75eb39
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_4566666563745772697465_978bd01bdde6403f8768775af245b6b0_end
  func_4566666563745772697465_978bd01bdde6403f8768775af245b6b0_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563744661756C74_ec1a7cdfe22643ffb4ac77541047ae56_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000007
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 32], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 24]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 32]
  while_4e927eece23740a3bf252005c2c41584: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_f2d4d73afb5446278a94c1488008429a
  mov rax, qword [rbp + 40]
    push rax
  push r8
  mov rax, 0x0000000000000008
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    imul rax, rcx
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
    mov r9, rax
  mov rax, 0x0000000000000018
    push rax
  mov rax, 0x0000000000000019
    push rax
  mov rax, 0x000000000000001A
    push rax
  add rsp, 8
  add rsp, 8
  add rsp, 8
  if_2424bf716acb486cae0f711190ded309: ; IF start
  mov rcx, 0
    mov rax, r10
    cmp rax, rcx
    jne end_if_9b24b8ec658b4bbba5e018fdf3517838
  push r9
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov qword [rax], rcx
  ; effect-registers: reload after STORE
  mov r10, qword [rbp + 24]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 32]
    jmp end_else_5c841b9a223d4f8aab295dac414b8998     ; Jump over ELSE part
  end_if_9b24b8ec658b4bbba5e018fdf3517838:    ; if_2424bf716acb486cae0f711190ded309 END
  else_51dc3b70ad8f4f7098334309fd2a6197:  ; Start ELSE block
  if_23a0e4cc447846a79fff361c458f8c1d: ; IF start
  mov rcx, 1
    mov rax, r10
    cmp rax, rcx
    jne end_if_54d4b29a89a54ca1b4f2152f76da7014
  push r9
  call func_45666665637452656164_cf3dc96c269849a0936bcc787fe234bc_start
    add rsp, 8
    push rax
  ; effect-registers: reload after CALL
  mov r10, qword [rbp + 24]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 32]
  add rsp, 8
    jmp end_else_faf3348d8341444c9961196504ac0552     ; Jump over ELSE part
  end_if_54d4b29a89a54ca1b4f2152f76da7014:    ; if_23a0e4cc447846a79fff361c458f8c1d END
  else_362ef839772d4d74a670ed34cd91f118:  ; Start ELSE block
  push r9
  lea rax, [rel func_4566666563745772697465_978bd01bdde6403f8768775af245b6b0_start]
  mov qword [rsp - 8], rax
    call rax
    add rsp, 8
    
    push rax
  ; effect-registers: reload after CALLI
  mov r10, qword [rbp + 24]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 32]
  add rsp, 8
  end_else_faf3348d8341444c9961196504ac0552: ; END of else_362ef839772d4d74a670ed34cd91f118
  end_else_5c841b9a223d4f8aab295dac414b8998: ; END of else_51dc3b70ad8f4f7098334309fd2a6197
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_4e927eece23740a3bf252005c2c41584 ; Reevaluate WHILE condition
  end_while_f2d4d73afb5446278a94c1488008429a: ; END of while_4e927eece23740a3bf252005c2c41584
  mov qword [rsp - 8], r8
  mov rax, r8
    
    jmp func_4566666563744661756C74_ec1a7cdfe22643ffb4ac77541047ae56_end
  func_4566666563744661756C74_ec1a7cdfe22643ffb4ac77541047ae56_end:
    mov rsp, rbp
    pop rbp
    ret
module_6566666563745F6661756C7473_eda9f9a1024c46d9b8821232a9c176d8_end:
section .text
global ubytec_host_register_EffectFault
ubytec_host_register_EffectFault:
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
call func_4566666563744661756C74_ec1a7cdfe22643ffb4ac77541047ae56_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
