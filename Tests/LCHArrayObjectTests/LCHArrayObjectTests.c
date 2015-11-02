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
    assert(0 == LCHArrayElementsCount(array));
    
    // Array allocated count must be equal to kLCHAllocatedCountInitial
    assert(kLCHAllocatedCountInitial == LCHArrayAllocatedCount(array));
    
    // After add 1 element to array
    LCHArrayAddElement(array, array);
    
    // Array count must be equal to 1
    assert(1 == LCHArrayElementsCount(array));
    
    // Result must not be NULL of array getter
    assert(NULL != LCHArrayElementAtIndex(array, 0));
    
    // After remove 1 element
    LCHArrayRemoveElementAtIndex(array, 0);
    
    // Array count must be equal to 0
    assert(0 == LCHArrayElementsCount(array));
    
    // Array reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(array));
    
    // Object deallocator must not be NULL
    assert(NULL != LCHObjectDeallocator(array));
    
    LCHObjectRelease(array);
}
