#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "LCHStringObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHString {
    LCHObject _super;
    char *_value;
};

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHStringDeallocate(void *object) {
    LCHStringSetValue(object, NULL);
    __LCHObjectDeallocate(object);
}

LCHString *LCHStringCreate(char *value) {
    LCHString *object = LCHObjectCreateOfType(LCHString);
    LCHStringSetValue(object, value);
    
    return object;
}

#pragma mark -
#pragma mark Accessors

char *LCHStringValue(LCHString *object) {
    LCHObjectIvarGetter(object, object->_value, NULL);
}

void LCHStringSetValue(LCHString *object, char *value) {
    if (object && value != object->_value) {
        if (object->_value) {
            free(object->_value);
            object->_value = NULL;
        }
        
        if (value) {
            object->_value = strdup(value);
        }
    }
}

#pragma mark -
#pragma mark Public Implementations

uint16_t LCHStringLength(LCHString *object) {
    return NULL != object ? strlen(LCHStringValue(object)) : 0;
}
