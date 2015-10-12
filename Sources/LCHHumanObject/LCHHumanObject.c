#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHObjectRetain(LCHHuman *object);

static
void LCHObjectRelease(LCHHuman *object);

static
void LCHHumanSetMaidenName(LCHHuman *object, char *maidenName);

static
void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender);

static
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner);

static
void LCHHumanSetRank(LCHHuman *object, uint8_t rank);

static
bool LCHHumanIsBabyPossible(LCHHuman *object, LCHHuman *partner);

static
bool LCHHumanIsLegalMarriage(LCHHuman *object, LCHHuman *partner);

#pragma mark -
#pragma mark Public Implementations

LCHHuman *LCHHumanCreate(LCHHumanGenderType gender) {
    LCHHuman *object = calloc(1, sizeof(LCHHuman));
    assert(NULL != object);
    
    uint8_t rank = arc4random_uniform(kLCHRankOfAwesomenessMax);
    
    LCHHumanSetGender(object, gender);
    LCHHumanSetAge(object, 1);
    LCHHumanSetRank(object, rank);
    
    return object;
}

LCHHuman *LCHHumanCreateWithParameters(LCHHumanGenderType gender,
                                       char *name,
                                       char *surname,
                                       uint8_t age,
                                       uint8_t rank
                                       )
{
    LCHHuman *object = calloc(1, sizeof(LCHHuman));
    assert(NULL != object);
    
    LCHHumanSetGender(object, gender);
    LCHHumanSetName(object, name);
    LCHHumanSetSurname(object, surname);
    LCHHumanSetAge(object, age);
    LCHHumanSetRank(object, rank);
    
    return object;
}

LCHHuman *LCHHumanCreateBabyWithParameters(LCHHumanGenderType gender,
                                           LCHHuman *mother,
                                           LCHHuman *father,
                                           char*name) {
    // TODO: Set correct retain to mother, father, child
    //       Add child to array with children
    assert(true == LCHHumanIsBabyPossible(mother, father));
    
    LCHHuman *object = calloc(1, sizeof(LCHHuman));
    assert(NULL != object);
    
    uint8_t rank = (mother->_rankOfAwesomeness + father->_rankOfAwesomeness) / 2;
    
    LCHHumanSetGender(object, gender);
    LCHHumanSetName(object, name);
    LCHHumanSetSurname(object, father->_surname);
    LCHHumanSetAge(object, 1);
    LCHHumanSetRank(object, rank);
    
    return object;
}

void _LCHHumanDeallocate(LCHHuman *object) {
    // TODO: set NULL to all pointer fields
    LCHHumanSetName(object, NULL);
    LCHHumanSetSurname(object, NULL);
    LCHHumanSetDivorce(object);
    
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
            LCHHumanSetMaidenName(object, surname);
        }
    }
}

char *LCHHumanMaidenName(LCHHuman *object) {
    return NULL != object ? object->_maidenName : NULL;
}

void LCHHumanSetMaidenName(LCHHuman *object, char *maidenName) {
    if (NULL != object && object->_gender == LCHHumanGenderFemale) {
        if (NULL == object->_maidenName && maidenName) {
            object->_maidenName = strdup(maidenName);
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
        if (age > object->_age && age <= kLCHAgeLimitMax) {
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

bool LCHHumanIsMarried(LCHHuman *object) {
    return NULL != object && NULL != object->_partner;
}

bool LCHHumanIsLegalMarriage(LCHHuman *object, LCHHuman *partner) {
    bool isLegal = false;
    
    if (NULL != object && NULL != partner) {
        if (object->_gender != partner->_gender) {
            if (kLCHAgeLimitMin <= object->_age && kLCHAgeLimitMax >= object->_age &&
                kLCHAgeLimitMin <= partner->_age && kLCHAgeLimitMax >= partner->_age) {
                if (NULL != object->_name && NULL != partner->_name) {
                    if (NULL != object->_surname && NULL != partner->_surname) {
                        if (object != partner->_partner) {
                            isLegal = true;
                        }
                    }
                }
            }
        }
    }
    
    return isLegal;
}

void LCHHumanSetMarry(LCHHuman *object, LCHHuman *partner) {
    // TODO: Set correct surname to partners
    //       Set wife surname equal to husband depends on rank
    if (NULL != object && NULL != partner) {
        if (true == LCHHumanIsLegalMarriage(object, partner)) {
            if (NULL != object->_partner) {
                LCHHumanSetDivorce(object);
            }
            
            if (NULL != partner->_partner) {
                LCHHumanSetDivorce(partner);
            }
    
            LCHHumanSetPartner(object, partner);
        }
    }
}

void LCHHumanSetDivorce(LCHHuman *object) {
    // TODO: Set correct surname to partners
    //       Set wife surname equal to her maidenName
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
            if (object->_rankOfAwesomeness > object->_partner->_rankOfAwesomeness) {
                object->_partner->_partner = NULL;
                LCHObjectRelease(object->_partner);
                object->_partner = NULL;
            }
            else if (object->_rankOfAwesomeness < object->_partner->_rankOfAwesomeness) {
                object->_partner->_partner = NULL;
                object->_partner = NULL;
                LCHObjectRelease(object);
            } else if (object->_rankOfAwesomeness == object->_partner->_rankOfAwesomeness) {
                if (object->_gender == LCHHumanGenderMale) {
                    object->_partner->_partner = NULL;
                    LCHObjectRelease(object->_partner);
                    object->_partner = NULL;
                } else if (object->_partner->_gender == LCHHumanGenderMale) {
                    object->_partner->_partner = NULL;
                    object->_partner = NULL;
                    LCHObjectRelease(object);
                }
            }
        }
        else {
            if (object->_rankOfAwesomeness > partner->_rankOfAwesomeness) {
                partner->_partner = object;
                LCHObjectRetain(partner);
                object->_partner = partner;
            } else if (object->_rankOfAwesomeness < partner->_rankOfAwesomeness) {
                object->_partner = partner;
                LCHObjectRetain(object);
                partner->_partner = object;
            } else if (object->_rankOfAwesomeness == partner->_rankOfAwesomeness) {
                if (object->_gender == LCHHumanGenderMale) {
                    partner->_partner = object;
                    LCHObjectRetain(partner);
                    object->_partner = partner;
                } else if (partner->_gender == LCHHumanGenderMale) {
                    object->_partner = partner;
                    LCHObjectRetain(object);
                    partner->_partner = object;
                }
            }
        }
    }
}

void LCHHumanSetRank(LCHHuman *object, uint8_t rank) {
    if (NULL != object) {
        object->_rankOfAwesomeness = kLCHRankOfAwesomenessMax >= rank ? rank : kLCHRankOfAwesomenessMax;
    }
}

bool LCHHumanIsBabyPossible(LCHHuman *object, LCHHuman *partner) {
    bool isPossible = false;
    
    if (NULL != object && NULL != partner) {
        if (object->_gender != partner->_gender) {
            if (kLCHAgeLimitMin <= object->_age && kLCHAgeLimitMax >= object->_age &&
                kLCHAgeLimitMin <= partner->_age && kLCHAgeLimitMax >= partner->_age) {
                if (object->_childrenCount < kLCHChildrenLimit && partner->_childrenCount < kLCHChildrenLimit) {
                    if (NULL != object->_surname && NULL != partner->_surname) {
                        isPossible = true;
                    }
                }
            }
        }
    }

    
    return isPossible;
}
