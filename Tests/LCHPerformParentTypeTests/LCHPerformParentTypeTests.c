#include <stdio.h>
#include <assert.h>

#include "LCHPerformParentTypeTests.h"
#include "LCHPerformParentType.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHCheckParentTypeMother(void);

static
void LCHCheckParentTypeFather(void);

static
void LCHCheckParentTypeMotherFather(void);

static
void LCHCheckParentTypeLoop(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerformParentTypeTests(void) {
    LCHCheckParentTypeMother();
    LCHCheckParentTypeFather();
    LCHCheckParentTypeMotherFather();
    LCHCheckParentTypeLoop();
}

#pragma mark -
#pragma mark Private Implementatios

// LCHCheckParentType function must return kLCHParentTypeMother
void LCHCheckParentTypeMother(void) {
    int result = LCHPerformParentType(3);
    
    // If not, program will crash here
    assert(result == kLCHParentTypeMother);
}

// LCHCheckParentType function must return kLCHParentTypeFather
void LCHCheckParentTypeFather(void) {
    int result = LCHPerformParentType(5);
    
    // If not, program will crash here
    assert(result == kLCHParentTypeFather);
}

// LCHCheckParentType function must return kLCHParentTypeMotherFather
void LCHCheckParentTypeMotherFather(void) {
    int result = LCHPerformParentType(15);
    
    // If not, program will crash here
    assert(result == kLCHParentTypeMotherFather);
}

// Test LCHCheckParentType function using loop with 16 iteration
void LCHCheckParentTypeLoop(void) {
    for (int count = 0; count < 16; count++) {
        int currentCount = count;
        
        // Print current counter value
        printf("counter = %d\t", currentCount);
        
        // Run function with current counter value in parameters
        LCHPerformParentType(currentCount);
    }
    
}
