#ifndef LCHLinkedListNode_h
#define LCHLinkedListNode_h

typedef struct LCHLinkedListNode LCHLinkedListNode;

extern
void __LCHLinkedListNodeDeallocate(void *node);

extern
LCHLinkedListNode *LCHLinkedListNodeCreateWithObject(void *object);

extern
LCHLinkedListNode *LCHLinkedListNodeNextNode(LCHLinkedListNode *node);

extern
void LCHLinkedListNodeSetNextNode(LCHLinkedListNode *node, LCHLinkedListNode *nextNode);

extern
void *LCHLinkedListNodeObject(LCHLinkedListNode *node);

extern
void LCHLinkedListNodeSetObject(LCHLinkedListNode *node, void *object);

#endif
