  module_626C6F636B5F63616C6C6572_4e32b14ace6b4043bec0916bda936f21_start:
  ; Module: block_caller v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-06 01:35:36Z
    ; Module UUID: 4e32b14a-ce6b-4043-bec0-916bda936f21


    section .bss

    section .text

    func_4D61696E_87f46657dad04f618316122884ecf04b_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    call ubytec_import_Fold
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_c9f7971066804be1827f8fd6b0f0891a: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_58e6bd66d57b43e19ef73369a32314f8
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      
      jmp func_4D61696E_87f46657dad04f618316122884ecf04b_end
    end_if_58e6bd66d57b43e19ef73369a32314f8: ; END of if_c9f7971066804be1827f8fd6b0f0891a
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      jmp func_4D61696E_87f46657dad04f618316122884ecf04b_end
    func_4D61696E_87f46657dad04f618316122884ecf04b_end:
      mov rsp, rbp
      pop rbp
      ret
module_626C6F636B5F63616C6C6572_4e32b14ace6b4043bec0916bda936f21_end:

section .text
extern ubytec_bridge_call
ubytec_module_invoke:
    push rbp
    mov rbp, rsp
    mov rdi, [rbp+56]
    mov rsi, [rbp+48]
    mov rdx, [rbp+40]
    mov rcx, [rbp+32]
    mov r8, [rbp+24]
    mov r9, [rbp+16]
    and rsp, -16
    call ubytec_bridge_call
    mov rsp, rbp
    pop rbp
    ret
section .text
ubytec_import_Fold:
 push rbp
 mov rbp,rsp
 push 1
 add rsp,8
 sub rsp,48
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,1
 lea rsi,[rbp-48]
 mov rdx,2
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
global ubytec_host_contract_Main
ubytec_host_contract_Main:
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
call func_4D61696E_87f46657dad04f618316122884ecf04b_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,70,111,108,100,124,109,101,109,111,114,121,124,70,111,108,100,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
