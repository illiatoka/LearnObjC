#ifndef LCHPrintBytesOfValue_h
#define LCHPrintBytesOfValue_h

typedef enum {
    kLCHLittleEndian,
    kLCHBigEndian,
} LCHEndianType;

extern
void LCHPrintBitsOfValue(void *value, size_t typeSize, LCHEndianType endianType);

#endif
