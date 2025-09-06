OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
OUTPUT_ARCH(aarch64)
ENTRY(_start)
SECTIONS {
	. = 0;
	ImageBase = .;
	.text : { *(.text) *(.text.*) }
	.data : { *(.data) *(.data.*) }
	.rodata : { *(.rodata) *(.rodata.*) }
	.bss : { *(.bss) *(.bss.*) }
	.rela : { *(.rela.dyn) }
}
