#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

const uint8_t kLCHRankOfAwesomenessMax = 100;
const uint8_t kLCHChildrenLimit        = 20;
const uint8_t kLCHAgeInitial           = 1;
const uint8_t kLCHAgeLimitMin          = 18;
const uint8_t kLCHAgeLimitMax          = 75;

struct LCHHuman {
    char *_name;
    char *_surname;
    LCHHuman *_partner;
    LCHHuman *_mother;
    LCHHuman *_father;
    LCHHuman *_children[kLCHChildrenLimit];
    uint8_t _age;
    uint8_t _childrenCount;
    uint8_t _rankOfAwesomeness;
    LCHHumanGenderType _gender;
    
    uint64_t _referenceCount;
};

static
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner);

static
void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender);

static
void LCHHumanSetRank(LCHHuman *object, uint8_t rank);

static
bool LCHHumanIsAgeValid(LCHHuman *object);

static
bool LCHHumanAddChild(LCHHuman *object, LCHHuman *parent);

static
void LCHHumanRemoveChildren(LCHHuman *object);

static
void LCHHumanSetMother(LCHHuman *object, LCHHuman *father);

static
void LCHHumanSetFather(LCHHuman *object, LCHHuman *father);

static
bool LCHHumanShouldBeMarried(LCHHuman *object, LCHHuman *partner);

static
bool LCHHumanShouldCreateChild(LCHHuman *object, LCHHuman *partner);

// TODO: Give clear name for this method
static
LCHHuman *LCHHumanStatus(LCHHuman *object, LCHHuman *partner, LCHHumanStatusType status);

#pragma mark -
#pragma mark Public Implementations

void _LCHHumanDeallocate(LCHHuman *object) {
    LCHHumanSetName(object, NULL);
    LCHHumanSetSurname(object, NULL);
    LCHHumanDivorce(object);
    LCHHumanRemoveChildren(object);

    free(object);
}

LCHHuman *LCHHumanCreate(LCHHumanGenderType gender) {
    LCHHuman *object = calloc(1, sizeof(LCHHuman));
    assert(NULL != object);
    
    LCHHumanSetGender(object, gender);
    LCHHumanSetAge(object, kLCHAgeInitial);
    LCHHumanSetRank(object, arc4random_uniform(kLCHRankOfAwesomenessMax));
    LCHObjectRetain(object);
    
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

LCHHuman *LCHHumanCreateChildWithParameters(LCHHumanGenderType gender,
                                           LCHHuman *mother,
                                           LCHHuman *father,
                                           char*name)
{
    LCHHuman *redefinedFather = LCHHumanGender(father) == LCHHumanGenderMale ? father : mother;
    
    LCHHuman *child = (false == LCHHumanShouldCreateChild(mother, father)
                        ? NULL
                        : LCHHumanCreateWithParameters(gender,
                                                       name,
                                                       LCHHumanSurname(redefinedFather),
                                                       kLCHAgeInitial,
                                                       (LCHHumanRank(mother) + LCHHumanRank(father)) / 2));
    
    if (NULL != child) {
        LCHHumanAddChild(child, mother);
        LCHHumanAddChild(child, father);
    }
    
    return child;
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
            object->_surname = NULL;
        }
        
        if (surname) {
            object->_surname = strdup(surname);
        }
    }
}

LCHHumanGenderType LCHHumanGender(LCHHuman *object) {
    return NULL != object ? object->_gender : 0;
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

void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner) {
    LCHHuman *redefinedPartner = NULL == partner ? LCHHumanPartner(object) : partner;
    
    LCHHuman *master = LCHHumanStatus(object, redefinedPartner, LCHHumanStatusMaster);
    LCHHuman *slave = LCHHumanStatus(object, redefinedPartner, LCHHumanStatusSlave);
    
    if (NULL == partner) {
        slave->_partner = NULL;
        LCHObjectRelease(slave);
        master->_partner = NULL;
    } else {
        slave->_partner = master;
        LCHObjectRetain(slave);
        master->_partner = slave;
    }
}

bool LCHHumanIsMarried(LCHHuman *object) {
    return NULL != object && NULL != object->_partner;
}

uint8_t LCHHumanRank(LCHHuman *object) {
    return NULL != object ? object->_rankOfAwesomeness : 0;
}

void LCHHumanSetRank(LCHHuman *object, uint8_t rank) {
    if (NULL != object) {
        object->_rankOfAwesomeness = kLCHRankOfAwesomenessMax >= rank ? rank : kLCHRankOfAwesomenessMax;
    }
}

