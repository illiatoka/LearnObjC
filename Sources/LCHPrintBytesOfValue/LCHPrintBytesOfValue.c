#include <stdio.h>
#include <stdlib.h>

#include "LCHPrintBytesOfValue.h"

#pragma mark -
#pragma mark Private Declarations

static const int kLCHBitCount = 8;
static const int kLCHBitMask = 1;

static
void LCHPrintBitsOfByte(uint8_t value);

#pragma mark -
#pragma mark Public Implementations

void LCHPrintBitsOfValue(void *valuePointer, size_t typeSize, LCHEndianType endianType) {
    printf("Bits of value with pointer %p is: \n", valuePointer);
    
    if (endianType == kLCHLittleEndian) {
        for (size_t index = 0; index < typeSize; index++ ) {
            uint8_t byte = ((uint8_t *)valuePointer)[index];
            LCHPrintBitsOfByte(byte);
            printf(" ");
        }
    } else if (endianType == kLCHBigEndian) {
        while (typeSize) {
            typeSize--;
            uint8_t byte = ((uint8_t *)valuePointer)[typeSize];
            LCHPrintBitsOfByte(byte);
            printf(" ");
        }
    }
    printf("\n\n");
}

#pragma mark -
#pragma mark Private Implementations

void LCHPrintBitsOfByte(uint8_t byteData) {
    for (int bitIndex = kLCHBitCount; bitIndex != 0; bitIndex--) {
        printf("%s", (((byteData >> (bitIndex - 1)) & kLCHBitMask) ? "1" : "0"));
        
    }
}
