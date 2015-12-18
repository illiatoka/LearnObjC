#import "LCHAccountant.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public Implementations

- (void)performEmployeeSpecificOperationWithObject:(id<LCHCashProtocol>)object {
    [object giveAllMoneyToReceiver:self];
    [self countMoney];
}

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.wallet);
}

@end
