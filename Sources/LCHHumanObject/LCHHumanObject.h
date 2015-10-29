#ifndef LCHHumanObject_h
#define LCHHumanObject_h

#include <stdio.h>
#include <stdbool.h>

#include "LCHStringObject.h"
#include "LCHArrayObject.h"

typedef struct LCHHuman LCHHuman;

typedef enum {
    kLCHHumanGenderUnknown,
    kLCHHumanGenderMale,
    kLCHHumanGenderFemale
} LCHHumanGenderType;

extern const uint8_t kLCHRankOfAwesomenessMax;
extern const uint8_t kLCHChildrenLimit;
extern const uint8_t kLCHAgeInitial;
extern const uint8_t kLCHAgeLimitMin;
extern const uint8_t kLCHAgeLimitMax;

extern
void __LCHHumanDeallocate(void *object);

extern
LCHHuman *LCHHumanCreateWithGender(LCHHumanGenderType gender);

extern
LCHHuman *LCHHumanCreateWithParameters(LCHHumanGenderType gender,
                                       LCHString *name,
                                       LCHString *surname,
                                       uint8_t age,
                                       uint8_t rank);

extern
LCHHuman *LCHHumanCreateChildWithParameters(LCHHumanGenderType gender,
                                           LCHHuman *mother,
                                           LCHHuman *father,
                                           LCHString *name);

extern
LCHString *LCHHumanName(LCHHuman *object);

extern
void LCHHumanSetName(LCHHuman *object, LCHString *name);

extern
LCHString *LCHHumanSurname(LCHHuman *object);

extern
void LCHHumanSetSurname(LCHHuman *object, LCHString *surname);

extern
LCHHumanGenderType LCHHumanGender(LCHHuman *object);

extern
uint8_t LCHHumanAge(LCHHuman *object);

extern
void LCHHumanSetAge(LCHHuman *object, uint8_t age);

extern
LCHArray *LCHHumanChildren(LCHHuman *object);

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
