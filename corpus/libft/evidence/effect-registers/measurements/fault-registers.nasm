module_6566666563745F6661756C7473_51454a709fff4f92adcf4979f7a074bc_start:
; Module: effect_faults v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:57:40Z
  ; Module UUID: 51454a70-9fff-4f92-adcf-4979f7a074bc


  section .bss

  section .text

  func_45666665637452656164_ed5dd62d84774ad3acc1ab94e1bb02f8_start:
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
    
    jmp func_45666665637452656164_ed5dd62d84774ad3acc1ab94e1bb02f8_end
  func_45666665637452656164_ed5dd62d84774ad3acc1ab94e1bb02f8_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563745772697465_a7b262ff60724364a83cedd542d4c7c7_start:
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
  while_f1d1a9db42a44222abe3db29f543f220: ; WHILE start
  mov rcx, 1
    mov rax, r8
    cmp rax, rcx
    jae end_while_0ac7d5dbcf91402d823de626e4f874bb
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
    jmp while_f1d1a9db42a44222abe3db29f543f220 ; Reevaluate WHILE condition
  end_while_0ac7d5dbcf91402d823de626e4f874bb: ; END of while_f1d1a9db42a44222abe3db29f543f220
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_4566666563745772697465_a7b262ff60724364a83cedd542d4c7c7_end
  func_4566666563745772697465_a7b262ff60724364a83cedd542d4c7c7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_4566666563744661756C74_ae456138561f4338b9c4aefcef8eb7c0_start:
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
  while_8b436c24d7494250827c155a7c8f9df3: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_b48476b6baf946aa8ebc2da3de141893
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
  if_ad2004e87d654beeb93d12613ee26479: ; IF start
  mov rcx, 0
    mov rax, r10
    cmp rax, rcx
    jne end_if_f463bc8e7998496fabd224419a680a47
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
    jmp end_else_e595a2d23d6844bd9cc81b95037c6014     ; Jump over ELSE part
  end_if_f463bc8e7998496fabd224419a680a47:    ; if_ad2004e87d654beeb93d12613ee26479 END
  else_5a38fc13180e4ec7bbfe8de7ab43200b:  ; Start ELSE block
  if_a85e55705bc2443fbbe812f44894bf73: ; IF start
  mov rcx, 1
    mov rax, r10
    cmp rax, rcx
    jne end_if_0fa9faba887f42f0be7fd46de3d13a63
  push r9
  call func_45666665637452656164_ed5dd62d84774ad3acc1ab94e1bb02f8_start
    add rsp, 8
    push rax
  ; effect-registers: reload after CALL
  mov r10, qword [rbp + 24]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 32]
  add rsp, 8
    jmp end_else_636abc5a426444b68ed7fc070dd16b3b     ; Jump over ELSE part
  end_if_0fa9faba887f42f0be7fd46de3d13a63:    ; if_a85e55705bc2443fbbe812f44894bf73 END
  else_1371e77684e24c15b77e6fa6bf9328f6:  ; Start ELSE block
  push r9
  lea rax, [rel func_4566666563745772697465_a7b262ff60724364a83cedd542d4c7c7_start]
  mov qword [rsp - 8], rax
    call rax
    add rsp, 8
    
    push rax
  ; effect-registers: reload after CALLI
  mov r10, qword [rbp + 24]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 32]
  add rsp, 8
  end_else_636abc5a426444b68ed7fc070dd16b3b: ; END of else_1371e77684e24c15b77e6fa6bf9328f6
  end_else_e595a2d23d6844bd9cc81b95037c6014: ; END of else_5a38fc13180e4ec7bbfe8de7ab43200b
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_8b436c24d7494250827c155a7c8f9df3 ; Reevaluate WHILE condition
  end_while_b48476b6baf946aa8ebc2da3de141893: ; END of while_8b436c24d7494250827c155a7c8f9df3
  mov qword [rsp - 8], r8
  mov rax, r8
    
    jmp func_4566666563744661756C74_ae456138561f4338b9c4aefcef8eb7c0_end
  func_4566666563744661756C74_ae456138561f4338b9c4aefcef8eb7c0_end:
    mov rsp, rbp
    pop rbp
    ret
module_6566666563745F6661756C7473_51454a709fff4f92adcf4979f7a074bc_end:
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
call func_4566666563744661756C74_ae456138561f4338b9c4aefcef8eb7c0_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
