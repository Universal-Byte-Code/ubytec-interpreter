module_646961676E6F737469635F6B65726E656C73_c64ff7630f304fe687a7704176cd7719_start:
; Module: diagnostic_kernels v0.1 by Ubytec

  section .data

  ; ---------------- Metadata ----------------
  ; Compilation UTC Time: 2026-10-06 01:36:39Z
  ; Module UUID: c64ff763-0f30-4fe6-87a7-704176cd7719


  section .bss

  section .text

  func_446961674964656E74697479_3074135b61e4430599925782f7e32522_start:
  push rbp
    mov rbp, rsp
  mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
    
    jmp func_446961674964656E74697479_3074135b61e4430599925782f7e32522_end
  func_446961674964656E74697479_3074135b61e4430599925782f7e32522_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674279746573_14ff61d991444b9da44405a465a461fc_start:
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
  while_0d504feea315498a9f66adcbb858a9aa: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_8d1873dfee7d4ee0975b03a9b8bac7bd
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
    jmp while_0d504feea315498a9f66adcbb858a9aa ; Reevaluate WHILE condition
  end_while_8d1873dfee7d4ee0975b03a9b8bac7bd: ; END of while_0d504feea315498a9f66adcbb858a9aa
  mov qword [rsp - 8], r9
  mov rax, r9
    
    jmp func_446961674279746573_14ff61d991444b9da44405a465a461fc_end
  func_446961674279746573_14ff61d991444b9da44405a465a461fc_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_start:
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
  func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_start_record_reduce:
  cmp r8, r10
    jae func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_start_record_reduce_done
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
    jmp func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_start_record_reduce
  func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_start_record_reduce_done:
  mov rax, r9
    mov qword [rsp - 8], rax
    jmp func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_end
  func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_end:
    mov rsp, rbp
    pop rbp
    ret
  func_446961674C6F6F6B7570_294e48065e574bb695629bfc18407a6a_start:
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
  while_5c80543069d14bdaa0954f1cdc331fce: ; WHILE start
  mov rax, qword [rbp + 32]
    mov rcx, rax
    mov rax, r9
    cmp rax, rcx
    jae end_while_8a91380b34294e6ea2a7a208ee629377
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
  if_123ae26b23324ba29a033330a98adb86: ; IF start
  pop rax
    test rax, rax
    je end_if_92181a508dcb41f0abe547abbd8f1c75
  mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
    mov rax, qword [rax]
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 32], rax
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
  while_aa25bb22852f4858a6aaa225d4d5e41c: ; WHILE start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jae end_while_87662936fed840948a01124c7114b67d
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
  if_660e89c8bfca4369b47bc3d4007ba68e: ; IF start
  pop rax
    test rax, rax
    je end_if_8ca8bebf9a0d4c12b57b717f213116c0
  jmp end_while_87662936fed840948a01124c7114b67d ; BREAK
  end_if_8ca8bebf9a0d4c12b57b717f213116c0: ; END of if_660e89c8bfca4369b47bc3d4007ba68e
  mov qword [rsp - 8], r8
  mov rax, r8
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 16], rax
    mov r8, rax
    jmp while_aa25bb22852f4858a6aaa225d4d5e41c ; Reevaluate WHILE condition
  end_while_87662936fed840948a01124c7114b67d: ; END of while_aa25bb22852f4858a6aaa225d4d5e41c
  if_b61373c3f1464df3894ae3b7138a594f: ; IF start
  mov rax, r10
    mov rcx, rax
    mov rax, r8
    cmp rax, rcx
    jne end_if_670047aa323840749ed6cd28975fb29a
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_294e48065e574bb695629bfc18407a6a_end
  end_if_670047aa323840749ed6cd28975fb29a: ; END of if_b61373c3f1464df3894ae3b7138a594f
  end_if_92181a508dcb41f0abe547abbd8f1c75: ; END of if_123ae26b23324ba29a033330a98adb86
  mov qword [rsp - 8], r9
  mov rax, r9
    inc rax
  mov qword [rsp - 8], rax
    
    mov qword [rbp - 8], rax
    mov r9, rax
    jmp while_5c80543069d14bdaa0954f1cdc331fce ; Reevaluate WHILE condition
  end_while_8a91380b34294e6ea2a7a208ee629377: ; END of while_5c80543069d14bdaa0954f1cdc331fce
  mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
    
    jmp func_446961674C6F6F6B7570_294e48065e574bb695629bfc18407a6a_end
  func_446961674C6F6F6B7570_294e48065e574bb695629bfc18407a6a_end:
    mov rsp, rbp
    pop rbp
    ret
module_646961676E6F737469635F6B65726E656C73_c64ff7630f304fe687a7704176cd7719_end:
section .text
global ubytec_host_reduction_DiagRecords
ubytec_host_reduction_DiagRecords:
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
call func_446961675265636F726473_7d372ef930514a3fa4ba94c9b4d0fdc5_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

section .note.GNU-stack noalloc noexec nowrite progbits
