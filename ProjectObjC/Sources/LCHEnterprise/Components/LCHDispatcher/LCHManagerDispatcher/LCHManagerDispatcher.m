#import "LCHManagerDispatcher.h"
#import "LCHManager.h"
#import "LCHQueue.h"

@implementation LCHManagerDispatcher

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(id)object {
    LCHManager *manager = [self freeHandlerOfClass:[LCHManager class]];
    if (manager) {
        [manager performWorkWithObject:object];
    } else {
        [self.queue addToQueue:object];
    }
}

@end
