#include <stdio.h>
#include <assert.h>

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

// Perform test with 'char'
// Function should print data with size equal to 1 byte
void LCHPrintBytesOfCharValue(void) {
    char value = 'A';
    LCHPrintBitsOfValue(&value, sizeof(value), LCHCurrentEndianType());
}

// Perform test with 'short'
// Function should print data with size equal to 2 bytes
void LCHPrintBytesOfShortValue(void) {
    short value = 1;
    LCHPrintBitsOfValue(&value, sizeof(value), LCHCurrentEndianType());
}

// Perform test with 'int'
// Function should print data with size equal to 4 bytes
void LCHPrintBytesOfIntValue(void) {
    int value = 94783743;
    LCHPrintBitsOfValue(&value, sizeof(value), LCHCurrentEndianType());
}

LCHEndianType LCHCurrentEndianType(void) {
    uint16_t endianMarker = 1;
    LCHEndianType endianType = ((uint8_t *)&endianMarker)[0] == 1 ? kLCHLittleEndian : kLCHBigEndian;
    
    return endianType;
}
