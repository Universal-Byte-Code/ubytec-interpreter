  module_67656E657269635F70616972_3770e720aea34c78ac598cd131c9aaa8_start:
  ; Module: generic_pair v0.1 by Ubytec

    section .data

    ; ---------------- Metadata ----------------
    ; Compilation UTC Time: 2026-10-05 11:57:31Z
    ; Module UUID: 3770e720-aea3-4c78-ac59-8cd131c9aaa8


    section .bss

    section .text

    func_506169724D61696E_513c332135b54ce3b274ac1f6a54b226_start:
    push rbp
      mov rbp, rsp
    sub rsp, 128
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
    mov rax, 0x0000000000000000
      mov qword [rbp - 56], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 64], rax
    mov rax, 0x0000000000000004
      mov qword [rbp - 72], rax
    mov rax, 0x0000000000000002
      mov qword [rbp - 80], rax
    mov rax, 0x0000000000000008
      mov qword [rbp - 88], rax
    mov rax, 0x0000000000000008
      mov qword [rbp - 96], rax
    mov rax, 0x00000000000003E8
      mov qword [rbp - 104], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 112], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 120], rax
    if_9265fa4159624d0fb7bed811dc152b76: ; IF start
    mov rcx, 2208
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_6fa22222cc9a4d898a50ff1bb8340240
    
    mov rax, 0xFFFFFFFFFFFFFFF6
      push rax
    pop rax
      
      jmp func_506169724D61696E_513c332135b54ce3b274ac1f6a54b226_end
    end_if_6fa22222cc9a4d898a50ff1bb8340240: ; END of if_9265fa4159624d0fb7bed811dc152b76
    
    mov rax, qword [rbp + 40]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000080
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000800
      push rax
    call func_4172656E61496E6974_2f115397ab5844688ce5f5f4491d35fc_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000010
      push rax
    call func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000010
      push rax
    call func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    while_6bd2df3477f2481b9d0937a985605c77: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 64]
      cmp rax, rcx
      jae end_while_6b0c5553ce0c486f831d4911bb2c0205
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 64]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 64]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000061
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 64], rax
      jmp while_6bd2df3477f2481b9d0937a985605c77 ; Reevaluate WHILE condition
    end_while_6b0c5553ce0c486f831d4911bb2c0205: ; END of while_6bd2df3477f2481b9d0937a985605c77
    
    if_4143dd3ed4934f44a62a3211106f01f8: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_a92430a9383948f28abb2a4929872b00
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_if_a92430a9383948f28abb2a4929872b00: ; END of if_4143dd3ed4934f44a62a3211106f01f8
    
    if_1d9cba0ceca04a0994f369eba7787e29: ; IF start
    mov rcx, 2
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_1aff3ff46544433781622377f4e26157
    
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000010000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    end_if_1aff3ff46544433781622377f4e26157: ; END of if_1d9cba0ceca04a0994f369eba7787e29
    
    if_03988b6df9274da39fcd8197ae81e593: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_c78ea2d2325245cda25db4a57edb6a8d
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    end_if_c78ea2d2325245cda25db4a57edb6a8d: ; END of if_03988b6df9274da39fcd8197ae81e593
    
    if_21ec4346f2854b009f9226ff6eea5b1a: ; IF start
    mov rcx, 20
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_5186bf60103241edb515e5089c877b67
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp - 40]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x000000000000FFFF
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    end_if_5186bf60103241edb515e5089c877b67: ; END of if_21ec4346f2854b009f9226ff6eea5b1a
    
    if_51c1f16f1fba4a1aa37be41ea273379b: ; IF start
    mov rcx, 4
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_4670f44b936741d0a149d6d5d4a888bb
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_if_4670f44b936741d0a149d6d5d4a888bb: ; END of if_51c1f16f1fba4a1aa37be41ea273379b
    
    if_6c60e9bd38744d6cb298e1d8b96eb4e1: ; IF start
    mov rcx, 6
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_0b9ecbbc0be54a179723b4e02ebb7424
    
    mov rax, 0x0000000000000019
      push rax
    pop rax
      
      mov qword [rbp - 104], rax
    end_if_0b9ecbbc0be54a179723b4e02ebb7424: ; END of if_6c60e9bd38744d6cb298e1d8b96eb4e1
    
    if_742ba379215d4149a7c348486c06d36f: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_92d0f5cfe9074ac69a90a4138e0e7985
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 104], rax
    end_if_92d0f5cfe9074ac69a90a4138e0e7985: ; END of if_742ba379215d4149a7c348486c06d36f
    
    if_a0ad791578a24957b2cce67edba537a2: ; IF start
    mov rcx, 10
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_b7f54af70d4f4967ad2f1f01f2188deb
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      mov qword [rbp - 72], rax
    end_if_b7f54af70d4f4967ad2f1f01f2188deb: ; END of if_a0ad791578a24957b2cce67edba537a2
    
    if_d9d155aeab0b46cdb3774dc58ebb734a: ; IF start
    mov rcx, 11
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_f024f157f94248338f0af0d65fddd988
    
    mov rax, 0xFFFFFFFFFFFFFFFF
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    end_if_f024f157f94248338f0af0d65fddd988: ; END of if_d9d155aeab0b46cdb3774dc58ebb734a
    
    if_05b52850064f4d97865c299ff36461c7: ; IF start
    mov rcx, 12
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_7c1c02bf2ef14f9a9bf888e81ca46807
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 88], rax
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 96], rax
    end_if_7c1c02bf2ef14f9a9bf888e81ca46807: ; END of if_05b52850064f4d97865c299ff36461c7
    
    if_397e4708301142479f6734d376fa2612: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_4189ca42e36141e48fe71dbbd087e544
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_4189ca42e36141e48fe71dbbd087e544: ; END of if_397e4708301142479f6734d376fa2612
    
    if_dec7d81ecbe54745a582a4a40e9eeadf: ; IF start
    mov rcx, 1
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_50b3b6a90b1d4a11a43fbf16b25e01c0
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_50b3b6a90b1d4a11a43fbf16b25e01c0: ; END of if_dec7d81ecbe54745a582a4a40e9eeadf
    
    if_c9099d377a324593a3751c34acc93e67: ; IF start
    mov rcx, 2
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_a3ad539afeb04d9498457f9f3d2d3037
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_a3ad539afeb04d9498457f9f3d2d3037: ; END of if_c9099d377a324593a3751c34acc93e67
    
    if_c7cc9e1289d74568bea3ec488246ed10: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_5c7f6c6e8c634c4e8246df128d7354ff
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_5c7f6c6e8c634c4e8246df128d7354ff: ; END of if_c7cc9e1289d74568bea3ec488246ed10
    
    if_ce5e71ba347b4f19a84372894317588c: ; IF start
    mov rcx, 4
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_fafa0efd6f0c4f3bb0adeca9ce6204ed
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_fafa0efd6f0c4f3bb0adeca9ce6204ed: ; END of if_ce5e71ba347b4f19a84372894317588c
    
    if_1e3eaeed0e6a43ff9489aec04a86dd03: ; IF start
    mov rcx, 5
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_1f71ab2a23fa4cbd9df3227698a14f24
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_1f71ab2a23fa4cbd9df3227698a14f24: ; END of if_1e3eaeed0e6a43ff9489aec04a86dd03
    
    if_4b3c83fe25204d98b508f49b1a57b059: ; IF start
    mov rcx, 6
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_5247664515c243b5b6753659a52209a9
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_5247664515c243b5b6753659a52209a9: ; END of if_4b3c83fe25204d98b508f49b1a57b059
    
    if_0cecb2d434894641a54ad8d30ed67ab2: ; IF start
    mov rcx, 7
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_db042758b4924bd187ed8fc80a7cce67
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_db042758b4924bd187ed8fc80a7cce67: ; END of if_0cecb2d434894641a54ad8d30ed67ab2
    
    if_933fc397ad284fb2a6bc6770b6ef070c: ; IF start
    mov rcx, 8
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_15ecd8bb26224fa6bcac33a695af75d5
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_15ecd8bb26224fa6bcac33a695af75d5: ; END of if_933fc397ad284fb2a6bc6770b6ef070c
    
    if_7fa6289dd7b54cf88e1aab98367bc3a1: ; IF start
    mov rcx, 9
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_f1f353538450454b92ce09fb2be4e0a9
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_f1f353538450454b92ce09fb2be4e0a9: ; END of if_7fa6289dd7b54cf88e1aab98367bc3a1
    
    if_a4cc4643444f4090a4863c8e32db0382: ; IF start
    mov rcx, 10
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_fbee046f73d042adafe050e93c4c1d0f
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_fbee046f73d042adafe050e93c4c1d0f: ; END of if_a4cc4643444f4090a4863c8e32db0382
    
    if_68f4abc048174da1928da3fb4bd47339: ; IF start
    mov rcx, 11
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_b034465e00284938abbc3b84693ab42c
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_b034465e00284938abbc3b84693ab42c: ; END of if_68f4abc048174da1928da3fb4bd47339
    
    if_efe90c64484046a7b0ee30a425f0b1b2: ; IF start
    mov rcx, 12
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_c053ea4d829c49f49b7c5b2f8d49b65c
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_c053ea4d829c49f49b7c5b2f8d49b65c: ; END of if_efe90c64484046a7b0ee30a425f0b1b2
    
    if_3f276a3438c24fb3be5e5f93d2ee1f2a: ; IF start
    mov rcx, 13
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_77a1c759bc0e4d2290b5157cd41a808f
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_77a1c759bc0e4d2290b5157cd41a808f: ; END of if_3f276a3438c24fb3be5e5f93d2ee1f2a
    
    if_5a64d3455f72478295b31eef1c2394ea: ; IF start
    mov rcx, 14
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_f2a07a19360e46b0a4e3172c362e535a
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_f2a07a19360e46b0a4e3172c362e535a: ; END of if_5a64d3455f72478295b31eef1c2394ea
    
    if_5ed66af7b8074ee29f104d75a2143c03: ; IF start
    mov rcx, 15
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_2d81dde3b081426eb448c9279a702771
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_2d81dde3b081426eb448c9279a702771: ; END of if_5ed66af7b8074ee29f104d75a2143c03
    
    if_5c65ac8669c842f69d78c3dbf448347a: ; IF start
    mov rcx, 16
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_d7f2d728afff43b1935d8234f39dcac7
    
    mov rax, 0xFFFFFFFFFFFFFFEF
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, 0x0000000100000001
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_start
      add rsp, 96
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_d7f2d728afff43b1935d8234f39dcac7: ; END of if_5c65ac8669c842f69d78c3dbf448347a
    
    if_49b03662210b43959f1c9e2ffbc9c412: ; IF start
    mov rcx, 17
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_7dab9bbfe20a433091e58357e839a290
    
    mov rax, 0xFFFFFFFFFFFFFFEF
      push rax
    mov rax, 0x0000000100000001
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F5363616C6172_3490b408e9df40b2a7b7fbf990586aac_start
      add rsp, 32
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_7dab9bbfe20a433091e58357e839a290: ; END of if_49b03662210b43959f1c9e2ffbc9c412
    
    if_d829073778744ec593c701c99d1e9eae: ; IF start
    mov rcx, 18
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_9a4c12c5bb1445cca51d5c8e5a3a026d
    
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F456D707479_37b25a1f4aff443ab19956b302b69882_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_9a4c12c5bb1445cca51d5c8e5a3a026d: ; END of if_d829073778744ec593c701c99d1e9eae
    
    if_6c19e1effeb0427c9d6d1e0de75af33c: ; IF start
    mov rcx, 19
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_829beb0c31944fc3a5ef203f0607e1e5
    
    mov rax, 0xFFFFFFFFFFFFFFEF
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, 0x0000000100000001
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, 0x000000000000000A
      push rax
    mov rax, 0xFFFFFFFFFFFFFFFD
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_start
      add rsp, 112
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_829beb0c31944fc3a5ef203f0607e1e5: ; END of if_6c19e1effeb0427c9d6d1e0de75af33c
    
    if_7ba39485583249cbb3a8133e85e67e49: ; IF start
    mov rcx, 20
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_dcf833ed1ae74563aa2eff403f0a34f5
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 72]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 80]
      push rax
    mov rax, qword [rbp - 88]
      push rax
    mov rax, qword [rbp - 96]
      push rax
    mov rax, qword [rbp - 104]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 120], rax
    end_if_dcf833ed1ae74563aa2eff403f0a34f5: ; END of if_7ba39485583249cbb3a8133e85e67e49
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 120]
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
    mov rax, qword [rbp - 40]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      mov qword [rbp - 64], rax
    while_54487811a91142c583895f93eb7425db: ; WHILE start
    mov rcx, 16
      mov rax, qword [rbp - 64]
      cmp rax, rcx
      jae end_while_76417b02e9604474ae69c680bf10956b
    
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000050
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 64]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp - 64]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 64]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 64], rax
      jmp while_54487811a91142c583895f93eb7425db ; Reevaluate WHILE condition
    end_while_76417b02e9604474ae69c680bf10956b: ; END of while_54487811a91142c583895f93eb7425db
    
    if_c8294226e8124a89a83b1cb0095aa451: ; IF start
    mov rcx, 20
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_7845f9d18dc4481f858a7019f49573d8
    
    mov rax, qword [rbp - 40]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    end_if_7845f9d18dc4481f858a7019f49573d8: ; END of if_c8294226e8124a89a83b1cb0095aa451
    
    if_3596abe7d0844eb5b4cb148c05dc5905: ; IF start
    mov rcx, 2
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_2d22b2b8ca6e418c9bee8afb2efc9f98
    
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    end_if_2d22b2b8ca6e418c9bee8afb2efc9f98: ; END of if_3596abe7d0844eb5b4cb148c05dc5905
    
    if_072672f99d7d47e890ae147cf866f735: ; IF start
    mov rcx, 3
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jne end_if_45f09a55f8294d439c21902088eba591
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    end_if_45f09a55f8294d439c21902088eba591: ; END of if_072672f99d7d47e890ae147cf866f735
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000000
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x0000000000000010
      push rax
    mov rax, 0x00000000000003E8
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000038
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    call func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start
      add rsp, 88
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000030
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 112]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000040
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 112]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    call func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 112], rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000048
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 112]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, 0x0000000000000028
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 120]
      push rax
    pop rax
      
      jmp func_506169724D61696E_513c332135b54ce3b274ac1f6a54b226_end
    func_506169724D61696E_513c332135b54ce3b274ac1f6a54b226_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61496E6974_2f115397ab5844688ce5f5f4491d35fc_start:
    push rbp
      mov rbp, rsp
    if_b560604ca168458e91b4392dd4004b78: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_8504bcfa8e524eaba04a7927ec1d6729
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61496E6974_2f115397ab5844688ce5f5f4491d35fc_end
    end_if_8504bcfa8e524eaba04a7927ec1d6729: ; END of if_b560604ca168458e91b4392dd4004b78
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E61496E6974_2f115397ab5844688ce5f5f4491d35fc_end
    func_4172656E61496E6974_2f115397ab5844688ce5f5f4491d35fc_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start:
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
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000008
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
    while_ab9ad04952a045028c91f59f3a9b3678: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jae end_while_352a4b5879b948e4a3a6079ee8006ee1
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 16]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 16]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    if_65d0ff4631834febb8df66148e065bd3: ; IF start
    pop rax
      test rax, rax
      je end_if_fa93ad2ace3b4710b41740977ebae244
    
      jmp end_else_a07db8b9fcd14062ae64c94349eab9e3     ; Jump over ELSE part
    end_if_fa93ad2ace3b4710b41740977ebae244:    ; if_65d0ff4631834febb8df66148e065bd3 END
    else_d3d04fd952e14920848d74191ad6e3d9:  ; Start ELSE block
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_067a44fe5e324a058c358c8f98893f38: ; IF start
    pop rax
      test rax, rax
      je end_if_a6a4d2f5d29747f8b8b449d4b2e13843
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_end
    end_if_a6a4d2f5d29747f8b8b449d4b2e13843: ; END of if_067a44fe5e324a058c358c8f98893f38
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_end
    end_else_a07db8b9fcd14062ae64c94349eab9e3: ; END of else_d3d04fd952e14920848d74191ad6e3d9
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 32]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
      jmp while_ab9ad04952a045028c91f59f3a9b3678 ; Reevaluate WHILE condition
    end_while_352a4b5879b948e4a3a6079ee8006ee1: ; END of while_ab9ad04952a045028c91f59f3a9b3678
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_end
    func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_start:
    push rbp
      mov rbp, rsp
    sub rsp, 64
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
    mov rax, 0x0000000000000000
      mov qword [rbp - 56], rax
    if_a9055516c73d4714b0d4e1806fdb59e9: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_86d37d79f4bd44a1ad6cd88993a71a6f
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_end
    end_if_86d37d79f4bd44a1ad6cd88993a71a6f: ; END of if_a9055516c73d4714b0d4e1806fdb59e9
    
    if_85146eea288d4189bde262234c6df840: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_e0277b9d3b734e8abe7fce60ed20e377
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_end
    end_if_e0277b9d3b734e8abe7fce60ed20e377: ; END of if_85146eea288d4189bde262234c6df840
    
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000007
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      cqo
      idiv rcx
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      imul rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 24]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    while_e8056ff18f6144efaa0e7752815b3e57: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_d05fed6807c84a30800b0c511b192fc4
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 24]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp - 32]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_ad1e877952e0470bbc764fc18362daba: ; IF start
    pop rax
      test rax, rax
      je end_if_925788f7ca65435b948878aed4e77efe
    
      jmp end_else_5ba6ccfc7e9b47b88c853c6eae4abefc     ; Jump over ELSE part
    end_if_925788f7ca65435b948878aed4e77efe:    ; if_ad1e877952e0470bbc764fc18362daba END
    else_4e2951ae5d25495eb8a43d5c665d55f7:  ; Start ELSE block
    if_0a8ffe341639469c8916eace0560fcb4: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jb end_if_7b711fc7e7c344baacd1a78854ec14af
    
    jmp end_while_d05fed6807c84a30800b0c511b192fc4 ; BREAK
    end_if_7b711fc7e7c344baacd1a78854ec14af: ; END of if_0a8ffe341639469c8916eace0560fcb4
    
    end_else_5ba6ccfc7e9b47b88c853c6eae4abefc: ; END of else_4e2951ae5d25495eb8a43d5c665d55f7
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp while_e8056ff18f6144efaa0e7752815b3e57 ; Reevaluate WHILE condition
    end_while_d05fed6807c84a30800b0c511b192fc4: ; END of while_e8056ff18f6144efaa0e7752815b3e57
    
    if_12a2e1d7aa484d0fa0311bc551645442: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_743b59405e5a4f58a2d95c8a3b92666f
    
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, qword [rbp - 16]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_157b4751fdee4e729e99eefe2a28088b: ; IF start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jbe end_if_87ed8e72e69145fe9392b3c74dfb5fad
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_end
    end_if_87ed8e72e69145fe9392b3c74dfb5fad: ; END of if_157b4751fdee4e729e99eefe2a28088b
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 16]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 48]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 16]
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
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    end_if_743b59405e5a4f58a2d95c8a3b92666f: ; END of if_12a2e1d7aa484d0fa0311bc551645442
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 16]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    while_5cec2f5fe8694df999a6d4a3a11c2f08: ; WHILE start
    mov rax, qword [rbp - 40]
      mov rcx, rax
      mov rax, qword [rbp - 56]
      cmp rax, rcx
      jae end_while_83d8a1e77c494a988fad7720e002655c
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 56]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 56]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 56], rax
      jmp while_5cec2f5fe8694df999a6d4a3a11c2f08 ; Reevaluate WHILE condition
    end_while_83d8a1e77c494a988fad7720e002655c: ; END of while_5cec2f5fe8694df999a6d4a3a11c2f08
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      jmp func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_end
    func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_e0e66132cfb24e50b85f99ef624b2061: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_ebd63a39013f4dd1a4bd6622da7dd314
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_end
    end_if_ebd63a39013f4dd1a4bd6622da7dd314: ; END of if_e0e66132cfb24e50b85f99ef624b2061
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_75e6a7b1e4e843d9a84da3aa820b74f9: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jb end_if_87df4fa253514f09bdca92287ae89aaf
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_end
    end_if_87df4fa253514f09bdca92287ae89aaf: ; END of if_75e6a7b1e4e843d9a84da3aa820b74f9
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_end
    func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000000
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_7810b72b9393426582e900071fc1b712: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_72b0fbbc4e5e41628c46e37e35d00aca
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_end
    end_if_72b0fbbc4e5e41628c46e37e35d00aca: ; END of if_7810b72b9393426582e900071fc1b712
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_182748908a12430da17478737b47f510: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_64e1525f07df4b08a5807f958e7d5fba
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_end
    end_if_64e1525f07df4b08a5807f958e7d5fba: ; END of if_182748908a12430da17478737b47f510
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_end
    func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_start:
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
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_0d5a4c7509c54888894d8dd4626f5c15: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_5abc9f46f3f447bbbbb54257a1e859cf
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_end
    end_if_5abc9f46f3f447bbbbb54257a1e859cf: ; END of if_0d5a4c7509c54888894d8dd4626f5c15
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_df8a872add1f4ef9ac6e05d043347429: ; IF start
    pop rax
      test rax, rax
      je end_if_fd8aa3d4b9ec4e32ae2d845887deda7b
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_end
    end_if_fd8aa3d4b9ec4e32ae2d845887deda7b: ; END of if_df8a872add1f4ef9ac6e05d043347429
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    while_4ea9d74a9175437db0f6d1d262834a67: ; WHILE start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_e231dfcba2e041fd953fb203d99776b5
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 24]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000010
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_3204d7e068c54b71bbf525362120c417: ; IF start
    pop rax
      test rax, rax
      je end_if_c6e45fa6c7484e25a189f1e1aa8f3eb5
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_if_c6e45fa6c7484e25a189f1e1aa8f3eb5: ; END of if_3204d7e068c54b71bbf525362120c417
    
      jmp while_4ea9d74a9175437db0f6d1d262834a67 ; Reevaluate WHILE condition
    end_while_e231dfcba2e041fd953fb203d99776b5: ; END of while_4ea9d74a9175437db0f6d1d262834a67
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 32]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_end
    func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_start:
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
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_7f829bbffcdd478ca4b2fd4ca6483cb5: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_5138788ae7b2456187356244b7308b7a
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end
    end_if_5138788ae7b2456187356244b7308b7a: ; END of if_7f829bbffcdd478ca4b2fd4ca6483cb5
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_ee0ab641f5d946ec8dc10e715bdfc4d4: ; IF start
    pop rax
      test rax, rax
      je end_if_189ef14d2a3045fdae8a8930fd32fe64
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end
    end_if_189ef14d2a3045fdae8a8930fd32fe64: ; END of if_ee0ab641f5d946ec8dc10e715bdfc4d4
    
    if_4b087eedc7cf44539e2feb6d5362af8f: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_c08d6b816df34810bafff48a215b6d55
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end
    end_if_c08d6b816df34810bafff48a215b6d55: ; END of if_4b087eedc7cf44539e2feb6d5362af8f
    
    if_7b354a44218d455e85541e452552af5a: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jne end_if_45be9bc328ee4bac927253fa636aa5f3
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end
    end_if_45be9bc328ee4bac927253fa636aa5f3: ; END of if_7b354a44218d455e85541e452552af5a
    
    mov rax, qword [rbp - 8]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_6971ae9da0494393935ec449686cd683: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      ja end_if_8299596f7c1b4622b2b63632559ff2b3
    
    if_4b8165509e4a4497b4dd086b9a653529: ; IF start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_c1eb6e46d86a4327bffee1cee18a4c17
    
    mov rax, qword [rbp - 24]
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    while_f517dd8de89241fead59ebb6d28fa0e4: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_b44e993900054ee9a91b44a012540d37
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 40]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
      jmp while_f517dd8de89241fead59ebb6d28fa0e4 ; Reevaluate WHILE condition
    end_while_b44e993900054ee9a91b44a012540d37: ; END of while_f517dd8de89241fead59ebb6d28fa0e4
    
    end_if_c1eb6e46d86a4327bffee1cee18a4c17: ; END of if_4b8165509e4a4497b4dd086b9a653529
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 16]
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 24]
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end
    end_if_8299596f7c1b4622b2b63632559ff2b3: ; END of if_6971ae9da0494393935ec449686cd683
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_9e05c611017e4182b3b17cb1ae4d8aa4: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_e8e37f2035c049d09579cbb2f1807540
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end
    end_if_e8e37f2035c049d09579cbb2f1807540: ; END of if_9e05c611017e4182b3b17cb1ae4d8aa4
    
    while_3779a1433ab54dc2a2665fa17dc1a60d: ; WHILE start
    mov rax, qword [rbp - 24]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_beff1e6a6f29477eaa56cbd5b1dd320f
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 40]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
      jmp while_3779a1433ab54dc2a2665fa17dc1a60d ; Reevaluate WHILE condition
    end_while_beff1e6a6f29477eaa56cbd5b1dd320f: ; END of while_3779a1433ab54dc2a2665fa17dc1a60d
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    call func_4172656E6146726565_29854e60994d4866a57985ed54abbd39_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp - 32]
      push rax
    pop rax
      
      jmp func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end
    func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_start:
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
    if_42187ed9bdba43fb823c7f968967f209: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jbe end_if_77412769997f488f94d07a2f22f5f1f9
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_77412769997f488f94d07a2f22f5f1f9: ; END of if_42187ed9bdba43fb823c7f968967f209
    
    if_401f5fc6acf249318ee2dcca8040b016: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp + 16]
      cmp rax, rcx
      jbe end_if_e3e38076b7a444d1b9921e7ce86d74a7
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_e3e38076b7a444d1b9921e7ce86d74a7: ; END of if_401f5fc6acf249318ee2dcca8040b016
    
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_41390ac546674d89a63496c7196db62e: ; IF start
    mov rcx, 65536
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jbe end_if_c896d01b1e464d8792ae10106adbab3d
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_c896d01b1e464d8792ae10106adbab3d: ; END of if_41390ac546674d89a63496c7196db62e
    
    if_b89229dd21e347c5aa0429859d51469f: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_0c4910b795e54ec293b48e3622b93707
    
    if_e459d115d57e4c28a53eb3fecc0ff878: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      je end_if_e66f40c1b86e4c689b7757bde25377fe
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_e66f40c1b86e4c689b7757bde25377fe: ; END of if_e459d115d57e4c28a53eb3fecc0ff878
    
    mov rax, 0x0000000000000008
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp end_else_4336439ed298444f95d493746ee18052     ; Jump over ELSE part
    end_if_0c4910b795e54ec293b48e3622b93707:    ; if_b89229dd21e347c5aa0429859d51469f END
    else_69ac8ec6bd67423aabf355bf7879475c:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_1c2de7abcf4248a6a1e75f030eaaf02e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 16]
      cmp rax, rcx
      jne end_if_2761b881b77c4a56bde09fc06eb9dcb0
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_2761b881b77c4a56bde09fc06eb9dcb0: ; END of if_1c2de7abcf4248a6a1e75f030eaaf02e
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000018
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    if_e777873915e844d2a069500772041e86: ; IF start
    pop rax
      test rax, rax
      je end_if_1dd1c15fec234c01b890986d072eb137
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_1dd1c15fec234c01b890986d072eb137: ; END of if_e777873915e844d2a069500772041e86
    
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    mov rax, qword [rbp - 16]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    if_f58fe6d01746455f8652e5542d48b837: ; IF start
    mov rax, qword [rbp - 48]
      mov rcx, rax
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jb end_if_b9c0e72a46594105b62ff290e433cae2
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_b9c0e72a46594105b62ff290e433cae2: ; END of if_f58fe6d01746455f8652e5542d48b837
    
    end_else_4336439ed298444f95d493746ee18052: ; END of else_69ac8ec6bd67423aabf355bf7879475c
    
    while_abb4ba277fb34fd3b2a275ff57d84679: ; WHILE start
    mov rax, qword [rbp - 8]
      mov rcx, rax
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jae end_while_15d847183b6f4af79b96532a154b9b83
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000002
      push rax
    pop rcx
      pop rax
      imul rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
      jmp while_abb4ba277fb34fd3b2a275ff57d84679 ; Reevaluate WHILE condition
    end_while_15d847183b6f4af79b96532a154b9b83: ; END of while_abb4ba277fb34fd3b2a275ff57d84679
    
    if_d884d41f2b464437b972dbb7c99cf6aa: ; IF start
    mov rcx, 0
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jne end_if_644cdb30acdc4280b0cda9a44c3023a6
    
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61416C6C6F63_6b5443843a5e42d0ac515d49b94d0725_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
      jmp end_else_dd1357a2fff14e62b1214ea887ca998a     ; Jump over ELSE part
    end_if_644cdb30acdc4280b0cda9a44c3023a6:    ; if_d884d41f2b464437b972dbb7c99cf6aa END
    else_9bdd19f5cb22464b9dd49fd8e4c52263:  ; Start ELSE block
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp - 24]
      push rax
    call func_4172656E61526573697A65_ceb748463a8544b592f32148a1322017_start
      add rsp, 24
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    end_else_dd1357a2fff14e62b1214ea887ca998a: ; END of else_9bdd19f5cb22464b9dd49fd8e4c52263
    
    if_cef9eeda375640f2b4375a07629c4b23: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 32]
      cmp rax, rcx
      jne end_if_26d5bb4e15824fb982541b80787ecc65
    
    mov rax, 0x0000000000000000
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    end_if_26d5bb4e15824fb982541b80787ecc65: ; END of if_cef9eeda375640f2b4375a07629c4b23
    
    while_632ba02f6c2b428e9e34a9d0cc17fb5f: ; WHILE start
    mov rax, qword [rbp + 16]
      mov rcx, rax
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jae end_while_781d4eb1c93f4cf0a8bab2332976409d
    
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      movzx eax, byte [rax]
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    if_35e150b7de744391b5fc91cabedbf03a: ; IF start
    mov rcx, 97
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      jb end_if_fa4c9e704fd74f2085569b50648c5ea8
    
    if_334b671c4a2b45cfa9a0ed45b29a3873: ; IF start
    mov rcx, 122
      mov rax, qword [rbp - 48]
      cmp rax, rcx
      ja end_if_08cb37a1135e4ed2a3fe88156d51fa3b
    
    mov rax, qword [rbp - 48]
      push rax
    mov rax, 0x0000000000000020
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    end_if_08cb37a1135e4ed2a3fe88156d51fa3b: ; END of if_334b671c4a2b45cfa9a0ed45b29a3873
    
    end_if_fa4c9e704fd74f2085569b50648c5ea8: ; END of if_35e150b7de744391b5fc91cabedbf03a
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp - 48]
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 40]
      push rax
    mov rax, 0x0000000000000001
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
      jmp while_632ba02f6c2b428e9e34a9d0cc17fb5f ; Reevaluate WHILE condition
    end_while_781d4eb1c93f4cf0a8bab2332976409d: ; END of while_632ba02f6c2b428e9e34a9d0cc17fb5f
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 16]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov byte [rax], cl
    mov rax, qword [rbp - 32]
      push rax
    pop rax
      
      jmp func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end
    func_4172656E61417070656E645570706572_9c1958a6fec9411e8a1111f27a00b087_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_94d063b5e25c4773bbd471c48c19b622: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_0c265b472b3f4decae7b5dd9ca28efb8
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_0c265b472b3f4decae7b5dd9ca28efb8: ; END of if_94d063b5e25c4773bbd471c48c19b622
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_b879591487814402b6407ed93f631a2f: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_62547a0b75b1447ab692c06305ad290f
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_62547a0b75b1447ab692c06305ad290f: ; END of if_b879591487814402b6407ed93f631a2f
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_c5b8d5167cc949ae8668e6fb1e241552: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_2495e99faf0a4b499ae4a00692d327dd
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_2495e99faf0a4b499ae4a00692d327dd: ; END of if_c5b8d5167cc949ae8668e6fb1e241552
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_d221f337476b4a3fa87a983e15ca5acd: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_d3efb0c5fa44412e814cdc7d00d3da74
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_d3efb0c5fa44412e814cdc7d00d3da74: ; END of if_d221f337476b4a3fa87a983e15ca5acd
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_ec822a74ec994b309776c980fa1d6191: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_ea78c8c1762d448f8d66b5ab5473eba1
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_ea78c8c1762d448f8d66b5ab5473eba1: ; END of if_ec822a74ec994b309776c980fa1d6191
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_85bad22eb9254eb1ac54d7e19417efb8: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_56d67965963e486d85e463c2edee2802
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_56d67965963e486d85e463c2edee2802: ; END of if_85bad22eb9254eb1ac54d7e19417efb8
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_4c08085b4ecf40df82d5d72c79e18b42: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_a4ac1efa0cd14987a2006cedc12f78de
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_a4ac1efa0cd14987a2006cedc12f78de: ; END of if_4c08085b4ecf40df82d5d72c79e18b42
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_21127a269c80467b9a72ad16dffec545: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_18a3a7e9b4fe493098b637120d1131f0
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    end_if_18a3a7e9b4fe493098b637120d1131f0: ; END of if_21127a269c80467b9a72ad16dffec545
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_DualWrite
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end
    func_4172656E615F4475616C5772697465_4263a3eed76c45beb81a46c8eeda5ffe_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_b77d4db0ee264cba982f3922067fac3d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_890b4b3c4b544677b3f9334bef2ea490
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_890b4b3c4b544677b3f9334bef2ea490: ; END of if_b77d4db0ee264cba982f3922067fac3d
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_e3a89f159b74439899f6a3198961e1f1: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_3b3470e277384109ade1f1a611b60a5c
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_3b3470e277384109ade1f1a611b60a5c: ; END of if_e3a89f159b74439899f6a3198961e1f1
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_46fa9b3ec3f7402d89afaa2336ef35e5: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_489ebfa4484f4302a4f8600834c531f9
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_489ebfa4484f4302a4f8600834c531f9: ; END of if_46fa9b3ec3f7402d89afaa2336ef35e5
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_2fccbc2d57934acaa2c2cc6b7cfe05a4: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_e733ac1085834c808399fbd2ab051f81
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_e733ac1085834c808399fbd2ab051f81: ; END of if_2fccbc2d57934acaa2c2cc6b7cfe05a4
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_43cb5a2f6683478fb23b27dd71091b2d: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_b6e560e0a393408ab11592e040a67e8b
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_b6e560e0a393408ab11592e040a67e8b: ; END of if_43cb5a2f6683478fb23b27dd71091b2d
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_57afcba4bad04d94ba1e48e382c5a484: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_4f18c080877c48f884787bd709435bc8
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_4f18c080877c48f884787bd709435bc8: ; END of if_57afcba4bad04d94ba1e48e382c5a484
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_6cb8312a06104e568b7c4d188130344e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_7cb12cb7bb4c42758debf8c91ca5db92
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_7cb12cb7bb4c42758debf8c91ca5db92: ; END of if_6cb8312a06104e568b7c4d188130344e
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_a62d95ab08264f848eaba80e0d13d71f: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_19efa954eb4c429f845e0a921ce6ecc6
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    end_if_19efa954eb4c429f845e0a921ce6ecc6: ; END of if_a62d95ab08264f848eaba80e0d13d71f
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Reverse
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end
    func_4172656E615F52657665727365_aa9a266bbe64474bba2e125a06c4bb3e_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_10fd59bfe3da46348a4ae5535ce5eeed: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_ac4d4719f0134e81a30bdee0f1633770
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_ac4d4719f0134e81a30bdee0f1633770: ; END of if_10fd59bfe3da46348a4ae5535ce5eeed
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_69cff84ca8eb42b58685b68c9ee88f52: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_adb2f696649746e599aabe582fd8e1f0
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_adb2f696649746e599aabe582fd8e1f0: ; END of if_69cff84ca8eb42b58685b68c9ee88f52
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_6b6d3b75173b4446940db3558d09e46d: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_997e9b103fa7427697dbb90de56f8cdd
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_997e9b103fa7427697dbb90de56f8cdd: ; END of if_6b6d3b75173b4446940db3558d09e46d
    
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_b47d38da09a7496192b304f530317a7d: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_995159b319524c8c9a709d7380a9ad77
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_995159b319524c8c9a709d7380a9ad77: ; END of if_b47d38da09a7496192b304f530317a7d
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_d449ca9087ea4d08a9b13493602ea3be: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_6cda27c061ba4095b02ba3cd7bc336a8
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_6cda27c061ba4095b02ba3cd7bc336a8: ; END of if_d449ca9087ea4d08a9b13493602ea3be
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_9500b5b07c7146dfb5ee506351a5be41: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 32]
      cmp rax, rcx
      jbe end_if_8e8377fdf36e4c948b23ba5bc15c4254
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_8e8377fdf36e4c948b23ba5bc15c4254: ; END of if_9500b5b07c7146dfb5ee506351a5be41
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_e21c07bf486d47c5b820f25e4768fa11: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_46b0ef4f715842258921ff98282a18e6
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_46b0ef4f715842258921ff98282a18e6: ; END of if_e21c07bf486d47c5b820f25e4768fa11
    
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_b74f83ff3f604cf09b99b042a327e605: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_c3944e5061094642bb7759d032670403
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    end_if_c3944e5061094642bb7759d032670403: ; END of if_b74f83ff3f604cf09b99b042a327e605
    
    mov rax, qword [rbp + 104]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    mov rax, qword [rbp + 40]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Mixed
      add rsp, 64
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end
    func_4172656E615F4D69786564_f90efd4101af4fcaa80956586cf6459f_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5363616C6172_3490b408e9df40b2a7b7fbf990586aac_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000001
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Scalar
      add rsp, 32
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      jmp func_4172656E615F5363616C6172_3490b408e9df40b2a7b7fbf990586aac_end
    func_4172656E615F5363616C6172_3490b408e9df40b2a7b7fbf990586aac_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F456D707479_37b25a1f4aff443ab19956b302b69882_start:
    push rbp
      mov rbp, rsp
    sub rsp, 16
    mov rax, 0x0000000000000000
      mov qword [rbp - 8], rax
    mov rax, 0x0000000000000001
      mov qword [rbp - 16], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Empty
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    mov rax, qword [rbp - 16]
      push rax
    pop rax
      
      jmp func_4172656E615F456D707479_37b25a1f4aff443ab19956b302b69882_end
    func_4172656E615F456D707479_37b25a1f4aff443ab19956b302b69882_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_4bdc7988d3cf4c14a576d5a9a4d0190b: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_cc8416a4cd3e45ec897e42b03e9352ab
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_cc8416a4cd3e45ec897e42b03e9352ab: ; END of if_4bdc7988d3cf4c14a576d5a9a4d0190b
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_2dc19099f3834248826ab034f6119fa5: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 96]
      cmp rax, rcx
      jbe end_if_76fd5a5b92214fe8b51908b0d565ed6c
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_76fd5a5b92214fe8b51908b0d565ed6c: ; END of if_2dc19099f3834248826ab034f6119fa5
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 96]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_45d363b29a374301a70257ef0a1146f5: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 88]
      cmp rax, rcx
      jbe end_if_d96148a0d9f244c3a6406818ba24e321
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_d96148a0d9f244c3a6406818ba24e321: ; END of if_45d363b29a374301a70257ef0a1146f5
    
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_7c61fe5e4a164a8d92f06c50cafc01d3: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_a6497553116d4956a8982ff63b808bc3
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_a6497553116d4956a8982ff63b808bc3: ; END of if_7c61fe5e4a164a8d92f06c50cafc01d3
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_5de3ca78e2ea46bc9d6b37148df3a72f: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 56]
      cmp rax, rcx
      jbe end_if_96a838f0bebc469184d37b5e4fc724bd
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_96a838f0bebc469184d37b5e4fc724bd: ; END of if_5de3ca78e2ea46bc9d6b37148df3a72f
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_9ebe2e90daa5484a9c731f99659f6398: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_18dba7bc633c48df978e9f4632872ad4
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_18dba7bc633c48df978e9f4632872ad4: ; END of if_9ebe2e90daa5484a9c731f99659f6398
    
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_f537f8fdadd64eb1bc83ecb124d75f56: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_a8a11ce8f08f40d198a420a9ca6eded3
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_a8a11ce8f08f40d198a420a9ca6eded3: ; END of if_f537f8fdadd64eb1bc83ecb124d75f56
    
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_d72e16ab70204671a9701902acdd99eb: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_62d530d454ce4aca88bfb249eb720098
    
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    end_if_62d530d454ce4aca88bfb249eb720098: ; END of if_d72e16ab70204671a9701902acdd99eb
    
    mov rax, qword [rbp + 120]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    mov rax, qword [rbp + 96]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
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
    call ubytec_import_Six
      add rsp, 80
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 64]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 112]
      push rax
    mov rax, qword [rbp + 104]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end
    func_4172656E615F536978_36063bbd4812464398e2029a51c9d744_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_cd8f34ce54884a0baaabdd86441f2e92: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_660cc764e0ca483fbccaec64da7a99a5
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_660cc764e0ca483fbccaec64da7a99a5: ; END of if_cd8f34ce54884a0baaabdd86441f2e92
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_311e5832aa2b498aa6f2afa52cbcee62: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_8845244541184ee29d0f2bae915ed147
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_8845244541184ee29d0f2bae915ed147: ; END of if_311e5832aa2b498aa6f2afa52cbcee62
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_2bac1b0f85294f89b90b177edccca9bc: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_0885dbeb847940c1a38e651f45b80651
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_0885dbeb847940c1a38e651f45b80651: ; END of if_2bac1b0f85294f89b90b177edccca9bc
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_d88db6890ff0404c9943c0b78b5a8d10: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_986f549b90984a37a9dcb59204777aea
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_986f549b90984a37a9dcb59204777aea: ; END of if_d88db6890ff0404c9943c0b78b5a8d10
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_02e193f39c4d4d62878ca5521a436e94: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_1ae1362d928e45acbe0a5dfe391d9a74
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_1ae1362d928e45acbe0a5dfe391d9a74: ; END of if_02e193f39c4d4d62878ca5521a436e94
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_c5a6462171ea4179a766de1b09f86d89: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_07bfb804b88445de8f67a22c67092eab
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_07bfb804b88445de8f67a22c67092eab: ; END of if_c5a6462171ea4179a766de1b09f86d89
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_a6762ddd920b4fb7be0c8d006c08144a: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_ec5cf034289b49a6b906747e547f322e
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_ec5cf034289b49a6b906747e547f322e: ; END of if_a6762ddd920b4fb7be0c8d006c08144a
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_5140e23c0871407195fba15c8383c289: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_197f5603d46d4b618bb9891edd85c762
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    end_if_197f5603d46d4b618bb9891edd85c762: ; END of if_5140e23c0871407195fba15c8383c289
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Copy
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end
    func_4172656E615F436F7079_7b270639fb2241cfbd1e728cf92a6703_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_0ca069c8c03a445a8ae086289c52fe45: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_054f40e064a04bf293d42bfbc017fb78
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_054f40e064a04bf293d42bfbc017fb78: ; END of if_0ca069c8c03a445a8ae086289c52fe45
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_78e02f775c2d42ddb720058490bf3653: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_39f38d1c842b4d988b991ec64530f22f
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_39f38d1c842b4d988b991ec64530f22f: ; END of if_78e02f775c2d42ddb720058490bf3653
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_6297b64e210641a29356a0659f34a743: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_f2b9873bd25841c49d2e9b717ec90909
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_f2b9873bd25841c49d2e9b717ec90909: ; END of if_6297b64e210641a29356a0659f34a743
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_72e05bcacdf946389bfdf707c9ba0196: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_78d0349a0edc43e7ad7f0ea6908c8c24
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_78d0349a0edc43e7ad7f0ea6908c8c24: ; END of if_72e05bcacdf946389bfdf707c9ba0196
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_bba73a94470c4ac79a4676e37a8c5ec9: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_0f625a2f82de4b6d96272743cc7d34ea
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_0f625a2f82de4b6d96272743cc7d34ea: ; END of if_bba73a94470c4ac79a4676e37a8c5ec9
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_621135e5f17843f18ca82aaa5460a73e: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_614f2795aff34f498646682401bccf0e
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_614f2795aff34f498646682401bccf0e: ; END of if_621135e5f17843f18ca82aaa5460a73e
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_b39be668fe8e40d2af821d99613927e4: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_1f3f7926cf264d96884f3bbf60437b37
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_1f3f7926cf264d96884f3bbf60437b37: ; END of if_b39be668fe8e40d2af821d99613927e4
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_1f35eb1d84e34f5ebedd25598661efcf: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_4495610b7a6e40968e410774b3cc3cc5
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    end_if_4495610b7a6e40968e410774b3cc3cc5: ; END of if_1f35eb1d84e34f5ebedd25598661efcf
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Partial
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end
    func_4172656E615F5061727469616C_19ae583320534a7bb61d0b92e4c85680_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_11f6612960994212984f78e69f3756c6: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_4a6167b4cf104398a123251021282c68
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_4a6167b4cf104398a123251021282c68: ; END of if_11f6612960994212984f78e69f3756c6
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_393cff451be44ca0b679d7dc6608c432: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_d3f0d8ec556440ae8d4a37146de19e67
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_d3f0d8ec556440ae8d4a37146de19e67: ; END of if_393cff451be44ca0b679d7dc6608c432
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_3f36325e1f484f29aeec8c02c4baafe6: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_6749f862f8cf40bcaf61a7430aaaeefa
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_6749f862f8cf40bcaf61a7430aaaeefa: ; END of if_3f36325e1f484f29aeec8c02c4baafe6
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_8597286908ec40ecb26e1c07b223bf07: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_54b3c75992bf4cc2b3db99619fd1942d
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_54b3c75992bf4cc2b3db99619fd1942d: ; END of if_8597286908ec40ecb26e1c07b223bf07
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_4f09861d73614061879b2fc16b460efd: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_a6c8c0d6bbd94f96ac246be3b89dba5f
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_a6c8c0d6bbd94f96ac246be3b89dba5f: ; END of if_4f09861d73614061879b2fc16b460efd
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_89b614859a5e48c6a0b06b6b0c5ac70b: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_2c567c1b41a34a458a050c933ced8f3c
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_2c567c1b41a34a458a050c933ced8f3c: ; END of if_89b614859a5e48c6a0b06b6b0c5ac70b
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_fb7f5f7781e3420682c5f3adbc458c5c: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_681ef78eb79845b1be411af3997a902f
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_681ef78eb79845b1be411af3997a902f: ; END of if_fb7f5f7781e3420682c5f3adbc458c5c
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_e8b748959f584564987148bfa3ca0bf1: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_5d11b80be2de44bd986fe9880c3ef0ef
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    end_if_5d11b80be2de44bd986fe9880c3ef0ef: ; END of if_e8b748959f584564987148bfa3ca0bf1
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Spin
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end
    func_4172656E615F5370696E_3da694d644634da0a12c525e5f40941d_end:
      mov rsp, rbp
      pop rbp
      ret
    func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_start:
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
    mov rax, 0x0000000000000001
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 16]
      push rax
    mov rax, 0x0000000000000000
      push rax
    pop rcx
      pop rax
      mov qword [rax], rcx
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 8], rax
    if_6aa86dc22ca44ddb82dc6313e7fe77d3: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 8]
      cmp rax, rcx
      jne end_if_4320d717bc5d4f0f8c111b8c2630696e
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_4320d717bc5d4f0f8c111b8c2630696e: ; END of if_6aa86dc22ca44ddb82dc6313e7fe77d3
    
    mov rax, qword [rbp - 8]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_2fad461ea3b149b592851fabe2290a4f: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 80]
      cmp rax, rcx
      jbe end_if_a4c100b30ee34cc7aa152f6491219da2
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_a4c100b30ee34cc7aa152f6491219da2: ; END of if_2fad461ea3b149b592851fabe2290a4f
    
    mov rax, qword [rbp - 16]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 16], rax
    if_3f4f3448124f4ce2b2f48fbe51686040: ; IF start
    mov rax, qword [rbp - 16]
      mov rcx, rax
      mov rax, qword [rbp + 72]
      cmp rax, rcx
      jbe end_if_3ed249b294ea4c8fbf51a34c5dd097ca
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_3ed249b294ea4c8fbf51a34c5dd097ca: ; END of if_3f4f3448124f4ce2b2f48fbe51686040
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6146696E64_7979789635af4010840a6dc9bf3d0380_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 24], rax
    if_bfed9039da7d444ca8d8a6e1f4312bcd: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 24]
      cmp rax, rcx
      jne end_if_30b2d002c50c42f7a31c90b2bed97bec
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_30b2d002c50c42f7a31c90b2bed97bec: ; END of if_bfed9039da7d444ca8d8a6e1f4312bcd
    
    mov rax, qword [rbp - 24]
      push rax
    mov rax, 0x0000000000000008
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    pop rax
      mov rax, qword [rax]
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_b0d5b9bf4caf4826be7272f2f43be159: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 48]
      cmp rax, rcx
      jbe end_if_2966167dab5b422bbd5962955d17bcf7
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_2966167dab5b422bbd5962955d17bcf7: ; END of if_b0d5b9bf4caf4826be7272f2f43be159
    
    mov rax, qword [rbp - 32]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      sub rax, rcx
      push rax
    pop rax
      
      mov qword [rbp - 32], rax
    if_3edab9c81c124cef9b0f1ae002595c73: ; IF start
    mov rax, qword [rbp - 32]
      mov rcx, rax
      mov rax, qword [rbp + 40]
      cmp rax, rcx
      jbe end_if_3b9d740f80204feb839cdd7839b27ce3
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_3b9d740f80204feb839cdd7839b27ce3: ; END of if_3edab9c81c124cef9b0f1ae002595c73
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_fd366d6afda2455caddb3580301af48e: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_2b2786948acc404b9577ae2df2aed902
    
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_2b2786948acc404b9577ae2df2aed902: ; END of if_fd366d6afda2455caddb3580301af48e
    
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E6150696E_8efe75ddc1ef4763b2d95abdeb6bfec5_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    if_7d3b9ff793a544b29fe1064bd511ae51: ; IF start
    mov rcx, 0
      mov rax, qword [rbp - 40]
      cmp rax, rcx
      jne end_if_1bf0a6c1c14b4120af06bd2323ff80c1
    
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, 0x0000000000000001
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    end_if_1bf0a6c1c14b4120af06bd2323ff80c1: ; END of if_7d3b9ff793a544b29fe1064bd511ae51
    
    mov rax, qword [rbp + 88]
      push rax
    mov rax, qword [rbp + 80]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 72]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    mov rax, qword [rbp + 48]
      push rax
    pop rcx
      pop rax
      add rax, rcx
      push rax
    mov rax, qword [rbp + 40]
      push rax
    mov rax, qword [rbp + 32]
      push rax
    mov rax, qword [rbp + 24]
      push rax
    mov rax, qword [rbp + 16]
      push rax
    call ubytec_import_Negative
      add rsp, 56
      push rax
    pop rax
      
      mov qword [rbp - 48], rax
    mov rax, qword [rbp + 64]
      push rax
    mov rax, qword [rbp + 56]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp + 96]
      push rax
    mov rax, qword [rbp + 88]
      push rax
    call func_4172656E61556E70696E_6c95930d90a343429c51e591092811f4_start
      add rsp, 16
      push rax
    pop rax
      
      mov qword [rbp - 40], rax
    mov rax, qword [rbp - 48]
      push rax
    pop rax
      
      jmp func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end
    func_4172656E615F4E65676174697665_e4d0ff4e3d15482d8177c0a354f6a829_end:
      mov rsp, rbp
      pop rbp
      ret
