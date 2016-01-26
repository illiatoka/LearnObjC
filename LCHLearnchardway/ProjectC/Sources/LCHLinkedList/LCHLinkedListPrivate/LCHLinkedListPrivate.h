#ifndef LCHLinkedListPrivate_h
#define LCHLinkedListPrivate_h

#include <stdio.h>

typedef struct LCHLinkedList LCHLinkedList;
typedef struct LCHLinkedListNode LCHLinkedListNode;

typedef struct {
    LCHLinkedListNode *previousNode;
    LCHLinkedListNode *node;
    void *object;
} LCHLinkedListNodeContext;

typedef bool (*LCHLinkedListNodeComparisonFunction)(LCHLinkedListNode *node, LCHLinkedListNodeContext context);

extern
LCHLinkedListNode *LCHLinkedListHead(LCHLinkedList *list);

extern
uint64_t LCHLinkedListMutationsCount(LCHLinkedList *list);

extern
LCHLinkedListNode *LCHLinkedListFindNodeWithContext(LCHLinkedList *list,
                                                LCHLinkedListNodeComparisonFunction comparator,
                                                LCHLinkedListNodeContext *context);

extern
bool LCHLinkedListNodeContainsObject(LCHLinkedListNode *node, LCHLinkedListNodeContext context);

#endif
