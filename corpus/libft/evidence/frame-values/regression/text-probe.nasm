  module_696F5F70726F6265_afddde8145b54217811fd0f7a82baef4_start:
  ; Module: io_probe v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 21:43:52Z
    ; Module UUID: afddde81-45b5-4217-811f-d0f7a82baef4


    section .bss

    section .text

    func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start:
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
    if_8fee81be8efe4cff8ca4494e2e73a71e: ; IF start
    mov rcx, 1
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jne end_if_7a804ed219474da884b814a4181069e1
    
    call ubytec_hostio_HostRead
      add rsp, 40
      push rax
      jmp end_else_1f365ea233cb48bdaf5a7dcb9a80e4a0     ; Jump over ELSE part
    end_if_7a804ed219474da884b814a4181069e1:    ; if_8fee81be8efe4cff8ca4494e2e73a71e END
    else_a163ac671abe427189bf81c7ae2176a4:  ; Start ELSE block
    call ubytec_hostio_HostWrite
      add rsp, 40
      push rax
    end_else_1f365ea233cb48bdaf5a7dcb9a80e4a0: ; END of else_a163ac671abe427189bf81c7ae2176a4
    
    pop rax
      
      mov qword [rbp - 8], rax
    if_fcd47c4d889b44b08c60c949ef89aff5: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      je end_if_606eabbae7a04254aa91ba9082c39484
    
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_end
    end_if_606eabbae7a04254aa91ba9082c39484: ; END of if_fcd47c4d889b44b08c60c949ef89aff5
    
    mov rax, qword [rbp + 16]
  mov qword [rsp - 8], rax
      mov rax, qword [rax]
      push rax
    if_56ea0b0ec2394cfca0a8bb7eff53ab5c: ; IF start
    pop rax
      test rax, rax
      je end_if_9577db1bd65245b09867503e934f4ca8
    
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_end
    end_if_9577db1bd65245b09867503e934f4ca8: ; END of if_56ea0b0ec2394cfca0a8bb7eff53ab5c
    
    mov rax, 0x0000000000000001
  mov qword [rsp - 8], rax
      
      jmp func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_end
    func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_end:
      mov rsp, rbp
      pop rbp
      ret
    func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_start:
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
    if_7da37cbf160d4024b3fc6708adaedf5b: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_6702b3a8cef2498386783c2fb5e942cf
    
    mov rax, 0xFFFFFFFFFFFFFFFF
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_6702b3a8cef2498386783c2fb5e942cf: ; END of if_7da37cbf160d4024b3fc6708adaedf5b
    
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
    while_e059252b4116467e8b1d678f8f9c35a4: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_872afe25525b48d9a3ff3e4a2b7d326b
    
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
      jmp while_e059252b4116467e8b1d678f8f9c35a4 ; Reevaluate WHILE condition
    end_while_872afe25525b48d9a3ff3e4a2b7d326b: ; END of while_e059252b4116467e8b1d678f8f9c35a4
    
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
    call func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start
      add rsp, 48
      push rax
    if_38d1a455775f42ad92557806861b74c6: ; IF start
    pop rax
      test rax, rax
      je end_if_68d1c9995ebf4c619f3fe3dec85d9768
    
      jmp end_else_b3587a431d64447097c0ded596d1f919     ; Jump over ELSE part
    end_if_68d1c9995ebf4c619f3fe3dec85d9768:    ; if_38d1a455775f42ad92557806861b74c6 END
    else_d467daa3d3d14350b1fe84b1652c8a11:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_else_b3587a431d64447097c0ded596d1f919: ; END of else_d467daa3d3d14350b1fe84b1652c8a11
    
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
    call func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start
      add rsp, 48
      push rax
    if_e5ec248e027f44b49129c170542532a9: ; IF start
    pop rax
      test rax, rax
      je end_if_bacaa7c2102248108a0961973684f9e4
    
      jmp end_else_e20aa85df2e547fba1ca10b76d0a7bab     ; Jump over ELSE part
    end_if_bacaa7c2102248108a0961973684f9e4:    ; if_e5ec248e027f44b49129c170542532a9 END
    else_563a6113d80d4769bfe78b68309892a2:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_else_e20aa85df2e547fba1ca10b76d0a7bab: ; END of else_563a6113d80d4769bfe78b68309892a2
    
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
    call func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start
      add rsp, 48
      push rax
    if_d323e07b96da4d5db69b9276f68066c0: ; IF start
    pop rax
      test rax, rax
      je end_if_b30b10ccb93c4176b06c814c8ebbedc1
    
      jmp end_else_acd15e2b051a4eaeabcf0ec3f4464e4f     ; Jump over ELSE part
    end_if_b30b10ccb93c4176b06c814c8ebbedc1:    ; if_d323e07b96da4d5db69b9276f68066c0 END
    else_9ef2b7c6cac749779e8f58e7b72a5328:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_else_acd15e2b051a4eaeabcf0ec3f4464e4f: ; END of else_9ef2b7c6cac749779e8f58e7b72a5328
    
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
    call func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start
      add rsp, 48
      push rax
    if_1b0471b8d6ab4fa28884c54632b68486: ; IF start
    pop rax
      test rax, rax
      je end_if_242d611822a64d10b75b0cb5696bccf9
    
      jmp end_else_c8f02dcc1eba45949ebfa5f608148198     ; Jump over ELSE part
    end_if_242d611822a64d10b75b0cb5696bccf9:    ; if_1b0471b8d6ab4fa28884c54632b68486 END
    else_910c02ed52a74cae83d8d64634bd2c72:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_else_c8f02dcc1eba45949ebfa5f608148198: ; END of else_910c02ed52a74cae83d8d64634bd2c72
    
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
    call func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start
      add rsp, 48
      push rax
    if_c8b60564e827462c803844a376107129: ; IF start
    pop rax
      test rax, rax
      je end_if_8ffa6f72a4784df1a2a2ce2befd6c6fc
    
      jmp end_else_73f6bc5ea65d4a5880e1bb121d4e54cc     ; Jump over ELSE part
    end_if_8ffa6f72a4784df1a2a2ce2befd6c6fc:    ; if_c8b60564e827462c803844a376107129 END
    else_ca947b72e83d410dac15131d34641c6b:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_else_73f6bc5ea65d4a5880e1bb121d4e54cc: ; END of else_ca947b72e83d410dac15131d34641c6b
    
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
    call func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start
      add rsp, 48
      push rax
    if_56366fe3e25b4e0e9bb140761aec988d: ; IF start
    pop rax
      test rax, rax
      je end_if_91153e902fdb48ab9f8c52b68da1d283
    
      jmp end_else_cdbc306d5cce4972ac8e01f9c7c084ee     ; Jump over ELSE part
    end_if_91153e902fdb48ab9f8c52b68da1d283:    ; if_56366fe3e25b4e0e9bb140761aec988d END
    else_cda52e61691746c59c84f655f0be0d92:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_else_cdbc306d5cce4972ac8e01f9c7c084ee: ; END of else_cda52e61691746c59c84f655f0be0d92
    
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
    call func_45787065637444656E696564_576adda9fc5342ab8e07abb9561087d6_start
      add rsp, 48
      push rax
    if_c26bcf466d4b4a939de00d86ad450b33: ; IF start
    pop rax
      test rax, rax
      je end_if_4d753edd47eb426d8c518822ffd774fd
    
      jmp end_else_9f9ab50509d1428795db845b37b411f6     ; Jump over ELSE part
    end_if_4d753edd47eb426d8c518822ffd774fd:    ; if_c26bcf466d4b4a939de00d86ad450b33 END
    else_d3a4e5ae2d8c4d20b6bd16e41ea1f80b:  ; Start ELSE block
    mov rax, 0xFFFFFFFFFFFFFFFE
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_else_9f9ab50509d1428795db845b37b411f6: ; END of else_d3a4e5ae2d8c4d20b6bd16e41ea1f80b
    
    mov rax, 0x0000000000000000
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_ac97648b8fa8417396d6c38f3d8d14ff: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_f0d4713a8e994d899b524d55ec84de4b
    
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
    if_0de068b062ee45f197027c5d53530a56: ; IF start
    pop rax
      test rax, rax
      je end_if_370073abc69942edb404f820d0238818
    
    mov rax, 0xFFFFFFFFFFFFFFFD
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_370073abc69942edb404f820d0238818: ; END of if_0de068b062ee45f197027c5d53530a56
    
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_ac97648b8fa8417396d6c38f3d8d14ff ; Reevaluate WHILE condition
    end_while_f0d4713a8e994d899b524d55ec84de4b: ; END of while_ac97648b8fa8417396d6c38f3d8d14ff
    
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
    if_21f7f0f90bc84adf8c8ae7c5c4169e48: ; IF start
    pop rax
      test rax, rax
      je end_if_32703683bd2b4c3087d824abfb7cab0a
    
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_32703683bd2b4c3087d824abfb7cab0a: ; END of if_21f7f0f90bc84adf8c8ae7c5c4169e48
    
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
    if_ae8a9e5c6f0e446ca281a50d6eeffa26: ; IF start
    pop rax
      test rax, rax
      je end_if_4e6f6f1395b14bf1820755c64670066b
    
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_4e6f6f1395b14bf1820755c64670066b: ; END of if_ae8a9e5c6f0e446ca281a50d6eeffa26
    
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
    if_d8743b5bad9b46bebe3d2f2db3039d80: ; IF start
    pop rax
      test rax, rax
      je end_if_7080e203d57249858209af49721d3024
    
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_7080e203d57249858209af49721d3024: ; END of if_d8743b5bad9b46bebe3d2f2db3039d80
    
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
    if_95cd08c4adf7433698d077e81be9ae8d: ; IF start
    pop rax
      test rax, rax
      je end_if_241cdf4d102c4e39bb34cbb640641227
    
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_241cdf4d102c4e39bb34cbb640641227: ; END of if_95cd08c4adf7433698d077e81be9ae8d
    
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
    if_6d4ac5707b7b44b8b695dca818cfe1e5: ; IF start
    pop rax
      test rax, rax
      je end_if_a071d069811f482a84af159d006cdbc2
    
    mov rax, 0xFFFFFFFFFFFFFFFC
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_a071d069811f482a84af159d006cdbc2: ; END of if_6d4ac5707b7b44b8b695dca818cfe1e5
    
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
    if_9a1a2827ee4a4bdb90bfcdcb9c42d373: ; IF start
    pop rax
      test rax, rax
      je end_if_c5f4158233f64a838481a452d57c056c
    
    mov rax, 0xFFFFFFFFFFFFFFFB
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_c5f4158233f64a838481a452d57c056c: ; END of if_9a1a2827ee4a4bdb90bfcdcb9c42d373
    
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
    if_813b3f86d6d04d32984bac58e0271a97: ; IF start
    pop rax
      test rax, rax
      je end_if_8709d7cc2ab64d76b53c174dfef96217
    
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_8709d7cc2ab64d76b53c174dfef96217: ; END of if_813b3f86d6d04d32984bac58e0271a97
    
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
    if_6ff12807147a408485c82c2f5db4badb: ; IF start
    pop rax
      test rax, rax
      je end_if_7a42adf2fe824ca79498842cce1bd0b0
    
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_7a42adf2fe824ca79498842cce1bd0b0: ; END of if_6ff12807147a408485c82c2f5db4badb
    
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
    if_1af699723441480a884f6079c8c6844e: ; IF start
    pop rax
      test rax, rax
      je end_if_40ac72a93b814087aeb50a3ca7463f67
    
    mov rax, 0xFFFFFFFFFFFFFFFA
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_40ac72a93b814087aeb50a3ca7463f67: ; END of if_1af699723441480a884f6079c8c6844e
    
    mov rax, 0x0000000000000003
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
    while_93bd07a0b1034ef1988319a9ea49dea9: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jae end_while_cb647173323c4a02be140aacbb45d52a
    
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
    if_069e6a003bee4403b6d2652eb3b12804: ; IF start
    pop rax
      test rax, rax
      je end_if_cd34ea76ec444ee49ac44c430001c5ac
    
    mov rax, 0xFFFFFFFFFFFFFFF9
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_cd34ea76ec444ee49ac44c430001c5ac: ; END of if_069e6a003bee4403b6d2652eb3b12804
    
    mov rax, qword [rbp - 8]
  mov qword [rsp - 8], rax
      inc rax
  mov qword [rsp - 8], rax
      
      mov qword [rbp - 8], rax
      jmp while_93bd07a0b1034ef1988319a9ea49dea9 ; Reevaluate WHILE condition
    end_while_cb647173323c4a02be140aacbb45d52a: ; END of while_93bd07a0b1034ef1988319a9ea49dea9
    
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
    if_cbebe29613de4478b56ce9a7cc7925e9: ; IF start
    pop rax
      test rax, rax
      je end_if_1ac363e68cfa425cb9dbcb9225e248f7
    
    mov rax, 0xFFFFFFFFFFFFFFF8
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_1ac363e68cfa425cb9dbcb9225e248f7: ; END of if_cbebe29613de4478b56ce9a7cc7925e9
    
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
    if_c4016483212f492c878854c8d93be921: ; IF start
    pop rax
      test rax, rax
      je end_if_f1a3e1b7f6444151920a81923933766e
    
    mov rax, 0xFFFFFFFFFFFFFFF7
  mov qword [rsp - 8], rax
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    end_if_f1a3e1b7f6444151920a81923933766e: ; END of if_c4016483212f492c878854c8d93be921
    
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
      
      jmp func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end
    func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_end:
      mov rsp, rbp
      pop rbp
      ret
module_696F5F70726F6265_afddde8145b54217811fd0f7a82baef4_end:

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
call func_546578744D61696E_5c5fc842b5794ba6ab0a5da792413a6b_start
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
