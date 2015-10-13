#ifndef LCHHumanObject_h
#define LCHHumanObject_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

typedef struct LCHHuman LCHHuman;

typedef enum {
    LCHHumanGenderUnknown,
    LCHHumanGenderMale,
    LCHHumanGenderFemale
} LCHHumanGenderType;

static const uint8_t kLCHRankOfAwesomenessMax = 100;
static const uint8_t kLCHChildrenLimit        = 20;
static const uint8_t kLCHAgeLimitMin          = 18;
static const uint8_t kLCHAgeLimitMax          = 75;

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

// TODO: Not finished
extern
void _LCHHumanDeallocate(LCHHuman *object);

#pragma mark -
#pragma mark How can I call this type of declarations?

extern
LCHHuman *LCHHumanCreate(LCHHumanGenderType gender);

extern
LCHHuman *LCHHumanCreateWithParameters(LCHHumanGenderType gender,
                                       char *name,
                                       char *surname,
                                       uint8_t age,
                                       uint8_t rank);

extern
LCHHuman *LCHHumanCreateChildWithParameters(LCHHumanGenderType gender,
                                           LCHHuman *mother,
                                           LCHHuman *father,
                                           char*name);

#pragma mark -
#pragma mark Accessors

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

// TODO: Ask about name for method
extern
bool LCHHumanIsMarried(LCHHuman *object);

extern
uint8_t LCHHumanRank(LCHHuman *object);

// TODO: Not finished
extern
void LCHHumanMarry(LCHHuman *object, LCHHuman *partner);

// TODO: Not finished
extern
void LCHHumanDivorce(LCHHuman *object);

extern
LCHHuman *LCHHumanMother(LCHHuman *object);

// TODO: Not finished
extern
void LCHHumanSetMother(LCHHuman *object, LCHHuman *mother);

extern
LCHHuman *LCHHumanFather(LCHHuman *object);

// TODO: Not finished
extern
void LCHHumanSetFather(LCHHuman *object, LCHHuman *father);

extern
uint64_t LCHHumanReferenceCount(LCHHuman *object);

#endif
