#import "LCHManager.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(LCHAccountant *)object {
    self.state = kLCHEmployeeIsWorking;
    
    [object giveAllMoneyToReceiver:self];
    [object setState:kLCHEmployeeIsFree];
    
    [self countProfit];
    self.state = kLCHEmployeeIsFree;
}

- (void)countProfit {
    NSLog(@"Manager profit is %lu", self.wallet);
}

@end
