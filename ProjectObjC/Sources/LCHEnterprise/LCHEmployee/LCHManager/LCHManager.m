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

- (void)performBackgroundWorkWithObject:(LCHAccountant *)object {
    @autoreleasepool {
        [object giveAllMoneyToReceiver:self];
        object.state = kLCHEmployeeIsFree;
        
        [self countProfit];
        self.state = kLCHEmployeeIsFree;
    }
}

@end
