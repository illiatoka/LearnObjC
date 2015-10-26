#include <assert.h>

#include "LCHStringObjectTests.h"
#include "LCHStringObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHStringCreateTests(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerformStringTests(void) {
    LCHStringCreateTests();
}

#pragma mark -
#pragma mark Private Implementations

void LCHStringCreateTests(void) {
    // Create object
    LCHString *string = LCHStringCreate("Test value");
    
    // After string was created
    // string must not be NULL
    assert(NULL != string);
    
    // String value must not be NULL
    assert(NULL != LCHStringValue(string));
    
    // After string value was set
    char *value = "Hello World";
    LCHStringSetValue(string, value);
    
    // String value must not be equal to NULL
    assert(NULL != LCHStringValue(string));
    
    // String reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(string));
    
    // String deallocator must not be NULL
    assert(NULL != LCHObjectDeallocator(string));
    
    LCHObjectRelease(string);
}
