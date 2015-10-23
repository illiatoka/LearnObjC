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

LCHString *LCHStringCreate(void) {
    return LCHObjectCreateOfType(LCHString);
}

#pragma mark -
#pragma mark Accessors

char *LCHStringValue(LCHString *object) {
    LCHObjectIvarGetterSynthesize(object, object->_value, NULL)
}

void LCHStringSetValue(LCHString *object, char *value) {
    LCHObjectIvarStringSetterSynthesize(object, _value, value)
}

#pragma mark -
#pragma mark Public Implementations

void LCHStringPrintValue(char *value) {
    puts(value);
}
