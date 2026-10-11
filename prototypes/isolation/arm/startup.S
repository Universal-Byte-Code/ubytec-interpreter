.syntax unified
.cpu cortex-m3
.thumb
.section .vectors,"a",%progbits
.word _monitor_stack_top
.word Reset_Handler
.word Fault_Handler
.word Fault_Handler
.word MemManage_Handler
.word Fault_Handler
.word Fault_Handler
.word 0,0,0,0
.word SVC_Handler
.word Fault_Handler
.word 0
.word Fault_Handler
.word SysTick_Handler

.text
.thumb_func
.global Reset_Handler
Reset_Handler:
 ldr r0, =_data_load
 ldr r1, =_data_start
 ldr r2, =_data_end
1: cmp r1, r2
 bhs 2f
 ldr r3, [r0], #4
 str r3, [r1], #4
 b 1b
2: ldr r1, =_bss_start
 ldr r2, =_bss_end
 movs r3, #0
3: cmp r1, r2
 bhs 4f
 str r3, [r1], #4
 b 3b
4: bl monitor_main
5: wfi
 b 5b

/* Supervisor context is captured on protected MSP. No module frame is used
   for recovery, including faults during exception stacking. */
.thumb_func
.global enter_module
enter_module:
 push {r4-r11,r12,lr}
 ldr r2, =supervisor_sp
 mov r3, sp
 str r3, [r2]
 ldr r2, =supervisor_resume
 ldr r3, =resume_module
 str r3, [r2]
 ldr r2, =module_start
 bx r2
resume_module:
 pop {r4-r11,r12,pc}

.section .module_text,"ax",%progbits
.thumb_func
module_start:
 msr psp, r1
 movs r2, #3
 msr control, r2
 isb
 movs r1, #0
 movs r2, #0
 movs r3, #0
 movs r4, #0
 movs r5, #0
 movs r6, #0
 movs r7, #0
 movs r8, #0
 movs r9, #0
 movs r10, #0
 movs r11, #0
 movs r12, #0
 bl module_payload
 udf #0
.text

.macro HANDLER name, kind
.thumb_func
.global \name
\name:
 mrs r0, psp
 mov r1, lr
 movs r2, #\kind
 push {r4,lr}
 bl handle_exception
 pop {r4,lr}
 cmp r0, #0
 beq 9f
 /* Disable timer before switching to the supervisor thread. */
 ldr r1, =0xe000e010
 movs r2, #0
 str r2, [r1]
 movs r1, #0
 msr control, r1
 isb
 ldr r1, =supervisor_sp
 ldr r1, [r1]
 sub r1, #32
 movs r2, #0
 str r2, [r1,#0]
 str r2, [r1,#4]
 str r2, [r1,#8]
 str r2, [r1,#12]
 str r2, [r1,#16]
 str r2, [r1,#20]
 ldr r2, =supervisor_resume
 ldr r2, [r2]
 str r2, [r1,#24]
 mov r2, #0x01000000
 str r2, [r1,#28]
 msr msp, r1
 ldr lr, =0xfffffff9
9: bx lr
.endm
HANDLER SVC_Handler, 1
HANDLER MemManage_Handler, 2
HANDLER Fault_Handler, 3
HANDLER SysTick_Handler, 4
