/*
 * 32-разрядные типы данных
 */
typedef unsigned long  Elf32_Addr;   // Программный адрес
typedef unsigned long  Elf32_Off;    // Смещение
typedef unsigned short Elf32_Half;   // Среднее беззнаковое число
typedef signed long    Elf32_Sword;  // Длинное знаковое число
typedef unsigned long  Elf32_Word;   // Длинное беззнаковое число
/*
 * 64-разрядные типы данных
 */
typedef unsigned long long Elf64_Addr;   // Программный адрес
typedef unsigned long long Elf64_Off;    // Смещение
typedef unsigned short     Elf64_Half;   // Среднее беззнаковое число
typedef unsigned long      Elf64_Word;   // Беззнаковое число
typedef   signed long      Elf64_Sword;  // Знаковое число
typedef unsigned long long Elf64_Xword;  // Длинное беззнаковое число
typedef unsigned long long Elf64_Sxword; // Длинное знаковое число

#include "elf/header.h"
