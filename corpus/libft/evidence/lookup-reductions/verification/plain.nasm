module_646961676E6F737469635F6B65726E656C73_8c2c0e346832482c884dc47d69e87f0a_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 02:04:37Z
  ; Module UUID: 8c2c0e34-6832-482c-884d-c47d69e87f0a


  section .bss

  section .text

  func_446961674964656E74697479_d3d1bdc9608947a0beca5eeece53128c_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_d3d1bdc9608947a0beca5eeece53128c_end
  func_446961674964656E74697479_d3d1bdc9608947a0beca5eeece53128c_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_52d22b780e9b47cf900f82238cd74abb_start:
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
  while_42fdee81782d48168af29066b2bd4546: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_226ac110880e46b38ae7fa2c5e6e8890
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
    jmp while_42fdee81782d48168af29066b2bd4546 ; Reevaluate WHILE condition
  end_while_226ac110880e46b38ae7fa2c5e6e8890: ; END of while_42fdee81782d48168af29066b2bd4546
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_52d22b780e9b47cf900f82238cd74abb_end
  func_446961674279746573_52d22b780e9b47cf900f82238cd74abb_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_fa1e0ab2abeb455b8d6ecb5344ee033e_start:
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
  while_7dd54a817e7c40c9a2f099955eb37021: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_7462984a181548b1be4019cb020cbf6b
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
    jmp while_7dd54a817e7c40c9a2f099955eb37021 ; Reevaluate WHILE condition
  end_while_7462984a181548b1be4019cb020cbf6b: ; END of while_7dd54a817e7c40c9a2f099955eb37021
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961675265636F726473_fa1e0ab2abeb455b8d6ecb5344ee033e_end
  func_446961675265636F726473_fa1e0ab2abeb455b8d6ecb5344ee033e_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_141a790abbc942f182e3a468269c936b_start:
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
  while_c23918ce78a6499fb026d27a5141d99f: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_28d65c6131f645c38679e68afe1e05be
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
  if_944391a3423247f795d11feb3880b272: ; IF start
  pop rax
    test rax, rax
    je end_if_23a1019afb29447aa5b6538372d96ee0
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_7afda18863434af79e92d880b5b9d375: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_32ef009145004492bfb988ad70adeec2
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
  if_2b3339ae58e949a796ab35f60bc4ff88: ; IF start
  pop rax
    test rax, rax
    je end_if_717b028a051b4031a65072626263236d
  jmp end_while_32ef009145004492bfb988ad70adeec2 ; BREAK
  end_if_717b028a051b4031a65072626263236d: ; END of if_2b3339ae58e949a796ab35f60bc4ff88
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_7afda18863434af79e92d880b5b9d375 ; Reevaluate WHILE condition
  end_while_32ef009145004492bfb988ad70adeec2: ; END of while_7afda18863434af79e92d880b5b9d375
  if_164c246a20eb46ca92a9bd5a5af9afa4: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_31907a9d9caf4d83aaa88378c7a9b4ac
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_141a790abbc942f182e3a468269c936b_end
  end_if_31907a9d9caf4d83aaa88378c7a9b4ac: ; END of if_164c246a20eb46ca92a9bd5a5af9afa4
  end_if_23a1019afb29447aa5b6538372d96ee0: ; END of if_944391a3423247f795d11feb3880b272
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_c23918ce78a6499fb026d27a5141d99f ; Reevaluate WHILE condition
  end_while_28d65c6131f645c38679e68afe1e05be: ; END of while_c23918ce78a6499fb026d27a5141d99f
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_141a790abbc942f182e3a468269c936b_end
  func_446961674C6F6F6B7570_141a790abbc942f182e3a468269c936b_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_8c2c0e346832482c884dc47d69e87f0a_end:
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
call func_446961674964656E74697479_d3d1bdc9608947a0beca5eeece53128c_start
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
call func_446961674279746573_52d22b780e9b47cf900f82238cd74abb_start
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
call func_446961675265636F726473_fa1e0ab2abeb455b8d6ecb5344ee033e_start
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
call func_446961674C6F6F6B7570_141a790abbc942f182e3a468269c936b_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
