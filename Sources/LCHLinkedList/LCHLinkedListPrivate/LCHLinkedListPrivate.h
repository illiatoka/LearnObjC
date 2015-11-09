#ifndef LCHLinkedListPrivate_h
#define LCHLinkedListPrivate_h

#include <stdio.h>

typedef struct LCHLinkedList LCHLinkedList;
typedef struct LCHLinkedListNode LCHLinkedListNode;

extern
LCHLinkedListNode *LCHLinkedListHead(LCHLinkedList *list);

extern
uint64_t LCHLinkedListMutationsCount(LCHLinkedList *list);

#endif
