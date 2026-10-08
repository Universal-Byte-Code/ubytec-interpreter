  module_696F5F70726F6265_3f1a76da424548748b8cf10906f03a2e_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-06 01:17:14Z
    ; Module UUID: 3f1a76da-4245-4874-8b8c-f10906f03a2e


    section .bss

    section .text

    func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start:
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
    if_29273d7e6a9d4b78b9186f4e395c9647: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_68be4085a5f5431cb3b64681945621de
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_7ce70581c79c46939827825732a6badd     ; Jump over ELSE part
    end_if_68be4085a5f5431cb3b64681945621de:    ; if_29273d7e6a9d4b78b9186f4e395c9647 END
    else_2bb8b6c826644071a2bec0d2d46bb9ac:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_7ce70581c79c46939827825732a6badd: ; END of else_2bb8b6c826644071a2bec0d2d46bb9ac
    pop rax
      
      mov qword [rbp - 8], rax
    if_ad3b05717e044846ac7468e4d6f4a8c3: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_9819651bd4f74badbf84399f25ca2fd5
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_end
    end_if_9819651bd4f74badbf84399f25ca2fd5: ; END of if_ad3b05717e044846ac7468e4d6f4a8c3
    mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    if_b18faa268e664d28ad7bf1fc579a39b2: ; IF start
    pop rax
      test rax, rax
      je end_if_e782552b1a534144a66759510b1a56b5
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_end
    end_if_e782552b1a534144a66759510b1a56b5: ; END of if_b18faa268e664d28ad7bf1fc579a39b2
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_end
    func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_start:
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
    if_52a976a862f542b5a480f2a36aceb104: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_a3903bbdb4714208995fe0d96da71b4b
    mov rax, 0xFFFFFFFFFFFFFFFF
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_a3903bbdb4714208995fe0d96da71b4b: ; END of if_52a976a862f542b5a480f2a36aceb104
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
    while_8e33184439ca4c8f961c7c366fada1e2: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_b709fa2b5d584081b82d1361d6bbc9c2
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
      jmp while_8e33184439ca4c8f961c7c366fada1e2 ; Reevaluate WHILE condition
    end_while_b709fa2b5d584081b82d1361d6bbc9c2: ; END of while_8e33184439ca4c8f961c7c366fada1e2
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
    call func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start
      add rsp, 48
      push rax
    if_85ade6331f004e33bc949ac913737ea3: ; IF start
    pop rax
      test rax, rax
      je end_if_2ca6164c1deb48f89d1e4e9c392292f7
      jmp end_else_1ca8c0b3d9b743bd880019c17107d88e     ; Jump over ELSE part
    end_if_2ca6164c1deb48f89d1e4e9c392292f7:    ; if_85ade6331f004e33bc949ac913737ea3 END
    else_4e5ddc3b8f704b159614cd30915db567:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_else_1ca8c0b3d9b743bd880019c17107d88e: ; END of else_4e5ddc3b8f704b159614cd30915db567
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
    call func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start
      add rsp, 48
      push rax
    if_b4b481a3936848729baedc9f97bc8b09: ; IF start
    pop rax
      test rax, rax
      je end_if_d0c923e8a3c24ef9bdfc4a203012f7b4
      jmp end_else_90fa382b1c834b03b65f8e274c557bf7     ; Jump over ELSE part
    end_if_d0c923e8a3c24ef9bdfc4a203012f7b4:    ; if_b4b481a3936848729baedc9f97bc8b09 END
    else_be7a36ff1c3942ba9314e3ee6295937d:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_else_90fa382b1c834b03b65f8e274c557bf7: ; END of else_be7a36ff1c3942ba9314e3ee6295937d
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
    call func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start
      add rsp, 48
      push rax
    if_79fafbccfb6d477aaf64d41b39109b0e: ; IF start
    pop rax
      test rax, rax
      je end_if_04f322c2d167431795495482e439492e
      jmp end_else_26f831ae64a54c1c96296c51d119aff5     ; Jump over ELSE part
    end_if_04f322c2d167431795495482e439492e:    ; if_79fafbccfb6d477aaf64d41b39109b0e END
    else_546b034a9c664e9587b1cc356ba1fe76:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_else_26f831ae64a54c1c96296c51d119aff5: ; END of else_546b034a9c664e9587b1cc356ba1fe76
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
    call func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start
      add rsp, 48
      push rax
    if_c690f98b514d4f189c12334fa0990806: ; IF start
    pop rax
      test rax, rax
      je end_if_d936f8278e3948208ec4adbef2766593
      jmp end_else_0ee91525134e4c9a8bd86f3917594150     ; Jump over ELSE part
    end_if_d936f8278e3948208ec4adbef2766593:    ; if_c690f98b514d4f189c12334fa0990806 END
    else_1f8dfd2ae6144488961b6a3c7450806e:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_else_0ee91525134e4c9a8bd86f3917594150: ; END of else_1f8dfd2ae6144488961b6a3c7450806e
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
    call func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start
      add rsp, 48
      push rax
    if_08c44cc3738b4cf99f07db27d9432816: ; IF start
    pop rax
      test rax, rax
      je end_if_85cf5b0216324ee6af666b782940b216
      jmp end_else_68d5d6f4ae7e4d0890b977f91d37ab14     ; Jump over ELSE part
    end_if_85cf5b0216324ee6af666b782940b216:    ; if_08c44cc3738b4cf99f07db27d9432816 END
    else_1713560ead5a4dc4b9541a7209477156:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_else_68d5d6f4ae7e4d0890b977f91d37ab14: ; END of else_1713560ead5a4dc4b9541a7209477156
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
    call func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start
      add rsp, 48
      push rax
    if_7aca15fe7a8c46b8950f2234a7078b52: ; IF start
    pop rax
      test rax, rax
      je end_if_26d7c26d43c74da083c1b2d576769d36
      jmp end_else_f337c7ab8c5049858dbd607c0e5239bc     ; Jump over ELSE part
    end_if_26d7c26d43c74da083c1b2d576769d36:    ; if_7aca15fe7a8c46b8950f2234a7078b52 END
    else_998d9afa400f44099cba7e4180989204:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_else_f337c7ab8c5049858dbd607c0e5239bc: ; END of else_998d9afa400f44099cba7e4180989204
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
    call func_45787065637444656E696564_46567ad662914e5da1fdbdd4d7da85d9_start
      add rsp, 48
      push rax
    if_a655c809219c4f82b501886e7f910077: ; IF start
    pop rax
      test rax, rax
      je end_if_36d217cb14f3457bb91de096cb63d1ad
      jmp end_else_e3c5696b0f8940d2a12c7436e0993933     ; Jump over ELSE part
    end_if_36d217cb14f3457bb91de096cb63d1ad:    ; if_a655c809219c4f82b501886e7f910077 END
    else_cdb9a440ccd342ce8c0bf24b03ea8fdd:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_else_e3c5696b0f8940d2a12c7436e0993933: ; END of else_cdb9a440ccd342ce8c0bf24b03ea8fdd
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_fbc5a72d97b24a35b1e1953f474ab981: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_70606e93183041ae9642e75467338461
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
    if_afa8ff8b4af54d928b3ca91699f222e3: ; IF start
    pop rax
      test rax, rax
      je end_if_7fcd39f6f78f4bb49d3887011edb8a77
    mov rax, 0xFFFFFFFFFFFFFFFD
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_7fcd39f6f78f4bb49d3887011edb8a77: ; END of if_afa8ff8b4af54d928b3ca91699f222e3
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_fbc5a72d97b24a35b1e1953f474ab981 ; Reevaluate WHILE condition
    end_while_70606e93183041ae9642e75467338461: ; END of while_fbc5a72d97b24a35b1e1953f474ab981
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
    if_3a05c10797f141f6b609e59a73c4ea81: ; IF start
    pop rax
      test rax, rax
      je end_if_b6e6bc0be0d846e3a73b1eabd88042d6
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_b6e6bc0be0d846e3a73b1eabd88042d6: ; END of if_3a05c10797f141f6b609e59a73c4ea81
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
    if_fbe25bcf73944cd9b7b8ce55df96f500: ; IF start
    pop rax
      test rax, rax
      je end_if_8e6d1c31808245f7a1c02a8f55220e29
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_8e6d1c31808245f7a1c02a8f55220e29: ; END of if_fbe25bcf73944cd9b7b8ce55df96f500
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
    if_d555322a00064b2db41acb0f27a11b48: ; IF start
    pop rax
      test rax, rax
      je end_if_c6a35eef442a4d248eba70aba5681bbd
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_c6a35eef442a4d248eba70aba5681bbd: ; END of if_d555322a00064b2db41acb0f27a11b48
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
    if_4d5a993c61154c3c90c28cc33363c0c6: ; IF start
    pop rax
      test rax, rax
      je end_if_9d7cd37cbe4243e7893aca2dbde09759
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_9d7cd37cbe4243e7893aca2dbde09759: ; END of if_4d5a993c61154c3c90c28cc33363c0c6
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
    if_c594feac382c44c19d9b9b3825237ad4: ; IF start
    pop rax
      test rax, rax
      je end_if_79900d6ad94e4ff3b708e250255c30b4
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_79900d6ad94e4ff3b708e250255c30b4: ; END of if_c594feac382c44c19d9b9b3825237ad4
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
    if_4632626e2fed4ed5a4105d0bee29dc7f: ; IF start
    pop rax
      test rax, rax
      je end_if_b6a7de3c000a4a54882cae5a74d8b09a
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_b6a7de3c000a4a54882cae5a74d8b09a: ; END of if_4632626e2fed4ed5a4105d0bee29dc7f
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
    if_572292fee895469fb7f239db1b846f92: ; IF start
    pop rax
      test rax, rax
      je end_if_e94712336c4747cc910408eae208e895
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_e94712336c4747cc910408eae208e895: ; END of if_572292fee895469fb7f239db1b846f92
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
    if_8d76d0b8b0ac43f4b1f0b7d88303f717: ; IF start
    pop rax
      test rax, rax
      je end_if_f6eb35d69ed4422c93700c7d322b464a
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_f6eb35d69ed4422c93700c7d322b464a: ; END of if_8d76d0b8b0ac43f4b1f0b7d88303f717
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
    if_143c847fc0174e7ebdfffed91ff4aff1: ; IF start
    pop rax
      test rax, rax
      je end_if_e5e83042c17a4f7194853cebd768c8bc
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_e5e83042c17a4f7194853cebd768c8bc: ; END of if_143c847fc0174e7ebdfffed91ff4aff1
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_609ca0288df8437885347b27e58ed25d: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_ae216089638341d9bf539740f96e2ee3
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
    if_7a60a24afa674cd8aec7d50421ac4d9b: ; IF start
    pop rax
      test rax, rax
      je end_if_aa4eff8286504fcf9e3fee2f4eba8599
    mov rax, 0xFFFFFFFFFFFFFFF9
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_aa4eff8286504fcf9e3fee2f4eba8599: ; END of if_7a60a24afa674cd8aec7d50421ac4d9b
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_609ca0288df8437885347b27e58ed25d ; Reevaluate WHILE condition
    end_while_ae216089638341d9bf539740f96e2ee3: ; END of while_609ca0288df8437885347b27e58ed25d
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
    if_542bcaf34b88406aa02dd1e6e73bc4a4: ; IF start
    pop rax
      test rax, rax
      je end_if_857dbba188bc4940bb27b5db94b6c768
    mov rax, 0xFFFFFFFFFFFFFFF8
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_857dbba188bc4940bb27b5db94b6c768: ; END of if_542bcaf34b88406aa02dd1e6e73bc4a4
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
    if_5ade95785bfb49e0b439e33bb0f23f76: ; IF start
    pop rax
      test rax, rax
      je end_if_3dc548cd1ade45208d84c26c18a7777c
    mov rax, 0xFFFFFFFFFFFFFFF7
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    end_if_3dc548cd1ade45208d84c26c18a7777c: ; END of if_5ade95785bfb49e0b439e33bb0f23f76
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
      
      jmp func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end
    func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_3f1a76da424548748b8cf10906f03a2e_end:

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
call func_546578744D61696E_95376b1768714a94bdf2243ea63beb80_start
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
