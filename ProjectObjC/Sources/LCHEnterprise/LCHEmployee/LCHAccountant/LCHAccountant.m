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
        [object giveAllMoneyToReceiver:self];
        [self countMoney];
    }
}

- (void)finishWithObject:(LCHWasherman *)object {
    object.state = kLCHEmployeeIsFree;
    self.state = kLCHEmployeeIsFinished;
}

@end
