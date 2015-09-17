#include <stdio.h>
#include <assert.h>

#include "LCHCheckValueAndPrint.h"

// LCHCheckParentType function must return kLCHParentTypeMother
void LCHCheckParentTypeMother() {
    int result = LCHCheckParentType(3);
    assert(result == kLCHParentTypeMother);
}

// LCHCheckParentType function must return kLCHParentTypeFather
void LCHCheckParentTypeFather() {
    int result = LCHCheckParentType(5);
    assert(result == kLCHParentTypeFather);
}

// LCHCheckParentType function must return kLCHParentTypeMotherFather
void LCHCheckParentTypeMotherFather() {
    int result = LCHCheckParentType(15);
    assert(result == kLCHParentTypeMotherFather);
}

// Test LCHCheckParentType function using loop with 1000 iteration
void LCHCheckParentTypeTests() {
    for (int count = 0; count < 1000; count++) {
        int currentCount = count;
        
        // Print current counter value
        printf("counter = %d\n", currentCount);
        
        // Run function with current counter value in parameters
        LCHCheckParentType(currentCount);
    }

}
