#include <stdlib.h>
#include <assert.h>

#include "LCHObject.h"

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHObjectDeallocate(void *object) {
    if (NULL != object) {
        free(object);
    }
}

void *__LCHObjectCreate(size_t size, LCHObjectDeallocate deallocator) {
    assert(0 != size);
    assert(NULL != deallocator);
    
    LCHObject *object = calloc(1, size);
    
    assert(NULL != object);
    
    object->_referenceCount = 1;
    object->_deallocator = deallocator;
    
    return object;
}

#pragma mark -
#pragma mark Public Implementations

void LCHObjectRetain(void *object) {
    if (NULL != object) {
        ((LCHObject *)object)->_referenceCount++;
    }
}

void LCHObjectRelease(void *object) {
    if (NULL != object) {
        if (0 == --(((LCHObject *)object)->_referenceCount)) {
            LCHObjectDeallocate deallocator = ((LCHObject *)object)->_deallocator;
            
            deallocator(object);
        }
    }
}

uint64_t LCHObjectReferenceCount(void *object) {
    LCHObjectIvarGetterSynthesize(object, ((LCHObject *)object)->_referenceCount, 0)
}

void *LCHObjectDeallocator(void *object) {
    LCHObjectIvarGetterSynthesize(object, ((LCHObject *)object)->_deallocator, NULL)
}
