ifeq ($(ARCH),)
ARCH=riscv64
endif
GNU_EFI_DIR=gnu-efi
CC=riscv64-elf-gcc
LD=riscv64-elf-ld
OBJCOPY=riscv64-elf-objcopy

.PHONY: all clean

all:
	$(CC) -Ignu-efi/inc -fpic -ffreestanding -fno-stack-protector -fno-stack-check -fshort-wchar -mabi=lp64 -march=rv64imac -c main.c -o main.o
	$(LD) -Bsymbolic -L$(GNU_EFI_DIR)/$(ARCH)/lib -L$(GNU_EFI_DIR)/$(ARCH)/gnuefi -T$(GNU_EFI_DIR)/gnuefi/elf_$(ARCH)_efi.lds $(GNU_EFI_DIR)/$(ARCH)/gnuefi/crt0-efi-$(ARCH).o main.o -o main.so -lgnuefi -lefi
	$(OBJCOPY) -j .text -j .sdata -j .data -j .rodata -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --target efi-app-$(ARCH) --subsystem=10 main.so main.efi --section-alignment=0x40 --file-alignment=0x40 -O efi-app-$(ARCH) --strip-all --strip-debug --strip-unneeded --remove-section=.comment --remove-section=.note*



# Очистка
clean:
	rm -f *.o uefi/*.o *.a *.so *.efi
