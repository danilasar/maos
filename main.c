typedef unsigned long long UINT64;
typedef unsigned int UINT32;
typedef unsigned short CHAR16;
typedef unsigned long SIZE_T;
typedef void VOID;

typedef UINT64 EFI_STATUS;

#define EFI_SUCCESS 0
#define EFI_INVALID_PARAMETER 1

// Простая реализация memcpy
static void* my_memcpy(void* dest, const void* src, SIZE_T n) {
    unsigned char* d = (unsigned char*)dest;
    const unsigned char* s = (const unsigned char*)src;
    for (SIZE_T i = 0; i < n; i++) {
        d[i] = s[i];
    }
    return dest;
}

// Переопределяем memcpy
void* memcpy(void* dest, const void* src, SIZE_T n) {
    return my_memcpy(dest, src, n);
}

// Правильное определение указателей на функции
typedef struct _EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL;

typedef EFI_STATUS (*EFI_TEXT_RESET)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    UINT64 ExtendedVerification
);

typedef EFI_STATUS (*EFI_TEXT_STRING)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    CHAR16* String
);

typedef EFI_STATUS (*EFI_TEXT_CLEAR_SCREEN)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This
);

struct _EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL {
    EFI_TEXT_RESET Reset;
    EFI_TEXT_STRING OutputString;
    VOID* TestString;
    VOID* QueryMode;
    VOID* SetMode;
    VOID* SetAttribute;
    EFI_TEXT_CLEAR_SCREEN ClearScreen;
    VOID* SetCursorPosition;
    VOID* EnableCursor;
    VOID* Mode;
};

typedef struct _EFI_SIMPLE_TEXT_INPUT_PROTOCOL {
    VOID* Reset;
    VOID* ReadKeyStroke;
    VOID* WaitForKey;
} EFI_SIMPLE_TEXT_INPUT_PROTOCOL;

#define EFI_SYSTEM_TABLE_SIGNATURE 0x5453595320494249
#define EFI_2_100_SYSTEM_TABLE_REVISION ((2<<16) | (100))
#define EFI_2_90_SYSTEM_TABLE_REVISION  ((2<<16) | (90))
#define EFI_2_80_SYSTEM_TABLE_REVISION  ((2<<16) | (80))
#define EFI_2_70_SYSTEM_TABLE_REVISION  ((2<<16) | (70))
#define EFI_2_60_SYSTEM_TABLE_REVISION  ((2<<16) | (60))
#define EFI_2_50_SYSTEM_TABLE_REVISION  ((2<<16) | (50))
#define EFI_2_40_SYSTEM_TABLE_REVISION  ((2<<16) | (40))
#define EFI_2_31_SYSTEM_TABLE_REVISION  ((2<<16) | (31))
#define EFI_2_30_SYSTEM_TABLE_REVISION  ((2<<16) | (30))
#define EFI_2_20_SYSTEM_TABLE_REVISION  ((2<<16) | (20))
#define EFI_2_10_SYSTEM_TABLE_REVISION  ((2<<16) | (10))
#define EFI_2_00_SYSTEM_TABLE_REVISION  ((2<<16) | (00))
#define EFI_1_10_SYSTEM_TABLE_REVISION  ((1<<16) | (10))
#define EFI_1_02_SYSTEM_TABLE_REVISION  ((1<<16) | (02))
#define EFI_SPECIFICATION_VERSION       EFI_SYSTEM_TABLE_REVISION
#define EFI_SYSTEM_TABLE_REVISION       EFI_2_100_SYSTEM_TABLE_REVISION
#define EFI_SIMPLE_TEXT_INPUT_PROTOCOL_GUID \
 {0x387477c1,0x69c7,0x11d2,\
  {0x8e,0x39,0x00,0xa0,0xc9,0x69,0x72,0x3b}}
typedef struct {
  UINT64      Signature;
  UINT32      Revision;
  UINT32      HeaderSize;
  UINT32      CRC32;
  UINT32      Reserved;
 } EFI_TABLE_HEADER;

typedef VOID* EFI_HANDLE;

typedef
EFI_STATUS
(EFIAPI *EFI_INPUT_RESET) (
 IN EFI_SIMPLE_TEXT_INPUT_PROTOCOL                 *This,
 IN BOOLEAN                                        ExtendedVerification
 );
typedef
EFI_STATUS
(EFIAPI \*EFI_INPUT_READ_KEY) (
 IN EFI_SIMPLE_TEXT_INPUT_PROTOCOL              *This,
 OUT EFI_INPUT_KEY                              *Key
 );
typedef struct {
 UINT16                             ScanCode;
 CHAR16                             UnicodeChar;
} EFI_INPUT_KEY;
typedef struct _EFI_SIMPLE_TEXT_INPUT_PROTOCOL {
 EFI_INPUT_RESET                       Reset;
 EFI_INPUT_READ_KEY                    ReadKeyStroke;
 EFI_EVENT                             WaitForKey;
} EFI_SIMPLE_TEXT_INPUT_PROTOCOL;
#define EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL_GUID \
 {0x387477c2,0x69c7,0x11d2,\
  {0x8e,0x39,0x00,0xa0,0xc9,0x69,0x72,0x3b}}
typedef struct _EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL {
 EFI_TEXT_RESET                           Reset;
 EFI_TEXT_STRING                          OutputString;
 EFI_TEXT_TEST_STRING                     TestString;
 EFI_TEXT_QUERY_MODE                      QueryMode;
 EFI_TEXT_SET_MODE                        SetMode;
 EFI_TEXT_SET_ATTRIBUTE                   SetAttribute;
 EFI_TEXT_CLEAR_SCREEN                    ClearScreen;
 EFI_TEXT_SET_CURSOR_POSITION             SetCursorPosition;
 EFI_TEXT_ENABLE_CURSOR                   EnableCursor;
 SIMPLE_TEXT_OUTPUT_MODE                  *Mode;
} EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL;

typedef struct {
  EFI_TABLE_HEADER                 Hdr;
  CHAR16                           *FirmwareVendor;
  UINT32                           FirmwareRevision;
  EFI_HANDLE                       ConsoleInHandle;
  EFI_SIMPLE_TEXT_INPUT_PROTOCOL   *ConIn;
  EFI_HANDLE                       ConsoleOutHandle;
  EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL  *ConOut;
  EFI_HANDLE                       StandardErrorHandle;
  EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL  *StdErr;
  EFI_RUNTIME_SERVICES             *RuntimeServices;
  EFI_BOOT_SERVICES                *BootServices;
  UINTN                            NumberOfTableEntries;
  EFI_CONFIGURATION_TABLE          *ConfigurationTable;
} EFI_SYSTEM_TABLE;

EFI_STATUS efi_main(EFI_HANDLE ImageHandle __attribute__((unused)), EFI_SYSTEM_TABLE* SystemTable)
{
	return 2;
	if(!SystemTable) {
		return EFI_INVALID_PARAMETER;
	}
	SystemTable->ConOut->ClearScreen(SystemTable->ConOut);
/*    CHAR16 hello[] = L"Hello, EFI World from aarch64!\r\n";
    
    // Очищаем экран
    SystemTable->ConOut->ClearScreen(SystemTable->ConOut);
    
    // Выводим сообщение
    SystemTable->ConOut->OutputString(SystemTable->ConOut, hello);
    
    // Простая задержка
    for (volatile int i = 0; i < 100000000; i++);*/
    
	return EFI_SUCCESS;
}

