#include <stdio.h>

#include "LCHCheckValueAndPrint.h"

LCHParentType LCHCheckParentType(int value) {
    const int kLCHMotherValue = 3;
    const int kLCHFatherValue = 5;
    
    LCHParentType result = kLCHParentTypeUndefined;
    
    if (0 == value % kLCHMotherValue && 0 != value) {
        result = kLCHParentTypeMother;
        printf("Mother");
    }
    
    if (0 == value % kLCHFatherValue && 0 != value) {
        result = (kLCHParentTypeMother == result
                  ? kLCHParentTypeMotherFather
                  : kLCHParentTypeFather);

        printf("Father");
    }
    
    if (kLCHParentTypeUndefined != result) {
        printf("\n");
    }
    
    return result;
}
