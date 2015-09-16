#include <stdio.h>

#include "LCHDataTypesTests.h"
#include "LCHCheckValueAndPrintTests.h"

int main(int argc, const char * argv[]) {
    
    // Test macro for print sizeof data types
    LCHPrintSizeofDataTypeTests();
    
    // Test function for print specific strings depends on value
    LCHCheckValueAndPrintTests();
    
    return 0;
    
}
