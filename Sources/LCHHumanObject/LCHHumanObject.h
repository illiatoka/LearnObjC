#ifndef LCHHumanObject_h
#define LCHHumanObject_h

typedef struct LCHHuman LCHHuman;

typedef enum {
    LCHHumanGenderMale,
    LCHHumanGenderFemale
} LCHHumanGenderType;

extern
LCHHuman *LCHHumanCreate(void);

extern
void _LCHHumanDeallocate(LCHHuman *object);

extern
char LCHHumanName(LCHHuman *object);

extern
char LCHHumanSurname(LCHHuman *object);

extern
LCHHumanGenderType LCHHumanGender(LCHHuman *object);

extern
uint8_t LCHHumanAge(LCHHuman *object);

extern
uint8_t LCHHumanChildrenCount(LCHHuman *object);

extern
LCHHuman LCHHumanPartner(LCHHuman *object);
extern
LCHHuman LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner);

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
