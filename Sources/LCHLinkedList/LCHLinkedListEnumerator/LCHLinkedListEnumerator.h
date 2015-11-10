#ifndef LCHLinkedListEnumerator_h
#define LCHLinkedListEnumerator_h

#include <stdbool.h>

typedef struct LCHLinkedList LCHLinkedList;
typedef struct LCHLinkedListEnumerator LCHLinkedListEnumerator;

extern
void __LCHLinkedListEnumeratorDeallocate(void *node);

extern
LCHLinkedListEnumerator *LCHLinkedListEnumeratorCreateWithList(LCHLinkedList *list);

extern
bool LCHLinkedListEnumeratorIsValid(LCHLinkedListEnumerator *enumerator);

extern
void *LCHLinkedListEnumeratorNextObject(LCHLinkedListEnumerator *enumerator);

#endif
