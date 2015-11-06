#include <assert.h>

#include "LCHArrayObjectTests.h"
#include "LCHArrayObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHArrayCreateTests(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerformArrayTests(void) {
    LCHArrayCreateTests();
}

#pragma mark -
#pragma mark Private Implementations

void LCHArrayCreateTests(void) {
    // Create object
    LCHArray *array = LCHArrayCreate();
    
    // After array was created
    // Array must not be NULL
    assert(NULL != array);
    
    // Array count must be equal to 0
    assert(0 == LCHArrayCount(array));
    
    // Array capacity must be equal to 0
    assert(0 == LCHArrayCapacity(array));
    
    // After add 1 element to array
    LCHArrayAddObject(array, array);
    
    // Array count must be equal to 1
    assert(1 == LCHArrayCount(array));
    
    // Result of LCHArrayObjectAtIndex must not be NULL
    assert(NULL != LCHArrayObjectAtIndex(array, 0));
    
    // After remove 1 element
    LCHArrayRemoveObjectAtIndex(array, 0);
    
    // Array count must be equal to 0
    assert(0 == LCHArrayCount(array));
    
    // Array reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(array));
    
    // Capacity must be equal to 0
    assert(0 == LCHArrayCapacity(array));
    
    // Object deallocator must not be NULL
    assert(NULL != LCHObjectDeallocator(array));
    
    LCHObjectRelease(array);
}
