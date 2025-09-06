CC := clang
LD := lld
CFLAGS := \
	-ffreestanding -MMD -mno-red-zone -std=c11 \
	-target aarch64-unknown-windows -Wall -Werror -pedantic \
	-g3 -O0 -fno-omit-frame-pointer -gdwarf-4 -gcolumn-info # debug
LDFLAGS := -flavor link -subsystem:efi_application -entry:efi_main \
	   -debug:dwarf -pdb:main.pdb # debug

KERNEL_CFLAGS := \
	-ffreestanding -MMD -mno-red-zone -std=c11 \
	-target aarch64-unknown-gnu -Wall -Werror -pedantic
KERNEL_LDFLAGS := \
	-flavor ld -e main

TARGET = main
EFI_TARGET = main.efi

.PHONY: all clean check

all: $(EFI_TARGET)

$(TARGET).o: $(TARGET).c
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET).efi: $(TARGET).o
	$(LD) $(LDFLAGS) $^ -out:$@


clean:
	rm -f $(TARGET).o $(TARGET).so $(EFI_TARGET)

install:
	cp $(EFI_TARGET) vm/efi_root/EFI/BOOT/bootaa64.efi

check: $(EFI_TARGET)
	file $(EFI_TARGET)
	xxd -s 0x80 -l 4 $(EFI_TARGET)
	xxd -s 0xA0 -l 4 $(EFI_TARGET)

