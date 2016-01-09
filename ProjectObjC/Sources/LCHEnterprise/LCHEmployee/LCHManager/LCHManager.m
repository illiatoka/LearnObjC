#import "LCHManager.h"
#import "LCHAccountant.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)countProfit {
    NSLog(@"Manager profit is %lu", self.wallet);
}

#pragma mark -
#pragma mark Private Implementations

- (void)processWithObject:(LCHAccountant *)object {
    @autoreleasepool {
        [object giveAllMoneyToReceiver:self];
        [self countProfit];
    }
}

- (void)finishWithObject:(LCHAccountant *)object {
    object.state = kLCHEmployeeIsFree;
    self.state = kLCHEmployeeIsFree;
}

@end
