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
    // List should be empty
    assert(0 == LCHLinkedListCount(list));
    
    LCHObjectRelease(list);
}