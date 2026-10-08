  module_6C6F6F6B75705F63616C6C6572_95ad26e65fa3484aa596ba17a6e6f0ff_start:
  ; Module: lookup_caller v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-06 02:04:43Z
    ; Module UUID: 95ad26e6-5fa3-484a-a596-ba17a6e6f0ff


    section .bss

    section .text

    func_4D61696E_bd0c7e1c467148baaebecc5ce7d4734f_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000020
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
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000020
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
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000018
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
    call ubytec_import_Find
      add rsp, 64
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_5219e874837a4aec957bd5cdc3d71077: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_5dbf3dc3ec28429aa2013328f49ca2df
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      
      jmp func_4D61696E_bd0c7e1c467148baaebecc5ce7d4734f_end
    end_if_5dbf3dc3ec28429aa2013328f49ca2df: ; END of if_5219e874837a4aec957bd5cdc3d71077
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
      
      jmp func_4D61696E_bd0c7e1c467148baaebecc5ce7d4734f_end
    func_4D61696E_bd0c7e1c467148baaebecc5ce7d4734f_end:
      mov rsp, rbp
      pop rbp
      ret
module_6C6F6F6B75705F63616C6C6572_95ad26e65fa3484aa596ba17a6e6f0ff_end:

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
ubytec_import_Find:
 push rbp
 mov rbp,rsp
 push 1
 add rsp,8
 sub rsp,96
 mov qword [rbp-96],2
 mov rax,[rbp+72]
 mov [rbp-88],rax
 mov rax,[rbp+64]
 mov [rbp-80],rax
 mov qword [rbp-72],3
 mov rax,[rbp+56]
 mov [rbp-64],rax
 mov qword [rbp-56],0
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
 lea rsi,[rbp-96]
 mov rdx,4
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
call func_4D61696E_bd0c7e1c467148baaebecc5ce7d4734f_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,70,105,110,100,124,109,101,109,111,114,121,124,70,105,110,100,124,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,85,73,110,116,54,52,10,69,124,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
