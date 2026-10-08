module_6566666563745F6661756C7473_2d8628c4180e4d64ade0170be0cf1048_start:
; Module: effect_faults v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:59:42Z
  ; Module UUID: 2d8628c4-180e-4d64-ade0-170be0cf1048


  section .bss

  section .text

  func_45666665637452656164_69940df9fb5a477ab15588cbb319a669_start:
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
    
    jmp func_45666665637452656164_69940df9fb5a477ab15588cbb319a669_end
  func_45666665637452656164_69940df9fb5a477ab15588cbb319a669_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563745772697465_2257d43689194268a1fbb71ed1c5be77_start:
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
  while_91659fb3411a460ebfb6bdc3d14da44f: ; WHILE start
  mov rcx, 1
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_698eeacda6b0425bb167f6dea31aeb77
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
    jmp while_91659fb3411a460ebfb6bdc3d14da44f ; Reevaluate WHILE condition
  end_while_698eeacda6b0425bb167f6dea31aeb77: ; END of while_91659fb3411a460ebfb6bdc3d14da44f
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
    
    jmp func_4566666563745772697465_2257d43689194268a1fbb71ed1c5be77_end
  func_4566666563745772697465_2257d43689194268a1fbb71ed1c5be77_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563744661756C74_9979c38a56f9446eaecc51ef4e5891ee_start:
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
  while_abab082b31b0484e95bbd6d45d495d14: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, qword [rbp - 8]
    cmp rax, rcx
    jae end_while_e618738cb8b84a59a891956e5e08ea94
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
  if_d2a0ddd280c84f5f956b690389bddced: ; IF start
  mov rcx, 0
    mov rax, qword [rbp + 24]
    cmp rax, rcx
    jne end_if_fe3ce1b74607444a84eceded92a93e25
  mov rax, qword [rbp - 32]
    push rax
  mov rax, qword [rbp - 16]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    mov qword [rax], rcx
    jmp end_else_1c4c2120ffc244738ccfc3b02a5fe274     ; Jump over ELSE part
  end_if_fe3ce1b74607444a84eceded92a93e25:    ; if_d2a0ddd280c84f5f956b690389bddced END
  else_31fe74f1582549629378634cab878979:  ; Start ELSE block
  if_3d696ba6c56e4ccaab1ee9e8896712c2: ; IF start
  mov rcx, 1
    mov rax, qword [rbp + 24]
    cmp rax, rcx
    jne end_if_952039f773554e85a41ec79fac267f91
  mov rax, qword [rbp - 32]
    push rax
  call func_45666665637452656164_69940df9fb5a477ab15588cbb319a669_start
    add rsp, 8
    push rax
  add rsp, 8
    jmp end_else_209c0f3b628e4a2ebb7166a8b3c5d385     ; Jump over ELSE part
  end_if_952039f773554e85a41ec79fac267f91:    ; if_3d696ba6c56e4ccaab1ee9e8896712c2 END
  else_defac86beb224233895b2c554fe00297:  ; Start ELSE block
  mov rax, qword [rbp - 32]
    push rax
  lea rax, [rel func_4566666563745772697465_2257d43689194268a1fbb71ed1c5be77_start]
  mov qword [rsp - 8], rax
    call rax
    add rsp, 8
    
    push rax
  add rsp, 8
  end_else_209c0f3b628e4a2ebb7166a8b3c5d385: ; END of else_defac86beb224233895b2c554fe00297
  end_else_1c4c2120ffc244738ccfc3b02a5fe274: ; END of else_31fe74f1582549629378634cab878979
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    jmp while_abab082b31b0484e95bbd6d45d495d14 ; Reevaluate WHILE condition
  end_while_e618738cb8b84a59a891956e5e08ea94: ; END of while_abab082b31b0484e95bbd6d45d495d14
  mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
    
    jmp func_4566666563744661756C74_9979c38a56f9446eaecc51ef4e5891ee_end
  func_4566666563744661756C74_9979c38a56f9446eaecc51ef4e5891ee_end:
    mov rsp, rbp
    pop rbp
    ret
module_6566666563745F6661756C7473_2d8628c4180e4d64ade0170be0cf1048_end:
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
call func_4566666563744661756C74_9979c38a56f9446eaecc51ef4e5891ee_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
