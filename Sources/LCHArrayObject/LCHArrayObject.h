#ifndef LCHArrayObject_h
#define LCHArrayObject_h

#include <stdio.h>

typedef struct LCHArray LCHArray;

extern
void __LCHArrayDeallocate(void *object);

extern
LCHArray *LCHArrayCreate(void);

extern
uint8_t LCHArrayCount(LCHArray *object);

extern
void *LCHArrayElement(LCHArray *object, uint8_t index);

extern
void LCHArrayAddElement(LCHArray *object, void *element);

extern
void LCHArrayRemoveElement(LCHArray *object, uint8_t index);

#endif
