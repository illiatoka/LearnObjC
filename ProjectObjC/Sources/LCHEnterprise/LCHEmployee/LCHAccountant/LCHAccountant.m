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

- (void)performBackgroundWorkWithObject:(LCHWasherman *)object {
    @autoreleasepool {
        [object giveAllMoneyToReceiver:self];
        object.state = kLCHEmployeeIsFree;
        
        [self countMoney];
        self.state = kLCHEmployeeIsFinished;
    }
}

@end
