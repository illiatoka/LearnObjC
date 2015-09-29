#ifndef LCHPrintBytesOfValue_h
#define LCHPrintBytesOfValue_h

#pragma mark -
#pragma mark Public Declarations

typedef enum {
    kLCHLittleEndian = 0,
    kLCHBigEndian,
} LCHEndianType;

typedef union fuck {
    uint16_t data;
    
    struct {
        uint8_t isLittleEndian;
        uint8_t isBigEndian;
    };
} kLCHEndianFlag;

extern
void LCHGetBitsOfValue(void *value, size_t typeSize, LCHEndianType endianType);

#endif
