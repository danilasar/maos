OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
OUTPUT_ARCH(aarch64)
ENTRY(efi_main)
SECTIONS
{
  . = 0x0;
  ImageBase = .;
  
  /* PE/COFF header будет добавлен objcopy */
  .text 0x1000 : ALIGN(0x1000) {
    _text = .;
    *(.text .text.*)
    *(.gnu.linkonce.t.*)
    . = ALIGN(16);
    _etext = .;
  }
  
  .reloc : ALIGN(0x1000) {
    *(.reloc)
  }
  
  .data : ALIGN(0x1000) {
    _data = .;
    *(.rodata*)
    *(.data .data.*)
    *(.sdata)
    *(.got.plt)
    *(.got)
    . = ALIGN(16);
    _edata = .;
  }
  
  .dynamic : ALIGN(0x1000) {
    *(.dynamic)
  }
  
  .rela : ALIGN(0x1000) {
    *(.rela.dyn)
    *(.rela.plt)
    *(.rela.got)
    *(.rela.data)
    *(.rela.text)
  }
  
  .bss : ALIGN(0x1000) {
    _bss = .;
    *(.sbss)
    *(.scommon)
    *(.dynbss)
    *(.bss)
    *(COMMON)
    . = ALIGN(16);
    _ebss = .;
  }
  
  /DISCARD/ : {
    *(.note.GNU-stack)
    *(.gnu_debuglink)
    *(.gnu.lto_*)
  }
}

