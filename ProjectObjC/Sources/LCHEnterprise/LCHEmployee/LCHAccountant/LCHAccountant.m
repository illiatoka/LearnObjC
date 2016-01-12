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

- (void)finishProcessingWithObject:(LCHWasherman *)object {
    @synchronized(self) {
        object.state = kLCHEmployeeDidBecomeFree;
        self.state = kLCHEmployeeDidFinish;
    }
}

@end
