#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "LCHArrayObject.h"
#include "LCHHumanObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

const uint64_t kLCHCapacityInitial = 2;
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
void LCHArrayDataResort(LCHArray *array);

static
void LCHArrayResizeIfNeeded(LCHArray *array);

static
void LCHArrayAllocateData(LCHArray *array, uint64_t capacity);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHArrayDeallocate(void *array) {
    LCHArrayRemoveAllObjects(array);
    __LCHObjectDeallocate(array);
}

LCHArray *LCHArrayCreate(void) {
    LCHArray *array = LCHObjectCreateOfType(LCHArray);
    LCHArraySetCapacity(array, kLCHCapacityInitial);
    
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
    LCHObjectAssignSetter(array, _count, count);
}

uint64_t LCHArrayCapacity(LCHArray *array) {
    LCHObjectIvarGetter(array, array->_capacity, 0);
}

void LCHArraySetCapacity(LCHArray *array, uint64_t capacity) {
    LCHObjectAssignSetter(array, _capacity, capacity);
}

void *LCHArrayObjectAtIndex(LCHArray *array, uint64_t index) {
    void *object = NULL;
    
    if (NULL != array) {
        assert(index < LCHArrayCount(array));
        
        if (index < LCHArrayCount(array)) {
            object = array->_data[index];
        }
    }
    
    return object;
}

void LCHArraySetObjectAtIndex(LCHArray *array, void *object, uint64_t index) {
    if (NULL != array) {
        assert(index <= LCHArrayCount(array));
        
        LCHObjectRetainSetter(array, _data[index], object);
    }
}

#pragma mark -
#pragma mark Public Implementations

uint64_t LCHArrayIndexOfObject(LCHArray *array, void *object) {
    uint64_t result = 0;
    
    if (NULL != array && NULL != object) {
        for (uint64_t index = 0; index < LCHArrayCount(array); index++) {
            void *objectAtIndex = LCHArrayObjectAtIndex(array, index);
            
            result = kLCHObjectNotFound;
            
            if (objectAtIndex == object) {
                return index;
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
        
        LCHArrayResizeIfNeeded(array);
        LCHArraySetObjectAtIndex(array, object, count);
        LCHArraySetCount(array, count + 1);
    }
}

void LCHArrayRemoveObject(LCHArray *array, void *object) {
    if (NULL != array && NULL != object) {
        uint64_t indexOfObject = LCHArrayIndexOfObject(array, object);
        
        if (kLCHObjectNotFound != indexOfObject) {
            LCHArrayRemoveObjectAtIndex(array, indexOfObject);
        }
    }
}

void LCHArrayRemoveObjectAtIndex(LCHArray *array, uint64_t index) {
    if (NULL != array) {
        uint64_t count = LCHArrayCount(array);
        
        if (index < count) {
            LCHArraySetObjectAtIndex(array, NULL, index);
            LCHArrayDataResort(array);
            LCHArrayResizeIfNeeded(array);
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
        
        LCHArrayAllocateData(array, 0);
    }
}

void LCHArrayDataResort(LCHArray *array) {
    if (NULL != array) {
        for (uint64_t index = 0; index < LCHArrayCount(array) - 1; index++) {
            void *object = LCHArrayObjectAtIndex(array, index);
            
            if (NULL == object) {
                array->_data[index] = LCHArrayObjectAtIndex(array, index + 1);
                array->_data[index + 1] = NULL;
            }
        }
    }
}

void LCHArrayResizeIfNeeded(LCHArray *array) {
    if (NULL != array) {
        // TODO: Resize strategy goes here!
        
        LCHArrayAllocateData(array, kLCHCapacityInitial);
    }
}

void LCHArrayAllocateData(LCHArray *array, uint64_t capacity) {
    if (NULL != array) {
        uint64_t count = LCHArrayCount(array);
        
        if (count == capacity) {
            return;
        }
        
        if (0 == capacity) {
            free(LCHArrayData(array));
            LCHArraySetData(array, NULL);
        } else {
            void **currentData = LCHArrayData(array);
            size_t dataSize = sizeof(*currentData);
            size_t capacitySize = capacity * dataSize;
            size_t fullDataSize = count * dataSize;
            
            void *data = realloc(currentData, capacitySize);
            assert(data);
            LCHArraySetData(array, data);
            
            if (count < capacity) {
                memset(LCHArrayData(array) + fullDataSize, 0, capacitySize - fullDataSize);
            }
        }
        
        LCHArraySetCapacity(array, capacity);
    }
}
