#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHObjectRetain(LCHHuman *object);

static
void LCHObjectRelease(LCHHuman *object);

static
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner);

static
void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender);

static
void LCHHumanSetRank(LCHHuman *object, uint8_t rank);

static
bool LCHHumanShouldBeMarried(LCHHuman *object, LCHHuman *partner);

static
bool LCHHumanShouldCreateChild(LCHHuman *object, LCHHuman *partner);

#pragma mark -
#pragma mark Public Implementations

void _LCHHumanDeallocate(LCHHuman *object) {
    // TODO: Set NULL to all pointer fields
    //       Send release to all retained object
    LCHHumanSetName(object, NULL);
    LCHHumanSetSurname(object, NULL);
    LCHHumanDivorce(object);
    
    free(object);
}

LCHHuman *LCHHumanCreate(LCHHumanGenderType gender) {
    LCHHuman *object = calloc(1, sizeof(LCHHuman));
    assert(NULL != object);
    
    LCHHumanSetGender(object, gender);
    LCHHumanSetAge(object, 1);
    LCHHumanSetRank(object, arc4random_uniform(kLCHRankOfAwesomenessMax));
    
    return object;
}

LCHHuman *LCHHumanCreateWithParameters(LCHHumanGenderType gender,
                                       char *name,
                                       char *surname,
                                       uint8_t age,
                                       uint8_t rank)
{
    LCHHuman *object = LCHHumanCreate(gender);

    LCHHumanSetName(object, name);
    LCHHumanSetSurname(object, surname);
    LCHHumanSetAge(object, age);
    LCHHumanSetRank(object, rank);
    
    return object;
}

// TODO: Ask about where should I implement this methods
//       Add child to mother/father children array
//       Retain/release for children/parrents
LCHHuman *LCHHumanCreateChildWithParameters(LCHHumanGenderType gender,
                                           LCHHuman *mother,
                                           LCHHuman *father,
                                           char*name)
{
    // TODO: Ask about better way to perform this check
    if (false == LCHHumanShouldCreateChild(mother, father)) {
        return NULL;
    }
    
    LCHHuman *object = LCHHumanCreate(gender);
    
    LCHHumanSetName(object, name);
    LCHHumanSetSurname(object, LCHHumanSurname(father));
    LCHHumanSetAge(object, 1);
    LCHHumanSetRank(object, (LCHHumanRank(mother) + LCHHumanRank(father)) / 2);
        
    return object;
}

#pragma mark -
#pragma mark Accessors

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
        
        if (LCHHumanGenderFemale == LCHHumanGender(object) && NULL == LCHHumanMaidenName(object)) {
            object->_maidenName = strdup(surname);
        }
    }
}

char *LCHHumanMaidenName(LCHHuman *object) {
    return NULL != object ? object->_maidenName : NULL;
}

LCHHumanGenderType LCHHumanGender(LCHHuman *object) {
    return NULL != object ? object->_gender : LCHHumanGenderUnknown;
}

uint8_t LCHHumanAge(LCHHuman *object) {
    return NULL != object ? object->_age : 0;
}

void LCHHumanSetAge(LCHHuman *object, uint8_t age) {
    if (NULL != object) {
        if (age > object->_age && age <= kLCHAgeLimitMax ? age : kLCHAgeLimitMax) {
            object->_age = age;
        }
    }
}

uint8_t LCHHumanChildrenCount(LCHHuman *object) {
    return NULL != object ? object->_childrenCount : 0;
}

LCHHuman *LCHHumanPartner(LCHHuman *object) {
    return NULL != object ? object->_partner : NULL;
}

// TODO: Ask about name for method
bool LCHHumanIsMarried(LCHHuman *object) {
    return NULL != object && NULL != object->_partner;
}

uint8_t LCHHumanRank(LCHHuman *object) {
    return NULL != object ? object->_rankOfAwesomeness : 0;
}

void LCHHumanMarry(LCHHuman *object, LCHHuman *partner) {
    // TODO: Set correct surname to partners
    //       Set wife surname equal to husband depends on rank
    //       Check logic
    if (NULL != object && NULL != partner) {
        if (true == LCHHumanShouldBeMarried(object, partner)) {
            if (NULL != object->_partner) {
                LCHHumanDivorce(object);
            }
            
            if (NULL != partner->_partner) {
                LCHHumanDivorce(partner);
            }
    
            LCHHumanSetPartner(object, partner);
        }
    }
}

