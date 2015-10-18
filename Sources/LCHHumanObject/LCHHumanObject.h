#ifndef LCHHumanObject_h
#define LCHHumanObject_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

#include "LCHObject.h"

typedef struct LCHHuman LCHHuman;

typedef enum {
    LCHHumanGenderUnknown,
    LCHHumanGenderMale,
    LCHHumanGenderFemale
} LCHHumanGenderType;

extern const uint8_t kLCHRankOfAwesomenessMax;
extern const uint8_t kLCHChildrenLimit;
extern const uint8_t kLCHAgeInitial;
extern const uint8_t kLCHAgeLimitMin;
extern const uint8_t kLCHAgeLimitMax;

extern
void _LCHHumanDeallocate(void *object);

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

extern
char *LCHHumanName(LCHHuman *object);

extern
void LCHHumanSetName(LCHHuman *object, char *name);

extern
char *LCHHumanSurname(LCHHuman *object);

extern
void LCHHumanSetSurname(LCHHuman *object, char *surname);

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
uint8_t LCHHumanRank(LCHHuman *object);

extern
void LCHHumanMarry(LCHHuman *object, LCHHuman *partner);

extern
void LCHHumanDivorce(LCHHuman *object);

extern
LCHHuman *LCHHumanMother(LCHHuman *object);

extern
LCHHuman *LCHHumanFather(LCHHuman *object);

#endif
