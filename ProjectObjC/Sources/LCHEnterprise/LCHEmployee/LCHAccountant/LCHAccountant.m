#import "LCHAccountant.h"
#import "LCHWasherman.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public Implementations

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.wallet);
}

#pragma mark -
#pragma mark Private Implementations

- (void)processWithObject:(LCHWasherman *)object {
    @autoreleasepool {
        @synchronized(self) {
            [object giveAllMoneyToReceiver:self];
            [self countMoney];
        }
    }
}

- (void)finishWithObject:(LCHWasherman *)object {
    @synchronized(self) {
        object.state = kLCHObjectIsFree;
        self.state = kLCHObjectFinished;
    }
}

@end
