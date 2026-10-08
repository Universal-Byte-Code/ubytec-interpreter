module_6566666563745F6661756C7473_245c62fef30e4d89924dcdd90cb291cd_start:
; Module: effect_faults v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:57:37Z
  ; Module UUID: 245c62fe-f30e-4d89-924d-cdd90cb291cd


  section .bss

  section .text

  func_45666665637452656164_5965fb33cbc74c8eb2233274a7aa3849_start:
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
    
    jmp func_45666665637452656164_5965fb33cbc74c8eb2233274a7aa3849_end
  func_45666665637452656164_5965fb33cbc74c8eb2233274a7aa3849_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563745772697465_b9d002a14f184290b7d8a156545c34b7_start:
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
  while_9953693d1e1f4e4b858bc94ae32cd97c: ; WHILE start
  mov rcx, 1
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_fb18229fb8d44cda8b16633fae185672
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
    push rax
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov qword [rax], rcx
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_9953693d1e1f4e4b858bc94ae32cd97c ; Reevaluate WHILE condition
  end_while_fb18229fb8d44cda8b16633fae185672: ; END of while_9953693d1e1f4e4b858bc94ae32cd97c
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_4566666563745772697465_b9d002a14f184290b7d8a156545c34b7_end
  func_4566666563745772697465_b9d002a14f184290b7d8a156545c34b7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563744661756C74_736e669f41f447cfb1347eb631c6dea1_start:
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
  while_2c8b8a46cba44288acf8a1dafbb33e5f: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_614526a4546c4fc0b928c128779057a8
  mov rax, qword [rbp + 40]
    push rax
  mov rax, qword [rbp - 8]
    push rax
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
  mov rax, 0x0000000000000018
    push rax
  mov rax, 0x0000000000000019
    push rax
  mov rax, 0x000000000000001A
    push rax
  add rsp, 8
  add rsp, 8
  add rsp, 8
  if_c0a88bafafeb476fb0687b39601b03f7: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 24]
    cmp rax, rcx
    jne end_if_01d4438ed89e4318807498e4aacac20f
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov qword [rax], rcx
    jmp end_else_74dc4cce647a449aa17491908e8d4bd8     ; Jump over ELSE part
  end_if_01d4438ed89e4318807498e4aacac20f:    ; if_c0a88bafafeb476fb0687b39601b03f7 END
  else_addb1104ccd140ed98bed0cac03bb357:  ; Start ELSE block
  if_395e7423acca4febbb88fd736aa50a66: ; IF start
  mov rcx, 1
    mov rax, qword [rbp + 24]
    cmp rax, rcx
    jne end_if_8b101e5160ac4271a0d6964d37e81ada
  mov rax, qword [rbp - 32]
    push rax
  call func_45666665637452656164_5965fb33cbc74c8eb2233274a7aa3849_start
    add rsp, 8
    push rax
  add rsp, 8
    jmp end_else_0d0bc83b053f400e9067c0be5a652c2d     ; Jump over ELSE part
  end_if_8b101e5160ac4271a0d6964d37e81ada:    ; if_395e7423acca4febbb88fd736aa50a66 END
  else_6b732d4ce54d4ed9ad26d775cc75cb51:  ; Start ELSE block
  mov rax, qword [rbp - 32]
    push rax
  lea rax, [rel func_4566666563745772697465_b9d002a14f184290b7d8a156545c34b7_start]
  mov qword [rsp - 8], rax
    call rax
    add rsp, 8
    
    push rax
  add rsp, 8
  end_else_0d0bc83b053f400e9067c0be5a652c2d: ; END of else_6b732d4ce54d4ed9ad26d775cc75cb51
  end_else_74dc4cce647a449aa17491908e8d4bd8: ; END of else_addb1104ccd140ed98bed0cac03bb357
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_2c8b8a46cba44288acf8a1dafbb33e5f ; Reevaluate WHILE condition
  end_while_614526a4546c4fc0b928c128779057a8: ; END of while_2c8b8a46cba44288acf8a1dafbb33e5f
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    
    jmp func_4566666563744661756C74_736e669f41f447cfb1347eb631c6dea1_end
  func_4566666563744661756C74_736e669f41f447cfb1347eb631c6dea1_end:
    mov rsp, rbp
    pop rbp
    ret
module_6566666563745F6661756C7473_245c62fef30e4d89924dcdd90cb291cd_end:
section .text
global ubytec_host_plain_EffectFault
ubytec_host_plain_EffectFault:
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
call func_4566666563744661756C74_736e669f41f447cfb1347eb631c6dea1_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
