module_646961676E6F737469635F6B65726E656C73_4d9ebee38315499087ae964c1de71def_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-05 22:48:29Z
  ; Module UUID: 4d9ebee3-8315-4990-87ae-964c1de71def


  section .bss

  section .text

  func_446961674964656E74697479_5c242cbce13b43e7b650fdb845d328df_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_5c242cbce13b43e7b650fdb845d328df_end
  func_446961674964656E74697479_5c242cbce13b43e7b650fdb845d328df_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_e781acda08234ceb934c0e6042250878_start:
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
  while_7fd9e5410a08455c81d8163553810ec6: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_7b9ddf9b7e5d422790beb821be8c7bef
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
    jmp while_7fd9e5410a08455c81d8163553810ec6 ; Reevaluate WHILE condition
  end_while_7b9ddf9b7e5d422790beb821be8c7bef: ; END of while_7fd9e5410a08455c81d8163553810ec6
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_e781acda08234ceb934c0e6042250878_end
  func_446961674279746573_e781acda08234ceb934c0e6042250878_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_281e3a6940d640fb887d37dcd2311a4a_start:
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
  while_5db177b55c6f47d8b719ade58ff6010d: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_c7a7f7334c6e49cc8f29d8a317d7dd2e
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
    jmp while_5db177b55c6f47d8b719ade58ff6010d ; Reevaluate WHILE condition
  end_while_c7a7f7334c6e49cc8f29d8a317d7dd2e: ; END of while_5db177b55c6f47d8b719ade58ff6010d
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_281e3a6940d640fb887d37dcd2311a4a_end
  func_446961675265636F726473_281e3a6940d640fb887d37dcd2311a4a_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_71dd7fe51dd845f0bca072d8de756297_start:
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
  while_21d75fda97ad45eca701b7ccd835b363: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_9db91817f5ad4139a51ca0614c4434d7
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
  if_b6287e98b902407da5593a61270c7ae5: ; IF start
  pop rax
    test rax, rax
    je end_if_56cf923d9704473abdfec0d094f6d0ee
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_c9433dff42ef47ddb645da4603e3d765: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_937c4bff229c4fc68af786d5ac05546b
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
  if_5b0ce36c7f9c443797e8fc2100e85fb6: ; IF start
  pop rax
    test rax, rax
    je end_if_d60dd20b79304ac4bcd96f26cc42d905
  jmp end_while_937c4bff229c4fc68af786d5ac05546b ; BREAK
  end_if_d60dd20b79304ac4bcd96f26cc42d905: ; END of if_5b0ce36c7f9c443797e8fc2100e85fb6
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_c9433dff42ef47ddb645da4603e3d765 ; Reevaluate WHILE condition
  end_while_937c4bff229c4fc68af786d5ac05546b: ; END of while_c9433dff42ef47ddb645da4603e3d765
  if_f4c159381b5e406a8d35b45fe5d74097: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_a93eb08c4f2647a99000ea966d7e8980
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_71dd7fe51dd845f0bca072d8de756297_end
  end_if_a93eb08c4f2647a99000ea966d7e8980: ; END of if_f4c159381b5e406a8d35b45fe5d74097
  end_if_56cf923d9704473abdfec0d094f6d0ee: ; END of if_b6287e98b902407da5593a61270c7ae5
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_21d75fda97ad45eca701b7ccd835b363 ; Reevaluate WHILE condition
  end_while_9db91817f5ad4139a51ca0614c4434d7: ; END of while_21d75fda97ad45eca701b7ccd835b363
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_71dd7fe51dd845f0bca072d8de756297_end
  func_446961674C6F6F6B7570_71dd7fe51dd845f0bca072d8de756297_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_4d9ebee38315499087ae964c1de71def_end:
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
call func_446961674964656E74697479_5c242cbce13b43e7b650fdb845d328df_start
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
call func_446961674279746573_e781acda08234ceb934c0e6042250878_start
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
call func_446961675265636F726473_281e3a6940d640fb887d37dcd2311a4a_start
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
call func_446961674C6F6F6B7570_71dd7fe51dd845f0bca072d8de756297_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
