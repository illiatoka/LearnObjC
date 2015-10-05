#ifndef LCHHumanObject_h
#define LCHHumanObject_h

#endif

typedef struct LCHHuman LCHHuman;

extern
LCHHuman *LCHHumanCreate(void);
extern
void _LCHHumanDeallocate(LCHHuman *object);

extern
char *LCHHumanName(LCHHuman *object);
extern
void LCHHumanSetName(LCHHuman *object, char *name);

extern
char *LCHHumanSurname(LCHHuman *object);
extern
void LCHHumanSetSurname(LCHHuman *object, char *surname);

extern
char *LCHHumanGender(LCHHuman *object);
extern
void LCHHumanSetGender(LCHHuman *object, char gender);

extern
char *LCHHumanAge(LCHHuman *object);
extern
void LCHHumanSetAge(LCHHuman *object, char age);

extern
char *LCHHumanChildrenCount(LCHHuman *object);
extern
void LCHHumanSetChildrenCount(LCHHuman *object, char childrenCount);

extern
char *LCHHumanPartner(LCHHuman *object);
extern
void LCHHumanSetPartner(LCHHuman *object, LCHHuman *partner);

extern
char *LCHHumanParrentMother(LCHHuman *object);
extern
void LCHHumanSetParrentMother(LCHHuman *object, LCHHuman *parrentMother);

extern
char *LCHHumanParrentFather(LCHHuman *object);
extern
void LCHHumanSetParrentFather(LCHHuman *object, LCHHuman *parrentFather);

extern
char *LCHHumanChildrenList(LCHHuman *object);
extern
void LCHHumanSetChildrenList(LCHHuman *object, LCHHuman *childrenList);
