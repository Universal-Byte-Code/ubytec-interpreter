module_646961676E6F737469635F6B65726E656C73_23f744c610414a369bc9d2402c3e03bd_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 02:06:44Z
  ; Module UUID: 23f744c6-1041-4a36-9bc9-d2402c3e03bd


  section .bss

  section .text

  func_446961674964656E74697479_df29784ec1034a8692cfb7481205813c_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_df29784ec1034a8692cfb7481205813c_end
  func_446961674964656E74697479_df29784ec1034a8692cfb7481205813c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_2611db9285544f17af402349871a05e7_start:
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
  while_3d492ec0821a48e0866be2845d5aaac4: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_221c4a94025746e58f9808ea70cb7518
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
    jmp while_3d492ec0821a48e0866be2845d5aaac4 ; Reevaluate WHILE condition
  end_while_221c4a94025746e58f9808ea70cb7518: ; END of while_3d492ec0821a48e0866be2845d5aaac4
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_2611db9285544f17af402349871a05e7_end
  func_446961674279746573_2611db9285544f17af402349871a05e7_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_a535455b6ab845dca695385e308c313b_start:
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
  while_cbd309c4352e4e14b50a1742f986cd46: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_a98a656579d04e73a62cc1a067c126ec
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
    jmp while_cbd309c4352e4e14b50a1742f986cd46 ; Reevaluate WHILE condition
  end_while_a98a656579d04e73a62cc1a067c126ec: ; END of while_cbd309c4352e4e14b50a1742f986cd46
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_a535455b6ab845dca695385e308c313b_end
  func_446961675265636F726473_a535455b6ab845dca695385e308c313b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_59fb7a16da374fb59bf32763db2c7e3c_start:
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
  while_fadde2f0e6214f1896584902e14d375b: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_fdb0bb7d95e143f5b9c0191b9268ac93
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
  if_03b0f52cf660406fbd0160d28a07c690: ; IF start
  pop rax
    test rax, rax
    je end_if_63461c22f77941848a75619bdfba4b3f
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_cf67bf2178c344c583adbd5b3aacf465: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_98139b3b9cb14643a4b0a8d16b57176c
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
  if_7808517f3db04469ab698075e26e73be: ; IF start
  pop rax
    test rax, rax
    je end_if_3e53e9543ef54fadaf2e0a29fbd6556a
  jmp end_while_98139b3b9cb14643a4b0a8d16b57176c ; BREAK
  end_if_3e53e9543ef54fadaf2e0a29fbd6556a: ; END of if_7808517f3db04469ab698075e26e73be
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_cf67bf2178c344c583adbd5b3aacf465 ; Reevaluate WHILE condition
  end_while_98139b3b9cb14643a4b0a8d16b57176c: ; END of while_cf67bf2178c344c583adbd5b3aacf465
  if_af6c2c36e9174460abb118f95c3c1ad3: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_a9bd30f8168b4da0bf2aa57392adcbe4
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_59fb7a16da374fb59bf32763db2c7e3c_end
  end_if_a9bd30f8168b4da0bf2aa57392adcbe4: ; END of if_af6c2c36e9174460abb118f95c3c1ad3
  end_if_63461c22f77941848a75619bdfba4b3f: ; END of if_03b0f52cf660406fbd0160d28a07c690
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_fadde2f0e6214f1896584902e14d375b ; Reevaluate WHILE condition
  end_while_fdb0bb7d95e143f5b9c0191b9268ac93: ; END of while_fadde2f0e6214f1896584902e14d375b
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_59fb7a16da374fb59bf32763db2c7e3c_end
  func_446961674C6F6F6B7570_59fb7a16da374fb59bf32763db2c7e3c_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_23f744c610414a369bc9d2402c3e03bd_end:
section .text
global ubytec_host_plain_DiagIdentity
ubytec_host_plain_DiagIdentity:
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
call func_446961674964656E74697479_df29784ec1034a8692cfb7481205813c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_plain_DiagBytes
ubytec_host_plain_DiagBytes:
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
call func_446961674279746573_2611db9285544f17af402349871a05e7_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_plain_DiagRecords
ubytec_host_plain_DiagRecords:
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
call func_446961675265636F726473_a535455b6ab845dca695385e308c313b_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .text
global ubytec_host_plain_DiagLookup
ubytec_host_plain_DiagLookup:
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
call func_446961674C6F6F6B7570_59fb7a16da374fb59bf32763db2c7e3c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
