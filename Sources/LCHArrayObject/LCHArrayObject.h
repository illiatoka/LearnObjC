#ifndef LCHArrayObject_h
#define LCHArrayObject_h

#include <stdio.h>

typedef struct LCHArray LCHArray;

extern const uint8_t kLCHAllocatedCountInitial;

extern
void __LCHArrayDeallocate(void *object);

extern
LCHArray *LCHArrayCreate(void);

extern
uint8_t LCHArrayElementsCount(LCHArray *object);

extern
uint8_t LCHArrayAllocatedCount(LCHArray *object);

extern
void LCHArrayAddElement(LCHArray *object, void *element);

extern
void LCHArrayRemoveElement(LCHArray *object, void *element);

extern
void *LCHArrayElementAtIndex(LCHArray *object, uint8_t index);

extern
void LCHArrayRemoveElementAtIndex(LCHArray *object, uint8_t index);

#endif
