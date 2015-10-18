#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

const uint8_t kLCHRankOfAwesomenessMax = 100;
const uint8_t kLCHChildrenLimit        = 20;
const uint8_t kLCHAgeInitial           = 1;
const uint8_t kLCHAgeLimitMin          = 18;
const uint8_t kLCHAgeLimitMax          = 75;

struct LCHHuman {
    LCHObject _super;
    
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
};

static
void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender);

static
void LCHHumanSetRank(LCHHuman *object, uint8_t rank);

static
bool LCHHumanIsAgeValid(LCHHuman *object);

static
void LCHHumanAddChild(LCHHuman *object, LCHHuman *child);

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

static
LCHHuman *LCHHumanWithStatusMaster(LCHHuman *object, LCHHuman *partner);

#pragma mark -
#pragma mark Public Implementations

void _LCHHumanDeallocate(void *object) {
    LCHHumanSetName(object, NULL);
    LCHHumanSetSurname(object, NULL);
    LCHHumanDivorce(object);
    LCHHumanRemoveChildren(object);

    _LCHObjectDeallocate(object);
}

LCHHuman *LCHHumanCreate(LCHHumanGenderType gender) {
    LCHHuman *object = LCHObjectCreateOfType(LCHHuman);
    
    LCHHumanSetGender(object, gender);
    LCHHumanSetAge(object, kLCHAgeInitial);
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

LCHHuman *LCHHumanCreateChildWithParameters(LCHHumanGenderType gender,
                                           LCHHuman *mother,
                                           LCHHuman *father,
                                           char*name)
{
    LCHHuman *child = NULL;
    
    if (true == LCHHumanShouldCreateChild(mother, father)) {
        LCHHuman *redefinedFather = LCHHumanGender(father) == LCHHumanGenderMale ? father : mother;
        
        child = LCHHumanCreateWithParameters(gender,
                                             name,
                                             LCHHumanSurname(redefinedFather),
                                             kLCHAgeInitial,
                                             (LCHHumanRank(mother) + LCHHumanRank(father)) / 2);
        
        LCHHumanAddChild(mother, child);
        LCHHumanAddChild(father, child);
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
            LCHHuman *master = LCHHumanWithStatusMaster(object, partner);
            LCHHuman *slave = master == object ? partner : object;
            
            LCHHumanDivorce(object);
            LCHHumanDivorce(partner);
    
            slave->_partner = master;
            LCHObjectRetain(slave);
            master->_partner = slave;
        }
    }
}

void LCHHumanDivorce(LCHHuman *object) {
    if (NULL != object && NULL != LCHHumanPartner(object)) {
        LCHHuman *master = LCHHumanWithStatusMaster(object, object->_partner);
        LCHHuman *slave = master == object ? object->_partner : object;
        
        slave->_partner = NULL;
        LCHObjectRelease(slave);
        master->_partner = NULL;
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

#pragma mark -
#pragma mark Private Implementations

void LCHHumanAddChild(LCHHuman *object, LCHHuman *child) {
    if (object != NULL) {
        if (LCHHumanGenderFemale == LCHHumanGender(object)) {
            LCHHumanSetMother(child, object);
        } else if (LCHHumanGenderMale == LCHHumanGender(object)) {
            LCHHumanSetFather(child, object);
        }
        
        for (uint8_t count = 0; count < kLCHChildrenLimit; count++) {
            if (NULL == object->_children[count]) {
                object->_children[count] = child;
                object->_childrenCount++;
                LCHObjectRetain(child);
                
                break;
            }
        }
    }
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
                object->_children[count] = NULL;
                object->_childrenCount--;
            }
        }
    }
}

bool LCHHumanShouldBeMarried(LCHHuman *object, LCHHuman *partner) {
    return (NULL != object
            && NULL != partner
            && LCHHumanGender(object) != LCHHumanGender(partner)
            && LCHHumanIsAgeValid(object)
            && LCHHumanIsAgeValid(partner)
            && LCHHumanPartner(object) != partner);
}

bool LCHHumanShouldCreateChild(LCHHuman *object, LCHHuman *partner) {
    return (NULL != object
            && NULL != partner
            && LCHHumanGender(object) != LCHHumanGender(partner)
            && LCHHumanIsAgeValid(object)
            && LCHHumanIsAgeValid(partner)
            && kLCHChildrenLimit > LCHHumanChildrenCount(object)
            && kLCHChildrenLimit > LCHHumanChildrenCount(partner));
}

LCHHuman *LCHHumanWithStatusMaster(LCHHuman *object, LCHHuman *partner) {
    uint8_t objectRank = LCHHumanRank(object);
    uint8_t partnerRank = LCHHumanRank(partner);
    
    return objectRank > partnerRank
            ? object
            : objectRank < partnerRank
            ? partner
            : LCHHumanGenderMale == LCHHumanGender(object)
            ? object
            : partner;
}

bool LCHHumanIsAgeValid(LCHHuman *object) {
    return NULL != object && kLCHAgeLimitMin <= LCHHumanAge(object) && kLCHAgeLimitMax >= LCHHumanAge(object);
}
