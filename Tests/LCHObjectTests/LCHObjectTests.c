#include <assert.h>

#include "LCHObjectTests.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHObjectCreateTests(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerformObjectTests(void) {
    LCHObjectCreateTests();
}

#pragma mark -
#pragma mark Private Implementations

void LCHObjectCreateTests(void) {
    // Create object
    LCHObject *object = LCHObjectCreateOfType(LCHObject);
    
    // After object was created
    // Object must not be NULL
    assert(NULL != object);
    
    // Object reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(object));
    
    // Object deallocator must not be NULL
    assert(NULL != LCHObjectDeallocator(object));
    
    LCHObjectRelease(object);
}
