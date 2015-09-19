#include "LCHDataTypeTests.h"
#include "LCHDataType.h"

#pragma mark -
#pragma Public Implementatios

// Print size of data type using macro
void LCHPrintSizeOfDataTypeTests(void) {
    LCHPrintSizeOfDataType(char);
    LCHPrintSizeOfDataType(unsigned char);
    LCHPrintSizeOfDataType(signed char);
    LCHPrintSizeOfDataType(int);
    LCHPrintSizeOfDataType(unsigned int);
    LCHPrintSizeOfDataType(short);
    LCHPrintSizeOfDataType(unsigned short);
    LCHPrintSizeOfDataType(long);
    LCHPrintSizeOfDataType(unsigned long);
    LCHPrintSizeOfDataType(float);
    LCHPrintSizeOfDataType(double);
    LCHPrintSizeOfDataType(long double);
}
