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
    void *valuePointer = &value;
    
    unsigned long sizeOfValue = sizeof(value);
    
    LCHPrintBytesOfValue(valuePointer, sizeOfValue);
}

// Perform test with 'short'
// Function should print data with size equal to 2 bytes
void LCHPrintBytesOfShortValue(void) {
    short value = 347;
    void *valuePointer = &value;
    
    unsigned long sizeOfValue = sizeof(value);
    
    LCHPrintBytesOfValue(valuePointer, sizeOfValue);
}

// Perform test with 'int'
// Function should print data with size equal to 4 bytes
void LCHPrintBytesOfIntValue(void) {
    int value = 94783743;
    void *valuePointer = &value;
    
    unsigned long sizeOfValue = sizeof(value);
    
    LCHPrintBytesOfValue(valuePointer, sizeOfValue);
}
