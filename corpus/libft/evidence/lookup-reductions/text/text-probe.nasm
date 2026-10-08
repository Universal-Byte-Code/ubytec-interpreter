  module_696F5F70726F6265_aac71b99cfdb4a72aa0ec711a87021d7_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-06 02:04:36Z
    ; Module UUID: aac71b99-cfdb-4a72-aa0e-c711a87021d7


    section .bss

    section .text

    func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start:
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
    if_0c5a5111345b440d959bcdea35a74588: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_c6db814065c5427abdbec313a31d2220
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_93a56d11b32142a683651a81be27ee42     ; Jump over ELSE part
    end_if_c6db814065c5427abdbec313a31d2220:    ; if_0c5a5111345b440d959bcdea35a74588 END
    else_f999bd9e618c42b4b88d049670d29daa:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_93a56d11b32142a683651a81be27ee42: ; END of else_f999bd9e618c42b4b88d049670d29daa
    pop rax
      
      mov qword [rbp - 8], rax
    if_9469a61a8a2d442eb3c1d40d913257d5: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_f9239549182c4bfc97af442d65024331
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_end
    end_if_f9239549182c4bfc97af442d65024331: ; END of if_9469a61a8a2d442eb3c1d40d913257d5
    mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    if_1ae7352a474d4ec2b3ccc624d8e9c098: ; IF start
    pop rax
      test rax, rax
      je end_if_bf4e981e2b1a4670b5d908bad3bb2f98
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_end
    end_if_bf4e981e2b1a4670b5d908bad3bb2f98: ; END of if_1ae7352a474d4ec2b3ccc624d8e9c098
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_end
    func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_start:
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
    if_a568ad2a15b64106a61141e31bb69520: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_5e3c70cb34e54d9aad2ddca6c945d577
    mov rax, 0xFFFFFFFFFFFFFFFF
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_5e3c70cb34e54d9aad2ddca6c945d577: ; END of if_a568ad2a15b64106a61141e31bb69520
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000200
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 24], rax
    while_5b0a2a04cfff48f4944d9948cb1e5864: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_5ef43dd4a9d84d11a96f2ddc6b1a3d16
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x00000000000000A5
  mov qword [rsp - 8], rax
  mov rcx, rax
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_5b0a2a04cfff48f4944d9948cb1e5864 ; Reevaluate WHILE condition
    end_while_5ef43dd4a9d84d11a96f2ddc6b1a3d16: ; END of while_5b0a2a04cfff48f4944d9948cb1e5864
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
    call func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start
      add rsp, 48
      push rax
    if_9f06d2c48d594be88a44f40321903b70: ; IF start
    pop rax
      test rax, rax
      je end_if_807a505f2f78483e868f8c265059638b
      jmp end_else_c93dcf4ff78c4839ac37e7dc96a8bc5d     ; Jump over ELSE part
    end_if_807a505f2f78483e868f8c265059638b:    ; if_9f06d2c48d594be88a44f40321903b70 END
    else_f4f67c26122f45c48b977e3d51308bc9:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_else_c93dcf4ff78c4839ac37e7dc96a8bc5d: ; END of else_f4f67c26122f45c48b977e3d51308bc9
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
    call func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start
      add rsp, 48
      push rax
    if_01a48e2fdb6d4885892250e5f8bcdeab: ; IF start
    pop rax
      test rax, rax
      je end_if_99c34301498547fcbfd34d911bf1e1ca
      jmp end_else_f7d9e9b704764711b3595b49b716243c     ; Jump over ELSE part
    end_if_99c34301498547fcbfd34d911bf1e1ca:    ; if_01a48e2fdb6d4885892250e5f8bcdeab END
    else_a0e1619ab65646b783b74889df7a48f1:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_else_f7d9e9b704764711b3595b49b716243c: ; END of else_a0e1619ab65646b783b74889df7a48f1
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
    call func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start
      add rsp, 48
      push rax
    if_f479ea92959546919463771bf201085c: ; IF start
    pop rax
      test rax, rax
      je end_if_13d3cf9f6e064683834ab15ff64e2abe
      jmp end_else_aa7db562da444f40a296e43b332d52bb     ; Jump over ELSE part
    end_if_13d3cf9f6e064683834ab15ff64e2abe:    ; if_f479ea92959546919463771bf201085c END
    else_e3761b8b91c941e8bde811535c6dedec:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_else_aa7db562da444f40a296e43b332d52bb: ; END of else_e3761b8b91c941e8bde811535c6dedec
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
    call func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start
      add rsp, 48
      push rax
    if_e8516927064448af97c207cf1ccac7a9: ; IF start
    pop rax
      test rax, rax
      je end_if_d5f7868eeb4a42af92369b3f6a1944e0
      jmp end_else_ceb0c2089ac44fe5a6a54d209ed4b56f     ; Jump over ELSE part
    end_if_d5f7868eeb4a42af92369b3f6a1944e0:    ; if_e8516927064448af97c207cf1ccac7a9 END
    else_c44cd145e41442eb91672bb185ac6834:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_else_ceb0c2089ac44fe5a6a54d209ed4b56f: ; END of else_c44cd145e41442eb91672bb185ac6834
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
    call func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start
      add rsp, 48
      push rax
    if_118546808bcb40d1ac0e04b614d5294e: ; IF start
    pop rax
      test rax, rax
      je end_if_09bc5cedb04c4382bb0086a6eede8c77
      jmp end_else_a5ba5353fe6e4534aaec5733b25d1ca6     ; Jump over ELSE part
    end_if_09bc5cedb04c4382bb0086a6eede8c77:    ; if_118546808bcb40d1ac0e04b614d5294e END
    else_980153ae89984812a6b3d39a4e9b2eda:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_else_a5ba5353fe6e4534aaec5733b25d1ca6: ; END of else_980153ae89984812a6b3d39a4e9b2eda
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
    call func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start
      add rsp, 48
      push rax
    if_c5945c1210874ede9efdc094ad643d8a: ; IF start
    pop rax
      test rax, rax
      je end_if_4e2d9be5d2bb426dafaed1fefe1000e2
      jmp end_else_11b28779ba1f4bf6b3d7f9b54439d04d     ; Jump over ELSE part
    end_if_4e2d9be5d2bb426dafaed1fefe1000e2:    ; if_c5945c1210874ede9efdc094ad643d8a END
    else_1840c7e7a4974c9dac62f0a21bc67b8c:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_else_11b28779ba1f4bf6b3d7f9b54439d04d: ; END of else_1840c7e7a4974c9dac62f0a21bc67b8c
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
    call func_45787065637444656E696564_7c88eb1d0f394ff1848b1857e9293ffa_start
      add rsp, 48
      push rax
    if_daddf67f90d044c09e7151a2cf9a1d2c: ; IF start
    pop rax
      test rax, rax
      je end_if_43082cccddff4fd68dcd45ee94739d06
      jmp end_else_5319b9048cbe4c4fb70456daea9d7ac7     ; Jump over ELSE part
    end_if_43082cccddff4fd68dcd45ee94739d06:    ; if_daddf67f90d044c09e7151a2cf9a1d2c END
    else_676ab5dacc5d4ab79a60ac8d42e89af3:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_else_5319b9048cbe4c4fb70456daea9d7ac7: ; END of else_676ab5dacc5d4ab79a60ac8d42e89af3
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_76e5d6d4ca3c47f9aa3d327f34cbc2b1: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_c139c590b20e4951b1c0d9d8d02918eb
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
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
    if_b5de5055f3074bb28de745fdac417fe7: ; IF start
    pop rax
      test rax, rax
      je end_if_10767c1c310a40859266a647feeef5cc
    mov rax, 0xFFFFFFFFFFFFFFFD
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_10767c1c310a40859266a647feeef5cc: ; END of if_b5de5055f3074bb28de745fdac417fe7
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_76e5d6d4ca3c47f9aa3d327f34cbc2b1 ; Reevaluate WHILE condition
    end_while_c139c590b20e4951b1c0d9d8d02918eb: ; END of while_76e5d6d4ca3c47f9aa3d327f34cbc2b1
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
    if_f7540b942a5f4dea93c28e6cd825f815: ; IF start
    pop rax
      test rax, rax
      je end_if_947033fad4f2462cb7fddbb82178d929
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_947033fad4f2462cb7fddbb82178d929: ; END of if_f7540b942a5f4dea93c28e6cd825f815
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
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
    if_3653e63a950b4fbd8bc7dd40ef9d5144: ; IF start
    pop rax
      test rax, rax
      je end_if_bca5bd8ffb1641a3b7ed3bb472e1f881
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_bca5bd8ffb1641a3b7ed3bb472e1f881: ; END of if_3653e63a950b4fbd8bc7dd40ef9d5144
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
    if_bfef25c8b2ed419e806015534fb5a06a: ; IF start
    pop rax
      test rax, rax
      je end_if_ea30f9a2762f4876a5fed5b0ca0fbf72
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_ea30f9a2762f4876a5fed5b0ca0fbf72: ; END of if_bfef25c8b2ed419e806015534fb5a06a
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
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
    if_9cb17954946b4edcbeda41fd12cd8964: ; IF start
    pop rax
      test rax, rax
      je end_if_61c05dbf55384c2b88d3435d13309c7b
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_61c05dbf55384c2b88d3435d13309c7b: ; END of if_9cb17954946b4edcbeda41fd12cd8964
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
    if_c85236cf198d4f75915d37a3587acb44: ; IF start
    pop rax
      test rax, rax
      je end_if_a29a7b55574a45f7bd4c5bc5961f4943
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_a29a7b55574a45f7bd4c5bc5961f4943: ; END of if_c85236cf198d4f75915d37a3587acb44
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
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
    if_8df79220bfdd4578886206208e529dec: ; IF start
    pop rax
      test rax, rax
      je end_if_ac88c8ed082f4582885ace847036cb89
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_ac88c8ed082f4582885ace847036cb89: ; END of if_8df79220bfdd4578886206208e529dec
    mov rax, qword [rbp - 16]
      push rax
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
    if_472098e33d7445269a41cb2592e3bb2e: ; IF start
    pop rax
      test rax, rax
      je end_if_3e0095a2c7b24056a17926916926603c
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_3e0095a2c7b24056a17926916926603c: ; END of if_472098e33d7445269a41cb2592e3bb2e
    mov rax, qword [rbp - 16]
      push rax
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
    if_00a711a5abb143bf8bb027d8d9cc9137: ; IF start
    pop rax
      test rax, rax
      je end_if_eaaaee8e4fc24c15a9caba1c1a3b52ba
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_eaaaee8e4fc24c15a9caba1c1a3b52ba: ; END of if_00a711a5abb143bf8bb027d8d9cc9137
    mov rax, qword [rbp - 16]
      push rax
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
    if_c57a14f8ebeb4587831673f8a719b51f: ; IF start
    pop rax
      test rax, rax
      je end_if_dcf1e2f282d24f06ada732b11055aa24
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_dcf1e2f282d24f06ada732b11055aa24: ; END of if_c57a14f8ebeb4587831673f8a719b51f
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_e867230b4a754875932267ceca262ee2: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_cea71510e16741b4a4ca027b38247aaf
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
  mov rcx, rax
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
    if_583ab94fafeb4ad490e2e72df9dbce47: ; IF start
    pop rax
      test rax, rax
      je end_if_85ffa15308f9400caccf84580681779a
    mov rax, 0xFFFFFFFFFFFFFFF9
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_85ffa15308f9400caccf84580681779a: ; END of if_583ab94fafeb4ad490e2e72df9dbce47
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_e867230b4a754875932267ceca262ee2 ; Reevaluate WHILE condition
    end_while_cea71510e16741b4a4ca027b38247aaf: ; END of while_e867230b4a754875932267ceca262ee2
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
    if_ad938f7c02b5435ca6638cde80916794: ; IF start
    pop rax
      test rax, rax
      je end_if_05209ad4e9cc4bd299151093a5283f5d
    mov rax, 0xFFFFFFFFFFFFFFF8
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_05209ad4e9cc4bd299151093a5283f5d: ; END of if_ad938f7c02b5435ca6638cde80916794
    mov rax, qword [rbp - 24]
  mov qword [rsp - 8], rax
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
    if_d176c37f2ea54837850307f1f76f309f: ; IF start
    pop rax
      test rax, rax
      je end_if_36a56fbb1cce4b1ebb7890f4cafe89b6
    mov rax, 0xFFFFFFFFFFFFFFF7
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    end_if_36a56fbb1cce4b1ebb7890f4cafe89b6: ; END of if_d176c37f2ea54837850307f1f76f309f
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
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end
    func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_aac71b99cfdb4a72aa0ec711a87021d7_end:

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
call func_546578744D61696E_5c9f4fa32f964f6195e9627d20189d0d_start
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
