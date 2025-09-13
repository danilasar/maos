#qemu-system-aarch64 -machine virt -smp 2 -cpu max -m 4G -initrd initrd.gz -kernel linux -drive file=debian.img,if=virtio -nic user,model=e1000 -nographic
mkdir -p fs/boot/efi/EFI/BOOT
qemu-system-riscv64 \
    -machine virt,pflash0=code,pflash1=vars \
    -cpu rv64 \
    -m 4G \
    -blockdev node-name=code,driver=file,filename=qemu/riscv64/RISCV_VIRT_CODE.fd,read-only=on \
    -blockdev node-name=vars,driver=file,filename=qemu/riscv64/RISCV_VIRT_VARS.fd \
    -drive format=raw,file=fat:rw:./fs/boot/efi \
    -nographic \
    -serial mon:stdio
exit
qemu-system-riscv64 \
    -M virt \
    -bios qemu/riscv64/RISCV_VIRT_CODE.qcow2
qemu-system-riscv64 \
	-machine virt -cpu rv64 \
	-drive if=pflash,format=qcow2,readonly=on,file=qemu/riscv64/RISCV_VIRT_CODE.qcow2 \
	-drive if=pflash,format=qcow2,file=qemu/riscv64/RISCV_VIRT_VARS.qcow2 \
	-drive format=raw,file=fat:rw:./fs/boot/efi \
	-net none \
        -gdb tcp::1236 \
	#-serial stdio \
	#-nographic

