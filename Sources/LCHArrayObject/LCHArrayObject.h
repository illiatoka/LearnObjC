#ifndef LCHArrayObject_h
#define LCHArrayObject_h

#include <stdio.h>

typedef struct LCHArray LCHArray;

extern const uint8_t kLCHCapacityInitial;
extern const uint8_t kLCHObjectNotFound;

extern
void __LCHArrayDeallocate(void *array);

extern
LCHArray *LCHArrayCreate(void);

extern
uint8_t LCHArrayCount(LCHArray *array);

extern
uint8_t LCHArrayCapacity(LCHArray *array);

extern
uint8_t LCHArrayIndexOfObject(LCHArray *array, void *object);

extern
void LCHArrayAddObject(LCHArray *array, void *object);

extern
void LCHArrayRemoveObject(LCHArray *array, void *object);

extern
void *LCHArrayObjectAtIndex(LCHArray *array, uint8_t index);

extern
void LCHArrayRemoveObjectAtIndex(LCHArray *array, uint8_t index);

#endif
