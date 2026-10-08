module_646961676E6F737469635F6B65726E656C73_db4cd50cf7d84b40832c6f44f7b46072_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:19:01Z
  ; Module UUID: db4cd50c-f7d8-4b40-832c-6f44f7b46072


  section .bss

  section .text

  func_446961674964656E74697479_6af3487f02fc4a4784bbf467e2dd1d49_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_6af3487f02fc4a4784bbf467e2dd1d49_end
  func_446961674964656E74697479_6af3487f02fc4a4784bbf467e2dd1d49_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_3ce521f1657e4f16ae8acfc3bd0b4847_start:
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
  while_7c70719232f94d54b163cc7c4c8ad829: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_5a795a51c7304f65ad09d05376caa6fe
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
    jmp while_7c70719232f94d54b163cc7c4c8ad829 ; Reevaluate WHILE condition
  end_while_5a795a51c7304f65ad09d05376caa6fe: ; END of while_7c70719232f94d54b163cc7c4c8ad829
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_3ce521f1657e4f16ae8acfc3bd0b4847_end
  func_446961674279746573_3ce521f1657e4f16ae8acfc3bd0b4847_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_9784022217204ceaa3c826fc7e15bdce_start:
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
  while_7e709700c34a4df99855452e6bda63b9: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_5b3771f480e44a058d8622a12d8e3f4f
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
    jmp while_7e709700c34a4df99855452e6bda63b9 ; Reevaluate WHILE condition
  end_while_5b3771f480e44a058d8622a12d8e3f4f: ; END of while_7e709700c34a4df99855452e6bda63b9
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_9784022217204ceaa3c826fc7e15bdce_end
  func_446961675265636F726473_9784022217204ceaa3c826fc7e15bdce_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_e95fadfb18894b0cbe9d2f66543fee5e_start:
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
  while_2aa7abcb90d54590a1c71c8fc1401892: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_fb1ddc48a6a4441cb7a14cb5cdc094b4
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
  if_3813cbf066874fa3b8c419342f1273d4: ; IF start
  pop rax
    test rax, rax
    je end_if_9810be5ed2df4520982acda8543d0e05
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_4e757514f54446b08891e5c0dc19ef52: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_d1ac3870d9ed497895a8bdc30ff9881e
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
  if_471825bc1191403ea219dd09d0f3ffde: ; IF start
  pop rax
    test rax, rax
    je end_if_adb6736f30274038ac5e7f3933d65c4f
  jmp end_while_d1ac3870d9ed497895a8bdc30ff9881e ; BREAK
  end_if_adb6736f30274038ac5e7f3933d65c4f: ; END of if_471825bc1191403ea219dd09d0f3ffde
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_4e757514f54446b08891e5c0dc19ef52 ; Reevaluate WHILE condition
  end_while_d1ac3870d9ed497895a8bdc30ff9881e: ; END of while_4e757514f54446b08891e5c0dc19ef52
  if_70fbbac7074443e7b964cd132fa9ddce: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_8248dd71afbf492293c38e97f8497061
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_e95fadfb18894b0cbe9d2f66543fee5e_end
  end_if_8248dd71afbf492293c38e97f8497061: ; END of if_70fbbac7074443e7b964cd132fa9ddce
  end_if_9810be5ed2df4520982acda8543d0e05: ; END of if_3813cbf066874fa3b8c419342f1273d4
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_2aa7abcb90d54590a1c71c8fc1401892 ; Reevaluate WHILE condition
  end_while_fb1ddc48a6a4441cb7a14cb5cdc094b4: ; END of while_2aa7abcb90d54590a1c71c8fc1401892
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_e95fadfb18894b0cbe9d2f66543fee5e_end
  func_446961674C6F6F6B7570_e95fadfb18894b0cbe9d2f66543fee5e_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_db4cd50cf7d84b40832c6f44f7b46072_end:
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
call func_446961674279746573_3ce521f1657e4f16ae8acfc3bd0b4847_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
