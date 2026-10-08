module_646961676E6F737469635F6B65726E656C73_bb22bfa94ebe436b975c4c25b91bf828_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 09:57:33Z
  ; Module UUID: bb22bfa9-4ebe-436b-975c-4c25b91bf828


  section .bss

  section .text

  func_446961674964656E74697479_2ebceedf79984de6bb387e2bf3db42d2_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_2ebceedf79984de6bb387e2bf3db42d2_end
  func_446961674964656E74697479_2ebceedf79984de6bb387e2bf3db42d2_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_0f690d92eb7f4946b895b8bbcd824b88_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_37d06cd03b3b492a863607c6c5c50fae: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_f9e0e770321d4224bc70f18a671140e1
  push r9
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
    jmp while_37d06cd03b3b492a863607c6c5c50fae ; Reevaluate WHILE condition
  end_while_f9e0e770321d4224bc70f18a671140e1: ; END of while_37d06cd03b3b492a863607c6c5c50fae
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_0f690d92eb7f4946b895b8bbcd824b88_end
  func_446961674279746573_0f690d92eb7f4946b895b8bbcd824b88_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_c366e72e6ada4beebfaf7c4bd79c8505_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_4cc29ee083a24bf6814fc836549e1a67: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_dfe031c08aeb4954801816cc10579712
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
    jmp while_4cc29ee083a24bf6814fc836549e1a67 ; Reevaluate WHILE condition
  end_while_dfe031c08aeb4954801816cc10579712: ; END of while_4cc29ee083a24bf6814fc836549e1a67
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_c366e72e6ada4beebfaf7c4bd79c8505_end
  func_446961675265636F726473_c366e72e6ada4beebfaf7c4bd79c8505_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_27cc0e74993d4f4486e7b3f74d72dc7d_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  while_c9f22a0d90da4b9fa61115f77bd3e613: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_d6ceaaac03f4442f8f2d84e8856d48db
  mov rax, qword [rbp + 40]
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
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r9, rax
  push r9
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
  if_0818da5fa16c4010aba625ecadf39090: ; IF start
  pop rax
    test rax, rax
    je end_if_322316e94e0f48c1b37fcb33a8980656
  mov qword [rsp - 8], r9
  mov rax, r9
    mov rax, qword [rax]
    push rax
  mov rax, qword [rbp + 24]
    push rax
  push r10
  call func_66745F6D656D636D70_508086b5612748c5b5c9daa1d7b9dae1_start
    add rsp, 24
    push rax
  ; effect-registers: reload after CALL
  mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  mov r9, qword [rbp - 16]
  if_e86dc23f7c2c49afabbacc94a6dcc4b1: ; IF start
  pop rax
    test rax, rax
    je end_if_3db1f237a5914f88b1a0e82812ac341c
    jmp end_else_cf20eeb469d041fbb40df9d175a3fddf     ; Jump over ELSE part
  end_if_3db1f237a5914f88b1a0e82812ac341c:    ; if_e86dc23f7c2c49afabbacc94a6dcc4b1 END
  else_ea45fc05551c4e76ae4092f1c83b7000:  ; Start ELSE block
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_27cc0e74993d4f4486e7b3f74d72dc7d_end
  end_else_cf20eeb469d041fbb40df9d175a3fddf: ; END of else_ea45fc05551c4e76ae4092f1c83b7000
  end_if_322316e94e0f48c1b37fcb33a8980656: ; END of if_0818da5fa16c4010aba625ecadf39090
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_c9f22a0d90da4b9fa61115f77bd3e613 ; Reevaluate WHILE condition
  end_while_d6ceaaac03f4442f8f2d84e8856d48db: ; END of while_c9f22a0d90da4b9fa61115f77bd3e613
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_27cc0e74993d4f4486e7b3f74d72dc7d_end
  func_446961674C6F6F6B7570_27cc0e74993d4f4486e7b3f74d72dc7d_end:
    mov rsp, rbp
    pop rbp
    ret
  func_66745F6D656D636D70_508086b5612748c5b5c9daa1d7b9dae1_start:
  push rbp
    mov rbp, rsp
  sub rsp, 32
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 24], rax
  ; effect-registers: write-through copies, raw-store/call reload boundaries
  mov r10, qword [rbp + 24]
  mov r9, qword [rbp + 16]
  mov r8, qword [rbp - 8]
  while_64bb550c7e5c4f439ca1883c4cfcc808: ; WHILE start
  mov rax, r9
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_1ceaedb15305465eaaf338c34c4608a6
  mov rax, qword [rbp + 32]
    push rax
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
    movsxd rax, eax
    mov qword [rbp - 16], rax
  push r10
  mov qword [rsp - 8], r8
  mov rcx, r8
    pop rax
    add rax, rcx
  mov qword [rsp - 8], rax
    movzx eax, byte [rax]
  mov qword [rsp - 8], rax
    movsxd rax, eax
    mov qword [rbp - 24], rax
  if_b7dc56e7c3bf4dcbaa0c54064ab6a800: ; IF start
  movsxd rax, dword [rbp - 24]
    mov rcx, rax
    movsxd rax, dword [rbp - 16]
    cmp rax, rcx
    je end_if_805949965c6c460d80c09aaffc8795db
  movsxd rax, dword [rbp - 16]
    push rax
  movsxd rax, dword [rbp - 24]
  mov qword [rsp - 8], rax
  mov rcx, rax
    pop rax
    sub rax, rcx
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_508086b5612748c5b5c9daa1d7b9dae1_end
  end_if_805949965c6c460d80c09aaffc8795db: ; END of if_b7dc56e7c3bf4dcbaa0c54064ab6a800
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r8, rax
    jmp while_64bb550c7e5c4f439ca1883c4cfcc808 ; Reevaluate WHILE condition
  end_while_1ceaedb15305465eaaf338c34c4608a6: ; END of while_64bb550c7e5c4f439ca1883c4cfcc808
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    movsxd rax, eax
    jmp func_66745F6D656D636D70_508086b5612748c5b5c9daa1d7b9dae1_end
  func_66745F6D656D636D70_508086b5612748c5b5c9daa1d7b9dae1_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_bb22bfa94ebe436b975c4c25b91bf828_end:
section .text
global ubytec_host_register_DiagIdentity
ubytec_host_register_DiagIdentity:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_446961674964656E74697479_2ebceedf79984de6bb387e2bf3db42d2_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_register_DiagBytes
ubytec_host_register_DiagBytes:
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
call func_446961674279746573_0f690d92eb7f4946b895b8bbcd824b88_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_register_DiagRecords
ubytec_host_register_DiagRecords:
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
call func_446961675265636F726473_c366e72e6ada4beebfaf7c4bd79c8505_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_register_DiagLookup
ubytec_host_register_DiagLookup:
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
call func_446961674C6F6F6B7570_27cc0e74993d4f4486e7b3f74d72dc7d_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
