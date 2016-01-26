#include <assert.h>

#include "LCHLinkedListNode.h"
#include "LCHObject.h"

#pragma mark -
#pragma mark Private Declarations

struct LCHLinkedListNode {
    LCHObject _super;
    LCHLinkedListNode *_nextNode;
    void *_object;
};

#pragma mark -
#pragma mark Initializations and Deallocation

void __LCHLinkedListNodeDeallocate(void *node) {
    LCHLinkedListNodeSetNextNode(node, NULL);
    LCHLinkedListNodeSetObject(node, NULL);
    __LCHObjectDeallocate(node);
}

LCHLinkedListNode *LCHLinkedListNodeCreateWithObject(void *object) {
    LCHLinkedListNode *node = LCHObjectCreateOfType(LCHLinkedListNode);
    LCHLinkedListNodeSetObject(node, object);
    
    return node;
}

#pragma mark -
#pragma mark Accessors

LCHLinkedListNode *LCHLinkedListNodeNextNode(LCHLinkedListNode *node) {
    LCHObjectIvarGetter(node, node->_nextNode, NULL);
}

void LCHLinkedListNodeSetNextNode(LCHLinkedListNode *node, LCHLinkedListNode *nextNode) {
    assert(NULL != node || node != nextNode);
    
    LCHObjectRetainSetter(node, _nextNode, nextNode);
}

void *LCHLinkedListNodeObject(LCHLinkedListNode *node) {
    LCHObjectIvarGetter(node, node->_object, NULL);
}

void LCHLinkedListNodeSetObject(LCHLinkedListNode *node, void *object) {
    assert(NULL != node || node != object);
    
    LCHObjectRetainSetter(node, _object, object);
}
