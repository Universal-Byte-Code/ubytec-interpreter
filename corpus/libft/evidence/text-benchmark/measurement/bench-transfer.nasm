  module_746578745F7472616E736665725F62656E63686D61726B_c33e27d540404ff48fafa69a47823282_start:
  ; Module: text_transfer_benchmark v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 18:35:05Z
    ; Module UUID: c33e27d5-4040-4ff4-8faf-a69a47823282


    section .bss

    section .text

    func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_start:
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
    if_6aeacf89e0ed41fc89adc30a307f0a99: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_717c0a52ceb94c5c892c110c1e14835b
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end
    end_if_717c0a52ceb94c5c892c110c1e14835b: ; END of if_6aeacf89e0ed41fc89adc30a307f0a99
    
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
    if_7d6d348f7bf943c1a23faecaca262fb0: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_0b636cd1e65c48b3b58df80f4ec5ec86
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end
    end_if_0b636cd1e65c48b3b58df80f4ec5ec86: ; END of if_7d6d348f7bf943c1a23faecaca262fb0
    
    if_fc4ea55a2058480cba1dbefd20867aed: ; IF start
    mov rcx, 4096
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jbe end_if_2061e2451522433cbc096cb0e4058bab
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end
    end_if_2061e2451522433cbc096cb0e4058bab: ; END of if_fc4ea55a2058480cba1dbefd20867aed
    
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
    loop_c2ea3ab432db44e69880f07aca23cb08: ; LOOP start
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
    if_9725c7f9b7c04dc190710aaec82304f0: ; IF start
    pop rax
      test rax, rax
      je end_if_73eedd5172af403fb70789f1b9d1a86b
    
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    pop rax
      
      jmp func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end
    end_if_73eedd5172af403fb70789f1b9d1a86b: ; END of if_9725c7f9b7c04dc190710aaec82304f0
    
    mov rax, qword [rbp - 40]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_1a30fc27ce9a467bb17bf4bcb2200cb2: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_ccb9f06a06a34449954c4a0ac416efb0
    
    jmp end_loop_fd548edea3f045c480dbe29c1e8b19b8 ; BREAK
    end_if_ccb9f06a06a34449954c4a0ac416efb0: ; END of if_1a30fc27ce9a467bb17bf4bcb2200cb2
    
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
    if_465e0e2b94434b8aab92ea3e7c3cf9eb: ; IF start
    pop rax
      test rax, rax
      je end_if_0839219ea7ef4a97847c35a57a24a9f4
    
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    pop rax
      
      jmp func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end
    end_if_0839219ea7ef4a97847c35a57a24a9f4: ; END of if_465e0e2b94434b8aab92ea3e7c3cf9eb
    
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
    call func_546578745772697465_83ae539d536a41148007cbd9a371bc8f_start
      add rsp, 40
      push rax
    if_e97dc5a3069e4415a133e7f6df6d84cd: ; IF start
    pop rax
      test rax, rax
      je end_if_a5f168f9a16946e0bafcf4940ec07be4
    
      jmp end_else_0cc497aa01ec4df99a91f8c6ff2881df     ; Jump over ELSE part
    end_if_a5f168f9a16946e0bafcf4940ec07be4:    ; if_e97dc5a3069e4415a133e7f6df6d84cd END
    else_782d3e68844043eaa7c23f3ada3a62d5:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end
    end_else_0cc497aa01ec4df99a91f8c6ff2881df: ; END of else_782d3e68844043eaa7c23f3ada3a62d5
    
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
      jmp loop_c2ea3ab432db44e69880f07aca23cb08 ; LOOP: continue iteration
    end_loop_fd548edea3f045c480dbe29c1e8b19b8: ; END of loop_c2ea3ab432db44e69880f07aca23cb08
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end
    func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578745772697465_83ae539d536a41148007cbd9a371bc8f_start:
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
    while_33b5ba74cc2c4033adc019ecdbc32a61: ; WHILE start
    mov rax, qword [rbp + 32]
      mov rcx, rax
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_defdc80657f4487a9a11e3a945707549
    
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
    if_36871b772cc04987b0a58c3853acb277: ; IF start
    mov rcx, 4096
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jbe end_if_84bfc03930084961906d3451bffff099
    
    mov rax, 0x0000000000001000
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    end_if_84bfc03930084961906d3451bffff099: ; END of if_36871b772cc04987b0a58c3853acb277
    
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
    if_c427a229545b4637a65442186622b6fe: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      je end_if_90b6e89a1f614b0785ca11f3d871e132
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578745772697465_83ae539d536a41148007cbd9a371bc8f_end
    end_if_90b6e89a1f614b0785ca11f3d871e132: ; END of if_c427a229545b4637a65442186622b6fe
    
    mov rax, qword [rbp + 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_236e8a34ba3b444aa494b2050bc2a3fa: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_50613677b04546ad9c212e877ed5c462
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578745772697465_83ae539d536a41148007cbd9a371bc8f_end
    end_if_50613677b04546ad9c212e877ed5c462: ; END of if_236e8a34ba3b444aa494b2050bc2a3fa
    
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
    if_3c2bff5568c243f59260c4e84aa43859: ; IF start
    pop rax
      test rax, rax
      je end_if_91c4337ac07149a78033a933ff25e5fd
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578745772697465_83ae539d536a41148007cbd9a371bc8f_end
    end_if_91c4337ac07149a78033a933ff25e5fd: ; END of if_3c2bff5568c243f59260c4e84aa43859
    
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
      jmp while_33b5ba74cc2c4033adc019ecdbc32a61 ; Reevaluate WHILE condition
    end_while_defdc80657f4487a9a11e3a945707549: ; END of while_33b5ba74cc2c4033adc019ecdbc32a61
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_546578745772697465_83ae539d536a41148007cbd9a371bc8f_end
    func_546578745772697465_83ae539d536a41148007cbd9a371bc8f_end:
      mov rsp, rbp
      pop rbp
      ret
module_746578745F7472616E736665725F62656E63686D61726B_c33e27d540404ff48fafa69a47823282_end:

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
call func_546578744D61696E_bb92a559e8a94b71a5b16b48c749f1bc_start
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
