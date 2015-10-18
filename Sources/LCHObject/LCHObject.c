#include "LCHObject.h"

#pragma mark -
#pragma mark Public Implementations

void _LCHObjectDeallocate(void *object) {
    if (NULL != object) {
        free(object);
    }
}

void *_LCHObjectCreate(size_t size, LCHObjectDeallocate deallocator) {
    assert(0 != size);
    assert(NULL != deallocator);
    
    LCHObject *object = calloc(1, size);
    
    assert(NULL != object);
    
    object->_referenceCount = 1;
    object->_deallocateFunction = deallocator;
    
    return object;
}

void LCHObjectRetain(void *object) {
    if (NULL != object) {
        ((LCHObject *)object)->_referenceCount++;
    }
}

void LCHObjectRelease(void *object) {
    if (NULL != object) {
        if (0 == --(((LCHObject *)object)->_referenceCount)) {
            LCHObjectDeallocate deallocator = ((LCHObject *)object)->_deallocateFunction;
            
            deallocator(object);
        }
    }
}

uint64_t LCHHumanReferenceCount(void *object) {
    return NULL != object ? ((LCHObject *)object)->_referenceCount : 0;
}
