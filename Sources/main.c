#include <stdio.h>

#include "LCHDataTypeTests.h"
#include "LCHPerformParentTypeTests.h"
#include "LCHDataValueTests.h"

int main(int argc, const char * argv[]) {
    LCHPrintSizeOfDataTypeTests();
    LCHPerformParentTypeTests();
    LCHDataValueTests();
    
    return 0;
}
