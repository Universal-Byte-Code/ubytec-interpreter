module_646961676E6F737469635F6B65726E656C73_69510d576ad344acadcb3e2fbdacd139_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 23:38:27Z
  ; Module UUID: 69510d57-6ad3-44ac-adcb-3e2fbdacd139


  section .bss

  section .text

  func_446961674964656E74697479_7d76e5356d62480e834abe8bdb2df4a4_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_7d76e5356d62480e834abe8bdb2df4a4_end
  func_446961674964656E74697479_7d76e5356d62480e834abe8bdb2df4a4_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_eba5802f80934f978b32b261703483cf_start:
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
  func_446961674279746573_eba5802f80934f978b32b261703483cf_start_byte_reduce:
  cmp r8, r10
    jae func_446961674279746573_eba5802f80934f978b32b261703483cf_start_byte_reduce_done
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
    jmp func_446961674279746573_eba5802f80934f978b32b261703483cf_start_byte_reduce
  func_446961674279746573_eba5802f80934f978b32b261703483cf_start_byte_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961674279746573_eba5802f80934f978b32b261703483cf_end
  func_446961674279746573_eba5802f80934f978b32b261703483cf_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_7eb16f9b731d40af9902de2ca17b4161_start:
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
  while_acbe03183abd4dbdba87af4488ca03f7: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_eea7ee7d9acd42889032cd52bb4fd05c
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
    jmp while_acbe03183abd4dbdba87af4488ca03f7 ; Reevaluate WHILE condition
  end_while_eea7ee7d9acd42889032cd52bb4fd05c: ; END of while_acbe03183abd4dbdba87af4488ca03f7
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_7eb16f9b731d40af9902de2ca17b4161_end
  func_446961675265636F726473_7eb16f9b731d40af9902de2ca17b4161_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_f1a6daa64d0d4eecb50ba9b8fa3bb558_start:
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
  while_1c5654e7ed4b4461a6e2c6f5089f43c5: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_cbce9edd4b8a4b099fdd48d1fde8cf4b
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
  if_6445df4c93344031a49cdf3fbb56d27a: ; IF start
  pop rax
    test rax, rax
    je end_if_73b57402333e43748fe4d3529dafc2c0
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_2e71074134ec454bbb743f1756700c92: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_a360704822ec4283a95468d9c83372c7
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
  if_c14d4381a188494c8078f34a65c595ea: ; IF start
  pop rax
    test rax, rax
    je end_if_baa19c8710e24ee8892032877817dbb9
  jmp end_while_a360704822ec4283a95468d9c83372c7 ; BREAK
  end_if_baa19c8710e24ee8892032877817dbb9: ; END of if_c14d4381a188494c8078f34a65c595ea
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_2e71074134ec454bbb743f1756700c92 ; Reevaluate WHILE condition
  end_while_a360704822ec4283a95468d9c83372c7: ; END of while_2e71074134ec454bbb743f1756700c92
  if_97a2f6c1f7db47bf9dd13ebfbfa3495e: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_ab311c0522494c84bcfc98c18c87d9ea
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_f1a6daa64d0d4eecb50ba9b8fa3bb558_end
  end_if_ab311c0522494c84bcfc98c18c87d9ea: ; END of if_97a2f6c1f7db47bf9dd13ebfbfa3495e
  end_if_73b57402333e43748fe4d3529dafc2c0: ; END of if_6445df4c93344031a49cdf3fbb56d27a
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_1c5654e7ed4b4461a6e2c6f5089f43c5 ; Reevaluate WHILE condition
  end_while_cbce9edd4b8a4b099fdd48d1fde8cf4b: ; END of while_1c5654e7ed4b4461a6e2c6f5089f43c5
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_f1a6daa64d0d4eecb50ba9b8fa3bb558_end
  func_446961674C6F6F6B7570_f1a6daa64d0d4eecb50ba9b8fa3bb558_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_69510d576ad344acadcb3e2fbdacd139_end:
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
call func_446961674279746573_eba5802f80934f978b32b261703483cf_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
