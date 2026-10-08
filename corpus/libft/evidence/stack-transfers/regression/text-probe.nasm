  module_696F5F70726F6265_45d91a3184804e5d86c28db4ecf4fcd1_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 21:31:21Z
    ; Module UUID: 45d91a31-8480-4e5d-86c2-8db4ecf4fcd1


    section .bss

    section .text

    func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start:
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
    if_c619ee74c0464a1a9a01adbd1ca1de2a: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_ceb7cc91c8c149798b0b19a16270d475
    
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_484c7c9d8b144b4aae8149f8b6cc5427     ; Jump over ELSE part
    end_if_ceb7cc91c8c149798b0b19a16270d475:    ; if_c619ee74c0464a1a9a01adbd1ca1de2a END
    else_20a4ecc7405f435a869e1640a9d46871:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_484c7c9d8b144b4aae8149f8b6cc5427: ; END of else_20a4ecc7405f435a869e1640a9d46871
    
    pop rax
      
      mov qword [rbp - 8], rax
    if_50f0b872611e4f41b955525c23a2d263: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_97ed75f44d82449bb6e14ec8f554904f
    
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_end
    end_if_97ed75f44d82449bb6e14ec8f554904f: ; END of if_50f0b872611e4f41b955525c23a2d263
    
    mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    if_06f3c29ca30749f384ac485a93831ea7: ; IF start
    pop rax
      test rax, rax
      je end_if_159b0298aebb4bbf983f4e353b678d5a
    
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_end
    end_if_159b0298aebb4bbf983f4e353b678d5a: ; END of if_06f3c29ca30749f384ac485a93831ea7
    
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_end
    func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_728db6e82c2745b69214f45183170b5c_start:
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
    if_704d69533ab247fc8aa7eb315e19dd09: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_5b6c519640f54c8fab01a8a57c5d048d
    
    mov rax, 0xFFFFFFFFFFFFFFFF
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_5b6c519640f54c8fab01a8a57c5d048d: ; END of if_704d69533ab247fc8aa7eb315e19dd09
    
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
    while_2ba43948b1fa461fbabd7d5f3d2b67bb: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_df7437c4f5114c5692101c99bac09dba
    
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
      jmp while_2ba43948b1fa461fbabd7d5f3d2b67bb ; Reevaluate WHILE condition
    end_while_df7437c4f5114c5692101c99bac09dba: ; END of while_2ba43948b1fa461fbabd7d5f3d2b67bb
    
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
    call func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start
      add rsp, 48
      push rax
    if_5905149007e44a0f827ece0c8c78d704: ; IF start
    pop rax
      test rax, rax
      je end_if_10ef1dcd17d44cf982a68ef9078913d3
    
      jmp end_else_7859fa3528054b528413e0e7aeade29e     ; Jump over ELSE part
    end_if_10ef1dcd17d44cf982a68ef9078913d3:    ; if_5905149007e44a0f827ece0c8c78d704 END
    else_e369eee3690f44088e7a63b27b20a8cf:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_else_7859fa3528054b528413e0e7aeade29e: ; END of else_e369eee3690f44088e7a63b27b20a8cf
    
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
    call func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start
      add rsp, 48
      push rax
    if_f6a3222cf3994f11b89772ab021624fe: ; IF start
    pop rax
      test rax, rax
      je end_if_bc46d4f91b964ae28fa07626624b7146
    
      jmp end_else_2e24c466095d4787a7644ccad84aa580     ; Jump over ELSE part
    end_if_bc46d4f91b964ae28fa07626624b7146:    ; if_f6a3222cf3994f11b89772ab021624fe END
    else_47a283d0059f4859b81f7b0462cb669a:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_else_2e24c466095d4787a7644ccad84aa580: ; END of else_47a283d0059f4859b81f7b0462cb669a
    
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
    call func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start
      add rsp, 48
      push rax
    if_258c4c6f49464ddb877576774a2f543a: ; IF start
    pop rax
      test rax, rax
      je end_if_fad49aad40b64c6d868105ae59a100a8
    
      jmp end_else_c5556b94a0974c61b1056a0c3de66a12     ; Jump over ELSE part
    end_if_fad49aad40b64c6d868105ae59a100a8:    ; if_258c4c6f49464ddb877576774a2f543a END
    else_fb13e946277c4205a129a595e09a11ab:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_else_c5556b94a0974c61b1056a0c3de66a12: ; END of else_fb13e946277c4205a129a595e09a11ab
    
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
    call func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start
      add rsp, 48
      push rax
    if_f0c9a2fb48ab4ac8bb5c62b3876d24e4: ; IF start
    pop rax
      test rax, rax
      je end_if_944a45b0f46c47c58d405149e44e04eb
    
      jmp end_else_61aa15dca294484c9e265f171476756c     ; Jump over ELSE part
    end_if_944a45b0f46c47c58d405149e44e04eb:    ; if_f0c9a2fb48ab4ac8bb5c62b3876d24e4 END
    else_c69cbb19c32f4b1ebe41af0d8f54f5b6:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_else_61aa15dca294484c9e265f171476756c: ; END of else_c69cbb19c32f4b1ebe41af0d8f54f5b6
    
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
    call func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start
      add rsp, 48
      push rax
    if_d7d20b368a124ce8811eb25ba6bba56e: ; IF start
    pop rax
      test rax, rax
      je end_if_6dcb850942cb49d195f38ed0c9c263e0
    
      jmp end_else_25c9d3a32b244c59802c8ab3e96fc0d5     ; Jump over ELSE part
    end_if_6dcb850942cb49d195f38ed0c9c263e0:    ; if_d7d20b368a124ce8811eb25ba6bba56e END
    else_de4ed000316a49d888b9755e22a54c4e:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_else_25c9d3a32b244c59802c8ab3e96fc0d5: ; END of else_de4ed000316a49d888b9755e22a54c4e
    
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
    call func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start
      add rsp, 48
      push rax
    if_465b614fcb474ada895d316c42279303: ; IF start
    pop rax
      test rax, rax
      je end_if_b86726c9fdd841a583fa31b76a58b055
    
      jmp end_else_18a64b22f697443c92584c14a9cda6a9     ; Jump over ELSE part
    end_if_b86726c9fdd841a583fa31b76a58b055:    ; if_465b614fcb474ada895d316c42279303 END
    else_7359919caeee4bed988c64be919822e6:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_else_18a64b22f697443c92584c14a9cda6a9: ; END of else_7359919caeee4bed988c64be919822e6
    
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
    call func_45787065637444656E696564_39cd272c25054f549724aceb71accee7_start
      add rsp, 48
      push rax
    if_66f0ca1a01bb4782a1f85137d88cd3b8: ; IF start
    pop rax
      test rax, rax
      je end_if_ad4178ee96a24fa5938b435a48bd337e
    
      jmp end_else_8417b35d357f481bb7903e9523e84c02     ; Jump over ELSE part
    end_if_ad4178ee96a24fa5938b435a48bd337e:    ; if_66f0ca1a01bb4782a1f85137d88cd3b8 END
    else_1a903c75c9024792b41c2ee14077f24a:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_else_8417b35d357f481bb7903e9523e84c02: ; END of else_1a903c75c9024792b41c2ee14077f24a
    
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_5a6f0ffeddda420192e80d3a807f264d: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_c20e5c358720447abfd73ef59ec56ae8
    
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
    if_f293d52bb68d46f28e9264785c5383b6: ; IF start
    pop rax
      test rax, rax
      je end_if_82e2606d349945f9a6fa81aecea72e67
    
    mov rax, 0xFFFFFFFFFFFFFFFD
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_82e2606d349945f9a6fa81aecea72e67: ; END of if_f293d52bb68d46f28e9264785c5383b6
    
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_5a6f0ffeddda420192e80d3a807f264d ; Reevaluate WHILE condition
    end_while_c20e5c358720447abfd73ef59ec56ae8: ; END of while_5a6f0ffeddda420192e80d3a807f264d
    
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
    if_2c4433140bdb4891b0ede64de0e362be: ; IF start
    pop rax
      test rax, rax
      je end_if_5dae574a6d084a588ef25d9f8a3cad51
    
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_5dae574a6d084a588ef25d9f8a3cad51: ; END of if_2c4433140bdb4891b0ede64de0e362be
    
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
    if_25109a2bfed94f77ad87f4d083266a30: ; IF start
    pop rax
      test rax, rax
      je end_if_51da86a5dcd8483e8a2565982a393dda
    
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_51da86a5dcd8483e8a2565982a393dda: ; END of if_25109a2bfed94f77ad87f4d083266a30
    
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
    if_b4bcf73340644cb3be139d9ee78ab990: ; IF start
    pop rax
      test rax, rax
      je end_if_aad10478ab5b42f399ddc2c50abf8f58
    
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_aad10478ab5b42f399ddc2c50abf8f58: ; END of if_b4bcf73340644cb3be139d9ee78ab990
    
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
    if_f0be4073ecd6454f999b2e6030633cae: ; IF start
    pop rax
      test rax, rax
      je end_if_69dde42ef3434055aa0cf57658379477
    
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_69dde42ef3434055aa0cf57658379477: ; END of if_f0be4073ecd6454f999b2e6030633cae
    
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
    if_1698ab797fab4eb5bf33fca753868ae7: ; IF start
    pop rax
      test rax, rax
      je end_if_b44ecbc18a2e4b6ba51ad5c870a6412d
    
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_b44ecbc18a2e4b6ba51ad5c870a6412d: ; END of if_1698ab797fab4eb5bf33fca753868ae7
    
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
    if_5b432170335e43db9b98020f39b5425c: ; IF start
    pop rax
      test rax, rax
      je end_if_7e6e973621234f90a72669f3abbdbf2e
    
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_7e6e973621234f90a72669f3abbdbf2e: ; END of if_5b432170335e43db9b98020f39b5425c
    
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
    if_357c3360d9be430b912c526a011178a4: ; IF start
    pop rax
      test rax, rax
      je end_if_e249e57746104fcab559091c815df97c
    
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_e249e57746104fcab559091c815df97c: ; END of if_357c3360d9be430b912c526a011178a4
    
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
    if_f9612d17e2064d27be9fa1e0e14de341: ; IF start
    pop rax
      test rax, rax
      je end_if_5847bd2df19549d98a762e1b507f050d
    
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_5847bd2df19549d98a762e1b507f050d: ; END of if_f9612d17e2064d27be9fa1e0e14de341
    
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
    if_8fb638d742b845a49f0471cb657dd7a8: ; IF start
    pop rax
      test rax, rax
      je end_if_c127ddb1e9cc4515b1e3eb275a86f9f3
    
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_c127ddb1e9cc4515b1e3eb275a86f9f3: ; END of if_8fb638d742b845a49f0471cb657dd7a8
    
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_87c632b7616149329a4fb8046470134f: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_bc19f12cc0e4403a8d4c86862aab27a2
    
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
    if_0fd584a713104dafacabecca4416f065: ; IF start
    pop rax
      test rax, rax
      je end_if_f137cf94646842cf981fd8697ad6eeb8
    
    mov rax, 0xFFFFFFFFFFFFFFF9
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_f137cf94646842cf981fd8697ad6eeb8: ; END of if_0fd584a713104dafacabecca4416f065
    
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_87c632b7616149329a4fb8046470134f ; Reevaluate WHILE condition
    end_while_bc19f12cc0e4403a8d4c86862aab27a2: ; END of while_87c632b7616149329a4fb8046470134f
    
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
    if_68efb80b617042b9b10a07756ab466eb: ; IF start
    pop rax
      test rax, rax
      je end_if_8a07565a87004626be88ae35d4c950c0
    
    mov rax, 0xFFFFFFFFFFFFFFF8
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_8a07565a87004626be88ae35d4c950c0: ; END of if_68efb80b617042b9b10a07756ab466eb
    
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
    if_c497bc9d405a4b6a8636e5e2f2f38781: ; IF start
    pop rax
      test rax, rax
      je end_if_e57378dfe5bc413cb3454d79e4bccd1b
    
    mov rax, 0xFFFFFFFFFFFFFFF7
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    end_if_e57378dfe5bc413cb3454d79e4bccd1b: ; END of if_c497bc9d405a4b6a8636e5e2f2f38781
    
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
      
      jmp func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end
    func_546578744D61696E_728db6e82c2745b69214f45183170b5c_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_45d91a3184804e5d86c28db4ecf4fcd1_end:

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
call func_546578744D61696E_728db6e82c2745b69214f45183170b5c_start
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
