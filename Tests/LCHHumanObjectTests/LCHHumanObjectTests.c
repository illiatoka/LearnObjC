#include "LCHHumanObjectTests.h"
#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Public implementations

void LCHHumanObjectTests(void) {
    char *name = "John";
    
    char *partnerName = "Lucy";
    char *partnerSurname = "Melof";
    
    char *childName = "Marry";
    
    LCHHuman *male = LCHHumanCreate(LCHHumanGenderMale);
    LCHHuman *female = LCHHumanCreateWithParameters(LCHHumanGenderFemale, partnerName, partnerSurname, 27, 93);
    
    LCHHumanSetName(male, name);
    LCHHumanSetAge(male, 29);
    LCHHumanMarry(male, female);
    
    printf("Male name: %s\n", LCHHumanName(male));
    printf("Male partner: %p\n", LCHHumanPartner(male));
    printf("Male reference: %llu\n\n", LCHHumanReferenceCount(male));

    printf("Female name: %s\n", LCHHumanName(female));
    printf("Female partner: %p\n", LCHHumanPartner(female));
    printf("Female reference: %llu\n\n", LCHHumanReferenceCount(female));
    
    LCHHuman *child = LCHHumanCreateChildWithParameters(LCHHumanGenderFemale, female, male, childName);
    
    printf("Child mother: %p\n", LCHHumanMother(child));
    printf("Child father: %p\n", LCHHumanFather(child));
    printf("Child reference: %llu\n", LCHHumanReferenceCount(child));
    printf("Female children count: %d\n", LCHHumanChildrenCount(female));
    printf("Male children count: %d\n", LCHHumanChildrenCount(male));
    printf("Female reference: %llu\n", LCHHumanReferenceCount(female));
    printf("Male reference: %llu\n\n", LCHHumanReferenceCount(male));
    
    LCHHumanDivorce(female);
    
    printf("Male partner: %p\n", LCHHumanPartner(male));
    printf("Male reference: %llu\n", LCHHumanReferenceCount(male));
    printf("Female partner: %p\n", LCHHumanPartner(female));
    printf("Female reference: %llu\n\n", LCHHumanReferenceCount(female));
    
    LCHObjectRelease(male);
    
    printf("Male partner: %p\n", LCHHumanPartner(male));
    printf("Male reference: %llu\n", LCHHumanReferenceCount(male));
    printf("Female partner: %p\n", LCHHumanPartner(female));
    printf("Female reference: %llu\n\n", LCHHumanReferenceCount(female));
    
    LCHObjectRelease(female);
    
    printf("Male partner: %p\n", LCHHumanPartner(male));
    printf("Male reference: %llu\n", LCHHumanReferenceCount(male));
    printf("Female partner: %p\n", LCHHumanPartner(female));
    printf("Female reference: %llu\n\n", LCHHumanReferenceCount(female));
    
    printf("Child reference: %llu\n", LCHHumanReferenceCount(child));
}
