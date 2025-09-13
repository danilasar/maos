ifeq ($(ARCH),)
ARCH=riscv64
endif
# Компилятор и инструменты
CC = riscv64-elf-gcc
AR = riscv64-elf-ar
OBJCOPY = riscv64-elf-objcopy
#OBJCOPY = llvm-objcopy
TARGET=boot$(ARCH).efi

# Флаги компиляции
CFLAGS = -std=c11 -fshort-wchar -fno-strict-aliasing -ffreestanding \
         -fno-stack-protector -fno-stack-check -fpic -fPIC \
         -mabi=lp64d -march=rv64imafdc \
         -I./elf -I./uefi \
         -I/usr/include -I/usr/include/efi -I/usr/include/efi/protocol -I/usr/include/efi/$(ARCH) \
         -D__$(ARCH)__ \
         -Wno-builtin-requires-header -Wno-incompatible-library-redeclaration -Wno-long-long

# Флаги компоновки
LDFLAGS = -nostdlib -Wl,-Bsymbolic,-T,uefi/elf_$(ARCH)_efi.lds,-Luefi

# Флаги для objcopy
OBJCOPYFLAGS = -O efi-app-$(ARCH) -j .text -j .sdata -j .data -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --subsystem=10 --target efi-app-$(ARCH)
#efi-app-$(ARCH)
#--strip-debug --strip-unneeded --remove-section=.comment

# Исходные файлы
SOURCES = main.c uefi/crt_$(ARCH).c uefi/dirent.c uefi/qsort.c uefi/stat.c \
          uefi/stdio.c uefi/stdlib.c uefi/string.c uefi/time.c uefi/unistd.c

# Объектные файлы
OBJECTS = $(SOURCES:.c=.o)

# Библиотечные объекты (исключая main.o и crt)
LIB_OBJECTS = uefi/dirent.o uefi/qsort.o uefi/stat.o uefi/stdio.o \
              uefi/stdlib.o uefi/string.o uefi/time.o uefi/unistd.o

.PHONY: all clean

# Основная цель
all: $(TARGET)

# Правило для компиляции .c файлов в .o
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Специальное правило для crt файла (может потребовать дополнительные флаги)
uefi/crt_$(ARCH).o: uefi/crt_$(ARCH).c
	$(CC) $(CFLAGS) -c $< -o $@

# Создание статической библиотеки
libuefi.a: $(LIB_OBJECTS)
	$(AR) -rsv $@ $^

# Создание промежуточного ELF файла
$(TARGET).so: libuefi.a main.o uefi/crt_$(ARCH).o
	$(CC) $(LDFLAGS) uefi/crt_$(ARCH).o main.o -L. -luefi -o $@

# Финальное преобразование в EFI
$(TARGET): $(TARGET).so
	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@

# Очистка
clean:
	rm -f *.o uefi/*.o *.a *.so *.efi
