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

LCHHuman *LCHHumanCreate(void) {
    LCHHuman *human = calloc(1, sizeof(LCHHuman));
    assert(NULL != human);
    
    uint8_t rank = rand() % 100 + 1;
    
    LCHHumanSetGender(human, LCHHumanGenderUnknown);
    LCHHumanSetAge(human, 1);
    LCHHumanSetRank(human, rank);
    
    return human;
}

LCHHuman *LCHHumanCreateWithParameters(LCHHumanGenderType gender, char *name, char *surname, uint8_t age, uint8_t rank) {
    LCHHuman *human = calloc(1, sizeof(LCHHuman));
    assert(NULL != human);
    
    LCHHumanSetGender(human, gender);
    LCHHumanSetName(human, name);
    LCHHumanSetSurname(human, surname);
    LCHHumanSetAge(human, age);
    LCHHumanSetRank(human, rank);
    
    return human;
}

void _LCHHumanDeallocate(LCHHuman *object) {
    // TODO: set NULL to all pointer fildes
    // LCHHumanSetName(object, NULL);
    
    free(object);
}

char *LCHHumanName(LCHHuman *object) {
    return NULL != object ? object->_name : NULL;
}

void LCHHumanSetName(LCHHuman *object, char *name) {
    if (NULL != object) {
        if (NULL != object->_name) {
            free(object->_name);
            object->_name = NULL;
        }
        
        if (name) {
            object->_name = strdup(name);
        }
    }
}

char *LCHHumanSurname(LCHHuman *object) {
    return NULL != object ? object->_surname : NULL;
}

void LCHHumanSetSurname(LCHHuman *object, char *surname) {
    if (NULL != object) {
        if (NULL != object->_surname) {
            free(object->_surname);
            object->_name = NULL;
        }
        
        if (surname) {
            object->_surname = strdup(surname);
        }
    }
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

void LCHHumanSetRank(LCHHuman *object, uint8_t rank) {
    if (NULL != object) {
        if (0 == object->_rankOfAwesomeness && 0 != rank) {
            object->_rankOfAwesomeness = rank;
        }
    }
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
