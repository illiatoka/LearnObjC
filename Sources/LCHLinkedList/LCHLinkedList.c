#include "LCHLinkedList.h"
#include "LCHLinkedListPrivate.h"
#include "LCHLinkedListNode.h"
#include "LCHLinkedListEnumerator.h"
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
    
    if (NULL != list) {
        LCHLinkedListNode *node = LCHLinkedListHead(list);
        
        while (NULL != node) {
            if (object == LCHLinkedListNodeObject(node)) {
                result = true;

                break;
            }
            
            node = LCHLinkedListNodeNextNode(node);
        }
    }
    
//    if (NULL != list) {
//        uint64_t count = LCHLinkedListCount(list);
//        
//        while (count--) {
//            LCHLinkedListEnumerator *enumerator = LCHLinkedListEnumeratorCreateWithList(list);
//            
//            if (LCHLinkedListEnumeratorNextObject(enumerator) == object) {
//                result = true;
//                
//                break;
//            }
//            
//            LCHObjectRelease(enumerator);
//        }
//    }
    
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
        LCHLinkedListNode *node = LCHLinkedListHead(list);
        LCHLinkedListNode *previousNode = NULL;
        
        while (NULL != node) {
            LCHLinkedListNode *nextNode = LCHLinkedListNodeNextNode(node);
            
            if (object == LCHLinkedListNodeObject(node)) {
                if (node == LCHLinkedListHead(list)) {
                    LCHLinkedListSetHead(list, nextNode);
                } else {
                    LCHLinkedListNodeSetNextNode(previousNode, nextNode);
                }
                
                LCHLinkedListSetCount(list, LCHLinkedListCount(list) - 1);
                
                break;
            }
            
            previousNode = node;
            node = nextNode;
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
