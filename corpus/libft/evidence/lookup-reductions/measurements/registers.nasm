module_646961676E6F737469635F6B65726E656C73_e3d21a339dd1426d90323169c2b7c4ce_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 02:06:47Z
  ; Module UUID: e3d21a33-9dd1-426d-9032-3169c2b7c4ce


  section .bss

  section .text

  func_446961674964656E74697479_51f5114a77dc4d75a698d2ae7f728128_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_51f5114a77dc4d75a698d2ae7f728128_end
  func_446961674964656E74697479_51f5114a77dc4d75a698d2ae7f728128_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_c69513e971d34fccb7ebbe1659082d8e_start:
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
  while_6a454c8b149a4acbba2db9e228cd3f2b: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_02ca58658cb041c69bf3b68cb532e8f4
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
    jmp while_6a454c8b149a4acbba2db9e228cd3f2b ; Reevaluate WHILE condition
  end_while_02ca58658cb041c69bf3b68cb532e8f4: ; END of while_6a454c8b149a4acbba2db9e228cd3f2b
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_c69513e971d34fccb7ebbe1659082d8e_end
  func_446961674279746573_c69513e971d34fccb7ebbe1659082d8e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_b78a311cac2c46f09830ed605b24e27c_start:
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
  while_5e87166e78ec43a08ec6b51f690acfdb: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_9af4998f7fc64f14bb0276c923474d57
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
    jmp while_5e87166e78ec43a08ec6b51f690acfdb ; Reevaluate WHILE condition
  end_while_9af4998f7fc64f14bb0276c923474d57: ; END of while_5e87166e78ec43a08ec6b51f690acfdb
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_b78a311cac2c46f09830ed605b24e27c_end
  func_446961675265636F726473_b78a311cac2c46f09830ed605b24e27c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start:
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
  ; lookup-reductions: nested scalar bytes, stride 24, length offset 8, observable stack retained
  mov r8, qword [rbp - 8]
  mov rax, qword [rbp + 40]
  imul r10, r8, 24
  add r10, rax
  mov rcx, qword [rbp + 32]
  mov rdx, qword [rbp + 16]
  movq xmm0, qword [rbp + 24]
  func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_outer:
  cmp r8, rcx
  jae func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_missing
  mov qword [rbp - 24], r10
  mov qword [rsp - 24], 24
  mov qword [rsp - 16], 8
  lea rax, [r10 + 8]
  mov qword [rsp - 8], rax
  ; Length read: RSP=S, ledger=(address, length offset, stride).
  mov rax, qword [rax]
  mov qword [rsp - 8], rax
  mov qword [rsp - 16], rdx
  cmp rax, rdx
  sete al
  movzx eax, al
  mov qword [rsp - 8], rax
  test eax, eax
  jz func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_advance
  mov qword [rsp - 8], r10
  ; Name-pointer read retains key length and stride in the deeper cells.
  mov rax, qword [r10]
  movq xmm1, rax
  mov qword [rsp - 8], rax
  mov qword [rbp - 32], rax
  mov qword [rsp - 8], 0
  xor r9d, r9d
  mov qword [rbp - 16], r9
  func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_inner:
  cmp r9, rdx
  jae func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_inner_done
  movq rax, xmm1
  add rax, r9
  mov qword [rsp - 8], rax
  mov qword [rsp - 16], r9
  ; Read the name byte first; do not prewrite the key-byte ledger.
  movzx eax, byte [rax]
  mov qword [rsp - 8], rax
  mov qword [rsp - 24], r9
  movq rax, xmm0
  add rax, r9
  mov qword [rsp - 16], rax
  lea rsp, [rsp - 8]
  ; Key read: RSP=S-8, ledger=(name byte, key address, inner index).
  movzx eax, byte [rax]
  mov qword [rsp - 8], rax
  cmp rax, qword [rsp]
  setne al
  movzx eax, al
  mov qword [rsp], rax
  lea rsp, [rsp + 8]
  test eax, eax
  jnz func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_inner_done
  inc r9
  mov qword [rbp - 16], r9
  mov qword [rsp - 8], r9
  jmp func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_inner
  func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_inner_done:
  cmp r9, rdx
  jne func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_advance
  lea rax, [r8 + 1]
  mov qword [rsp - 8], rax
  jmp func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_end
  func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_advance:
  inc r8
  mov qword [rbp - 8], r8
  mov qword [rsp - 8], r8
  add r10, 24
  jmp func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_outer
  func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start_lookup_reduce_missing:
  xor eax, eax
  mov qword [rsp - 8], rax
  jmp func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_end
  func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_e3d21a339dd1426d90323169c2b7c4ce_end:
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
call func_446961674964656E74697479_51f5114a77dc4d75a698d2ae7f728128_start
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
call func_446961674279746573_c69513e971d34fccb7ebbe1659082d8e_start
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
call func_446961675265636F726473_b78a311cac2c46f09830ed605b24e27c_start
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
call func_446961674C6F6F6B7570_28d89c6221cb4a97985ac5d0106a9d04_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
