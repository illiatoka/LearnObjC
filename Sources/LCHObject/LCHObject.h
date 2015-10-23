#ifndef LCHObject_h
#define LCHObject_h

#include <stdio.h>

#define LCHObjectCreateOfType(type) __LCHObjectCreate(sizeof(type), __ ## type ## Deallocate)

#define LCHObjectIvarGetterSynthesize(object, iVar, returnValue) return NULL != object ? iVar : returnValue;

#define LCHObjectIvarSetterSynthesize(object, iVar, value) \
    if (NULL != object && value != object->iVar) { \
        object->iVar = value; \
    }

#define LCHObjectIvarStringSetterSynthesize(object, iVar, value) \
    if (NULL != object && value != object->iVar) { \
        if (NULL != object->iVar) { \
            free(object->iVar); \
            object->iVar = NULL; \
        } \
        if (value) { \
            object->iVar = strdup(value); \
        } \
    }

typedef void (*LCHObjectDeallocate)(void *object);

typedef struct {
    uint64_t _referenceCount;
    LCHObjectDeallocate _deallocator;
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

extern
void *LCHObjectDeallocator(void *object);

#endif
