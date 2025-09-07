# define which architecture you're targeting
ARCH = aarch64
# define your target file here
TARGET = bootaa64.efi
#define your sources here
SRCS = $(wildcard *.c) uefi/crt_aarch64.c $(filter-out uefi/crt_%, $(wildcard uefi/*.c))
# define your default compiler flags
# CFLAGS = -pedantic -Wall -Wextra -Werror --ansi -O2
CFLAGS = -std=c11 -I./elf
# define your default linker flags
#LDFLAGS =
#LDFLAGS = -subsystem:efi_application
# define your additional libraries here
#LIBS = -lm

# leave the hard work and all the rest to posix-uefi

# set this if you want GNU gcc + ld + objcopy instead of LLVM Clang + Lld
# USE_GCC = 1
include uefi/Makefile
