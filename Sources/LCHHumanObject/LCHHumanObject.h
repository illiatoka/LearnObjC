#ifndef LCHHumanObject_h
#define LCHHumanObject_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

// Readme
// Create new human object using LCHHumanCreate method. It will generate object with default parameters:
//  age: 1,
//  gender: LCHHumanGenderType
//  rankOfAwesomeness: random

// Parameters specifications:
// age: set in years
// gender: use Male or Female type.
// rankOfAwesomeness: store value between 1 to 100. Set predominancy in relationship between objects.
//    Object with lower value will have low power. Rank value can't be change after assign.


typedef struct LCHHuman LCHHuman;

typedef enum {
    LCHHumanGenderUnknown,
    LCHHumanGenderMale,
    LCHHumanGenderFemale
} LCHHumanGenderType;

static
const uint8_t kLCHChildrenLimit = 20;

static
const uint8_t kLCHAgeLimitMin = 18;

static
const uint8_t kLCHAgeLimitMax = 75;

static
const uint8_t kLCHRankOfAwesomenessMax = 100;

struct LCHHuman {
    char *_name;
    char *_surname;
    char *_maidenName;
    LCHHuman *_partner;
    LCHHuman *_mother;
    LCHHuman *_father;
    LCHHuman *_children[kLCHChildrenLimit];
    uint8_t _age;
    uint8_t _childrenCount;
    uint8_t _rankOfAwesomeness;
    LCHHumanGenderType _gender;
    
    uint64_t _referenceCount;
};

extern
LCHHuman *LCHHumanCreate(LCHHumanGenderType gender);

extern
LCHHuman *LCHHumanCreateWithParameters(LCHHumanGenderType gender,
                                       char *name,
                                       char *surname,
                                       uint8_t age,
                                       uint8_t rank
                                       );

extern
LCHHuman *LCHHumanCreateBabyWithParameters(LCHHumanGenderType gender,
                             LCHHuman *mother,
                             LCHHuman *father,
                             char*name
                             );

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
char *LCHHumanMaidenName(LCHHuman *object);

extern
LCHHumanGenderType LCHHumanGender(LCHHuman *object);

extern
uint8_t LCHHumanAge(LCHHuman *object);

extern
void LCHHumanSetAge(LCHHuman *object, uint8_t age);

extern
uint8_t LCHHumanChildrenCount(LCHHuman *object);

extern
LCHHuman *LCHHumanPartner(LCHHuman *object);

extern
bool LCHHumanIsMarried(LCHHuman *object);

extern
void LCHHumanSetMarry(LCHHuman *object, LCHHuman *partner);

extern
void LCHHumanSetDivorce(LCHHuman *object);

extern
LCHHuman *LCHHumanMother(LCHHuman *object);

extern
void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother);

extern
LCHHuman *LCHHumanFather(LCHHuman *object);

extern
void LCHHumanSetFather(LCHHuman *object, LCHHuman *father);

#endif
