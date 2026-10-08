  module_746578745F7472616E736665725F62656E63686D61726B_2572338015bf4131a51f42222f9e5ab5_start:
  ; Module: text_transfer_benchmark v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 21:08:29Z
    ; Module UUID: 25723380-15bf-4131-a51f-42222f9e5ab5


    section .bss

    section .text

    func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_start:
    push rbp
      mov rbp, rsp
    sub rsp, 48
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 16], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 24], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 32], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 48], rax
    if_a901d41da0b14249a39d6ba37ead45c6: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_a3ef4dae810b4bfd862a8ee4b22d927d
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end
    end_if_a3ef4dae810b4bfd862a8ee4b22d927d: ; END of if_a901d41da0b14249a39d6ba37ead45c6
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000028
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
    if_0b814394116249c0abebaabde18296bf: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_8c1c5f75a73b4547b805c35cecda7c25
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end
    end_if_8c1c5f75a73b4547b805c35cecda7c25: ; END of if_0b814394116249c0abebaabde18296bf
    
    if_0024ce688332405785fe86b11e6d78f3: ; IF start
    mov rcx, 4096
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jbe end_if_3c1abb00cfd247afaf7315133c6ef01a
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end
    end_if_3c1abb00cfd247afaf7315133c6ef01a: ; END of if_0024ce688332405785fe86b11e6d78f3
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000110
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    loop_1aab41356f9a4e158308e4f08bcf7b50: ; LOOP start
    mov rax, 0x0000000000000101
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    if_56b4a5e0bca547c4bc49ef748f28f684: ; IF start
    pop rax
      test rax, rax
      je end_if_b95ee42e5c4143bf9db1237ad0739943
    
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    pop rax
      
      jmp func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end
    end_if_b95ee42e5c4143bf9db1237ad0739943: ; END of if_56b4a5e0bca547c4bc49ef748f28f684
    
    mov rax, qword [rbp - 40]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_d127c43115264415a283fbe5e0b3ae42: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_837a21ea9a1d4a20ba69ab6a3f0fa2b8
    
    jmp end_loop_142594900d21434fa4cf5ffa3c8ca3ee ; BREAK
    end_if_837a21ea9a1d4a20ba69ab6a3f0fa2b8: ; END of if_d127c43115264415a283fbe5e0b3ae42
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      seta al
      movzx eax, al
      push rax
    if_df8e3d2a34094154a6f6ac618491bfcb: ; IF start
    pop rax
      test rax, rax
      je end_if_32333537000c49a6a6d311d8b1d54ca2
    
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    pop rax
      
      jmp func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end
    end_if_32333537000c49a6a6d311d8b1d54ca2: ; END of if_df8e3d2a34094154a6f6ac618491bfcb
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000102
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    mov rax, qword [rbp - 48]
      push rax
    call func_546578745772697465_da6387436fe5421c8aca2ecf7d8c06e7_start
      add rsp, 40
      push rax
    if_62ced56251d642f7a3d20eac4b711520: ; IF start
    pop rax
      test rax, rax
      je end_if_e294f0e9f4834b6ea068f6a3d4f4b406
    
      jmp end_else_d68c85cef8f146518ceda3adad5cf77a     ; Jump over ELSE part
    end_if_e294f0e9f4834b6ea068f6a3d4f4b406:    ; if_62ced56251d642f7a3d20eac4b711520 END
    else_57fe6aa20a274f9b9612467cad849531:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end
    end_else_d68c85cef8f146518ceda3adad5cf77a: ; END of else_57fe6aa20a274f9b9612467cad849531
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp loop_1aab41356f9a4e158308e4f08bcf7b50 ; LOOP: continue iteration
    end_loop_142594900d21434fa4cf5ffa3c8ca3ee: ; END of loop_1aab41356f9a4e158308e4f08bcf7b50
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end
    func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578745772697465_da6387436fe5421c8aca2ecf7d8c06e7_start:
    push rbp
      mov rbp, rsp
    sub rsp, 48
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 16], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 24], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 32], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 40], rax
    while_907ca8cba2254202bf3b1034c063d98d: ; WHILE start
    mov rax, qword [rbp + 32]
      mov rcx, rax
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_f458761835474000ab1f4fb1928a81a1
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_cfc5091e4b5c45088d922a0651503b40: ; IF start
    mov rcx, 4096
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jbe end_if_d3332e8cba9743cca8ebe832c11453f0
    
    mov rax, 0x0000000000001000
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    end_if_d3332e8cba9743cca8ebe832c11453f0: ; END of if_cfc5091e4b5c45088d922a0651503b40
    
    mov rax, qword [rbp + 16]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_07e8b8b6c74f4f2b9369e04a417ef8e9: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      je end_if_5f9c33fbec744d5fbc752bbd1c1c9ec3
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578745772697465_da6387436fe5421c8aca2ecf7d8c06e7_end
    end_if_5f9c33fbec744d5fbc752bbd1c1c9ec3: ; END of if_07e8b8b6c74f4f2b9369e04a417ef8e9
    
    mov rax, qword [rbp + 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_f678e364b7d547c6982d9fc87bbd3ac7: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_98aa6706c7f6451892b4defa810dca83
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578745772697465_da6387436fe5421c8aca2ecf7d8c06e7_end
    end_if_98aa6706c7f6451892b4defa810dca83: ; END of if_f678e364b7d547c6982d9fc87bbd3ac7
    
    mov rax, qword [rbp - 40]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      seta al
      movzx eax, al
      push rax
    if_eb0601f1125740edb2a027cea1977bf3: ; IF start
    pop rax
      test rax, rax
      je end_if_252c761350e74a5fbeb66585d737a3c5
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578745772697465_da6387436fe5421c8aca2ecf7d8c06e7_end
    end_if_252c761350e74a5fbeb66585d737a3c5: ; END of if_eb0601f1125740edb2a027cea1977bf3
    
    mov rax, qword [rbp + 16]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
      jmp while_907ca8cba2254202bf3b1034c063d98d ; Reevaluate WHILE condition
    end_while_f458761835474000ab1f4fb1928a81a1: ; END of while_907ca8cba2254202bf3b1034c063d98d
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_546578745772697465_da6387436fe5421c8aca2ecf7d8c06e7_end
    func_546578745772697465_da6387436fe5421c8aca2ecf7d8c06e7_end:
      mov rsp, rbp
      pop rbp
      ret
module_746578745F7472616E736665725F62656E63686D61726B_2572338015bf4131a51f42222f9e5ab5_end:

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
extern ubytec_bridge_read
ubytec_hostio_HostRead:
push rbp
mov rbp, rsp
mov rdi, [rbp+48]
mov rsi, [rbp+40]
mov rdx, [rbp+32]
mov rcx, [rbp+24]
mov r8, [rbp+16]
and rsp, -16
call ubytec_bridge_read
mov rsp, rbp
pop rbp
ret

section .text
extern ubytec_bridge_write
ubytec_hostio_HostWrite:
push rbp
mov rbp, rsp
mov rdi, [rbp+48]
mov rsi, [rbp+40]
mov rdx, [rbp+32]
mov rcx, [rbp+24]
mov r8, [rbp+16]
and rsp, -16
call ubytec_bridge_write
mov rsp, rbp
pop rbp
ret
section .text
global ubytec_host_contract_TextMain
ubytec_host_contract_TextMain:
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
call func_546578744D61696E_6ddf15c5436f4fbaac84d764d6b34c6d_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,69,124,84,101,120,116,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,84,101,120,116,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
