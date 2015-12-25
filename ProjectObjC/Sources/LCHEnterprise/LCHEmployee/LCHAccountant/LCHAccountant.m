#import "LCHAccountant.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public Implementations

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.wallet);
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)performAsyncWorkWithObject:(LCHWasherman *)object {
    self.state = kLCHEmployeeIsWorking;
    
    [object giveAllMoneyToReceiver:self];
    [object setState:kLCHEmployeeIsFree];
    
    [self countMoney];
    
    self.state = kLCHEmployeeIsOnHold;
    
    [self notifyWithSelector:@selector(performAsyncWorkWithObject:) withObject:self];
}

@end