void LCHHumanDivorce(LCHHuman *object) {
    // TODO: Set correct surname to partners
    //       Set wife surname equal to her maidenName
    //       Check logic
    if (NULL != object) {
        if (NULL != object->_partner) {
            LCHHumanSetPartner(object, NULL);
        }
    }
}

LCHHuman *LCHHumanMother(LCHHuman *object) {
    return NULL != object ? object->_mother : NULL;
}

void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother) {
    // TODO: Check logic
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
    // TODO: Check logic
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

// TODO: Refactor this shit
//       Ask about better way to perform set-partner method
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner) {
    if (NULL != object) {
        
        if (NULL == partner) {
            if (LCHHumanRank(object) > LCHHumanRank(object->_partner)) {
                object->_partner->_partner = NULL;
                LCHObjectRelease(object->_partner);
                object->_partner = NULL;
            } else if (LCHHumanRank(object) < LCHHumanRank(object->_partner)) {
                object->_partner->_partner = NULL;
                object->_partner = NULL;
                LCHObjectRelease(object);
            } else {
                if (LCHHumanGenderMale == LCHHumanGender(object)) {
                    object->_partner->_partner = NULL;
                    LCHObjectRelease(object->_partner);
                    object->_partner = NULL;
                } else if (LCHHumanGenderMale == LCHHumanGender(object->_partner)) {
                    object->_partner->_partner = NULL;
                    object->_partner = NULL;
                    LCHObjectRelease(object);
                }
            }
        } else {
            if (LCHHumanRank(object) > LCHHumanRank(partner)) {
                partner->_partner = object;
                LCHObjectRetain(partner);
                object->_partner = partner;
            } else if (LCHHumanRank(object) < LCHHumanRank(partner)) {
                object->_partner = partner;
                LCHObjectRetain(object);
                partner->_partner = object;
            } else {
                if (LCHHumanGenderMale == LCHHumanGender(object)) {
                    partner->_partner = object;
                    LCHObjectRetain(partner);
                    object->_partner = partner;
                } else if (LCHHumanGenderMale == LCHHumanGender(partner)) {
                    object->_partner = partner;
                    LCHObjectRetain(object);
                    partner->_partner = object;
                }
            }
        }
    }
}

void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender) {
    if (NULL != object) {
        object->_gender = gender;
    }
}

void LCHHumanSetRank(LCHHuman *object, uint8_t rank) {
    if (NULL != object) {
        object->_rankOfAwesomeness = kLCHRankOfAwesomenessMax >= rank ? rank : kLCHRankOfAwesomenessMax;
    }
}

bool LCHHumanShouldBeMarried(LCHHuman *object, LCHHuman *partner) {
    bool result = false;
    
    if (NULL != object && NULL != partner) {
        if (LCHHumanGender(object) != LCHHumanGender(partner)) {
            if ((kLCHAgeLimitMin <= LCHHumanAge(object) && kLCHAgeLimitMax >= LCHHumanAge(object))
                && (kLCHAgeLimitMin <= LCHHumanAge(partner) && kLCHAgeLimitMax >= LCHHumanAge(partner)))
            {
                result = object != LCHHumanPartner(object);
            }
        }
    }
    
    return result;
}

bool LCHHumanShouldCreateChild(LCHHuman *object, LCHHuman *partner) {
    bool result = false;
    
    if (NULL != object && NULL != partner) {
        if (LCHHumanGender(object) != LCHHumanGender(partner)) {
            if ((kLCHAgeLimitMin <= LCHHumanAge(object) && kLCHAgeLimitMax >= LCHHumanAge(object))
                && (kLCHAgeLimitMin <= LCHHumanAge(partner) && kLCHAgeLimitMax >= LCHHumanAge(partner)))
            {
                result = kLCHChildrenLimit > LCHHumanChildrenCount(object)
                             && kLCHChildrenLimit > LCHHumanChildrenCount(partner);
            }
        }
    }
    
    return result;
}
