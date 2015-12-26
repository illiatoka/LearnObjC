#import "LCHQueue.h"

@implementation LCHQueue

#pragma mark -
#pragma mark Public Implementations

- (void)addToQueue:(id)object {
    @synchronized(self) {
        [self addItem:object];
    }
}

- (id)nextObjectFromQueue {
    id object = nil;
    
    @synchronized(self) {
        object = [[[self items] allObjects] firstObject];
        
        if (object) {
            [[object retain] autorelease];
            [self removeItem:object];
        }
    }
    
    return object;
}

@end
