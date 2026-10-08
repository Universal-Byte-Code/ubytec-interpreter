  module_696F5F70726F6265_e1a54ec94b3c44ca91f7164263121618_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 17:16:18Z
    ; Module UUID: e1a54ec9-4b3c-44ca-91f7-164263121618


    section .bss

    section .text

    func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start:
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
    if_2c93d4215cd1430b9bfda001d34d11cc: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_f6f489f83efe480db6236f2fa5b6d5df
    
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_852e4fe6dc8844098836272613ed9d3c     ; Jump over ELSE part
    end_if_f6f489f83efe480db6236f2fa5b6d5df:    ; if_2c93d4215cd1430b9bfda001d34d11cc END
    else_db4c688b1e444bc985e8617c3dfc2845:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_852e4fe6dc8844098836272613ed9d3c: ; END of else_db4c688b1e444bc985e8617c3dfc2845
    
    pop rax
      
      mov qword [rbp - 8], rax
    if_cfdbc36d9f3d4a73b193684547f44e82: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_2d2679600c3b4da8ba363e02e7a41343
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_end
    end_if_2d2679600c3b4da8ba363e02e7a41343: ; END of if_cfdbc36d9f3d4a73b193684547f44e82
    
    mov rax, qword [rbp + 16]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_8cc162a59a7f465a9a2fcfe36ed9b5f1: ; IF start
    pop rax
      test rax, rax
      je end_if_a324cef3c7fb4c049d972199c588dd5b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_end
    end_if_a324cef3c7fb4c049d972199c588dd5b: ; END of if_8cc162a59a7f465a9a2fcfe36ed9b5f1
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_end
    func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_start:
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
    if_5dae6bfd89a94be59d919769dc4db480: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_cb6e261719a94d9184f055dbcf9633a6
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_cb6e261719a94d9184f055dbcf9633a6: ; END of if_5dae6bfd89a94be59d919769dc4db480
    
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
    while_f9a94cbe0c25457290d1ec0b77d8b191: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_25b32fbf123045e7ab4cac4d4355794a
    
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
      jmp while_f9a94cbe0c25457290d1ec0b77d8b191 ; Reevaluate WHILE condition
    end_while_25b32fbf123045e7ab4cac4d4355794a: ; END of while_f9a94cbe0c25457290d1ec0b77d8b191
    
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
    call func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start
      add rsp, 48
      push rax
    if_9a3d6347371f455d85b8894d2c7508bf: ; IF start
    pop rax
      test rax, rax
      je end_if_830cabdf31cc4b9bbf662b48d8a0708d
    
      jmp end_else_dadbd3ea055f4d0894b1861832e41967     ; Jump over ELSE part
    end_if_830cabdf31cc4b9bbf662b48d8a0708d:    ; if_9a3d6347371f455d85b8894d2c7508bf END
    else_9c249831c87347a69525045e5db2cca0:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_else_dadbd3ea055f4d0894b1861832e41967: ; END of else_9c249831c87347a69525045e5db2cca0
    
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
    call func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start
      add rsp, 48
      push rax
    if_7868422cc13e46af87907b20c7a26362: ; IF start
    pop rax
      test rax, rax
      je end_if_930fb7766a134e8ea00bae0103eeeb3b
    
      jmp end_else_c017c9ee665c4aebafdcd7d177020791     ; Jump over ELSE part
    end_if_930fb7766a134e8ea00bae0103eeeb3b:    ; if_7868422cc13e46af87907b20c7a26362 END
    else_5139521feeb3448f9dc2b238b8652fd3:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_else_c017c9ee665c4aebafdcd7d177020791: ; END of else_5139521feeb3448f9dc2b238b8652fd3
    
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
    call func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start
      add rsp, 48
      push rax
    if_fc86657544f54b21aa6bb45edab969dc: ; IF start
    pop rax
      test rax, rax
      je end_if_41606b57c47148c6bb8b6621e864cf08
    
      jmp end_else_2959c627c6834e78a85316ce69d64bed     ; Jump over ELSE part
    end_if_41606b57c47148c6bb8b6621e864cf08:    ; if_fc86657544f54b21aa6bb45edab969dc END
    else_75bf8099c37e4c6f9d55d4ca7b9288aa:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_else_2959c627c6834e78a85316ce69d64bed: ; END of else_75bf8099c37e4c6f9d55d4ca7b9288aa
    
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
    call func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start
      add rsp, 48
      push rax
    if_2685dbb7d5274183830699733461561b: ; IF start
    pop rax
      test rax, rax
      je end_if_89d6e1f2642f4697847b4a04f104c9f1
    
      jmp end_else_e4ff050e333b468b9a5212080a393893     ; Jump over ELSE part
    end_if_89d6e1f2642f4697847b4a04f104c9f1:    ; if_2685dbb7d5274183830699733461561b END
    else_15052404f2e0461d97b012354583114c:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_else_e4ff050e333b468b9a5212080a393893: ; END of else_15052404f2e0461d97b012354583114c
    
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
    call func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start
      add rsp, 48
      push rax
    if_6e0d4157c23e474380973566840e846c: ; IF start
    pop rax
      test rax, rax
      je end_if_6b62d271f9b24883be76ac6241376627
    
      jmp end_else_407d56b594a14bec92446286166329a4     ; Jump over ELSE part
    end_if_6b62d271f9b24883be76ac6241376627:    ; if_6e0d4157c23e474380973566840e846c END
    else_c2713a0ba0fa401f8d9eb62704042bc6:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_else_407d56b594a14bec92446286166329a4: ; END of else_c2713a0ba0fa401f8d9eb62704042bc6
    
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
    call func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start
      add rsp, 48
      push rax
    if_0a171e839ae34f89b0d0178994218715: ; IF start
    pop rax
      test rax, rax
      je end_if_537703b6d90d4d368bcab06f51d1df9a
    
      jmp end_else_d8168ddb547a42e1b07d70a2dff82f6c     ; Jump over ELSE part
    end_if_537703b6d90d4d368bcab06f51d1df9a:    ; if_0a171e839ae34f89b0d0178994218715 END
    else_2698e20946c2448aaf8853c60f488a4d:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_else_d8168ddb547a42e1b07d70a2dff82f6c: ; END of else_2698e20946c2448aaf8853c60f488a4d
    
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
    call func_45787065637444656E696564_deaa29a229c546db948fb12dd64392ef_start
      add rsp, 48
      push rax
    if_17ac1813e1824c2c96fef4552edd6ac8: ; IF start
    pop rax
      test rax, rax
      je end_if_b042d1a394a24d2d8ad4df4c6cf97f06
    
      jmp end_else_b79c9fd4c90d4d4a9eb3afcf95cf9f73     ; Jump over ELSE part
    end_if_b042d1a394a24d2d8ad4df4c6cf97f06:    ; if_17ac1813e1824c2c96fef4552edd6ac8 END
    else_f6bee8e096554e4d8e16ff91477b4d03:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_else_b79c9fd4c90d4d4a9eb3afcf95cf9f73: ; END of else_f6bee8e096554e4d8e16ff91477b4d03
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    while_5d24633f39fe464185fc401a4f282c73: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_803c9e61808640ad896e7f643d9d7d38
    
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
    if_3f51aec30b3345e2b0eadca38a8b7596: ; IF start
    pop rax
      test rax, rax
      je end_if_a7fb65ab074b417f82b05214ee1c0ed0
    
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_a7fb65ab074b417f82b05214ee1c0ed0: ; END of if_3f51aec30b3345e2b0eadca38a8b7596
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      inc rax
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
      jmp while_5d24633f39fe464185fc401a4f282c73 ; Reevaluate WHILE condition
    end_while_803c9e61808640ad896e7f643d9d7d38: ; END of while_5d24633f39fe464185fc401a4f282c73
    
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
    if_2d6ebec9978346b7a8d46daaec46cf46: ; IF start
    pop rax
      test rax, rax
      je end_if_e6f6381b6021478fa98597de319a2dee
    
    mov rax, 0xFFFFFFFFFFFFFFFC
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_e6f6381b6021478fa98597de319a2dee: ; END of if_2d6ebec9978346b7a8d46daaec46cf46
    
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
    if_99cb44d19f114eb2a016423eb69a2296: ; IF start
    pop rax
      test rax, rax
      je end_if_5979c8a6e05f4329b535801b3ddbbd5c
    
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_5979c8a6e05f4329b535801b3ddbbd5c: ; END of if_99cb44d19f114eb2a016423eb69a2296
    
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
    if_b2cfac92fdfb42978c1199c0aa822227: ; IF start
    pop rax
      test rax, rax
      je end_if_67ed89059da44c879bc60243e816b5ce
    
    mov rax, 0xFFFFFFFFFFFFFFFC
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_67ed89059da44c879bc60243e816b5ce: ; END of if_b2cfac92fdfb42978c1199c0aa822227
    
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
    if_74ba5760a7a7499c8fe935c38ec70539: ; IF start
    pop rax
      test rax, rax
      je end_if_e904bb53382c406faffc657859249078
    
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_e904bb53382c406faffc657859249078: ; END of if_74ba5760a7a7499c8fe935c38ec70539
    
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
    if_32b944b1bb974e4a89a8b13d793c8211: ; IF start
    pop rax
      test rax, rax
      je end_if_98df1b538f374c3090e12f2c2ec4a707
    
    mov rax, 0xFFFFFFFFFFFFFFFC
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_98df1b538f374c3090e12f2c2ec4a707: ; END of if_32b944b1bb974e4a89a8b13d793c8211
    
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
    if_88e179407fa041e1b1d25871f13684d2: ; IF start
    pop rax
      test rax, rax
      je end_if_9e426dcea6324d55b23d26c0c73640f2
    
    mov rax, 0xFFFFFFFFFFFFFFFB
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_9e426dcea6324d55b23d26c0c73640f2: ; END of if_88e179407fa041e1b1d25871f13684d2
    
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
    if_8983e68db0564ba19f9422254826ab4f: ; IF start
    pop rax
      test rax, rax
      je end_if_fbe6de09083a41c4911c97fcac4e2aaa
    
    mov rax, 0xFFFFFFFFFFFFFFFA
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_fbe6de09083a41c4911c97fcac4e2aaa: ; END of if_8983e68db0564ba19f9422254826ab4f
    
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
    if_bb1e9e7d63854ebcbe9f320f9b553887: ; IF start
    pop rax
      test rax, rax
      je end_if_4131ca5e15734a71b63dae36e49594ac
    
    mov rax, 0xFFFFFFFFFFFFFFFA
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_4131ca5e15734a71b63dae36e49594ac: ; END of if_bb1e9e7d63854ebcbe9f320f9b553887
    
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
    if_bcc51250ec9d4de8a989bc99efe20d06: ; IF start
    pop rax
      test rax, rax
      je end_if_f3a54ce9e82b49548d7a1eacb9a885fc
    
    mov rax, 0xFFFFFFFFFFFFFFFA
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_f3a54ce9e82b49548d7a1eacb9a885fc: ; END of if_bcc51250ec9d4de8a989bc99efe20d06
    
    mov rax, 0x0000000000000003
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    while_c7ea5c18015840c3a32cda79b0190e78: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_ddacceb2d64345868baecbd78bff7e58
    
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
    if_136f7e1d1f754ac39177fe9cb6f4c921: ; IF start
    pop rax
      test rax, rax
      je end_if_241b0ce2b6ec4a11a2374f6c8935d0f5
    
    mov rax, 0xFFFFFFFFFFFFFFF9
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_241b0ce2b6ec4a11a2374f6c8935d0f5: ; END of if_136f7e1d1f754ac39177fe9cb6f4c921
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      inc rax
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
      jmp while_c7ea5c18015840c3a32cda79b0190e78 ; Reevaluate WHILE condition
    end_while_ddacceb2d64345868baecbd78bff7e58: ; END of while_c7ea5c18015840c3a32cda79b0190e78
    
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
    if_d0810e887ed5453d80abee6cedda631d: ; IF start
    pop rax
      test rax, rax
      je end_if_db5e4ec2e4714f82a1b3b292b8f75471
    
    mov rax, 0xFFFFFFFFFFFFFFF8
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_db5e4ec2e4714f82a1b3b292b8f75471: ; END of if_d0810e887ed5453d80abee6cedda631d
    
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
    if_309e3d307dad4e92818a5e0b699db4d1: ; IF start
    pop rax
      test rax, rax
      je end_if_7017ec31b01d4233b346de79d37b6fc3
    
    mov rax, 0xFFFFFFFFFFFFFFF7
      push rax
    pop rax
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    end_if_7017ec31b01d4233b346de79d37b6fc3: ; END of if_309e3d307dad4e92818a5e0b699db4d1
    
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
      
      jmp func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end
    func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_e1a54ec94b3c44ca91f7164263121618_end:

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
call func_546578744D61696E_18e85c9e829b40bead7ae7ea01040f4d_start
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
