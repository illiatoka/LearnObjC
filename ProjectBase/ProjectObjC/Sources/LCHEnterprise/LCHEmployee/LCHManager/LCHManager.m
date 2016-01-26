#import "LCHManager.h"
#import "LCHAccountant.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public

- (void)countProfit {
    if (0 == (self.moneyAmount % 1000000)) {
        NSLog(@"Manager profit is %lu", self.moneyAmount);
    }
}

#pragma mark -
#pragma mark LCHEmployee

- (void)processObject:(LCHAccountant *)object {
    [object giveAllMoneyToReceiver:self];
    [self countProfit];
}

- (void)cleanupAfterProcessing {
    self.state = kLCHEmployeeDidBecomeFree;
}

@end
