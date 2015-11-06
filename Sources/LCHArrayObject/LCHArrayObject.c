#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "LCHArrayObject.h"
#include "LCHHumanObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

const uint64_t kLCHObjectNotFound = UINT64_MAX;

struct LCHArray {
    LCHObject _super;
    void **_data;
    uint64_t _count;
    uint64_t _capacity;
};

static
void **LCHArrayData(LCHArray *array);

static
void LCHArraySetData(LCHArray *array, void *data);

static
void LCHArraySetCount(LCHArray *array, uint64_t count);

static
void LCHArraySetCapacity(LCHArray *array, uint64_t capacity);

static
void LCHArraySetObjectAtIndex(LCHArray *array, void *object, uint64_t index);

static
void LCHArrayRemoveAllObjects(LCHArray *array);

static
void LCHArrayResizeIfNeeded(LCHArray *array, uint64_t newCount);

static
uint64_t LCHArrayProposedCapacityForCount(LCHArray *array, uint64_t newCount);

static
bool LCHArrayShouldResize(LCHArray *array, uint64_t newCount);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHArrayDeallocate(void *array) {
    LCHArrayRemoveAllObjects(array);
    __LCHObjectDeallocate(array);
}

LCHArray *LCHArrayCreate(void) {
    LCHArray *array = LCHObjectCreateOfType(LCHArray);
    
    return array;
}

#pragma mark -
#pragma mark Accessors

void **LCHArrayData(LCHArray *array) {
    LCHObjectIvarGetter(array, array->_data, NULL);
}

void LCHArraySetData(LCHArray *array, void *data) {
    LCHObjectAssignSetter(array, _data, data);
}

uint64_t LCHArrayCount(LCHArray *array) {
    LCHObjectIvarGetter(array, array->_count, 0);
}

void LCHArraySetCount(LCHArray *array, uint64_t count) {
    LCHArrayResizeIfNeeded(array, count);
    LCHObjectAssignSetter(array, _count, count);
}

uint64_t LCHArrayCapacity(LCHArray *array) {
    LCHObjectIvarGetter(array, array->_capacity, 0);
}

void LCHArraySetCapacity(LCHArray *array, uint64_t capacity) {
    if (NULL != array) {
        void **currentData = LCHArrayData(array);
        
        if (0 == capacity && NULL != currentData) {
            free(LCHArrayData(array));
            LCHArraySetData(array, NULL);
        } else {
            uint64_t currentCapacity = LCHArrayCapacity(array);
            size_t dataSize = sizeof(*currentData);
            size_t capacitySize = capacity * dataSize;
            size_t fullDataSize = currentCapacity * dataSize;
            
            void *data = realloc(currentData, capacitySize);
            assert(data);
            LCHArraySetData(array, data);
            
            if (currentCapacity < capacity) {
                memset(LCHArrayData(array) + fullDataSize, 0, capacitySize - fullDataSize);
            }
        }
        
        array->_capacity = capacity;
    }
}

void *LCHArrayObjectAtIndex(LCHArray *array, uint64_t index) {
    void *object = NULL;
    
    if (NULL != array) {
        assert(index < LCHArrayCount(array));
        
        object = array->_data[index];
    }
    
    return object;
}

void LCHArraySetObjectAtIndex(LCHArray *array, void *object, uint64_t index) {
    if (NULL != array) {
        assert(index < LCHArrayCount(array));
    }
    
    LCHObjectRetainSetter(array, _data[index], object);
}

#pragma mark -
#pragma mark Public Implementations

uint64_t LCHArrayIndexOfObject(LCHArray *array, void *object) {
    uint64_t result = array ? kLCHObjectNotFound : 0;
    uint64_t count = LCHArrayCount(array);
    
    if (NULL != array && NULL != object) {
        for (uint64_t index = 0; index < count; index++) {
            if (LCHArrayObjectAtIndex(array, index) == object) {
                result = index;
                
                break;
            }
        }
    }
    
    return result;
}

bool LCHArrayContainsObject(LCHArray *array, void *object) {
    return NULL != array && NULL != object && kLCHObjectNotFound != LCHArrayIndexOfObject(array, object);
}

void LCHArrayAddObject(LCHArray *array, void *object) {
    if (NULL != array && NULL != object) {
        uint64_t count = LCHArrayCount(array);
        
        LCHArraySetCount(array, count + 1);
        LCHArraySetObjectAtIndex(array, object, count);
    }
}

void LCHArrayRemoveObject(LCHArray *array, void *object) {
    if (LCHArrayContainsObject(array, object)) {
        LCHArrayRemoveObjectAtIndex(array, LCHArrayIndexOfObject(array, object));
    }
}

void LCHArrayRemoveObjectAtIndex(LCHArray *array, uint64_t index) {
    if (NULL != array) {
        uint64_t count = LCHArrayCount(array);
        
        if (index < count) {
            LCHArraySetObjectAtIndex(array, NULL, index);
            
            void **data = LCHArrayData(array);
            size_t memorySize = (count - index) * sizeof(data);
            
            memmove(&data[index], &data[index + 1], memorySize);
            data[count - 1] = NULL;
            
            LCHArraySetCount(array, count - 1);
        }
    }
}

#pragma mark -
#pragma mark Private Implementations

void LCHArrayRemoveAllObjects(LCHArray *array) {
    if (NULL != array) {
        for (uint64_t index = 0; index < LCHArrayCount(array); index++) {
            LCHArrayRemoveObjectAtIndex(array, index);
        }
    }
}

void LCHArrayResizeIfNeeded(LCHArray *array, uint64_t newCount) {
    if (true == LCHArrayShouldResize(array, newCount)) {
        LCHArraySetCapacity(array, LCHArrayProposedCapacityForCount(array, newCount));
    }
}

uint64_t LCHArrayProposedCapacityForCount(LCHArray *array, uint64_t newCount) {
    uint64_t proposedCapacity = 0;
    
    if (NULL != array) {
        uint64_t currentCount = LCHArrayCount(array);
        uint64_t currentCapacity = LCHArrayCapacity(array);
        
        if (newCount > currentCount) {
            if (newCount >= currentCapacity) {
                proposedCapacity = (newCount *3)/2 + 1;
            } else {
                proposedCapacity = currentCapacity;
            }
        } else {
            uint64_t deltaCapacity = ((currentCapacity *3)/2 + 1) - currentCapacity;
            if (newCount <= currentCapacity - deltaCapacity) {
                proposedCapacity = currentCapacity - deltaCapacity;
            } else {
                proposedCapacity = currentCapacity;
            }
        }
    }
    
    return proposedCapacity;
}

bool LCHArrayShouldResize(LCHArray *array, uint64_t newCount) {
    return NULL != array && LCHArrayCapacity(array) != LCHArrayProposedCapacityForCount(array, newCount);
}
