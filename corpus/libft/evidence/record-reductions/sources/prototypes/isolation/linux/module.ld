OUTPUT_FORMAT(elf64-x86-64)
PHDRS { code PT_LOAD FLAGS(5); ro PT_LOAD FLAGS(4); private PT_LOAD FLAGS(6); }
SECTIONS
{
    . = 0x400000000000;
    .text : { *(.text*) } :code
    . = ALIGN(4096);
    .ubytec_contract : { *(.ubytec_contract) } :ro
    .rodata : { *(.rodata*) } :ro
    . = DEFINED(PRIVATE_BASE) ? PRIVATE_BASE : 0x400000100000;
    .data : { *(.data*) *(.init_array*) } :private
    .bss : { *(.bss*) *(COMMON) } :private
    /DISCARD/ : { *(.note.GNU-stack) *(.comment) }
}
