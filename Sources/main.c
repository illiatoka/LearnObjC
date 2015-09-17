#include <stdio.h>

#include "LCHDataTypesTests.h"
#include "LCHCheckValueAndPrintTests.h"

int main(int argc, const char * argv[]) {
    LCHPrintSizeofDataTests();
    LCHCheckParentTypeMother();
    LCHCheckParentTypeFather();
    LCHCheckParentTypeMotherFather();
    LCHCheckParentTypeTests();
    
    return 0;
}