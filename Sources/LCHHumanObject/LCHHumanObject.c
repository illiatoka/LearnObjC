#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

#pragma mark -
#pragma mark Public Implementations

LCHHuman *LCHHumanCreate(void) {
    LCHHuman *human = malloc(sizeof(LCHHuman));
    assert(NULL != human);
    
    return human;
}

void _LCHHumanDeallocate(LCHHuman *object) {
    free(object);
}

char *LCHHumanName(LCHHuman *object) {
    return NULL != object ? object->_name : NULL;
}

char *LCHHumanSurname(LCHHuman *object) {
    return NULL != object ? object->_surname : NULL;
}
