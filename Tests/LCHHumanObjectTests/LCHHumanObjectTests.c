#include <assert.h>
#include <string.h>

#include "LCHHumanObjectTests.h"
#include "LCHHumanObject.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

static
void LCHHumanObjectCreateTests(void);

static
void LCHHumanObjectCreateWithParametersTests(void);

static
void LCHHumanObjectMarriedTests(void);

static
void LCHHumanObjectCreateChildTests(void);

static
void LCHHumanObjectRandomTests(void);

#pragma mark -
#pragma mark Public Implementations

void LCHPerformHumanObjectTests(void) {
    LCHHumanObjectCreateTests();
    LCHHumanObjectCreateWithParametersTests();
    LCHHumanObjectCreateChildTests();
    LCHHumanObjectMarriedTests();
    LCHHumanObjectRandomTests();
}

void LCHHumanObjectCreateTests(void) {
    // Create default Human object with gender Male
    LCHHuman *male = LCHHumanCreateWithGender(kLCHHumanGenderMale);
    
    // After Human male object was created:
    // Object must not be NULL
    assert(NULL != male);
    
    // Object must have Male gender
    assert(kLCHHumanGenderMale == LCHHumanGender(male));
    
    // Object name must be NULL
    assert(NULL == LCHHumanName(male));
    
    // Object surname must be NULL
    assert(NULL == LCHHumanSurname(male));
    
    // Object must not be married
    assert(false == LCHHumanIsMarried(male));
    
    // Object must not have partner
    assert(NULL == LCHHumanPartner(male));
    
    // Object must not have mother
    assert(NULL == LCHHumanMother(male));
    
    // Object must not have father
    assert(NULL == LCHHumanFather(male));
    
    // Object age must be equal to initial age
    assert(kLCHAgeInitial == LCHHumanAge(male));
    
    // Object children count must be equal to 0
    assert(0 == LCHArrayElementsCount(LCHHumanChildren(male)));
    
    // Object reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(male));
    
    LCHObjectRelease(male);
}

void LCHHumanObjectCreateWithParametersTests(void) {
    LCHString *femaleName = LCHStringCreate("Lucy");
    LCHString *femaleSurname = LCHStringCreate("Melof");
    
    // Create Human object with gender female and parameters
    LCHHuman *female = LCHHumanCreateWithParameters(kLCHHumanGenderFemale, femaleName, femaleSurname, 27, 93);
    
    // After Human male object was created:
    // Object must not be NULL
    assert(NULL != female);
    
    // Object must have Female gender
    assert(kLCHHumanGenderFemale == LCHHumanGender(female));
    
    // Object name must be equal to femaleName
    assert(femaleName == LCHHumanName(female));
    
    // Object surname must be equal to femaleSurname
    assert(femaleSurname == LCHHumanSurname(female));
    
    // Object must not be married
    assert(false == LCHHumanIsMarried(female));
    
    // Object must not have partner
    assert(NULL == LCHHumanPartner(female));
    
    // Object must not have mother
    assert(NULL == LCHHumanMother(female));
    
    // Object must not have father
    assert(NULL == LCHHumanFather(female));
    
    // Object age must be equal to age in arg
    assert(27 == LCHHumanAge(female));
    
    // Object children count must be equal to 0
    assert(0 == LCHArrayElementsCount(LCHHumanChildren(female)));
    
    // Object reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(female));
    
    LCHObjectRelease(female);
    LCHObjectRelease(femaleName);
    LCHObjectRelease(femaleSurname);
}

void LCHHumanObjectMarriedTests(void) {
    LCHHuman *male = LCHHumanCreateWithGender(kLCHHumanGenderMale);
    LCHHuman *female = LCHHumanCreateWithGender(kLCHHumanGenderFemale);
    LCHHumanSetAge(male, 34);
    LCHHumanSetAge(female, 31);
    
    // After Human objects was married
    LCHHumanMarry(male, female);
    
    // Objects must be married
    assert(true == LCHHumanIsMarried(male));
    assert(true == LCHHumanIsMarried(female));
    
    // Objects must have partner
    assert(NULL != LCHHumanPartner(male));
    assert(NULL != LCHHumanPartner(female));
    
    // Most awesome partner must retain lower one
    if (LCHHumanRank(male) >= LCHHumanRank(female)) {
        assert(2 == LCHObjectReferenceCount(female));
    } else if (LCHHumanRank(male) < LCHHumanRank(female)) {
        assert(2 == LCHObjectReferenceCount(male));
    }
    
    // After Human objects was divorced
    LCHHumanDivorce(male);
    
    // Object must not be married
    assert(false == LCHHumanIsMarried(male));
    assert(false == LCHHumanIsMarried(female));
    
    // Objects must not have partner
    assert(NULL == LCHHumanPartner(male));
    assert(NULL == LCHHumanPartner(female));
    
    // Most awesome partner must release lower one
    if (LCHHumanRank(male) >= LCHHumanRank(female)) {
        assert(1 == LCHObjectReferenceCount(female));
    } else if (LCHHumanRank(male) < LCHHumanRank(female)) {
        assert(1 == LCHObjectReferenceCount(male));
    }
    
    LCHObjectRelease(male);
    LCHObjectRelease(female);
}

