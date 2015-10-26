#include "LCHArrayObject.h"
#include "LCHHumanObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

static const uint8_t kLCHArrayElementsLimit = 20;

struct LCHArray {
    LCHObject _super;
    void *_array[kLCHArrayElementsLimit];
};

static
void LCHArrayRemoveAllElements(LCHArray *object);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHArrayDeallocate(void *object) {
    LCHArrayRemoveAllElements(object);
    __LCHObjectDeallocate(object);
}

LCHArray *LCHArrayCreate(void) {
    return LCHObjectCreateOfType(LCHArray);
}

#pragma mark -
#pragma mark Accessors

uint8_t LCHArrayCount(LCHArray *object) {
    uint8_t elementCount = 0;
    
    if (NULL != object) {
        for (uint8_t count = 0; count < kLCHArrayElementsLimit; count++) {
            if (NULL != object->_array[count]) {
                elementCount++;
            }
        }
    }
    
    return elementCount;
}

void *LCHArrayElement(LCHArray *object, uint8_t index) {
    LCHObjectIvarGetterSynthesize(object, object->_array[index], NULL)
}

#pragma mark -
#pragma mark Public Implementations

void LCHArrayAddElement(LCHArray *object, void *element) {
    if (NULL != object && NULL != element) {
        for (uint8_t index = 0; index < kLCHArrayElementsLimit; index++) {
            if (NULL == object->_array[index]) {
                object->_array[index] = element;
                LCHObjectRetain(element);
                
                return;
            }
        }
    }
}

void LCHArrayRemoveElement(LCHArray *object, uint8_t index) {
    if (NULL != object) {
        LCHObjectRelease(object->_array[index]);
        object->_array[index] = NULL;
    }
}

#pragma mark -
#pragma mark Private Implementations

void LCHArrayRemoveAllElements(LCHArray *object) {
    if (NULL != object) {
        for (uint8_t index = 0; index < kLCHArrayElementsLimit; index++) {
            void *element = LCHArrayElement(object, index);
            
            if (NULL != element) {
                LCHArrayRemoveElement(object, index);
            }
        }
    }
}
