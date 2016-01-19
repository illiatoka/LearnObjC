#import "LCHAccountant.h"
#import "LCHWasherman.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.moneyAmount);
}

#pragma mark -
#pragma mark LCHEmployee

- (void)processObject:(LCHWasherman *)object {
    [object giveAllMoneyToReceiver:self];
    [self countMoney];
}

@end
