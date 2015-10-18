#ifndef LCHObject_h
#define LCHObject_h

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define LCHObjectCreateOfType(type) _LCHObjectCreate(sizeof(type), _ ## type ## Deallocate)

typedef void (*LCHObjectDeallocate)(void *object);

typedef struct {
    uint64_t _referenceCount;
    LCHObjectDeallocate _deallocateFunction;
} LCHObject;

extern
void _LCHObjectDeallocate(void *object);

extern
void *_LCHObjectCreate(size_t size, LCHObjectDeallocate deallocator);

extern
void LCHObjectRetain(void *object);

extern
void LCHObjectRelease(void *object);

extern
uint64_t LCHHumanReferenceCount(void *object);

#endif
