#ifndef LCHHumanObject_h
#define LCHHumanObject_h

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef struct LCHHuman LCHHuman;

typedef enum {
    LCHHumanGenderMale,
    LCHHumanGenderFemale
} LCHHumanGenderType;

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

extern
LCHHuman *LCHHumanCreate(void);

extern
void _LCHHumanDeallocate(LCHHuman *object);

extern
char *LCHHumanName(LCHHuman *object);

extern
char *LCHHumanSurname(LCHHuman *object);

extern
LCHHumanGenderType LCHHumanGender(LCHHuman *object);

extern
uint8_t LCHHumanAge(LCHHuman *object);

extern
uint8_t LCHHumanChildrenCount(LCHHuman *object);

extern
LCHHuman LCHHumanPartner(LCHHuman *object);

extern
LCHHuman LCHHumanSetMarry(LCHHuman *object, LCHHuman *wife, LCHHuman *husband);

extern
LCHHuman LCHHumanSetDivorce(LCHHuman *object, LCHHuman *wife, LCHHuman *husband);

extern
LCHHuman LCHHumanMother(LCHHuman *object);

extern
LCHHuman LCHHumanSetMother(LCHHuman *object, LCHHuman *mother);

extern
LCHHuman LCHHumanFather(LCHHuman *object);

extern
LCHHuman LCHHumanSetFather(LCHHuman *object, LCHHuman *father);

extern
LCHHuman LCHHumanChildren(LCHHuman *object);

#endif
