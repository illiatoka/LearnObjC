#include "LCHLinkedList.h"
#include "LCHLinkedListNode.h"
#include "LCHObject.h"
#include "LCHMacro.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHLinkedList {
    LCHObject _super;
    LCHLinkedListNode *_head;
    uint64_t _count;
};

static
LCHLinkedListNode *LCHLinkedListHead(LCHLinkedList *list);

static
void LCHLinkedListSetHead(LCHLinkedList *list, LCHLinkedListNode *node);

static
void LCHLinkedListSetCount(LCHLinkedList *list, uint64_t count);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHLinkedListDeallocate(void *list) {
    LCHLinkedListSetHead(list, NULL);
    __LCHObjectDeallocate(list);
}

LCHLinkedList *LCHLinkedListCreate(void) {
    LCHLinkedList *list = LCHObjectCreateOfType(LCHLinkedList);
    
    return list;
}

#pragma mark -
#pragma mark Accessors

LCHLinkedListNode *LCHLinkedListHead(LCHLinkedList *list) {
    LCHObjectIvarGetter(list, list->_head, NULL);
}

void LCHLinkedListSetHead(LCHLinkedList *list, LCHLinkedListNode *node) {
    LCHObjectRetainSetter(list, _head, node);
}

uint64_t LCHLinkedListCount(LCHLinkedList *list) {
    LCHObjectIvarGetter(list, list->_count, 0);
}

void LCHLinkedListSetCount(LCHLinkedList *list, uint64_t count) {
    LCHObjectAssignSetter(list, _count, count);
}

#pragma mark -
#pragma mark Public Implementations

bool LCHLinkedListContainsObject(LCHLinkedList *list, void *object) {
    bool result = false;
    
    if (NULL != list && NULL != object) {
        // Enumerator
    }
    
    return result;
}

void LCHLinkedListAddObject(LCHLinkedList *list, void *object) {
    if (NULL != list && NULL != object) {
        LCHLinkedListNode *node = LCHLinkedListNodeCreateWithObject(object);
        
        LCHLinkedListNodeSetNextNode(node, LCHLinkedListHead(list));
        LCHLinkedListSetHead(list, node);
        LCHLinkedListSetCount(list, LCHLinkedListCount(list) + 1);
        
        LCHObjectRelease(node);
    }
}

void LCHLinkedListRemoveObject(LCHLinkedList *list, void *object) {
    if (NULL != list && NULL != object) {
        // Enumerator
    }
}

void LCHLinkedListRemoveAllObjects(LCHLinkedList *list) {
    if (NULL != list) {
        LCHLinkedListSetHead(list, NULL);
        LCHLinkedListSetCount(list, 0);
    }
}

#pragma mark -
#pragma mark Private Implementations
