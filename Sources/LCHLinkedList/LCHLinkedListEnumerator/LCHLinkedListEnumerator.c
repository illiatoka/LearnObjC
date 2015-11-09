#include "LCHLinkedListEnumerator.h"
#include "LCHLinkedListPrivate.h"
#include "LCHLinkedListNode.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHLinkedListEnumerator {
    LCHObject _super;
    LCHLinkedList *_list;
    LCHLinkedListNode *_node;
    uint64_t _mutationsCount;
    bool _valid;
};

static
LCHLinkedList *LCHLinkedListEnumeratorList(LCHLinkedListEnumerator *enumerator);

static
void LCHLinkedListEnumeratorSetList(LCHLinkedListEnumerator *enumerator, LCHLinkedList *list);

static
void LCHLinkedListEnumeratorSetNode(LCHLinkedListEnumerator *enumerator, LCHLinkedListNode *node);

static
uint64_t LCHLinkedListEnumeratorMutationsCount(LCHLinkedListEnumerator *enumerator);

static
void LCHLinkedListEnumeratorSetMutationsCount(LCHLinkedListEnumerator *enumerator, uint64_t mutationsCount);

static
void LCHLinkedListEnumeratorSetIsValid(LCHLinkedListEnumerator *enumerator, bool valid);

static
bool LCHLinkedListEnumeratorValidate(LCHLinkedListEnumerator *enumerator);

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHLinkedListEnumeratorDeallocate(void *enumerator) {
    LCHLinkedListEnumeratorSetList(enumerator, NULL);
    LCHLinkedListEnumeratorSetNode(enumerator, NULL);
    __LCHObjectDeallocate(enumerator);
}

LCHLinkedListEnumerator *LCHLinkedListEnumeratorCreateWithList(LCHLinkedList *list) {
    LCHLinkedListEnumerator *enumerator = NULL;
    
    if (NULL != list || NULL != LCHLinkedListHead(list)) {
        enumerator = LCHObjectCreateOfType(LCHLinkedListEnumerator);
        LCHLinkedListEnumeratorSetList(enumerator, list);
        LCHLinkedListEnumeratorSetMutationsCount(enumerator, LCHLinkedListMutationsCount(list));
        LCHLinkedListEnumeratorSetIsValid(enumerator, true);
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

LCHLinkedListNode *LCHLinkedListEnumeratorNode(LCHLinkedListEnumerator *enumerator) {
    LCHObjectIvarGetter(enumerator, enumerator->_node, NULL);
}

void LCHLinkedListEnumeratorSetNode(LCHLinkedListEnumerator *enumerator, LCHLinkedListNode *node) {
    LCHObjectRetainSetter(enumerator, _node, node);
}

uint64_t LCHLinkedListEnumeratorMutationsCount(LCHLinkedListEnumerator *enumerator) {
    LCHObjectIvarGetter(enumerator, enumerator->_mutationsCount, 0);
}

void LCHLinkedListEnumeratorSetMutationsCount(LCHLinkedListEnumerator *enumerator, uint64_t mutationsCount) {
    LCHObjectAssignSetter(enumerator, _mutationsCount, mutationsCount);
}

bool LCHLinkedListEnumeratorIsValid(LCHLinkedListEnumerator *enumerator) {
    return NULL != enumerator && enumerator->_valid;
}

void LCHLinkedListEnumeratorSetIsValid(LCHLinkedListEnumerator *enumerator, bool valid) {
    LCHObjectAssignSetter(enumerator, _valid, valid);
}

#pragma mark -
#pragma mark Public Implementations

void *LCHLinkedListEnumeratorNextObject(LCHLinkedListEnumerator *enumerator) {
    void *object = NULL;
    
    if (NULL != enumerator && LCHLinkedListEnumeratorValidate(enumerator)) {
        LCHLinkedList *list = LCHLinkedListEnumeratorList(enumerator);
        LCHLinkedListNode *node = LCHLinkedListEnumeratorNode(enumerator);
        
        if (NULL != node) {
            node = LCHLinkedListNodeNextNode(node);
        } else {
            node = LCHLinkedListHead(list);
        }
        
        LCHLinkedListEnumeratorSetNode(enumerator, node);
        
        object = LCHLinkedListNodeObject(node);
    }
    
    return object;
}

#pragma mark -
#pragma mark Private Implementations

bool LCHLinkedListEnumeratorValidate(LCHLinkedListEnumerator *enumerator) {
    bool valid = false;
    
    if (LCHLinkedListEnumeratorIsValid(enumerator)) {
        LCHLinkedList *list = LCHLinkedListEnumeratorList(enumerator);
        
        if (LCHLinkedListMutationsCount(list) == LCHLinkedListEnumeratorMutationsCount(enumerator)) {
            valid = true;
        }
    }
    
    return valid;
}
