#include "LCHHumanObjectTests.h"
#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Public implementations

void LCHHumanObjectTests(void) {
    char *name = "Lucy";
    char *surname = "Melof";
    
    char *partnerName = "Jonn";
    char *partnerSurname = "Doe";
    
    LCHHuman human = *LCHHumanCreate();
    LCHHuman partner = *LCHHumanCreateWithParameters(LCHHumanGenderFemale, name, surname, 27, 93);
    
    LCHHumanSetName(&human, partnerName);
    LCHHumanSetSurname(&human, partnerSurname);
    
    printf("Human name: %s\n", human._name);
    printf("Human surname: %s\n", human._surname);
    printf("Human partner: %p\n", human._partner);
    printf("Human mother: %p\n", human._mother);
    printf("Human father: %p\n", human._father);
    printf("Human children array: %p\n", human._children);
    printf("Human age: %u\n", human._age);
    printf("Human children count: %hhu\n", human._childrenCount);
    printf("Human gender: %u\n", human._gender);
    printf("Human rank: %hhu\n\n", human._rankOfAwesomeness);
    
    printf("Partner name: %s\n", partner._name);
    printf("Partner surname: %s\n", partner._surname);
    printf("Partner partner: %p\n", partner._partner);
    printf("Partner mother: %p\n", partner._mother);
    printf("Partner father: %p\n", partner._father);
    printf("Partner children array: %p\n", partner._children);
    printf("Partner age: %u\n", partner._age);
    printf("Partner children count: %hhu\n", partner._childrenCount);
    printf("Partner gender: %u\n", partner._gender);
    printf("Partner rank: %hhu\n\n", partner._rankOfAwesomeness);
}
