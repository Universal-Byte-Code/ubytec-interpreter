module_646961676E6F737469635F6B65726E656C73_ce2824496a894797b1efa5e8324eded3_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 02:04:47Z
  ; Module UUID: ce282449-6a89-4797-b1ef-a5e8324eded3


  section .bss

  section .text

  func_446961674964656E74697479_2d82710896b942db82e4380cb920ea2e_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_2d82710896b942db82e4380cb920ea2e_end
  func_446961674964656E74697479_2d82710896b942db82e4380cb920ea2e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_23d848a2b6994932a26551a2dd196afd_start:
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
  while_a34af401f8934191a13376e2fbf4fffc: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_4cee7a552e264e7e83ea9f3c261041df
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
    jmp while_a34af401f8934191a13376e2fbf4fffc ; Reevaluate WHILE condition
  end_while_4cee7a552e264e7e83ea9f3c261041df: ; END of while_a34af401f8934191a13376e2fbf4fffc
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_23d848a2b6994932a26551a2dd196afd_end
  func_446961674279746573_23d848a2b6994932a26551a2dd196afd_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_c414aa0a3a9f430a8d7ddbe8043a7cd0_start:
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
  while_08a1dadf65404d319a0ea23e0afae21a: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_8ac8ddaed15343b9b000bacc7e382113
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
    jmp while_08a1dadf65404d319a0ea23e0afae21a ; Reevaluate WHILE condition
  end_while_8ac8ddaed15343b9b000bacc7e382113: ; END of while_08a1dadf65404d319a0ea23e0afae21a
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_c414aa0a3a9f430a8d7ddbe8043a7cd0_end
  func_446961675265636F726473_c414aa0a3a9f430a8d7ddbe8043a7cd0_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start:
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
  func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_outer:
  cmp r8, rcx
  jae func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_missing
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
  jz func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_advance
  mov qword [rsp - 8], r10
  ; Name-pointer read retains key length and stride in the deeper cells.
  mov rax, qword [r10]
  movq xmm1, rax
  mov qword [rsp - 8], rax
  mov qword [rbp - 32], rax
  mov qword [rsp - 8], 0
  xor r9d, r9d
  mov qword [rbp - 16], r9
  func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_inner:
  cmp r9, rdx
  jae func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_inner_done
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
  jnz func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_inner_done
  inc r9
  mov qword [rbp - 16], r9
  mov qword [rsp - 8], r9
  jmp func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_inner
  func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_inner_done:
  cmp r9, rdx
  jne func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_advance
  lea rax, [r8 + 1]
  mov qword [rsp - 8], rax
  jmp func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_end
  func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_advance:
  inc r8
  mov qword [rbp - 8], r8
  mov qword [rsp - 8], r8
  add r10, 24
  jmp func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_outer
  func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start_lookup_reduce_missing:
  xor eax, eax
  mov qword [rsp - 8], rax
  jmp func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_end
  func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_ce2824496a894797b1efa5e8324eded3_end:
section .text
global ubytec_host_contract_Find
extern fixture_lookup
ubytec_host_contract_Find:
 jmp fixture_lookup
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,70,105,110,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,70,105,110,100,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .text
global ubytec_host_candidate_DiagLookup
ubytec_host_candidate_DiagLookup:
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
call func_446961674C6F6F6B7570_4e71e87ef48245f18a7b9105dab2a2c0_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
