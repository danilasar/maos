#qemu-system-aarch64 -machine virt -smp 2 -cpu max -m 4G -initrd initrd.gz -kernel linux -drive file=debian.img,if=virtio -nic user,model=e1000 -nographic
mkdir -p boot/efi/EFI/BOOT
qemu-system-aarch64 \
	-machine virt -cpu max \
	-drive if=pflash,format=raw,readonly=on,file=QEMU_EFI.kernel.fd \
	-drive if=pflash,format=raw,file=QEMU_VARS.fd \
	-drive format=raw,file=fat:rw:./boot/efi \
	-net none \
        -gdb tcp::1236 \
	-serial mon:stdio \
	-nographic

