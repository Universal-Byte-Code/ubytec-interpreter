ENTRY(Reset_Handler)
MEMORY {
  FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 64K
  MODULE (rx) : ORIGIN = 0x00010000, LENGTH = 64K
  RAM (rw) : ORIGIN = 0x20000000, LENGTH = 64K
}
SECTIONS {
 .vectors : { KEEP(*(.vectors)) } > FLASH
 .text : { *(.text*) *(.rodata*) } > FLASH
 .module_text : { *(.module_text*) } > MODULE
 .data : { _data_start = .; *(.data*) _data_end = .; } > RAM AT> FLASH
 _data_load = LOADADDR(.data);
 .bss (NOLOAD) : { _bss_start = .; *(.bss*) *(COMMON) _bss_end = .; } > RAM
 _monitor_stack_top = ORIGIN(RAM) + LENGTH(RAM);
 ASSERT(_bss_end < _monitor_stack_top - 8192, "monitor stack collision")
 ASSERT(SIZEOF(.module_text) <= LENGTH(MODULE), "module code exceeds RX region")
 /DISCARD/ : { *(.ARM.exidx*) *(.ARM.extab*) *(.comment*) }
}
