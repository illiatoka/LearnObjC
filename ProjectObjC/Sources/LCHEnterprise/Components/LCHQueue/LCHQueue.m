#import "LCHQueue.h"

@implementation LCHQueue

#pragma mark -
#pragma mark Public Implementations

- (void)enqueue:(id)object {
    @synchronized(self) {
        [self addItem:object];
    }
}

- (id)dequeue {
    @synchronized(self) {
        id object = [[self items] firstObject];
        if (object) {
            [[object retain] autorelease];
            [self removeItem:object];
        }
        
        return object;
    }
    
    return nil;
}

@end
