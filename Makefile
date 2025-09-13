#ARCH=aarch64
ARCH=riscv64
.PHONY: all bootloader kernel install clean run
all: bootloader kernel

bootloader:
	@echo "Собираю загрузчик..."
	$(MAKE) -C bootloader ARCH=$(ARCH)

kernel:
	@echo "Собираю ядро..."
	#$(MAKE) -C kernel ARCH=$(ARCH)

install:
	@echo "Копирую загрузчик"
	cp bootloader/bootriscv64.efi bin/fs/boot/efi/EFI/BOOT/BOOTRISCV64.EFI

clean:
	$(MAKE) -C bootloader ARCH=$(ARCH) clean
	#$(MAKE) -C kernel ARCH=$(ARCH) clean

run:
	cd bin && ./run.sh
