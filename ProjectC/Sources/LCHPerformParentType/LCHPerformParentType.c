#include <stdio.h>

#include "LCHPerformParentType.h"

#pragma mark -
#pragma mark Private Declarations

static const int kLCHMotherDivisor = 3;
static const int kLCHFatherDivisor = 5;

#pragma mark -
#pragma mark Public Implementations

LCHParentType LCHPerformParentType(int value) {
    
    LCHParentType result = kLCHParentTypeUndefined;
    
    if (0 != value) {
        if (0 == value % kLCHMotherDivisor) {
            result = kLCHParentTypeMother;
            printf("Mother");
        }
        
        if (0 == value % kLCHFatherDivisor) {
            result = (kLCHParentTypeMother == result
                      ? kLCHParentTypeMotherFather
                      : kLCHParentTypeFather);
            
            printf("Father");
        }
        
        if (kLCHParentTypeUndefined != result) {
            printf("\n");
        }
    }
    
    return result;
}
