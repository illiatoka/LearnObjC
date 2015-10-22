#include "LCHHumanObjectTests.h"

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
    LCHHuman *male = LCHHumanCreate(kLCHHumanGenderMale);
    
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
    assert(0 == LCHHumanChildrenCount(male));
    
    // Object reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(male));
    
    LCHObjectRelease(male);
}

void LCHHumanObjectCreateWithParametersTests(void) {
    char *femaleName = "Lucy";
    char *femaleSurname = "Melof";
    
    // Create Human object with gender female and parameters
    LCHHuman *female = LCHHumanCreateWithParameters(kLCHHumanGenderFemale, femaleName, femaleSurname, 27, 93);
    
    // After Human male object was created:
    // Object must not be NULL
    assert(NULL != female);
    
    // Object must have Female gender
    assert(kLCHHumanGenderFemale == LCHHumanGender(female));
    
    // Object name must be equal to femaleName
    assert(0 == strcmp(femaleName, LCHHumanName(female)));
    
    // Object surname must be equal to femaleSurname
    assert(0 == strcmp(femaleSurname, LCHHumanSurname(female)));
    
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
    assert(0 == LCHHumanChildrenCount(female));
    
    // Object reference count must be equal to 1
    assert(1 == LCHObjectReferenceCount(female));
    
    LCHObjectRelease(female);
}

void LCHHumanObjectMarriedTests(void) {
    LCHHuman *male = LCHHumanCreate(kLCHHumanGenderMale);
    LCHHuman *female = LCHHumanCreate(kLCHHumanGenderFemale);
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
    char *maleSurname = "Doe";
    LCHHuman *male = LCHHumanCreate(kLCHHumanGenderMale);
    LCHHuman *female = LCHHumanCreate(kLCHHumanGenderFemale);
    LCHHumanSetAge(male, 34);
    LCHHumanSetAge(female, 31);
    LCHHumanSetSurname(male, maleSurname);
    
    // Create Human object with gender female and parameters
    char *childName = "Marry";
    LCHHuman *child = LCHHumanCreateChildWithParameters(kLCHHumanGenderFemale, female, male, childName);
    
    // After Human child object was created:
    // Object must not be NULL
    assert(NULL != child);
    
    // Object must have Female gender
    assert(kLCHHumanGenderFemale == LCHHumanGender(child));
    
    // Object name must be equal to femaleName
    assert(0 == strcmp(childName, LCHHumanName(child)));
    
    // Object surname must be equal to femaleSurname
    assert(0 == strcmp(LCHHumanSurname(male), LCHHumanSurname(child)));
    
    // Object must not be married
    assert(false == LCHHumanIsMarried(child));
    
    // Object must not have partner
    assert(NULL == LCHHumanPartner(child));
    
    // Object must have mother
    assert(female == LCHHumanMother(child));
    
    // Object must have father
    assert(male== LCHHumanFather(child));
    
    // Object age must be equal to initial age
    assert(1 == LCHHumanAge(child));
    
    // Object children count must be equal to 0
    assert(0 == LCHHumanChildrenCount(child));
    
    // Object reference count must be equal to 3
    assert(3 == LCHObjectReferenceCount(child));
    
    // Father children count must be equal to 1
    assert(1 == LCHHumanChildrenCount(male));
    
    // Father children count must be equal to 1
    assert(1 == LCHHumanChildrenCount(female));
    
    LCHObjectRelease(child);
    
    LCHObjectRelease(male);
    LCHObjectRelease(female);
}

void LCHHumanObjectRandomTests(void) {
    LCHHuman *male = LCHHumanCreate(kLCHHumanGenderMale);
    LCHHuman *mrNull = NULL;
    LCHHuman *female = LCHHumanCreate(kLCHHumanGenderFemale);
    LCHHuman *anotherFemale = LCHHumanCreate(kLCHHumanGenderFemale);
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
    char *childName = "Marry";
    LCHHuman *child = LCHHumanCreateChildWithParameters(kLCHHumanGenderFemale, female, mrNull, childName);
    
    // Child must be NULL
    assert(NULL == child);
    
    LCHHumanDivorce(male);
    LCHObjectRelease(male);
    LCHObjectRelease(female);
    LCHObjectRelease(anotherFemale);
    LCHObjectRelease(child);
}
