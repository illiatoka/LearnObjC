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
    if (NULL != node) {
        assert(node != nextNode);
    }
    
    LCHObjectRetainSetter(node, _object, nextNode);
}

void *LCHLinkedListNodeObject(LCHLinkedListNode *node) {
    LCHObjectIvarGetter(node, node->_object, NULL);
}

void LCHLinkedListNodeSetObject(LCHLinkedListNode *node, void *object) {
    if (NULL != node) {
        assert(node != object);
    }
    
    LCHObjectRetainSetter(node, _object, object);
}
