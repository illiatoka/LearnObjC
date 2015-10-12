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
void LCHCheckParentTypeUndefined(void);

static
void LCHCheckParentTypeLoop(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerformParentTypeTests(void) {
    LCHCheckParentTypeMother();
    LCHCheckParentTypeFather();
    LCHCheckParentTypeMotherFather();
    LCHCheckParentTypeUndefined();
    LCHCheckParentTypeLoop();
}

#pragma mark -
#pragma mark Private Implementatios

// LCHCheckParentType function must return kLCHParentTypeMother
void LCHCheckParentTypeMother(void) {
    // If not, program will crash here
    assert(LCHPerformParentType(3) == kLCHParentTypeMother);
    assert(LCHPerformParentType(9) == kLCHParentTypeMother);
}

// LCHCheckParentType function must return kLCHParentTypeFather
void LCHCheckParentTypeFather(void) {
    // If not, program will crash here
    assert(LCHPerformParentType(5) == kLCHParentTypeFather);
    assert(LCHPerformParentType(10) == kLCHParentTypeFather);
}

// LCHCheckParentType function must return kLCHParentTypeMotherFather
void LCHCheckParentTypeMotherFather(void) {
    // If not, program will crash here
    assert(LCHPerformParentType(15) == kLCHParentTypeMotherFather);
    assert(LCHPerformParentType(30) == kLCHParentTypeMotherFather);
}

// LCHCheckParentType function must return kLCHParentTypeMotherFather
void LCHCheckParentTypeUndefined(void) {
    // If not, program will crash here
    assert(LCHPerformParentType(0) == kLCHParentTypeUndefined);
    assert(LCHPerformParentType(7) == kLCHParentTypeUndefined);
}

// Test LCHCheckParentType function using loop with 16 iteration
void LCHCheckParentTypeLoop(void) {
    for (int count = 0; count < 17; count++) {
        // Print current counter value
        printf("counter = %d\n", count);
        
        // Run function with current counter value in parameters
        LCHPerformParentType(count);
    }
}
