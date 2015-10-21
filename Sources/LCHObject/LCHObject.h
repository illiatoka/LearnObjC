#ifndef LCHObject_h
#define LCHObject_h

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define LCHObjectCreateOfType(type) __LCHObjectCreate(sizeof(type), __ ## type ## Deallocate)

typedef void (*LCHObjectDeallocate)(void *object);

typedef struct {
    uint64_t _referenceCount;
    LCHObjectDeallocate _deallocateFunction;
} LCHObject;

extern
void __LCHObjectDeallocate(void *object);

extern
void *__LCHObjectCreate(size_t size, LCHObjectDeallocate deallocator);

extern
void LCHObjectRetain(void *object);

extern
void LCHObjectRelease(void *object);

extern
uint64_t LCHObjectReferenceCount(void *object);

#endif
