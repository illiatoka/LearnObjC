#ifndef LCHLinkedListEnumerator_h
#define LCHLinkedListEnumerator_h

#include <stdbool.h>

typedef struct LCHLinkedList LCHLinkedList;
typedef struct LCHLinkedListNode LCHLinkedListNode;
typedef struct LCHLinkedListEnumerator LCHLinkedListEnumerator;

extern
void __LCHLinkedListEnumeratorDeallocate(void *node);

extern
LCHLinkedListEnumerator *LCHLinkedListEnumeratorCreateWithList(LCHLinkedList *list);

extern
LCHLinkedListNode *LCHLinkedListEnumeratorNode(LCHLinkedListEnumerator *enumerator);

extern
bool LCHLinkedListEnumeratorIsValid(LCHLinkedListEnumerator *enumerator);

extern
void *LCHLinkedListEnumeratorNextObject(LCHLinkedListEnumerator *enumerator);

#endif
