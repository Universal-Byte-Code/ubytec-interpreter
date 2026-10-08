  module_636C69656E74_923df7ec40ea482fb4bbd38aa142db57_start:
  ; Module: client v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 01:16:49Z
    ; Module UUID: 923df7ec-40ea-482f-b4bb-d38aa142db57


    section .bss

    section .text

    func_4D61696E_60562acd30f94a058271de2004c6b8aa_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_ReadTool
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_725a25e26f9644ac95d092a1715142ee: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      je end_if_3d0adb9d43ca40d5b8f81859ed796148
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      jmp func_4D61696E_60562acd30f94a058271de2004c6b8aa_end
    end_if_3d0adb9d43ca40d5b8f81859ed796148: ; END of if_725a25e26f9644ac95d092a1715142ee
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x0000000000000003
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_WriteMemory
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_0ab6d4538f704374adee017fe9b87f30: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      je end_if_5fad1558d00b46efa91536ec868f5f53
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      jmp func_4D61696E_60562acd30f94a058271de2004c6b8aa_end
    end_if_5fad1558d00b46efa91536ec868f5f53: ; END of if_0ab6d4538f704374adee017fe9b87f30
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_ReadTool
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_3fa2779054884c16a25c5262a1a3fab7: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      je end_if_bc7d527edc2b49b38e63e1d6e562956a
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      jmp func_4D61696E_60562acd30f94a058271de2004c6b8aa_end
    end_if_bc7d527edc2b49b38e63e1d6e562956a: ; END of if_3fa2779054884c16a25c5262a1a3fab7
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      jmp func_4D61696E_60562acd30f94a058271de2004c6b8aa_end
    func_4D61696E_60562acd30f94a058271de2004c6b8aa_end:
      mov rsp, rbp
      pop rbp
      ret
    func_44656E696564_8b8209ac8c564968bb1132a93082e92c_start:
    push rbp
      mov rbp, rsp
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call ubytec_import_Forbidden
      add rsp, 40
      push rax
    pop rax
      
      jmp func_44656E696564_8b8209ac8c564968bb1132a93082e92c_end
    func_44656E696564_8b8209ac8c564968bb1132a93082e92c_end:
      mov rsp, rbp
      pop rbp
      ret
module_636C69656E74_923df7ec40ea482fb4bbd38aa142db57_end:

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
ubytec_import_ReadTool:
 push rbp
 mov rbp,rsp
 push 1
 push qword [rbp+48]
 push qword [rbp+40]
 push qword [rbp+32]
 push qword [rbp+24]
 push qword [rbp+16]
 call ubytec_module_invoke
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_WriteMemory:
 push rbp
 mov rbp,rsp
 push 2
 push qword [rbp+48]
 push qword [rbp+40]
 push qword [rbp+32]
 push qword [rbp+24]
 push qword [rbp+16]
 call ubytec_module_invoke
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Forbidden:
 push rbp
 mov rbp,rsp
 push 3
 push qword [rbp+48]
 push qword [rbp+40]
 push qword [rbp+32]
 push qword [rbp+24]
 push qword [rbp+16]
 call ubytec_module_invoke
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
call func_4D61696E_60562acd30f94a058271de2004c6b8aa_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Denied
ubytec_host_contract_Denied:
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
call func_44656E696564_8b8209ac8c564968bb1132a93082e92c_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,82,101,97,100,84,111,111,108,124,116,111,111,108,115,124,82,101,97,100,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,50,124,87,114,105,116,101,77,101,109,111,114,121,124,109,101,109,111,114,121,124,87,114,105,116,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,51,124,70,111,114,98,105,100,100,101,110,124,116,111,111,108,115,124,72,105,100,100,101,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,68,101,110,105,101,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,68,101,110,105,101,100,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
