#ifndef LCHLinkedList_h
#define LCHLinkedList_h

#include <stdio.h>
#include <stdbool.h>

typedef struct LCHLinkedList LCHLinkedList;

extern
void __LCHArrayDeallocate(void *list);

extern
LCHLinkedList *LCHLinkedListCreate(void);

extern
uint64_t LCHLinkedListCount(LCHLinkedList *list);

extern
bool LCHLinkedListContainsObject(LCHLinkedList *list, void *object);

extern
void LCHLinkedListAddObject(LCHLinkedList *list, void *object);

extern
void LCHLinkedListRemoveObject(LCHLinkedList *list, void *object);

#endif
