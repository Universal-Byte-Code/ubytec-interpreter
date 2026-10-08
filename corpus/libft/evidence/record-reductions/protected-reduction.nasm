module_646961676E6F737469635F6B65726E656C73_b2de427a76164cbe90b71a3deaf59a75_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:35:39Z
  ; Module UUID: b2de427a-7616-4cbe-90b7-1a3deaf59a75


  section .bss

  section .text

  func_446961674964656E74697479_29f746cfdf0b47ebbf13cc66bbe4bb50_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_29f746cfdf0b47ebbf13cc66bbe4bb50_end
  func_446961674964656E74697479_29f746cfdf0b47ebbf13cc66bbe4bb50_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_3fce9afd9ebf471785089e0ec4fefc7b_start:
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
  while_f6385a98aed34d469b66d22d86f7a73b: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_ee87a80938554d00b0c84dabef406ee3
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
    jmp while_f6385a98aed34d469b66d22d86f7a73b ; Reevaluate WHILE condition
  end_while_ee87a80938554d00b0c84dabef406ee3: ; END of while_f6385a98aed34d469b66d22d86f7a73b
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_3fce9afd9ebf471785089e0ec4fefc7b_end
  func_446961674279746573_3fce9afd9ebf471785089e0ec4fefc7b_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_start:
  push rbp
    mov rbp, rsp
  sub rsp, 16
  mov rax, 0x0000000000000000
    mov qword [rbp - 8], rax
  mov rax, 0x0000000000000000
    mov qword [rbp - 16], rax
  ; record-reductions: scalar UInt64, stride 24, offset 16, observable stack retained
  mov rdx, qword [rbp + 24]
    mov r10, qword [rbp + 16]
  mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
  imul rdi, r8, 24
    add rdi, rdx
    add rdi, 16
  func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_start_record_reduce:
  cmp r8, r10
    jae func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_start_record_reduce_done
  mov qword [rsp - 8], r9
    mov qword [rsp - 24], 16
  mov qword [rsp - 32], 24
    mov qword [rsp - 16], rdi
  lea rsp, [rsp - 8]
    mov rax, qword [rdi]
  mov qword [rsp - 8], rax
    add r9, rax
  mov qword [rbp - 16], r9
    inc r8
    mov qword [rbp - 8], r8
  lea rsp, [rsp + 8]
    mov qword [rsp - 8], r8
    add rdi, 24
    jmp func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_start_record_reduce
  func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_start_record_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_end
  func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_a40977ea2aa044108e8991e9436cb622_start:
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
  while_907e906177734015bafd7434644de478: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_5e38711ff21e40b987e474023c8664f0
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
  if_ce270580ad764a65a9dc59c212b18125: ; IF start
  pop rax
    test rax, rax
    je end_if_1f35f33994554f44be97cba1265d54dd
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_5d36e5fbc07c4b32b33b164fb7219629: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_5a1842b0fdab4254935b21505aca4397
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
  if_1fdc8fef89b3456abb35d37c2d6714c0: ; IF start
  pop rax
    test rax, rax
    je end_if_1ec5e50393ee464a8353da70c8203241
  jmp end_while_5a1842b0fdab4254935b21505aca4397 ; BREAK
  end_if_1ec5e50393ee464a8353da70c8203241: ; END of if_1fdc8fef89b3456abb35d37c2d6714c0
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_5d36e5fbc07c4b32b33b164fb7219629 ; Reevaluate WHILE condition
  end_while_5a1842b0fdab4254935b21505aca4397: ; END of while_5d36e5fbc07c4b32b33b164fb7219629
  if_ac5c960779a843b28458080cacfebd28: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_967b8f18297a4274ae63f684832bc36a
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a40977ea2aa044108e8991e9436cb622_end
  end_if_967b8f18297a4274ae63f684832bc36a: ; END of if_ac5c960779a843b28458080cacfebd28
  end_if_1f35f33994554f44be97cba1265d54dd: ; END of if_ce270580ad764a65a9dc59c212b18125
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_907e906177734015bafd7434644de478 ; Reevaluate WHILE condition
  end_while_5e38711ff21e40b987e474023c8664f0: ; END of while_907e906177734015bafd7434644de478
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_a40977ea2aa044108e8991e9436cb622_end
  func_446961674C6F6F6B7570_a40977ea2aa044108e8991e9436cb622_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_b2de427a76164cbe90b71a3deaf59a75_end:
section .text
global ubytec_host_contract_Fold
ubytec_host_contract_Fold:
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
call func_446961675265636F726473_7ad5eda2997f4bd196fc4fae84e618ad_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,70,111,108,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,70,111,108,100,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
