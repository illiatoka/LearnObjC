#include <stdlib.h>
#include <assert.h>
#include <string.h>

#include "LCHHumanObject.h"
#include "LCHObject.h"
#include "LCHArrayObject.h"

#pragma mark -
#pragma mark Private Declarations

const uint8_t kLCHRankOfAwesomenessMax = 100;
const uint8_t kLCHChildrenLimit        = 20;
const uint8_t kLCHAgeInitial           = 1;
const uint8_t kLCHAgeLimitMin          = 18;
const uint8_t kLCHAgeLimitMax          = 75;

struct LCHHuman {
    LCHObject _super;
    LCHString *_name;
    LCHString *_surname;
    LCHHuman *_partner;
    LCHHuman *_mother;
    LCHHuman *_father;
    LCHArray *_children;
    uint8_t _age;
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
void LCHHumanAddChild(LCHHuman *object, LCHHuman *child, LCHArray *children);

static
void LCHHumanRemoveChildren(LCHHuman *object);

static
void LCHHumanSetParent(LCHHuman *object, LCHHuman *parent);

static
void LCHHumanSetFather(LCHHuman *object, LCHHuman *father);

static
void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother);

static
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner, bool beMarried);

static
bool LCHHumanShouldBeMarried(LCHHuman *object, LCHHuman *partner);

static
bool LCHHumanShouldCreateChild(LCHHuman *object, LCHHuman *partner);

static
LCHHuman *LCHHumanWithStatusMaster(LCHHuman *object, LCHHuman *partner);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHHumanDeallocate(void *object) {
    LCHHumanSetName(object, NULL);
    LCHHumanSetSurname(object, NULL);
    LCHHumanDivorce(object);
    LCHHumanRemoveChildren(object);

    __LCHObjectDeallocate(object);
}

LCHHuman *LCHHumanCreateWithGender(LCHHumanGenderType gender) {
    LCHHuman *object = LCHObjectCreateOfType(LCHHuman);
    
    LCHHumanSetGender(object, gender);
    LCHHumanSetAge(object, kLCHAgeInitial);
    LCHHumanSetRank(object, arc4random_uniform(kLCHRankOfAwesomenessMax));
    
    return object;
}

LCHHuman *LCHHumanCreateWithParameters(LCHHumanGenderType gender,
                                       LCHString *name,
                                       LCHString *surname,
                                       uint8_t age,
                                       uint8_t rank)
{
    LCHHuman *object = LCHHumanCreateWithGender(gender);
    
    LCHHumanSetName(object, name);
    LCHHumanSetSurname(object, surname);
    LCHHumanSetAge(object, age);
    LCHHumanSetRank(object, rank);
    
    return object;
}

LCHHuman *LCHHumanCreateChildWithParameters(LCHHumanGenderType gender,
                                           LCHHuman *mother,
                                           LCHHuman *father,
                                           LCHString *name,
                                           LCHArray *motherChildren,
                                           LCHArray *fatherChildren)
{
    LCHHuman *child = NULL;
    
    if (true == LCHHumanShouldCreateChild(mother, father)) {
        LCHHuman *redefinedFather = LCHHumanGender(father) == kLCHHumanGenderMale ? father : mother;
        
        child = LCHHumanCreateWithParameters(gender,
                                             name,
                                             LCHHumanSurname(redefinedFather),
                                             kLCHAgeInitial,
                                             (LCHHumanRank(mother) + LCHHumanRank(father)) / 2);
        
        LCHHumanAddChild(mother, child, motherChildren);
        LCHHumanAddChild(father, child, fatherChildren);
    }
    
    return child;
}

#pragma mark -
#pragma mark Accessors

LCHString *LCHHumanName(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_name, NULL)
}

void LCHHumanSetName(LCHHuman *object, LCHString *name) {
    LCHObjectRetainSetter(object, _name, name);
}

LCHString *LCHHumanSurname(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_surname, NULL)
}

void LCHHumanSetSurname(LCHHuman *object, LCHString *surname) {
    LCHObjectRetainSetter(object, _surname, surname);
}

LCHHumanGenderType LCHHumanGender(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_gender, 0)
}

void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender) {
    LCHObjectAssignSetter(object, _gender, gender)
}

uint8_t LCHHumanAge(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_age, 0)
}

void LCHHumanSetAge(LCHHuman *object, uint8_t age) {
    if (NULL != object) {
        if (age > object->_age && age <= kLCHAgeLimitMax ? age : kLCHAgeLimitMax) {
            object->_age = age;
        }
    }
}