void LCHHumanMarry(LCHHuman *object, LCHHuman *partner) {
    if (NULL != object && NULL != partner) {
        if (true == LCHHumanShouldBeMarried(object, partner)) {
            LCHHumanDivorce(object);
            LCHHumanDivorce(partner);
    
            LCHHumanSetPartner(object, partner);
        }
    }
}

void LCHHumanDivorce(LCHHuman *object) {
    if (NULL != object && NULL != LCHHumanPartner(object)) {
        LCHHumanSetPartner(object, NULL);
    }
}

LCHHuman *LCHHumanMother(LCHHuman *object) {
    return NULL != object ? object->_mother : NULL;
}

void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother) {
    if (NULL != object) {
        object->_mother = mother;
    }
}

LCHHuman *LCHHumanFather(LCHHuman *object) {
    return NULL != object ? object->_father : NULL;
}

void LCHHumanSetFather(LCHHuman *object, LCHHuman *father) {
    if (NULL != object) {
        object->_father = father;
    }
}

uint64_t LCHHumanReferenceCount(LCHHuman *object) {
    return NULL != object ? object->_referenceCount : 0;
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

bool LCHHumanAddChild(LCHHuman *object, LCHHuman *parent) {
    bool result = false;
    
    if (object != NULL) {
        if (LCHHumanGenderFemale == LCHHumanGender(parent)) {
            LCHHumanSetMother(object, parent);
        } else if (LCHHumanGenderMale == LCHHumanGender(parent)) {
            LCHHumanSetFather(object, parent);
        }
        
        for (uint8_t count = 0; count < kLCHChildrenLimit; count++) {
            if (NULL == parent->_children[count]) {
                parent->_children[count] = object;
                parent->_childrenCount++;
                LCHObjectRetain(object);
                
                return result;
            }
        }
    }
    
    return result;
}

void LCHHumanRemoveChildren(LCHHuman *object) {
    if (NULL != object) {
        for (uint8_t count = 0; count < kLCHChildrenLimit; count++) {
            LCHHuman *child = object->_children[count];
            if (NULL != child) {
                if (LCHHumanGenderFemale == LCHHumanGender(object)) {
                    LCHHumanSetMother(child, NULL);
                } else if (LCHHumanGenderMale == LCHHumanGender(object)) {
                    LCHHumanSetFather(child, NULL);
                }
                
                LCHObjectRelease(child);
                child = NULL;
                object->_childrenCount--;
            }
        }
    }
}

bool LCHHumanShouldBeMarried(LCHHuman *object, LCHHuman *partner) {
    bool result = false;
    
    if (NULL != object && NULL != partner) {
        if (LCHHumanGender(object) != LCHHumanGender(partner)) {
            if (LCHHumanIsAgeValid(object) && LCHHumanIsAgeValid(partner)) {
                result = LCHHumanPartner(object) != partner;
            }
        }
    }
    
    return result;
}

bool LCHHumanShouldCreateChild(LCHHuman *object, LCHHuman *partner) {
    bool result = false;
    
    if (NULL != object && NULL != partner) {
        if (LCHHumanGender(object) != LCHHumanGender(partner)) {
            if (LCHHumanIsAgeValid(object) && LCHHumanIsAgeValid(partner)) {
                result = kLCHChildrenLimit > LCHHumanChildrenCount(object)
                         && kLCHChildrenLimit > LCHHumanChildrenCount(partner);
            }
        }
    }
    
    return result;
}

// TODO: Give clear name for this method
LCHHuman *LCHHumanStatus(LCHHuman *object, LCHHuman *partner, LCHHumanStatusType status) {
    uint8_t objectRank = LCHHumanRank(object);
    uint8_t partnerRank = LCHHumanRank(partner);
    
    LCHHuman *master = objectRank > partnerRank
                        ? object
                        : objectRank < partnerRank
                            ? partner
                            : LCHHumanGenderMale == LCHHumanGender(object)
                                ? object
                                : partner;
    
    LCHHuman *slave = object == master ? partner : object;
    
    return LCHHumanStatusMaster == status ? master : slave;
}

bool LCHHumanIsAgeValid(LCHHuman *object) {
    return NULL != object && kLCHAgeLimitMin <= LCHHumanAge(object) && kLCHAgeLimitMax >= LCHHumanAge(object);
}