void LCHHumanObjectCreateChildTests(void) {
    LCHString *maleSurname = LCHStringCreate("Doe");
    LCHHuman *male = LCHHumanCreateWithGender(kLCHHumanGenderMale);
    LCHHuman *female = LCHHumanCreateWithGender(kLCHHumanGenderFemale);
    LCHHumanSetAge(male, 34);
    LCHHumanSetAge(female, 31);
    LCHHumanSetSurname(male, maleSurname);
    
    // Create Human object with gender female and parameters
    LCHString *childName = LCHStringCreate("Marry");
    LCHHuman *child = LCHHumanCreateChildWithParameters(kLCHHumanGenderFemale, female, male, childName);
    
    // After Human child object was created:
    // Object must not be NULL
    assert(NULL != child);
    
    // Object must have Female gender
    assert(kLCHHumanGenderFemale == LCHHumanGender(child));
    
    // Object name must be equal to childName
    assert(childName == LCHHumanName(child));
    
    // Object surname must be equal to childSurname
    assert(maleSurname = LCHHumanSurname(child));
    
    // Object must not be married
    assert(false == LCHHumanIsMarried(child));
    
    // Object must not have partner
    assert(NULL == LCHHumanPartner(child));
    
    // Object must have mother
    assert(female == LCHHumanMother(child));
    
    // Object must have father
    assert(male == LCHHumanFather(child));
    
    // Object age must be equal to initial age
    assert(kLCHAgeInitial == LCHHumanAge(child));
    
    // Object children count must be equal to 0
    assert(0 == LCHArrayElementsCount(LCHHumanChildren(child)));
    
    // Object reference count must be equal to 3
    assert(3 == LCHObjectReferenceCount(child));
    
    // Father children count must be equal to 1
    assert(1 == LCHArrayElementsCount(LCHHumanChildren(male)));
    
    // Father children count must be equal to 1
    assert(1 == LCHArrayElementsCount(LCHHumanChildren(female)));
    
    LCHObjectRelease(male);
    LCHObjectRelease(female);
    LCHObjectRelease(maleSurname);
    
    // After parents was released
    // Object must not have mother
    assert(NULL == LCHHumanMother(child));
    
    // Object must not have father
    assert(NULL == LCHHumanFather(child));
    
    LCHObjectRelease(child);
    LCHObjectRelease(childName);
}

void LCHHumanObjectRandomTests(void) {
    LCHHuman *male = LCHHumanCreateWithGender(kLCHHumanGenderMale);
    LCHHuman *mrNull = NULL;
    LCHHuman *female = LCHHumanCreateWithGender(kLCHHumanGenderFemale);
    LCHHuman *anotherFemale = LCHHumanCreateWithGender(kLCHHumanGenderFemale);
    LCHHumanSetAge(male, 34);
    LCHHumanSetAge(female, 31);
    LCHHumanSetAge(anotherFemale, 17);
    
    // After Human objects was married
    LCHHumanMarry(male, female);
    
    // Try to marry with another object
    LCHHumanMarry(male, anotherFemale);
    
    // Male and female must be marry
    assert(true == LCHHumanIsMarried(male));
    assert(true == LCHHumanIsMarried(female));
    
    // AnotherFemale must not be marry
    assert(false == LCHHumanIsMarried(anotherFemale));
    
    // Try to marry with mr. NULL
    LCHHumanMarry(mrNull, female);
    
    // Female partner must be equal to male
    assert(LCHHumanPartner(female) == male);
    
    // Try to create child object with mr. NULL as a partner
    LCHString *childName = LCHStringCreate("Marry");
    LCHHuman *child = LCHHumanCreateChildWithParameters(kLCHHumanGenderFemale, female, mrNull, childName);
    
    // Child must be NULL
    assert(NULL == child);
    
    LCHHumanDivorce(male);
    LCHObjectRelease(male);
    LCHObjectRelease(female);
    LCHObjectRelease(anotherFemale);
    LCHObjectRelease(child);
}