LCHArray *LCHHumanChildren(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_children, NULL)
}

LCHHuman *LCHHumanPartner(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_partner, NULL)
}

bool LCHHumanIsMarried(LCHHuman *object) {
    return NULL != object && NULL != object->_partner;
}

uint8_t LCHHumanRank(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_rankOfAwesomeness, 0)
}

void LCHHumanSetRank(LCHHuman *object, uint8_t rank) {
    if (NULL != object) {
        object->_rankOfAwesomeness = kLCHRankOfAwesomenessMax >= rank ? rank : kLCHRankOfAwesomenessMax;
    }
}

LCHHuman *LCHHumanMother(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_mother, NULL)
}

void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother) {
    LCHObjectAssignSetter(object, _mother, mother)
}

LCHHuman *LCHHumanFather(LCHHuman *object) {
    LCHObjectIvarGetterSynthesize(object, object->_father, NULL)
}

void LCHHumanSetFather(LCHHuman *object, LCHHuman *father) {
    LCHObjectAssignSetter(object, _father, father)
}

void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner, bool beMarried) {
    LCHHuman *master = LCHHumanWithStatusMaster(object, partner);
    LCHHuman *slave = master == object ? partner : object;
    
    slave->_partner = beMarried ? master : NULL;
    beMarried ? LCHObjectRetain(slave) : LCHObjectRelease(slave);
    master->_partner = beMarried ? slave : NULL;
}

#pragma mark -
#pragma mark Public Implementations

void LCHHumanMarry(LCHHuman *object, LCHHuman *partner) {
    if (NULL != object && NULL != partner) {
        if (true == LCHHumanShouldBeMarried(object, partner)) {
            LCHHumanDivorce(object);
            LCHHumanDivorce(partner);
            
            LCHHumanSetPartner(object, partner, true);
        }
    }
}

void LCHHumanDivorce(LCHHuman *object) {
    LCHHuman *partner = LCHHumanPartner(object);
    
    if (NULL != object && NULL != partner) {
        LCHHumanSetPartner(object, partner, false);
    }
}

#pragma mark -
#pragma mark Private Implementations

void LCHHumanSetParent(LCHHuman *object, LCHHuman *parent) {
    if (kLCHHumanGenderMale == LCHHumanGender(parent)) {
        LCHHumanSetFather(object, parent);
    } else {
        LCHHumanSetMother(object, parent);
    }
}

void LCHHumanAddChild(LCHHuman *object, LCHHuman *child, LCHArray *children) {
    if (object != NULL && child != NULL) {
        LCHArray *objectArray = LCHHumanChildren(object);
        LCHArray *array = NULL == objectArray ? children : objectArray;
        
        if (NULL == objectArray) {
            LCHObjectRetain(array);
            object->_children = array;
        }

        LCHHumanSetParent(child, object);
        LCHArrayAddElement(array, child);
    }
}

void LCHHumanRemoveChildren(LCHHuman *object) {
    if (NULL != object) {
        LCHArray *array = LCHHumanChildren(object);
        
        if (NULL != array) {
            for (uint8_t index = 0; index < kLCHChildrenLimit; index++) {
                LCHHuman *child = LCHArrayElement(array, index);
                
                if (NULL != child) {
                    LCHHumanSetParent(child, NULL);
                }
            }
            
            LCHObjectRelease(array);
            object->_children = NULL;
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
            && kLCHChildrenLimit > LCHArrayCount(LCHHumanChildren(object))
            && kLCHChildrenLimit > LCHArrayCount(LCHHumanChildren(partner)));
}

LCHHuman *LCHHumanWithStatusMaster(LCHHuman *object, LCHHuman *partner) {
    uint8_t objectRank = LCHHumanRank(object);
    uint8_t partnerRank = LCHHumanRank(partner);
    
    LCHHuman *master = NULL;
    
    if (objectRank > partnerRank) {
        master = object;
    } else if (objectRank < partnerRank) {
        master = partner;
    } else {
        master = kLCHHumanGenderMale == LCHHumanGender(object) ? object : partner;
    }
    
    return master;
}

bool LCHHumanIsAgeValid(LCHHuman *object) {
    return NULL != object && kLCHAgeLimitMin <= LCHHumanAge(object) && kLCHAgeLimitMax >= LCHHumanAge(object);
}
