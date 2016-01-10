#import "LCHAccountantDispatcher.h"
#import "LCHAccountant.h"
#import "LCHQueue.h"

@implementation LCHAccountantDispatcher

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(id)object {
    LCHAccountant *accountant = [self freeHandlerOfClass:[LCHAccountant class]];
    if (accountant) {
        [accountant performWorkWithObject:object];
    } else {
        [self.queue addToQueue:object];
    }
}

@end
