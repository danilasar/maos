CROSS_COMPILE := aarch64-linux-gnu-
CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy

ARCH := aarch64
EFI_ARCH := aa64

EFI_INC := /usr/include/efi
EFI_LIB := /usr/lib

CFLAGS := \
	  -I$(EFI_INC) -I$(EFI_INC)/$(ARCH) -I$(EFI_INC)/protocol -fpic \
	  -ffreestanding -std=c11 \
	  -fno-stack-protector \
	  -fno-stack-check \
	  -fshort-wchar \
	  -Wall -Wextra
#LDFLAGS := -nostdlib \
#	   -znocombreloc \
#	   -shared \
#	   -Bsymbolic

LDFLAGS := -shared -Bsymbolic -Lgnu-efi-dir/aarch64/lib -Lgnu-efi-dir/aarch64/gnuefi -Tgnu-efi-dir/gnuefi/elf_aarch64_efi.lds gnu-efi-dir/aarch64/gnuefi/crt0-efi-aarch64.o -lgnuefi -lefi
# --oformat=pei-aarch64-little

SRCS := main.c

default: all

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

efi.lds:
	@echo 'OUTPUT_FORMAT("elf64-littleaarch64")' > efi.lds
	@echo 'OUTPUT_ARCH(aarch64)' >> efi.lds
	@echo 'ENTRY(_start)' >> efi.lds
	@echo 'SECTIONS' >> efi.lds
	@echo '{' >> efi.lds
	@echo '  . = 0;' >> efi.lds
	@echo '  .text : {' >> efi.lds
	@echo '    *(.text .text.*)'  >> efi.lds
	@echo '  }' >> efi.lds
	@echo '  .rodata : {' >> efi.lds
	@echo '    *(.rodata .rodata.*)'  >> efi.lds
	@echo '  }' >> efi.lds
	@echo '  .data : {' >> efi.lds
	@echo '    *(.data .data.*)'  >> efi.lds
	@echo '  }' >> efi.lds
	@echo '  .dynamic : { *(.dynamic) }' >> efi.lds
	@echo '  .rela.dyn : { *(.rela*) }' >> efi.lds
	@echo '  .bss : {' >> efi.lds
	@echo '    *(.bss .bss.*)'  >> efi.lds
	@echo '  }' >> efi.lds
	@echo '}' >> efi.lds

bootaa64.so: main.o efi.lds
	$(LD) $(LDFLAGS) $< -o $@

bootaa64.efi: bootaa64.so
	$(OBJCOPY) -j .text -j .sdata -j .data -j .dynamic \
		-j .dynsym -j .rel -j .rela -j .reloc \
		--target=efi-app-$(ARCH) \
		--subsystem=10 \
		$< $@

-include $(SRCS:.c=.d)

.PHONY: clean all default

all: bootaa64.efi

clean:
	rm -f *.o *.d *.so *.efi