module_67656E657269635F70616972_3770e720aea34c78ac598cd131c9aaa8_end:

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
ubytec_import_DualWrite:
 push rbp
 mov rbp,rsp
 push 1
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],1
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,1
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Reverse:
 push rbp
 mov rbp,rsp
 push 2
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],2
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],1
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,2
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Mixed:
 push rbp
 mov rbp,rsp
 push 3
 add rsp,8
 sub rsp,96
 mov qword [rbp-96],4
 mov rax,[rbp+72]
 mov [rbp-88],rax
 mov qword [rbp-80],0
 mov qword [rbp-72],2
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],3
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov qword [rbp-32],0
 mov qword [rbp-24],1
 mov rax,[rbp+40]
 mov [rbp-16],rax
 mov rax,[rbp+32]
 mov [rbp-8],rax
 extern ubytec_bridge_many
 mov rdi,3
 lea rsi,[rbp-96]
 mov rdx,4
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Scalar:
 push rbp
 mov rbp,rsp
 push 4
 add rsp,8
 sub rsp,48
 mov qword [rbp-48],4
 mov rax,[rbp+40]
 mov [rbp-40],rax
 mov qword [rbp-32],0
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,4
 lea rsi,[rbp-48]
 mov rdx,2
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Empty:
 push rbp
 mov rbp,rsp
 push 5
 add rsp,8
 sub rsp,24
 extern ubytec_bridge_many
 mov rdi,5
 lea rsi,[rbp-24]
 mov rdx,0
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Six:
 push rbp
 mov rbp,rsp
 push 6
 add rsp,8
 sub rsp,144
 mov qword [rbp-144],4
 mov rax,[rbp+88]
 mov [rbp-136],rax
 mov qword [rbp-128],0
 mov qword [rbp-120],1
 mov rax,[rbp+80]
 mov [rbp-112],rax
 mov rax,[rbp+72]
 mov [rbp-104],rax
 mov qword [rbp-96],3
 mov rax,[rbp+64]
 mov [rbp-88],rax
 mov qword [rbp-80],0
 mov qword [rbp-72],2
 mov rax,[rbp+56]
 mov [rbp-64],rax
 mov rax,[rbp+48]
 mov [rbp-56],rax
 mov qword [rbp-48],3
 mov rax,[rbp+40]
 mov [rbp-40],rax
 mov qword [rbp-32],0
 mov qword [rbp-24],4
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,6
 lea rsi,[rbp-144]
 mov rdx,6
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Copy:
 push rbp
 mov rbp,rsp
 push 7
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,7
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Partial:
 push rbp
 mov rbp,rsp
 push 8
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,8
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Spin:
 push rbp
 mov rbp,rsp
 push 9
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,9
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
ubytec_import_Negative:
 push rbp
 mov rbp,rsp
 push 10
 add rsp,8
 sub rsp,72
 mov qword [rbp-72],1
 mov rax,[rbp+64]
 mov [rbp-64],rax
 mov rax,[rbp+56]
 mov [rbp-56],rax
 mov qword [rbp-48],2
 mov rax,[rbp+48]
 mov [rbp-40],rax
 mov rax,[rbp+40]
 mov [rbp-32],rax
 mov qword [rbp-24],3
 mov rax,[rbp+32]
 mov [rbp-16],rax
 mov qword [rbp-8],0
 extern ubytec_bridge_many
 mov rdi,10
 lea rsi,[rbp-72]
 mov rdx,3
 mov rcx,[rbp+24]
 mov r8,[rbp+16]
 and rsp,-16
 call ubytec_bridge_many
 mov rsp,rbp
 pop rbp
 ret
