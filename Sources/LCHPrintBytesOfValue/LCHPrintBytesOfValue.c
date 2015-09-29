#include <stdio.h>
#include <stdlib.h>

#include "LCHPrintBytesOfValue.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHPrintBitsOfByte(uint8_t value);

static const int kLCHBitCount = 8;
static const int kLCHBitMask = 1;

#pragma mark -
#pragma mark Public Implementations

void LCHGetBitsOfValue(void *valuePointer, size_t typeSize, LCHEndianType endianType) {
    printf("Bits of value with pointer %p is: \n", valuePointer);
    
    if (endianType == kLCHLittleEndian) {
        for (size_t index = 0; index < typeSize; index++ ) {
            uint8_t byte = ((uint8_t *)valuePointer)[index];
            LCHPrintBitsOfByte(byte);
        }
    } else if (endianType == kLCHBigEndian) {
        while (typeSize) {
            typeSize--;
            LCHPrintBitsOfByte(((uint8_t *)valuePointer)[typeSize]);
        }
    }
    printf("\n\n");
}

#pragma mark -
#pragma mark Private Implementations

void LCHPrintBitsOfByte(uint8_t byteData) {
    for (int bitIndex = kLCHBitCount; bitIndex != 0; bitIndex--) {
        printf("%s", (((byteData >> (bitIndex - 1)) & kLCHBitMask) ? "1" : "0"));
        
        if (0 == (bitIndex % kLCHBitCount) - 1) {
            printf(" ");
        }
        
    }
}
