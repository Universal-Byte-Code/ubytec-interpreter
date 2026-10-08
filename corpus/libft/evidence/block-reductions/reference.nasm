module_646961676E6F737469635F6B65726E656C73_d75dc296f89b47c6b42ee6796198e61a_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 00:06:39Z
  ; Module UUID: d75dc296-f89b-47c6-b42e-e6796198e61a


  section .bss

  section .text

  func_446961674964656E74697479_3769c00cd75a44aa90630cc3a435ddcc_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_3769c00cd75a44aa90630cc3a435ddcc_end
  func_446961674964656E74697479_3769c00cd75a44aa90630cc3a435ddcc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_590dbfbd854049e38db6fba2cdd22a51_start:
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
  while_b67c532b093c4361a30b11a996d7f626: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_3e1087c4f8214b0586ec53978d57d456
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
    jmp while_b67c532b093c4361a30b11a996d7f626 ; Reevaluate WHILE condition
  end_while_3e1087c4f8214b0586ec53978d57d456: ; END of while_b67c532b093c4361a30b11a996d7f626
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_590dbfbd854049e38db6fba2cdd22a51_end
  func_446961674279746573_590dbfbd854049e38db6fba2cdd22a51_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_72cec29e659a4811bb0dca930f418a35_start:
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
  while_a5124389e6fa42beb7cdcfa50cc04512: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_d7c318ce113e4edfb90957462d1a3b85
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
    jmp while_a5124389e6fa42beb7cdcfa50cc04512 ; Reevaluate WHILE condition
  end_while_d7c318ce113e4edfb90957462d1a3b85: ; END of while_a5124389e6fa42beb7cdcfa50cc04512
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_72cec29e659a4811bb0dca930f418a35_end
  func_446961675265636F726473_72cec29e659a4811bb0dca930f418a35_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_2b3b89dd8c774701a76df49135134ec3_start:
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
  while_586ea5a97abe47db8eee0022d602e4eb: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_6ddd69f0ecfd4f88b241ee558bae6ee9
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
  if_db3ea301bc5948f790e8cc29c75b8577: ; IF start
  pop rax
    test rax, rax
    je end_if_e488d72805974e72948163fac06ca1a9
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_f4f6295b94be4f6f84411c99bb55cc56: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_0e28917bf16043edb634a0032a54d629
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
  if_6b0fd57350864eb386d10e3d6898d918: ; IF start
  pop rax
    test rax, rax
    je end_if_a9b6ba992fa24acb9a8dd22e4137cba4
  jmp end_while_0e28917bf16043edb634a0032a54d629 ; BREAK
  end_if_a9b6ba992fa24acb9a8dd22e4137cba4: ; END of if_6b0fd57350864eb386d10e3d6898d918
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_f4f6295b94be4f6f84411c99bb55cc56 ; Reevaluate WHILE condition
  end_while_0e28917bf16043edb634a0032a54d629: ; END of while_f4f6295b94be4f6f84411c99bb55cc56
  if_db316e6349b84b718fec56c5e0986c60: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_7f1af22fdbbb4d40a7c4f5f10fc279ff
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_2b3b89dd8c774701a76df49135134ec3_end
  end_if_7f1af22fdbbb4d40a7c4f5f10fc279ff: ; END of if_db316e6349b84b718fec56c5e0986c60
  end_if_e488d72805974e72948163fac06ca1a9: ; END of if_db3ea301bc5948f790e8cc29c75b8577
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_586ea5a97abe47db8eee0022d602e4eb ; Reevaluate WHILE condition
  end_while_6ddd69f0ecfd4f88b241ee558bae6ee9: ; END of while_586ea5a97abe47db8eee0022d602e4eb
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_2b3b89dd8c774701a76df49135134ec3_end
  func_446961674C6F6F6B7570_2b3b89dd8c774701a76df49135134ec3_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_d75dc296f89b47c6b42ee6796198e61a_end:
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
call func_446961674279746573_590dbfbd854049e38db6fba2cdd22a51_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
