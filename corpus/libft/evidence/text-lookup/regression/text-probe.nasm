  module_696F5F70726F6265_99c3d353c68549748b0f17220a50a344_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 21:08:16Z
    ; Module UUID: 99c3d353-c685-4974-8b0f-17220a50a344


    section .bss

    section .text

    func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start:
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
    if_cbb7c6bcbfe843f591d87214902cb43a: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_a6dc3ecb89c24a1b9fe58867b136719d
    
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_59bf007fc63e44a5bba992ba10bcc27b     ; Jump over ELSE part
    end_if_a6dc3ecb89c24a1b9fe58867b136719d:    ; if_cbb7c6bcbfe843f591d87214902cb43a END
    else_402a35fd6d4146f1aad15b6151e07cd3:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_59bf007fc63e44a5bba992ba10bcc27b: ; END of else_402a35fd6d4146f1aad15b6151e07cd3
    
    pop rax
      
      mov qword [rbp - 8], rax
    if_602cccc6aa8a4a11a041e28c03b09b12: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_d2fe335da4a2498396bad60c6f666e02
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_end
    end_if_d2fe335da4a2498396bad60c6f666e02: ; END of if_602cccc6aa8a4a11a041e28c03b09b12
    
    mov rax, qword [rbp + 16]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_eef483282c944e2a940c911ffaff323b: ; IF start
    pop rax
      test rax, rax
      je end_if_74d6283806e6423d80469362b95e900c
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_end
    end_if_74d6283806e6423d80469362b95e900c: ; END of if_eef483282c944e2a940c911ffaff323b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_end
    func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_start:
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
    if_aac1b4d9568d4005a405749980108eac: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_0c85548d9c894cffbc85ee95d4266cc3
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_0c85548d9c894cffbc85ee95d4266cc3: ; END of if_aac1b4d9568d4005a405749980108eac
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000200
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    while_8e8cbe9179f14e3cbeee8ed4bb1503d6: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_0afc3581490d403aa32ff7c0d9167512
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000A5
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      inc rax
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
      jmp while_8e8cbe9179f14e3cbeee8ed4bb1503d6 ; Reevaluate WHILE condition
    end_while_0afc3581490d403aa32ff7c0d9167512: ; END of while_8e8cbe9179f14e3cbeee8ed4bb1503d6
    
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x000000000000FFFF
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start
      add rsp, 48
      push rax
    if_533f5900d2ad4aef8d8902bb4097853c: ; IF start
    pop rax
      test rax, rax
      je end_if_c11fe7659b9b45c2b86f4d75062a18ac
    
      jmp end_else_f4fc5e4d93aa483b8b177cfee6c07d56     ; Jump over ELSE part
    end_if_c11fe7659b9b45c2b86f4d75062a18ac:    ; if_533f5900d2ad4aef8d8902bb4097853c END
    else_5d499e8d82874238ae9380c602b43432:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_else_f4fc5e4d93aa483b8b177cfee6c07d56: ; END of else_5d499e8d82874238ae9380c602b43432
    
    mov rax, 0x0000000000000002
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start
      add rsp, 48
      push rax
    if_104a5b6c397a4648810575105a17534f: ; IF start
    pop rax
      test rax, rax
      je end_if_0ae1b18075f64acaba2c9113e7c6dc41
    
      jmp end_else_25ffcdbb2a79457192e108e2e08d333f     ; Jump over ELSE part
    end_if_0ae1b18075f64acaba2c9113e7c6dc41:    ; if_104a5b6c397a4648810575105a17534f END
    else_3efbfb06a2a34d06966a7bce56020023:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_else_25ffcdbb2a79457192e108e2e08d333f: ; END of else_3efbfb06a2a34d06966a7bce56020023
    
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start
      add rsp, 48
      push rax
    if_13b0aec9a9e94d7c873cf3cde21ad9e2: ; IF start
    pop rax
      test rax, rax
      je end_if_e5b93cf9a11549f59efda2dbd1799869
    
      jmp end_else_4157089c0fbb450b9c8c59af42612908     ; Jump over ELSE part
    end_if_e5b93cf9a11549f59efda2dbd1799869:    ; if_13b0aec9a9e94d7c873cf3cde21ad9e2 END
    else_1e8b71085d6e4f90ba2ae35158c42bb4:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_else_4157089c0fbb450b9c8c59af42612908: ; END of else_1e8b71085d6e4f90ba2ae35158c42bb4
    
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000001001
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start
      add rsp, 48
      push rax
    if_3ceab93c3e5e4f3ba4c8bec56a9fc624: ; IF start
    pop rax
      test rax, rax
      je end_if_cec99fcf8ebc4e22a4b2e5b5074fc8dc
    
      jmp end_else_1002c8a048e14794882c460339a126d9     ; Jump over ELSE part
    end_if_cec99fcf8ebc4e22a4b2e5b5074fc8dc:    ; if_3ceab93c3e5e4f3ba4c8bec56a9fc624 END
    else_bca6c1bd541747ca91f640bd57467d0f:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_else_1002c8a048e14794882c460339a126d9: ; END of else_bca6c1bd541747ca91f640bd57467d0f
    
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start
      add rsp, 48
      push rax
    if_77a9453fccd14d6e9506ce71fded44a7: ; IF start
    pop rax
      test rax, rax
      je end_if_0b05da74b79f4a74a0493557d465d0e3
    
      jmp end_else_f6bf3cd61f7d484fb5a3a88c4afa8436     ; Jump over ELSE part
    end_if_0b05da74b79f4a74a0493557d465d0e3:    ; if_77a9453fccd14d6e9506ce71fded44a7 END
    else_00234febf0ff4306be2c7164676b5dfd:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_else_f6bf3cd61f7d484fb5a3a88c4afa8436: ; END of else_00234febf0ff4306be2c7164676b5dfd
    
    mov rax, 0x0000000000000002
      push rax
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start
      add rsp, 48
      push rax
    if_58a4c9be424f45569d82fac02ee6f7fd: ; IF start
    pop rax
      test rax, rax
      je end_if_985678e0ec304a8286fac087c3bbdc19
    
      jmp end_else_a0350e2556244a6096a78996d31dca0f     ; Jump over ELSE part
    end_if_985678e0ec304a8286fac087c3bbdc19:    ; if_58a4c9be424f45569d82fac02ee6f7fd END
    else_df1f797408054183aaad177d6504696b:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_else_a0350e2556244a6096a78996d31dca0f: ; END of else_df1f797408054183aaad177d6504696b
    
    mov rax, 0x0000000000000001
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_45787065637444656E696564_0d2b11811df9434eacb295f9965110bb_start
      add rsp, 48
      push rax
    if_4edee8dc81a94f2499d6c9d9cf2bc099: ; IF start
    pop rax
      test rax, rax
      je end_if_3d0e311533014dbea85ddc935a59105c
    
      jmp end_else_5f17987a091f44bcaae75b2c71c4a955     ; Jump over ELSE part
    end_if_3d0e311533014dbea85ddc935a59105c:    ; if_4edee8dc81a94f2499d6c9d9cf2bc099 END
    else_b13c5f40893547c9bb63c8a0851fba95:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_else_5f17987a091f44bcaae75b2c71c4a955: ; END of else_b13c5f40893547c9bb63c8a0851fba95
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    while_d920ddc7948d44539e286541bff21aeb: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_4dc55db0216c4d9cac754c7c1968e278
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x00000000000000A5
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_e296b975bc654d7e980602257cc8e83b: ; IF start
    pop rax
      test rax, rax
      je end_if_760dee6d76344a15a234c3b195718335
    
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_760dee6d76344a15a234c3b195718335: ; END of if_e296b975bc654d7e980602257cc8e83b
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      inc rax
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
      jmp while_d920ddc7948d44539e286541bff21aeb ; Reevaluate WHILE condition
    end_while_4dc55db0216c4d9cac754c7c1968e278: ; END of while_d920ddc7948d44539e286541bff21aeb
    
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    if_293a446527da43ac9c99e75adfb1a7ba: ; IF start
    pop rax
      test rax, rax
      je end_if_c09f0ce737734772a939ea2c30e74fb4
    
    mov rax, 0xFFFFFFFFFFFFFFFC
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_c09f0ce737734772a939ea2c30e74fb4: ; END of if_293a446527da43ac9c99e75adfb1a7ba
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_40aba25cd00a438e9b630c72cd7f2338: ; IF start
    pop rax
      test rax, rax
      je end_if_5b3528e42a324acbab715415a1937d3f
    
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_5b3528e42a324acbab715415a1937d3f: ; END of if_40aba25cd00a438e9b630c72cd7f2338
    
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000003
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    if_146ff7d7d7624b31908f033d4d354e97: ; IF start
    pop rax
      test rax, rax
      je end_if_55d00025befd4287b51899493f25eef3
    
    mov rax, 0xFFFFFFFFFFFFFFFC
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_55d00025befd4287b51899493f25eef3: ; END of if_146ff7d7d7624b31908f033d4d354e97
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_22640f345dcb477a8931c35f273e2c0e: ; IF start
    pop rax
      test rax, rax
      je end_if_b78c28aded5d479288c91f53da147466
    
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_b78c28aded5d479288c91f53da147466: ; END of if_22640f345dcb477a8931c35f273e2c0e
    
    mov rax, 0x0000000000000101
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000003
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
    if_db456d2435a044188c4a32864a1720ce: ; IF start
    pop rax
      test rax, rax
      je end_if_32eba2e008384578bccd36724006e389
    
    mov rax, 0xFFFFFFFFFFFFFFFC
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_32eba2e008384578bccd36724006e389: ; END of if_db456d2435a044188c4a32864a1720ce
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000003
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_1686ebbf62194a1b9ac90939af441dd3: ; IF start
    pop rax
      test rax, rax
      je end_if_51d351368378423c88bf14df14443bba
    
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_51d351368378423c88bf14df14443bba: ; END of if_1686ebbf62194a1b9ac90939af441dd3
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000061
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_b3198ccf343b40f5a6dca7ad6bcdf61f: ; IF start
    pop rax
      test rax, rax
      je end_if_e072bf7fb0af43c4b77371c750ba1201
    
    mov rax, 0xFFFFFFFFFFFFFFFA
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_e072bf7fb0af43c4b77371c750ba1201: ; END of if_b3198ccf343b40f5a6dca7ad6bcdf61f
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000062
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_ca387568b49b449ea26d8fd2ec88ebcc: ; IF start
    pop rax
      test rax, rax
      je end_if_39fe2a56c07b4f0d8d93e7e165e0e2db
    
    mov rax, 0xFFFFFFFFFFFFFFFA
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_39fe2a56c07b4f0d8d93e7e165e0e2db: ; END of if_ca387568b49b449ea26d8fd2ec88ebcc
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000002
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x0000000000000063
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_0961391b9f15439fb09dd34bb85ebf23: ; IF start
    pop rax
      test rax, rax
      je end_if_38bdd0b5484b488b9ef6f20278eef5df
    
    mov rax, 0xFFFFFFFFFFFFFFFA
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_38bdd0b5484b488b9ef6f20278eef5df: ; END of if_0961391b9f15439fb09dd34bb85ebf23
    
    mov rax, 0x0000000000000003
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    while_884cb41e0e6e4c8aac9a6584ae2debe2: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_48a51ded787a40818a13c8507ca30de1
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    mov rax, 0x00000000000000A5
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_8b0be532b1af446990a34d4ec91dc7a6: ; IF start
    pop rax
      test rax, rax
      je end_if_44ac50da723a4d87bfbb418737f62af6
    
    mov rax, 0xFFFFFFFFFFFFFFF9
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_44ac50da723a4d87bfbb418737f62af6: ; END of if_8b0be532b1af446990a34d4ec91dc7a6
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      inc rax
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
      jmp while_884cb41e0e6e4c8aac9a6584ae2debe2 ; Reevaluate WHILE condition
    end_while_48a51ded787a40818a13c8507ca30de1: ; END of while_884cb41e0e6e4c8aac9a6584ae2debe2
    
    mov rax, 0x0000000000000102
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000003
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    if_d2a0784d9d0c467586c8c6467d97a121: ; IF start
    pop rax
      test rax, rax
      je end_if_c63e5f4e1ea240bfbfb3fe681b169266
    
    mov rax, 0xFFFFFFFFFFFFFFF8
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_c63e5f4e1ea240bfbfb3fe681b169266: ; END of if_d2a0784d9d0c467586c8c6467d97a121
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    mov rax, 0x0000000000000003
      push rax
    pop rcx
      pop rax
      cmp rax, rcx
      setne al
      movzx eax, al
      push rax
    if_fb0913d7d67f4da59e220b942af75a18: ; IF start
    pop rax
      test rax, rax
      je end_if_bc7c0e669a044de885413e5f76018c55
    
    mov rax, 0xFFFFFFFFFFFFFFF7
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    end_if_bc7c0e669a044de885413e5f76018c55: ; END of if_fb0913d7d67f4da59e220b942af75a18
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000003
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000003
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end
    func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_99c3d353c68549748b0f17220a50a344_end:

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
call func_546578744D61696E_106a05c32a514229a6975b6b63e5306f_start
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
