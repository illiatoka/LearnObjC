#include <stdio.h>

#include "LCHDataValueTests.h"
#include "LCHDataValue.h"

LCHPrintDataValue(int, %d)
LCHPrintDataValue(char, %c)
LCHPrintDataValue(short, %d)

void LCHDataValueTests(void) {
    LCHCallPrintDataValue(int, 1);
    LCHCallPrintDataValue(char, 'a');
    LCHCallPrintDataValue(short, 2);
}
