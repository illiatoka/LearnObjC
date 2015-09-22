#include <stdio.h>

#include "LCHDataValueTests.h"
#include "LCHDataValue.h"

#pragma mark -
#pragma mark Private Declarations

static
LCHDeclarePrintDataValue(int);

static
LCHDeclarePrintDataValue(char);

static
LCHDeclarePrintDataValue(short);

#pragma mark -
#pragma mark Public Implementations

void LCHDataValueTests(void) {
    LCHCallPrintDataValue(int, 1);
    LCHCallPrintDataValue(char, 'a');
    LCHCallPrintDataValue(short, 2);
}

#pragma mark -
#pragma mark Private Implementatios

LCHPrintDataValue(int, %d);
LCHPrintDataValue(char, %c);
LCHPrintDataValue(short, %d);
