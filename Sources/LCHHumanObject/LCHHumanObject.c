#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHObjectRetain(LCHHuman *object);

static
void LCHObjectRelease(LCHHuman *object);

static
void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender);

static
void LCHHumanSetAge(LCHHuman *object, uint8_t age);

static
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner);

#pragma mark -
#pragma mark Public Implementations

LCHHuman *LCHHumanCreate(LCHHumanGenderType gender) {
    LCHHuman *human = calloc(1, sizeof(LCHHuman));
    assert(NULL != human);
    
    LCHHumanSetGender(human, gender);
    LCHHumanSetAge(human, 1);
    
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

LCHHumanGenderType LCHHumanGender(LCHHuman *object) {
    return NULL != object ? object->_gender : LCHHumanGenderUnknown;
}

void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender) {
    if (NULL != object) {
        object->_gender = gender;
    }
}

uint8_t LCHHumanAge(LCHHuman *object) {
    return NULL != object ? object->_age : 0;
}

void LCHHumanSetAge(LCHHuman *object, uint8_t age) {
    if (NULL != object) {
        object->_age = age;
    }
}

uint8_t LCHHumanChildrenCount(LCHHuman *object) {
    return NULL != object ? object->_childrenCount : 0;
}

LCHHuman *LCHHumanPartner(LCHHuman *object) {
    return NULL != object ? object->_partner : NULL;
}

bool LCHHumanMarried(LCHHuman *object) {
    return NULL != object && NULL != object->_partner;
}

void LCHHumanSetMarry(LCHHuman *object, LCHHuman *partner) {
    if (NULL != object && NULL != partner) {
        LCHHumanSetDivorce(object, partner);
        
        LCHHumanSetPartner(object, partner);
        LCHHumanSetPartner(partner, object);
    }
}

void LCHHumanSetDivorce(LCHHuman *object, LCHHuman *partner) {
    if (NULL != object) {
        if (NULL != object->_partner) {
            LCHObjectRelease(object->_partner);
            LCHHumanSetPartner(object, NULL);
        }
    }
    
    if (NULL != partner) {
        if (NULL != partner->_partner) {
            LCHObjectRelease(partner->_partner);
            LCHHumanSetPartner(partner, NULL);
        }
    }
}

LCHHuman *LCHHumanMother(LCHHuman *object) {
    return NULL != object ? object->_mother : NULL;
}

void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother) {
    if (NULL != object && NULL != mother) {
        if (NULL != object->_mother) {
            // TODO: Decrement _childrenCount field of previous mother.
            // TODO: Set NULL to specific item in array _children of previous mother.
            LCHObjectRelease(object->_mother);
        }
        
        // TODO: Increment _childrenCount field of new mother.
        // TODO: Add child to specific item in array _children of new mother.
        object->_mother = mother;
        LCHObjectRetain(mother);
    }
}

LCHHuman *LCHHumanFather(LCHHuman *object) {
    return NULL != object ? object->_father : NULL;
}

void LCHHumanSetFather(LCHHuman *object, LCHHuman *father) {
    if (NULL != object && NULL != father) {
        if (NULL != object->_father) {
            // TODO: Decrement _childrenCount field of previous father.
            // TODO: Set NULL to specific item in array _children of previous father.
            LCHObjectRelease(object->_father);
        }
        
        // TODO: Increment _childrenCount field of new father.
        // TODO: Add child to specific item in array _children of new father.
        object->_father = father;
        LCHObjectRetain(father);
    }
}

LCHHuman *LCHHumanChildren(LCHHuman *object) {
    return *(NULL != object ? object->_children : NULL);
}

#pragma mark -
#pragma mark Private Implementations

void LCHObjectRetain(LCHHuman *object) {
    if (object) {
        object->_referenceCount++;
    }
}

void LCHObjectRelease(LCHHuman *object) {
    if (NULL != object) {
        if (0 == --(object->_referenceCount)) {
            _LCHHumanDeallocate(object);
        }
    }
}

void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner) {
    if (NULL != object) {
        if (NULL == partner) {
            object->_partner = NULL;
        } else {
            LCHObjectRelease(object->_partner);
            object->_partner = partner;
            LCHObjectRetain(partner);
        }
    }
}
