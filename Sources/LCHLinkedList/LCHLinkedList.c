#include <string.h>

#include "LCHLinkedList.h"
#include "LCHLinkedListPrivate.h"
#include "LCHLinkedListNode.h"
#include "LCHLinkedListEnumerator.h"
#include "LCHLinkedListEnumeratorPrivate.h"
#include "LCHObject.h"
#include "LCHMacro.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHLinkedList {
    LCHObject _super;
    LCHLinkedListNode *_head;
    uint64_t _count;
    uint64_t _mutationsCount;
};

static
void LCHLinkedListSetHead(LCHLinkedList *list, LCHLinkedListNode *node);

static
void LCHLinkedListSetCount(LCHLinkedList *list, uint64_t count);

static
void LCHLinkedListSetMutationsCount(LCHLinkedList *list, uint64_t mutationsCount);

static
void LCHLinkedListMutate(LCHLinkedList *list);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHLinkedListDeallocate(void *list) {
    LCHLinkedListRemoveAllObjects(list);
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
    if (NULL != list) {
        list->_count = count;
        LCHLinkedListMutate(list);
    }
}

uint64_t LCHLinkedListMutationsCount(LCHLinkedList *list) {
    LCHObjectIvarGetter(list, list->_mutationsCount, 0);
}

void LCHLinkedListSetMutationsCount(LCHLinkedList *list, uint64_t mutationsCount) {
    LCHObjectAssignSetter(list, _mutationsCount, mutationsCount);
}

#pragma mark -
#pragma mark Public Implementations

bool LCHLinkedListContainsObject(LCHLinkedList *list, void *object) {
    bool result = false;
    
    if (NULL != list && NULL !=object) {
        LCHLinkedListNodeContext context;
        
        memset(&context, 0, sizeof(context));
        context.object = object;
    
        result = NULL != LCHLinkedListFindNodeWithContext(list, LCHLinkedListNodeContainsObject, &context);
    }
    
    return result;
}

void LCHLinkedListAddObject(LCHLinkedList *list, void *object) {
    if (NULL != list && NULL != object) {
        if (false == LCHLinkedListContainsObject(list, object)) {
            LCHLinkedListNode *node = LCHLinkedListNodeCreateWithObject(object);
            
            LCHLinkedListNodeSetNextNode(node, LCHLinkedListHead(list));
            LCHLinkedListSetHead(list, node);
            LCHLinkedListSetCount(list, LCHLinkedListCount(list) + 1);
            
            LCHObjectRelease(node);
        }
    }
}

void LCHLinkedListRemoveObject(LCHLinkedList *list, void *object) {
    if (NULL != list && NULL != object) {
        LCHLinkedListNodeContext context;
        
        memset(&context, 0, sizeof(context));
        context.object = object;
        
        LCHLinkedListNode *node = LCHLinkedListFindNodeWithContext(list, LCHLinkedListNodeContainsObject, &context);
        
        if (NULL != node) {
            if (node == LCHLinkedListHead(list)) {
                LCHLinkedListSetHead(list, LCHLinkedListNodeNextNode(context.node));
            } else {
                LCHLinkedListNodeSetNextNode(context.previousNode, LCHLinkedListNodeNextNode(context.node));
            }
            
            LCHLinkedListSetCount(list, LCHLinkedListCount(list) - 1);
        }
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

void LCHLinkedListMutate(LCHLinkedList *list) {
    LCHLinkedListSetMutationsCount(list, LCHLinkedListMutationsCount(list) + 1);
}

LCHLinkedListNode *LCHLinkedListFindNodeWithContext(LCHLinkedList *list,
                                                LCHLinkedListNodeComparison comparator,
                                                LCHLinkedListNodeContext *context)
{
    LCHLinkedListNode *result = NULL;
    
    if (NULL != list) {
        LCHLinkedListEnumerator *enumerator = LCHLinkedListEnumeratorCreateWithList(list);
        
        while (true == LCHLinkedListEnumeratorIsValid(enumerator)) {
            LCHLinkedListNode *node = LCHLinkedListEnumeratorCurrentNode(enumerator);
            context->node = node;
            
            if (true == comparator(node, *context)) {
                result = node;
                
                break;
            }
            
            context->previousNode = node;
        }
        
        LCHObjectRelease(enumerator);
    }
    
    return result;
}

bool LCHLinkedListNodeContainsObject(LCHLinkedListNode *node, LCHLinkedListNodeContext context) {
    return NULL != node && context.object == LCHLinkedListNodeObject(node);
}
