#ifndef LCHArrayObject_h
#define LCHArrayObject_h

#include <stdio.h>
#include <stdbool.h>

typedef struct LCHArray LCHArray;

extern const uint64_t kLCHObjectNotFound;

extern
void __LCHArrayDeallocate(void *array);

extern
LCHArray *LCHArrayCreate(void);

extern
uint64_t LCHArrayCount(LCHArray *array);

extern
uint64_t LCHArrayIndexOfObject(LCHArray *array, void *object);

extern
bool LCHArrayContainsObject(LCHArray *array, void *object);

extern
void LCHArrayAddObject(LCHArray *array, void *object);

extern
void LCHArrayRemoveObject(LCHArray *array, void *object);

extern
void *LCHArrayObjectAtIndex(LCHArray *array, uint64_t index);

extern
void LCHArrayRemoveObjectAtIndex(LCHArray *array, uint64_t index);

#endif
