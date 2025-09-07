ARCH=aarch64
.PHONY: all bootloader kernel install clean run
all: bootloader kernel

bootloader:
	@echo "Собираю загрузчик..."
	$(MAKE) -C bootloader ARCH=$(ARCH)

kernel:
	@echo "Собираю ядро..."
	$(MAKE) -C kernel ARCH=$(ARCH)

install:
	@cp bootloader/bootaa64.efi bin/boot/efi/EFI/BOOT/bootaa64.efi

clean:
	$(MAKE) -C bootloader ARCH=$(ARCH) clean
	$(MAKE) -C kernel ARCH=$(ARCH) clean

run:
	cd bin && ./run.sh
