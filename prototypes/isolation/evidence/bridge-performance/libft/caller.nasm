  module_636861696E5F63616C6C6572_9da19ed219e8479fb6326ada56032627_start:
  ; Module: chain_caller v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 01:27:46Z
    ; Module UUID: 9da19ed2-19e8-479f-b632-6ada56032627


    section .bss

    section .text

    func_53706C6974_683ef8e25f7540a9803d7d1b1af34ab0_start:
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
    mov rax, 0x0000000000000001
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
    call ubytec_import_ReadLength
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_863f759772c04a7fba99448ae8d69c2f: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_9b986ee59d514511bcccace305c5e249
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      
      jmp func_53706C6974_683ef8e25f7540a9803d7d1b1af34ab0_end
    end_if_9b986ee59d514511bcccace305c5e249: ; END of if_863f759772c04a7fba99448ae8d69c2f
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
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
    pop rax
      mov rax, qword [rax]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, 0x0000000000000003
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
    call ubytec_import_CopyMemory
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_afa8a1eb8e65422bb39d2463e53f4be4: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_63ab235ee9c848ee85bd94d8b37d81d8
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      
      jmp func_53706C6974_683ef8e25f7540a9803d7d1b1af34ab0_end
    end_if_63ab235ee9c848ee85bd94d8b37d81d8: ; END of if_afa8a1eb8e65422bb39d2463e53f4be4
    
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
      
      jmp func_53706C6974_683ef8e25f7540a9803d7d1b1af34ab0_end
    func_53706C6974_683ef8e25f7540a9803d7d1b1af34ab0_end:
      mov rsp, rbp
      pop rbp
      ret
    func_47726F7570_baf2fa6600e54d91af805a2bd6d6c623_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, 0x0000000000000003
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
    call ubytec_import_Grouped
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_6a479304d12b470ebb500598e729a2b5: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_ce1506eed0584398bdb468746ab8c295
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      
      jmp func_47726F7570_baf2fa6600e54d91af805a2bd6d6c623_end
    end_if_ce1506eed0584398bdb468746ab8c295: ; END of if_6a479304d12b470ebb500598e729a2b5
    
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
      
      jmp func_47726F7570_baf2fa6600e54d91af805a2bd6d6c623_end
    func_47726F7570_baf2fa6600e54d91af805a2bd6d6c623_end:
      mov rsp, rbp
      pop rbp
      ret
    func_44656E696564_6265335fa18e4eb885e38606bda2d908_start:
    push rbp
      mov rbp, rsp
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, 0x0000000000000003
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
    call ubytec_import_CopyHidden
      add rsp, 40
      push rax
    pop rax
      
      jmp func_44656E696564_6265335fa18e4eb885e38606bda2d908_end
    func_44656E696564_6265335fa18e4eb885e38606bda2d908_end:
      mov rsp, rbp
      pop rbp
      ret
    func_526561644F6E6C79_e6f95f4e3543483ea886ce4363d61bbd_start:
    push rbp
      mov rbp, rsp
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, 0x0000000000000001
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
    call ubytec_import_CopyMemory
      add rsp, 40
      push rax
    pop rax
      
      jmp func_526561644F6E6C79_e6f95f4e3543483ea886ce4363d61bbd_end
    func_526561644F6E6C79_e6f95f4e3543483ea886ce4363d61bbd_end:
      mov rsp, rbp
      pop rbp
      ret
    func_41747461636B_648a344e93da4148aff5b2bbe585aaaf_start:
    push rbp
      mov rbp, rsp
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, 0x0000000000000001
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
    call ubytec_import_EscapeMemory
      add rsp, 40
      push rax
    pop rax
      
      jmp func_41747461636B_648a344e93da4148aff5b2bbe585aaaf_end
    func_41747461636B_648a344e93da4148aff5b2bbe585aaaf_end:
      mov rsp, rbp
      pop rbp
      ret
module_636861696E5F63616C6C6572_9da19ed219e8479fb6326ada56032627_end:

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
ubytec_import_ReadLength:
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
ubytec_import_CopyMemory:
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
ubytec_import_CopyHidden:
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
ubytec_import_EscapeMemory:
 push rbp
 mov rbp,rsp
 push 4
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
ubytec_import_Grouped:
 push rbp
 mov rbp,rsp
 push 5
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
global ubytec_host_contract_Split
ubytec_host_contract_Split:
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
call func_53706C6974_683ef8e25f7540a9803d7d1b1af34ab0_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Group
ubytec_host_contract_Group:
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
call func_47726F7570_baf2fa6600e54d91af805a2bd6d6c623_start
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
call func_44656E696564_6265335fa18e4eb885e38606bda2d908_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_ReadOnly
ubytec_host_contract_ReadOnly:
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
call func_526561644F6E6C79_e6f95f4e3543483ea886ce4363d61bbd_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .text
global ubytec_host_contract_Attack
ubytec_host_contract_Attack:
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
call func_41747461636B_648a344e93da4148aff5b2bbe585aaaf_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,82,101,97,100,76,101,110,103,116,104,124,115,116,114,105,110,103,115,124,76,101,110,103,116,104,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,50,124,67,111,112,121,77,101,109,111,114,121,124,109,101,109,111,114,121,124,67,111,112,121,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,51,124,67,111,112,121,72,105,100,100,101,110,124,109,101,109,111,114,121,124,67,111,112,121,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,52,124,69,115,99,97,112,101,77,101,109,111,114,121,124,109,101,109,111,114,121,124,69,115,99,97,112,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,53,124,71,114,111,117,112,101,100,124,103,114,111,117,112,101,100,124,80,105,112,101,108,105,110,101,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,83,112,108,105,116,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,83,112,108,105,116,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,71,114,111,117,112,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,71,114,111,117,112,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,68,101,110,105,101,100,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,68,101,110,105,101,100,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,82,101,97,100,79,110,108,121,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,82,101,97,100,79,110,108,121,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,65,116,116,97,99,107,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,65,116,116,97,99,107,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