section .text
global ubytec_host_contract_PairMain
ubytec_host_contract_PairMain:
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
call func_506169724D61696E_513c332135b54ce3b274ac1f6a54b226_start
lea rsp, [rbp-40]
pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret
section .ubytec_contract alloc noexec nowrite progbits
db 85,66,67,49,10,73,124,49,124,68,117,97,108,87,114,105,116,101,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,68,117,97,108,87,114,105,116,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,50,124,82,101,118,101,114,115,101,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,82,101,118,101,114,115,101,124,76,111,97,110,82,101,97,100,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,51,124,77,105,120,101,100,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,77,105,120,101,100,124,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,76,111,97,110,87,114,105,116,101,58,73,110,116,54,52,10,73,124,52,124,83,99,97,108,97,114,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,83,99,97,108,97,114,124,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,53,124,69,109,112,116,121,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,69,109,112,116,121,124,58,73,110,116,54,52,10,73,124,54,124,83,105,120,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,83,105,120,124,73,110,116,54,52,44,76,111,97,110,87,114,105,116,101,44,85,73,110,116,54,52,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,44,73,110,116,54,52,58,73,110,116,54,52,10,73,124,55,124,67,111,112,121,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,67,111,112,121,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,56,124,80,97,114,116,105,97,108,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,80,97,114,116,105,97,108,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,57,124,83,112,105,110,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,83,112,105,110,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,73,124,49,48,124,78,101,103,97,116,105,118,101,124,112,97,105,114,95,114,101,99,101,105,118,101,114,124,78,101,103,97,116,105,118,101,124,76,111,97,110,87,114,105,116,101,44,76,111,97,110,82,101,97,100,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,124,80,97,105,114,77,97,105,110,124,117,98,121,116,101,99,95,104,111,115,116,95,99,111,110,116,114,97,99,116,95,80,97,105,114,77,97,105,110,124,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,44,85,73,110,116,54,52,58,73,110,116,54,52,10,69,78,68,10
section .note.GNU-stack noalloc noexec nowrite progbits
