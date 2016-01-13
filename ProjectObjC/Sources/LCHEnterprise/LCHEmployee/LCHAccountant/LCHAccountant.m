#import "LCHAccountant.h"
#import "LCHWasherman.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public Implementations

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.moneyAmount);
}

#pragma mark -
#pragma mark Private Implementations

- (void)processObject:(LCHWasherman *)object {
    @autoreleasepool {
        @synchronized(self) {
            [object giveAllMoneyToReceiver:self];
            [self countMoney];
        }
    }
}

- (void)finishProcessingObject:(LCHWasherman *)object {
    @synchronized(self) {
        object.state = kLCHEmployeeDidBecomeFree;
        self.state = kLCHEmployeeDidFinishWork;
    }
}

@end
