#include <stdio.h>

#include "LCHHumanObject.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHHuman {
    char *_name;
    char *_surname;
    LCHHuman *_partner;
    LCHHuman *_mother;
    LCHHuman *_father;
    LCHHuman *_children[20];
    uint8_t _age;
    uint8_t _childrenCount;
    LCHHumanGenderType _gender;
};
