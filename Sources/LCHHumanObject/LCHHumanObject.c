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
    LCHHumanGenderType _gender;
    uint8_t _age;
    uint8_t _rankOfAwesomeness;
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
void LCHHumanSetChildren(LCHHuman *object, LCHArray *array);

static
void LCHHumanRemoveAllChildren(LCHHuman *object);

static
void LCHHumanSetFather(LCHHuman *object, LCHHuman *father);

static
void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother);

static
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner);

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
    LCHHumanRemoveAllChildren(object);
    LCHHumanSetChildren(object, NULL);

    __LCHObjectDeallocate(object);
}

LCHHuman *LCHHumanCreateWithGender(LCHHumanGenderType gender) {
    LCHHuman *object = LCHObjectCreateOfType(LCHHuman);
    LCHArray *array = LCHArrayCreate();
    
    LCHHumanSetChildren(object, array);
    LCHHumanSetGender(object, gender);
    LCHHumanSetAge(object, kLCHAgeInitial);
    LCHHumanSetRank(object, arc4random_uniform(kLCHRankOfAwesomenessMax));
    
    LCHObjectRelease(array);
    
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
                                           LCHString *name)
{
    LCHHuman *child = NULL;
    
    if (true == LCHHumanShouldCreateChild(mother, father)) {
        LCHHuman *redefinedFather = LCHHumanGender(father) == kLCHHumanGenderMale ? father : mother;
        
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

LCHString *LCHHumanName(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_name, NULL);
}

void LCHHumanSetName(LCHHuman *object, LCHString *name) {
    LCHObjectRetainSetter(object, _name, name);
}

LCHString *LCHHumanSurname(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_surname, NULL);
}

void LCHHumanSetSurname(LCHHuman *object, LCHString *surname) {
    LCHObjectRetainSetter(object, _surname, surname);
}

LCHHumanGenderType LCHHumanGender(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_gender, 0);
}

void LCHHumanSetGender(LCHHuman *object, LCHHumanGenderType gender) {
    LCHObjectAssignSetter(object, _gender, gender);
}

uint8_t LCHHumanAge(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_age, 0);
}

void LCHHumanSetAge(LCHHuman *object, uint8_t age) {
    if (NULL != object) {
        object->_age = (age >= object->_age && age <= kLCHAgeLimitMax) ? age : kLCHAgeLimitMax;
    }
}

LCHArray *LCHHumanChildren(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_children, NULL);
}

void LCHHumanSetChildren(LCHHuman *object, LCHArray *array) {
    LCHObjectRetainSetter(object, _children, array);
}

LCHHuman *LCHHumanPartner(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_partner, NULL);
}

void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner) {
    LCHHuman *redefinedPartner = partner ? partner : LCHHumanPartner(object);
    LCHHuman *master = LCHHumanWithStatusMaster(object, redefinedPartner);
    LCHHuman *slave = master == object ? redefinedPartner : object;
    
    if (partner) {
        slave->_partner = master;
        LCHObjectRetain(slave);
        master->_partner = slave;
    } else {
        slave->_partner = NULL;
        LCHObjectRelease(slave);
        master->_partner = NULL;
    }
}

bool LCHHumanIsMarried(LCHHuman *object) {
    return NULL != object && LCHHumanPartner(object);
}

uint8_t LCHHumanRank(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_rankOfAwesomeness, 0);
}

void LCHHumanSetRank(LCHHuman *object, uint8_t rank) {
    if (NULL != object) {
        object->_rankOfAwesomeness = kLCHRankOfAwesomenessMax >= rank ? rank : kLCHRankOfAwesomenessMax;
    }
}

LCHHuman *LCHHumanMother(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_mother, NULL);
}

void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother) {
    LCHObjectAssignSetter(object, _mother, mother);
}

LCHHuman *LCHHumanFather(LCHHuman *object) {
    LCHObjectIvarGetter(object, object->_father, NULL);
}

void LCHHumanSetFather(LCHHuman *object, LCHHuman *father) {
    LCHObjectAssignSetter(object, _father, father);
}

#pragma mark -
#pragma mark Public Implementations

void LCHHumanMarry(LCHHuman *object, LCHHuman *partner) {
    if (object && partner && LCHHumanShouldBeMarried(object, partner)) {
        LCHHumanDivorce(object);
        LCHHumanDivorce(partner);
        
        LCHHumanSetPartner(object, partner);
    }
}

void LCHHumanDivorce(LCHHuman *object) {
    if (object && LCHHumanPartner(object)) {
        LCHHumanSetPartner(object, NULL);
    }
}

#pragma mark -
#pragma mark Private Implementations

void LCHHumanAddChild(LCHHuman *object, LCHHuman *child) {
    if (object && child) {
        LCHArrayAddObject(LCHHumanChildren(object), child);
        
        if (kLCHHumanGenderMale == LCHHumanGender(object)) {
            LCHHumanSetFather(child, object);
        } else {
            LCHHumanSetMother(child, object);
        }
    }
}

void LCHHumanRemoveChild(LCHHuman *object, LCHHuman *child) {
    if (object && child) {
        LCHArrayRemoveObject(LCHHumanChildren(object), child);
        
        if (kLCHHumanGenderMale == LCHHumanGender(object)) {
            LCHHumanSetFather(child, NULL);
        } else {
            LCHHumanSetMother(child, NULL);
        }
    }
}

void LCHHumanRemoveAllChildren(LCHHuman *object) {
    if (NULL != object) {
        LCHArray *children = LCHHumanChildren(object);
        
        for (uint64_t index = 0; index < LCHArrayCount(children); index++) {
            LCHHumanRemoveChild(object, LCHArrayObjectAtIndex(children, index));
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
