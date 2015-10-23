#include "LCHStringObject.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHString {
    LCHObject _super;
    char *_name;
    char *_surname;
};

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHStringDeallocate(void *object) {
    LCHStringSetName(object, NULL);
    LCHStringSetSurname(object, NULL);
    
    __LCHObjectDeallocate(object);
}

LCHString *LCHStringCreate(void) {
    return LCHObjectCreateOfType(LCHString);
}

#pragma mark -
#pragma mark Accessors

char *LCHStringName(LCHString *object) {
    LCHObjectIvarGetterSynthesize(object, _name, NULL)
}

void LCHStringSetName(LCHString *object, char *name) {
    LCHObjectIvarStringSetterSynthesize(object, _name, name)
}

char *LCHStringSurname(LCHString *object) {
    LCHObjectIvarGetterSynthesize(object, _surname, NULL)
}

void LCHStringSetSurname(LCHString *object, char *surname) {
    LCHObjectIvarStringSetterSynthesize(object, _surname, surname)
}

#pragma mark -
#pragma mark Public Implementations

void LCHStringPrintValue(char *value) {
    puts(value);
}
