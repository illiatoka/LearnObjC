#include "LCHPrintBytesOfValueTests.h"
#include "LCHPrintBytesOfValue.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHPrintBytesOfCharValue(void);

static
void LCHPrintBytesOfShortValue(void);

static
void LCHPrintBytesOfIntValue(void);

static
LCHEndianType LCHCurrentEndianType(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPrintBytesOfValueTests(void) {
    LCHPrintBytesOfCharValue();
    LCHPrintBytesOfShortValue();
    LCHPrintBytesOfIntValue();
}

#pragma mark -
#pragma mark Private Implementations

// Detect endian type
LCHEndianType LCHCurrentEndianType(void) {
    LCHEndianType endianType = 0;
    LCHEndianFlag endianFlag;
    endianFlag.data = 1;
    
    if (1 == endianFlag.isLittleEndian) {
        endianType = kLCHLittleEndian;
    } else if (1 == endianFlag.isBigEndian) {
        endianType = kLCHBigEndian;
    }
    
    return endianType;
}

// Perform test with 'char'
// Function should print data with size equal to 1 byte
void LCHPrintBytesOfCharValue(void) {
    char value = 'A';
    void *valuePointer = &value;
    size_t sizeOfValue = sizeof(value);
    LCHEndianType endianType = 0;
    LCHEndianType endianTypeFlag = LCHCurrentEndianType();
    
    if (endianTypeFlag == kLCHLittleEndian) {
        endianType = kLCHLittleEndian;
    } else if (endianTypeFlag == kLCHBigEndian) {
        endianType = kLCHBigEndian;
    }
    
    LCHPrintBitsOfValue(valuePointer, sizeOfValue, endianType);
}

// Perform test with 'short'
// Function should print data with size equal to 2 bytes
void LCHPrintBytesOfShortValue(void) {
    short value = 1;
    void *valuePointer = &value;
    size_t sizeOfValue = sizeof(value);
    LCHEndianType endianType = 0;
    LCHEndianType endianTypeFlag = LCHCurrentEndianType();
    
    if (endianTypeFlag == kLCHLittleEndian) {
        endianType = kLCHLittleEndian;
    } else if (endianTypeFlag == kLCHBigEndian) {
        endianType = kLCHBigEndian;
    }
    
    LCHPrintBitsOfValue(valuePointer, sizeOfValue, endianType);
}

// Perform test with 'int'
// Function should print data with size equal to 4 bytes
void LCHPrintBytesOfIntValue(void) {
    int value = 94783743;
    void *valuePointer = &value;
    size_t sizeOfValue = sizeof(value);
    LCHEndianType endianType = 0;
    LCHEndianType endianTypeFlag = LCHCurrentEndianType();
    
    if (endianTypeFlag == kLCHLittleEndian) {
        endianType = kLCHLittleEndian;
    } else if (endianTypeFlag == kLCHBigEndian) {
        endianType = kLCHBigEndian;
    }
    
    LCHPrintBitsOfValue(valuePointer, sizeOfValue, endianType);
}
