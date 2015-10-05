#include <stdbool.h>
#include <stdio.h>

#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHHuman {
    char *_name;
    char *_surname;
    LCHHuman *_partnerPointer;
    LCHHuman *_parrentMotherPointer;
    LCHHuman *_parrentFatherPointer;
    LCHHuman *_childrenListPointer[20];
    char _age;
    char _childrenCount;
    char _gender;
};
