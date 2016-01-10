#import "LCHWashermanDispatcher.h"
#import "LCHWasherman.h"
#import "LCHQueue.h"

@implementation LCHWashermanDispatcher

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(id)object {
    LCHWasherman *washerman = [self freeHandlerOfClass:[LCHWasherman class]];
    if (washerman) {
        [washerman performWorkWithObject:object];
    } else {
        [self.queue addToQueue:object];
    }
}

@end
