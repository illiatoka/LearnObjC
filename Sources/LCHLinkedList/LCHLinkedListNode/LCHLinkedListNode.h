#ifndef LCHLinkedListNode_h
#define LCHLinkedListNode_h

typedef struct LCHLinkedListNode LCHLinkedListNode;

extern
LCHLinkedListNode LCHLinkedListNodeCreateWithObject(void *object);

extern
LCHLinkedListNode LCHLinkedListNodeNextNode(LCHLinkedListNode *node);

extern
LCHLinkedListNode LCHLinkedListNodeSetNextNode(LCHLinkedListNode *node);

extern
void *LCHLinkedListNodeObject(LCHLinkedListNode *node);

extern
void LCHLinkedListNodeSetObject(void *object);

#endif
