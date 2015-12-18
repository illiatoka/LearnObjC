#import "LCHManager.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)performEmployeeSpecificOperationWithObject:(id<LCHCashProtocol>)object {
    [object giveAllMoneyToReceiver:self];
    [self countProfit];
}

- (void)countProfit {
    NSLog(@"Manager profit is %lu", self.wallet);
}

@end
