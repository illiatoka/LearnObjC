#include "LCHHumanObjectTests.h"
#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Public implementations

void LCHHumanObjectTests(void) {
    LCHHuman human = *LCHHumanCreate(LCHHumanGenderMale);
    LCHHuman partner = *LCHHumanCreate(LCHHumanGenderFemale);
    LCHHuman mother = *LCHHumanCreate(LCHHumanGenderMale);
    LCHHuman father = *LCHHumanCreate(LCHHumanGenderFemale);
    
    LCHHumanSetMarry(&human, &partner);
    LCHHumanSetMother(&human, &mother);
    LCHHumanSetFather(&human, &father);
    
    printf("Human name: %s\n", human._name);
    printf("Human surname: %s\n", human._surname);
    printf("Human partner: %p\n", human._partner);
    printf("Human mother: %p\n", human._mother);
    printf("Human father: %p\n", human._father);
    printf("Human children array: %p\n", human._children);
    printf("Human age: %hhu\n", human._age);
    printf("Human children count: %hhu\n", human._childrenCount);
    printf("Human gender: %u\n", human._gender);
    
    printf("\nReference count (human): %llu\n", human._referenceCount);
    printf("Reference count (partner): %llu\n", partner._referenceCount);
    printf("Reference count (mother): %llu\n", mother._referenceCount);
    printf("Reference count (father): %llu\n\n\n", father._referenceCount);
}
