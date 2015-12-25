#import "LCHManager.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)countProfit {
    NSLog(@"Manager profit is %lu", self.wallet);
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)performAsyncWorkWithObject:(LCHAccountant *)object {
    self.state = kLCHEmployeeIsWorking;
    
    [object giveAllMoneyToReceiver:self];
    [object setState:kLCHEmployeeIsFree];
    
    [self countProfit];
    self.state = kLCHEmployeeIsFree;
}

@end
