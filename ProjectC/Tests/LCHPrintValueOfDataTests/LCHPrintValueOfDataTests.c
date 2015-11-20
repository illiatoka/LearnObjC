#include <stdio.h>

#include "LCHPrintValueOfDataTests.h"
#include "LCHPrintValueOfData.h"

#pragma mark -
#pragma mark Public Implementations

// Declare functions using macro
LCHPrintDataValue(int, %d)
LCHPrintDataValue(char, %c)
LCHPrintDataValue(short, %d)

void LCHPrintValueOfDataTests(void) {
    // Call functions using macro
    LCHCallPrintDataValue(int, 1);
    LCHCallPrintDataValue(char, 'a');
    LCHCallPrintDataValue(short, 2);
}
