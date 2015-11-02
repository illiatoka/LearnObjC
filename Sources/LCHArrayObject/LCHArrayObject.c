#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "LCHArrayObject.h"
#include "LCHHumanObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

const uint8_t kLCHAllocatedCountInitial = 2;

struct LCHArray {
    LCHObject _super;
    void **_data;
    uint8_t _elementsCount;
    uint8_t _allocatedCount;
};

static
void **LCHArrayData(LCHArray *object);

static
void LCHArraySetData(LCHArray *object, void *data);

static
void LCHArraySetElementsCount(LCHArray *object, uint8_t elementsCount);

static
void LCHArraySetAllocatedCount(LCHArray *object, uint8_t allocatedCount);

static
void LCHArraySetElementAtIndex(LCHArray *object, void *element, uint8_t index);

static
void LCHArrayRemoveAllElements(LCHArray *object);

static
void LCHArrayDataResort(LCHArray *object);

static
void LCHArrayResizeIfNeeded(LCHArray *object);

static
void LCHArrayAllocateData(LCHArray *object, uint8_t allocatedCount);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHArrayDeallocate(void *object) {
    LCHArrayRemoveAllElements(object);
    LCHArrayAllocateData(object, 0);
    __LCHObjectDeallocate(object);
}

LCHArray *LCHArrayCreate(void) {
    LCHArray *object = LCHObjectCreateOfType(LCHArray);
    LCHArraySetAllocatedCount(object, kLCHAllocatedCountInitial);
    
    return object;
}

#pragma mark -
#pragma mark Accessors

void **LCHArrayData(LCHArray *object) {
    LCHObjectIvarGetter(object, object->_data, NULL);
}

void LCHArraySetData(LCHArray *object, void *data) {
    LCHObjectAssignSetter(object, _data, data);
}

uint8_t LCHArrayElementsCount(LCHArray *object) {
    LCHObjectIvarGetter(object, object->_elementsCount, 0);
}

void LCHArraySetElementsCount(LCHArray *object, uint8_t elementsCount) {
    LCHObjectAssignSetter(object, _elementsCount, elementsCount);
}

uint8_t LCHArrayAllocatedCount(LCHArray *object) {
    LCHObjectIvarGetter(object, object->_allocatedCount, 0);
}

void LCHArraySetAllocatedCount(LCHArray *object, uint8_t allocatedCount) {
    LCHObjectAssignSetter(object, _allocatedCount, allocatedCount);
}

void *LCHArrayElementAtIndex(LCHArray *object, uint8_t index) {
    LCHObjectIvarGetter(object, object->_data[index], NULL);
}

void LCHArraySetElementAtIndex(LCHArray *object, void *element, uint8_t index) {
    LCHObjectRetainSetter(object, _data[index], element);
}


#pragma mark -
#pragma mark Public Implementations

void LCHArrayAddElement(LCHArray *object, void *element) {
    if (NULL != object && NULL != element) {
        
        uint8_t elementsCount = LCHArrayElementsCount(object);
        
        LCHArrayResizeIfNeeded(object);
        LCHArraySetElementAtIndex(object, element, elementsCount);
        LCHArraySetElementsCount(object, elementsCount + 1);
    }
}

void LCHArrayRemoveElement(LCHArray *object, void *element) {
    if (NULL != object && NULL != element) {
        for (uint8_t index = 0; index < LCHArrayElementsCount(object); index++) {
            void *elementAtIndex = LCHArrayElementAtIndex(object, index);
            if (elementAtIndex == element) {
                LCHArrayRemoveElementAtIndex(object, index);
                
                return;
            }
        }
    }
}

void LCHArrayRemoveElementAtIndex(LCHArray *object, uint8_t index) {
    if (NULL != object) {
        uint8_t elementsCount = LCHArrayElementsCount(object);
        
        if (elementsCount > index) {
            LCHArraySetElementAtIndex(object, NULL, index);
            LCHArrayDataResort(object);
            LCHArrayResizeIfNeeded(object);
            LCHArraySetElementsCount(object, elementsCount - 1);
        }
    }
}

#pragma mark -
#pragma mark Private Implementations

void LCHArrayRemoveAllElements(LCHArray *object) {
    if (NULL != object) {
        for (uint8_t index = 0; index < LCHArrayElementsCount(object); index++) {
            void *element = LCHArrayElementAtIndex(object, index);
            
            if (NULL != element) {
                LCHArrayRemoveElementAtIndex(object, index);
            }
        }
    }
}

void LCHArrayDataResort(LCHArray *object) {
    if (NULL != object) {
        for (uint8_t index = 0; index < LCHArrayElementsCount(object) - 1; index++) {
            void *element = LCHArrayElementAtIndex(object, index);
            
            if (NULL == element) {
                object->_data[index] = LCHArrayElementAtIndex(object, index + 1);
                object->_data[index + 1] = NULL;
            }
        }
    }
}

void LCHArrayResizeIfNeeded(LCHArray *object) {
    if (NULL != object) {
        LCHArrayAllocateData(object, kLCHAllocatedCountInitial);
    }
}

void LCHArrayAllocateData(LCHArray *object, uint8_t allocatedCount) {
    if (NULL != object) {
        uint8_t elementsCount = LCHArrayElementsCount(object);
        
        if (elementsCount == allocatedCount) {
            return;
        }
        
        if (0 == allocatedCount) {
            free(LCHArrayData(object));
            LCHArraySetData(object, NULL);
        } else {
            void **currentData = LCHArrayData(object);
            size_t dataSize = sizeof(*currentData);
            size_t allocatedSize = allocatedCount * dataSize;
            size_t fullDataSize = elementsCount * dataSize;
            
            void *data = realloc(currentData, allocatedSize);
            assert(data);
            LCHArraySetData(object, data);
            
            if (elementsCount < allocatedCount) {
                memset(LCHArrayData(object) + fullDataSize, 0, allocatedSize - fullDataSize);
            }
        }
        
        LCHArraySetAllocatedCount(object, allocatedCount);
    }
}
