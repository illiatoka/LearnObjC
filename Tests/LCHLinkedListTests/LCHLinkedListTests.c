#include <assert.h>

#include "LCHLinkedListTests.h"
#include "LCHLinkedList.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHLinkedListCreateTests(void);

#pragma mark -
#pragma Public Implementations

void LCHPerformLinkedListTests(void) {
    LCHLinkedListCreateTests();
}

#pragma mark -
#pragma mark Private Implementations

void LCHLinkedListCreateTests(void) {
    // Create list
    LCHLinkedList *list = LCHLinkedListCreate();
    
    // After list was created
    // List count must be 0
    assert(0 == LCHLinkedListCount(list));
    
    // Create test object
    LCHObject *object = LCHObjectCreateOfType(LCHObject);
    
    // After test object was created
    // List must not contain object
    assert(false == LCHLinkedListContainsObject(list, object));
    
    // After test object was added to list
    LCHLinkedListAddObject(list, object);
    
    // Object reference count must be 2
    assert(2 == LCHObjectReferenceCount(object));
    
    // List count must be 1
    assert(1 == LCHLinkedListCount(list));
    
    // List must contain object
    assert(true == LCHLinkedListContainsObject(list, object));
    
    // After test object was removed from list
    LCHLinkedListRemoveObject(list, object);
    
    // List count must be 0
    assert(0 == LCHLinkedListCount(list));
    
    // List must not contain object
    assert(false == LCHLinkedListContainsObject(list, object));
    
    // Object reference count must be 1
    assert(1 == LCHObjectReferenceCount(object));
    
    LCHObjectRelease(object);
    LCHObjectRelease(list);
}