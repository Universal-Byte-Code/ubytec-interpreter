  module_696F5F70726F6265_f4b579c1e2aa41a9824c11176b80ef28_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-06 09:54:15Z
    ; Module UUID: f4b579c1-e2aa-41a9-824c-11176b80ef28


    section .bss

    section .text

    func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    if_9c5deda76b4f49a88eba3b92c1f69fc5: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_dacf13cc60f3489e961b764e1c8b0806
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_af4e909fa79340fc954c47bab6c2bcdd     ; Jump over ELSE part
    end_if_dacf13cc60f3489e961b764e1c8b0806:    ; if_9c5deda76b4f49a88eba3b92c1f69fc5 END
    else_e14f861cf4ab4144a4dd51e918e431d1:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_af4e909fa79340fc954c47bab6c2bcdd: ; END of else_e14f861cf4ab4144a4dd51e918e431d1
    pop rax
      
      mov qword [rbp - 8], rax
    if_547929f6dcf14261a7de6086abccda91: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_348c60dda4cc481298fce42afde43976
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_5ae21764e9984454a984284d54317954_end
    end_if_348c60dda4cc481298fce42afde43976: ; END of if_547929f6dcf14261a7de6086abccda91
    mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    if_f3ce8adf435847ffb184ac9d05075cfe: ; IF start
    pop rax
      test rax, rax
      je end_if_b227d181306a44349eb7f156cf1c65e1
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_5ae21764e9984454a984284d54317954_end
    end_if_b227d181306a44349eb7f156cf1c65e1: ; END of if_f3ce8adf435847ffb184ac9d05075cfe
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_5ae21764e9984454a984284d54317954_end
    func_45787065637444656E696564_5ae21764e9984454a984284d54317954_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_start:
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
    ; effect-registers: write-through copies, raw-store/call reload boundaries
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_ea55ab845610491d85fdc8c214e45623: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_361d22237eab423c8a294fc7deecfbe5
    mov rax, 0xFFFFFFFFFFFFFFFF
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_361d22237eab423c8a294fc7deecfbe5: ; END of if_ea55ab845610491d85fdc8c214e45623
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000200
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 16], rax
      mov r9, rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 24], rax
      mov r10, rax
    while_12a4263f4a1e4062880f8be356bd6893: ; WHILE start
    mov rcx, 16
      mov rax, r8
      cmp rax, rcx
      jae end_while_2653109127e543a182baf0e2c274c52e
    push r9
  mov qword [rsp - 8], r8
  mov rcx, r8
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000A5
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      mov byte [rax], cl
    ; effect-registers: reload after STORE
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
  mov qword [rsp - 8], r8
  mov rax, r8
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      mov r8, rax
      jmp while_12a4263f4a1e4062880f8be356bd6893 ; Reevaluate WHILE condition
    end_while_2653109127e543a182baf0e2c274c52e: ; END of while_12a4263f4a1e4062880f8be356bd6893
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x000000000000FFFF
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000000008
      push rax
    push r10
    call func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start
      add rsp, 48
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_1d242f669dc442d2888ac05c64f698a9: ; IF start
    pop rax
      test rax, rax
      je end_if_fe9e1ec780ad4acfb37a478ccd3b9e31
      jmp end_else_e49a70cbbc1c49058e662fdd2ec65c16     ; Jump over ELSE part
    end_if_fe9e1ec780ad4acfb37a478ccd3b9e31:    ; if_1d242f669dc442d2888ac05c64f698a9 END
    else_eadb776558294e9e9ebf64e2afba3c3c:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_else_e49a70cbbc1c49058e662fdd2ec65c16: ; END of else_eadb776558294e9e9ebf64e2afba3c3c
    mov rax, 0x0000000000000002
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000000008
      push rax
    push r10
    call func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start
      add rsp, 48
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_e93cf6639928429a9fc090fef5a00d75: ; IF start
    pop rax
      test rax, rax
      je end_if_2e759d36fdd444c6aca24abd572723c3
      jmp end_else_4ea9dea7d09542e2b388f6345514b92e     ; Jump over ELSE part
    end_if_2e759d36fdd444c6aca24abd572723c3:    ; if_e93cf6639928429a9fc090fef5a00d75 END
    else_d3ec9d0819374d0eb9d6f7485262cab4:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_else_4ea9dea7d09542e2b388f6345514b92e: ; END of else_d3ec9d0819374d0eb9d6f7485262cab4
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000000008
      push rax
    push r10
    call func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start
      add rsp, 48
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_bb9153961b2943f586848cfb77615031: ; IF start
    pop rax
      test rax, rax
      je end_if_21a781a9a82e41fc8a5b329c1a6654b4
      jmp end_else_b114c67449ba4ad4b069f9802c849c57     ; Jump over ELSE part
    end_if_21a781a9a82e41fc8a5b329c1a6654b4:    ; if_bb9153961b2943f586848cfb77615031 END
    else_4766ddeb4e1d44a09034f1b56b1af373:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_else_b114c67449ba4ad4b069f9802c849c57: ; END of else_4766ddeb4e1d44a09034f1b56b1af373
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000001001
      push rax
    push r10
    call func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start
      add rsp, 48
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_d8ac0f97ffbe465e9a00f18e87837f40: ; IF start
    pop rax
      test rax, rax
      je end_if_3f97ef1340c44efab91856741d78439c
      jmp end_else_a94f879e84c04b199d2b4bd3f54cae27     ; Jump over ELSE part
    end_if_3f97ef1340c44efab91856741d78439c:    ; if_d8ac0f97ffbe465e9a00f18e87837f40 END
    else_76b9d3040aea4da787d6d62543c573e4:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_else_a94f879e84c04b199d2b4bd3f54cae27: ; END of else_76b9d3040aea4da787d6d62543c573e4
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    push r9
    mov rax, 0x0000000000000008
      push rax
    push r10
    call func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start
      add rsp, 48
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_6eb3f2b5440a4e7da5a38952b08538f7: ; IF start
    pop rax
      test rax, rax
      je end_if_3cd8a42cf1544d5c9151cd450c77d4f2
      jmp end_else_5696b07f13b742a3bafd5ae847d41f35     ; Jump over ELSE part
    end_if_3cd8a42cf1544d5c9151cd450c77d4f2:    ; if_6eb3f2b5440a4e7da5a38952b08538f7 END
    else_38d055a6dc394786b7b55732637f65dc:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_else_5696b07f13b742a3bafd5ae847d41f35: ; END of else_38d055a6dc394786b7b55732637f65dc
    mov rax, 0x0000000000000002
      push rax
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    push r9
    mov rax, 0x0000000000000008
      push rax
    push r10
    call func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start
      add rsp, 48
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_a0e78610828f4203bc641eb4289fdf26: ; IF start
    pop rax
      test rax, rax
      je end_if_6cfc0d8885e744caaa44f725a3f45212
      jmp end_else_bc64d8f66b4b44959c07b786b8cae300     ; Jump over ELSE part
    end_if_6cfc0d8885e744caaa44f725a3f45212:    ; if_a0e78610828f4203bc641eb4289fdf26 END
    else_4b1fa6957f0d404daa0f1ad9bc5f9952:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_else_bc64d8f66b4b44959c07b786b8cae300: ; END of else_4b1fa6957f0d404daa0f1ad9bc5f9952
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000000008
      push rax
    push r10
    call func_45787065637444656E696564_5ae21764e9984454a984284d54317954_start
      add rsp, 48
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_08282b44bb494ff3b27abf7dcd846ee7: ; IF start
    pop rax
      test rax, rax
      je end_if_7ef8d7e8318b4e429b70f67b8f924605
      jmp end_else_ff9b476ccead4ecaadb373db2ba13233     ; Jump over ELSE part
    end_if_7ef8d7e8318b4e429b70f67b8f924605:    ; if_08282b44bb494ff3b27abf7dcd846ee7 END
    else_8102054f90c948f79903b49f30199fbd:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_else_ff9b476ccead4ecaadb373db2ba13233: ; END of else_8102054f90c948f79903b49f30199fbd
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      mov r8, rax
    while_9888f448b33c4e2183cb03d8c383f0b4: ; WHILE start
    mov rcx, 16
      mov rax, r8
      cmp rax, rcx
      jae end_while_a069ce76269e4ec8ac02b7793cfa4c5c
    push r9
  mov qword [rsp - 8], r8
  mov rcx, r8
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x00000000000000A5
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_80969935f1cc42b9a87d9cbdfe6a0612: ; IF start
    pop rax
      test rax, rax
      je end_if_af9c63318e3742a6828eac8353730ba0
    mov rax, 0xFFFFFFFFFFFFFFFD
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_af9c63318e3742a6828eac8353730ba0: ; END of if_80969935f1cc42b9a87d9cbdfe6a0612
  mov qword [rsp - 8], r8
  mov rax, r8
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      mov r8, rax
      jmp while_9888f448b33c4e2183cb03d8c383f0b4 ; Reevaluate WHILE condition
    end_while_a069ce76269e4ec8ac02b7793cfa4c5c: ; END of while_9888f448b33c4e2183cb03d8c383f0b4
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000000000
      push rax
    push r10
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_a71c90edb7d14019b8df8bf98ff23559: ; IF start
    pop rax
      test rax, rax
      je end_if_2d4b3f75664c47b99f5669ee273ebc92
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_2d4b3f75664c47b99f5669ee273ebc92: ; END of if_a71c90edb7d14019b8df8bf98ff23559
  mov qword [rsp - 8], r10
  mov rax, r10
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_99cd49de2a644ce084f8181772ce3f5a: ; IF start
    pop rax
      test rax, rax
      je end_if_b21499e7447a44c6a1acdb0ed02650cb
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_b21499e7447a44c6a1acdb0ed02650cb: ; END of if_99cd49de2a644ce084f8181772ce3f5a
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000003
      push rax
    push r9
    mov rax, 0x0000000000000008
      push rax
    push r10
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_1db628ff2e4a4a8ebf34be96a2e79b5d: ; IF start
    pop rax
      test rax, rax
      je end_if_d2abacb48dd2427db35d6c14a9b0423a
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_d2abacb48dd2427db35d6c14a9b0423a: ; END of if_1db628ff2e4a4a8ebf34be96a2e79b5d
  mov qword [rsp - 8], r10
  mov rax, r10
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_ee308e26c18b464e8debb58565789b86: ; IF start
    pop rax
      test rax, rax
      je end_if_0ea0d0a7b1534bddbb4fe95a51577d51
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_0ea0d0a7b1534bddbb4fe95a51577d51: ; END of if_ee308e26c18b464e8debb58565789b86
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000000003
      push rax
    push r10
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_a393cb4aa45a4dd6a04157a818ccf137: ; IF start
    pop rax
      test rax, rax
      je end_if_8afbc762507447e9b0c287dbcb708bc7
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_8afbc762507447e9b0c287dbcb708bc7: ; END of if_a393cb4aa45a4dd6a04157a818ccf137
  mov qword [rsp - 8], r10
  mov rax, r10
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_c8c6436856ef4df1853f69a8378310ad: ; IF start
    pop rax
      test rax, rax
      je end_if_1c8eb554f3ae4430979bf3981b563375
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_1c8eb554f3ae4430979bf3981b563375: ; END of if_c8c6436856ef4df1853f69a8378310ad
    push r9
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000061
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_689c40e9ed234145936403f989bbdc1f: ; IF start
    pop rax
      test rax, rax
      je end_if_7408028543454e258376ed13620c3ec5
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_7408028543454e258376ed13620c3ec5: ; END of if_689c40e9ed234145936403f989bbdc1f
    push r9
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000062
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_77eb32494b0e49ba806602c8b6c9ba18: ; IF start
    pop rax
      test rax, rax
      je end_if_8c730af2268348aaa34aeac792e5b043
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_8c730af2268348aaa34aeac792e5b043: ; END of if_77eb32494b0e49ba806602c8b6c9ba18
    push r9
    mov rax, 0x0000000000000002
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000063
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_193c18fbb0024d6aa81b16f750d1842f: ; IF start
    pop rax
      test rax, rax
      je end_if_ca99da0b5b6a413f883c3d1acea685dc
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_ca99da0b5b6a413f883c3d1acea685dc: ; END of if_193c18fbb0024d6aa81b16f750d1842f
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      mov r8, rax
    while_291b9417da4942e288ca8b49454fbe00: ; WHILE start
    mov rcx, 16
      mov rax, r8
      cmp rax, rcx
      jae end_while_c6a2dca8c11b46cabcb96816a9c9f168
    push r9
  mov qword [rsp - 8], r8
  mov rcx, r8
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x00000000000000A5
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_3cafaa2d8b654684a057d4f1baf80984: ; IF start
    pop rax
      test rax, rax
      je end_if_fbe070bf0fef44a7a26077c2bbe227dd
    mov rax, 0xFFFFFFFFFFFFFFF9
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_fbe070bf0fef44a7a26077c2bbe227dd: ; END of if_3cafaa2d8b654684a057d4f1baf80984
  mov qword [rsp - 8], r8
  mov rax, r8
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      mov r8, rax
      jmp while_291b9417da4942e288ca8b49454fbe00 ; Reevaluate WHILE condition
    end_while_c6a2dca8c11b46cabcb96816a9c9f168: ; END of while_291b9417da4942e288ca8b49454fbe00
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0x0000000000000000
      push rax
    push r9
    mov rax, 0x0000000000000003
      push rax
    push r10
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    ; effect-registers: reload after CALL
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    if_bd2f0d6d875a4eceb851b1d46b9de52f: ; IF start
    pop rax
      test rax, rax
      je end_if_44db1650644f48768d92d0fd20376dd1
    mov rax, 0xFFFFFFFFFFFFFFF8
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_44db1650644f48768d92d0fd20376dd1: ; END of if_bd2f0d6d875a4eceb851b1d46b9de52f
  mov qword [rsp - 8], r10
  mov rax, r10
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_37980d6962ff42fd80da238677ced88e: ; IF start
    pop rax
      test rax, rax
      je end_if_873a93ca6968465f84a3a44f968aee15
    mov rax, 0xFFFFFFFFFFFFFFF7
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    end_if_873a93ca6968465f84a3a44f968aee15: ; END of if_37980d6962ff42fd80da238677ced88e
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      mov qword [rax], rcx
    ; effect-registers: reload after STORE
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000018
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      mov qword [rax], rcx
    ; effect-registers: reload after STORE
    mov r8, qword [rbp - 8]
    mov r9, qword [rbp - 16]
    mov r10, qword [rbp - 24]
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end
    func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_f4b579c1e2aa41a9824c11176b80ef28_end:

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
call func_546578744D61696E_e70116a5f4984dff80c753e5417310a9_start
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
