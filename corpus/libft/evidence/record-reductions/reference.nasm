module_646961676E6F737469635F6B65726E656C73_968ca3d4f4ad4d0b9efb892ac9431788_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:36:35Z
  ; Module UUID: 968ca3d4-f4ad-4d0b-9efb-892ac9431788


  section .bss

  section .text

  func_446961674964656E74697479_96d11a0ac5b1431e8ff3835ede9818b7_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_96d11a0ac5b1431e8ff3835ede9818b7_end
  func_446961674964656E74697479_96d11a0ac5b1431e8ff3835ede9818b7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_e19657cc91904812aea9bde78ef04707_start:
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
  while_831cbfc7227943ea912fe0410a4fe01c: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_68d6259d815f488f8b9304ab9d958bef
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
    jmp while_831cbfc7227943ea912fe0410a4fe01c ; Reevaluate WHILE condition
  end_while_68d6259d815f488f8b9304ab9d958bef: ; END of while_831cbfc7227943ea912fe0410a4fe01c
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_e19657cc91904812aea9bde78ef04707_end
  func_446961674279746573_e19657cc91904812aea9bde78ef04707_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_4685bde4b7864a60a532b101b3c1d71e_start:
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
  while_1fccfa8eef0748e39588903535bb8a79: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_6c86eee82a5f43dbbd9acec0e6e25f3e
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
    jmp while_1fccfa8eef0748e39588903535bb8a79 ; Reevaluate WHILE condition
  end_while_6c86eee82a5f43dbbd9acec0e6e25f3e: ; END of while_1fccfa8eef0748e39588903535bb8a79
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_4685bde4b7864a60a532b101b3c1d71e_end
  func_446961675265636F726473_4685bde4b7864a60a532b101b3c1d71e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_0fcbe0d85a64417799540a657df2fc71_start:
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
  while_9e792f4f8a974b6ba919d64d0682a143: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_b58bf5b364994f179607e857f34c7e26
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
  if_3490081eb465453ea811b8d051c37402: ; IF start
  pop rax
    test rax, rax
    je end_if_4e5c89d55c634a67bd11a0b2f405b614
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_6373bcc55262455fbe65fb1a74352383: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_df08227582d94b69952244b51ee2725c
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
  if_33b172ada49d4b79aebaad1b9a479010: ; IF start
  pop rax
    test rax, rax
    je end_if_8c380f5df8cc46bc9a7b53d797e74501
  jmp end_while_df08227582d94b69952244b51ee2725c ; BREAK
  end_if_8c380f5df8cc46bc9a7b53d797e74501: ; END of if_33b172ada49d4b79aebaad1b9a479010
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_6373bcc55262455fbe65fb1a74352383 ; Reevaluate WHILE condition
  end_while_df08227582d94b69952244b51ee2725c: ; END of while_6373bcc55262455fbe65fb1a74352383
  if_765cb71607f14d49a38638d8e2fd0bf2: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_08764148a56e419995c7d0ca0fccdbeb
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_0fcbe0d85a64417799540a657df2fc71_end
  end_if_08764148a56e419995c7d0ca0fccdbeb: ; END of if_765cb71607f14d49a38638d8e2fd0bf2
  end_if_4e5c89d55c634a67bd11a0b2f405b614: ; END of if_3490081eb465453ea811b8d051c37402
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_9e792f4f8a974b6ba919d64d0682a143 ; Reevaluate WHILE condition
  end_while_b58bf5b364994f179607e857f34c7e26: ; END of while_9e792f4f8a974b6ba919d64d0682a143
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_0fcbe0d85a64417799540a657df2fc71_end
  func_446961674C6F6F6B7570_0fcbe0d85a64417799540a657df2fc71_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_968ca3d4f4ad4d0b9efb892ac9431788_end:
section .text
global ubytec_host_reference_DiagRecords
ubytec_host_reference_DiagRecords:
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
call func_446961675265636F726473_4685bde4b7864a60a532b101b3c1d71e_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
