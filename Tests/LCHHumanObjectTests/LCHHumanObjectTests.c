#include "LCHHumanObjectTests.h"
#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Public implementations

void LCHHumanObjectTests(void) {
    char *name = "Lucy";
    char *surname = "Melof";
    
    char *partnerName = "Jonn";
    char *partnerSurname = "Doe";
    
    char *childName = "Marry";
    
    LCHHuman *human = LCHHumanCreate(LCHHumanGenderMale);
    LCHHuman *partner = LCHHumanCreateWithParameters(LCHHumanGenderFemale, name, surname, 27, 93);
    
    LCHHumanSetName(human, partnerName);
    LCHHumanSetSurname(human, partnerSurname);
    
    LCHHumanSetAge(human, 29);
    LCHHumanSetMarry(human, partner);
    LCHHumanSetDivorce(partner);
    
    LCHHuman *child = LCHHumanCreateBabyWithParameters(LCHHumanGenderFemale, partner, human, childName);
    
    printf("Human name: %s\n", human->_name);
    printf("Human surname: %s\n", human->_surname);
    printf("Human maidenName: %s\n", human->_maidenName);
    printf("Human partner: %p\n", human->_partner);
    printf("Human mother: %p\n", human->_mother);
    printf("Human father: %p\n", human->_father);
    printf("Human children array: %p\n", human->_children);
    printf("Human age: %u\n", human->_age);
    printf("Human children count: %hhu\n", human->_childrenCount);
    printf("Human gender: %u\n", human->_gender);
    printf("Human rank: %hhu\n", human->_rankOfAwesomeness);
    printf("Human reference: %llu\n\n", human->_referenceCount);
    
    printf("Partner name: %s\n", partner->_name);
    printf("Partner surname: %s\n", partner->_surname);
    printf("Partner maidenName: %s\n", partner->_maidenName);
    printf("Partner partner: %p\n", partner->_partner);
    printf("Partner mother: %p\n", partner->_mother);
    printf("Partner father: %p\n", partner->_father);
    printf("Partner children array: %p\n", partner->_children);
    printf("Partner age: %u\n", partner->_age);
    printf("Partner children count: %hhu\n", partner->_childrenCount);
    printf("Partner gender: %u\n", partner->_gender);
    printf("Partner rank: %hhu\n", partner->_rankOfAwesomeness);
    printf("Partner reference: %llu\n\n", partner->_referenceCount);
    
    printf("Child name: %s\n", child->_name);
    printf("Child surname: %s\n", child->_surname);
    printf("Child maidenName: %s\n", child->_maidenName);
    printf("Child partner: %p\n", child->_partner);
    printf("Child mother: %p\n", child->_mother);
    printf("Child father: %p\n", child->_father);
    printf("Child children array: %p\n", child->_children);
    printf("Child age: %u\n", child->_age);
    printf("Child children count: %hhu\n", child->_childrenCount);
    printf("Child gender: %u\n", child->_gender);
    printf("Child rank: %hhu\n", child->_rankOfAwesomeness);
    printf("Child reference: %llu\n\n", child->_referenceCount);
}
