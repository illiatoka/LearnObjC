#include <assert.h>

#include "LCHLinkedListEnumerator.h"
#include "LCHLinkedListPrivate.h"
#include "LCHLinkedListNode.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHLinkedListEnumerator {
    LCHObject _super;
    LCHLinkedList *_list;
    LCHLinkedListNode *_currentNode;
    uint64_t _mutationsCount;
    bool _valid;
};

static
LCHLinkedList *LCHLinkedListEnumeratorList(LCHLinkedListEnumerator *enumerator);

static
void LCHLinkedListEnumeratorSetList(LCHLinkedListEnumerator *enumerator, LCHLinkedList *list);

static
void LCHLinkedListEnumeratorSetCurrentNode(LCHLinkedListEnumerator *enumerator, LCHLinkedListNode *currentNode);

static
uint64_t LCHLinkedListEnumeratorMutationsCount(LCHLinkedListEnumerator *enumerator);

static
void LCHLinkedListEnumeratorSetMutationsCount(LCHLinkedListEnumerator *enumerator, uint64_t mutationsCount);

static
void LCHLinkedListEnumeratorSetValid(LCHLinkedListEnumerator *enumerator, bool valid);

static
bool LCHLinkedListEnumeratorValidate(LCHLinkedListEnumerator *enumerator);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHLinkedListEnumeratorDeallocate(void *enumerator) {
    LCHLinkedListEnumeratorSetList(enumerator, NULL);
    LCHLinkedListEnumeratorSetCurrentNode(enumerator, NULL);
    __LCHObjectDeallocate(enumerator);
}

LCHLinkedListEnumerator *LCHLinkedListEnumeratorCreateWithList(LCHLinkedList *list) {
    LCHLinkedListEnumerator *enumerator = NULL;
    
    if (NULL != list || NULL != LCHLinkedListHead(list)) {
        enumerator = LCHObjectCreateOfType(LCHLinkedListEnumerator);
        LCHLinkedListEnumeratorSetList(enumerator, list);
        LCHLinkedListEnumeratorSetMutationsCount(enumerator, LCHLinkedListMutationsCount(list));
        LCHLinkedListEnumeratorSetValid(enumerator, true);
    }
    
    return enumerator;
}

#pragma mark -
#pragma mark Accessors

LCHLinkedList *LCHLinkedListEnumeratorList(LCHLinkedListEnumerator *enumerator) {
    LCHObjectIvarGetter(enumerator, enumerator->_list, NULL);
}

void LCHLinkedListEnumeratorSetList(LCHLinkedListEnumerator *enumerator, LCHLinkedList *list) {
    LCHObjectRetainSetter(enumerator, _list, list);
}

LCHLinkedListNode *LCHLinkedListEnumeratorCurrentNode(LCHLinkedListEnumerator *enumerator) {
    LCHObjectIvarGetter(enumerator, enumerator->_currentNode, NULL);
}

void LCHLinkedListEnumeratorSetCurrentNode(LCHLinkedListEnumerator *enumerator, LCHLinkedListNode *currentNode) {
    LCHObjectRetainSetter(enumerator, _currentNode, currentNode);
}

uint64_t LCHLinkedListEnumeratorMutationsCount(LCHLinkedListEnumerator *enumerator) {
    LCHObjectIvarGetter(enumerator, enumerator->_mutationsCount, 0);
}

void LCHLinkedListEnumeratorSetMutationsCount(LCHLinkedListEnumerator *enumerator, uint64_t mutationsCount) {
    LCHObjectAssignSetter(enumerator, _mutationsCount, mutationsCount);
}

bool LCHLinkedListEnumeratorIsValid(LCHLinkedListEnumerator *enumerator) {
    bool result = false;
    
    if (NULL != enumerator) {
        LCHLinkedList *list = LCHLinkedListEnumeratorList(enumerator);

        result = (true == enumerator->_valid
                 && LCHLinkedListMutationsCount(list) == LCHLinkedListEnumeratorMutationsCount(enumerator));
    }
    
    return result;
}

void LCHLinkedListEnumeratorSetValid(LCHLinkedListEnumerator *enumerator, bool valid) {
    LCHObjectAssignSetter(enumerator, _valid, valid);
}

#pragma mark -
#pragma mark Public Implementations

void *LCHLinkedListEnumeratorNextObject(LCHLinkedListEnumerator *enumerator) {
    void *object = NULL;
    
    if (NULL != enumerator && LCHLinkedListEnumeratorValidate(enumerator)) {
        LCHLinkedList *list = LCHLinkedListEnumeratorList(enumerator);
        LCHLinkedListNode *node = LCHLinkedListEnumeratorCurrentNode(enumerator);
        
        node = (NULL != node ? LCHLinkedListNodeNextNode(node) : LCHLinkedListHead(list));
        
        LCHLinkedListEnumeratorSetCurrentNode(enumerator, node);
        
        object = LCHLinkedListNodeObject(node);
        
        if (NULL == node) {
            LCHLinkedListEnumeratorSetValid(enumerator, false);
        }
    }
    
    return object;
}

#pragma mark -
#pragma mark Private Implementations

bool LCHLinkedListEnumeratorValidate(LCHLinkedListEnumerator *enumerator) {
    bool valid = LCHLinkedListEnumeratorIsValid(enumerator);
    
    assert(valid);
    
    return valid;
}
