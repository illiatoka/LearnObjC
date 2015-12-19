#import "LCHAccountant.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(LCHWasherman *)object {
    self.state = kLCHEmployeeIsWorking;
    
    [object giveAllMoneyToReceiver:self];
    [object setState:kLCHEmployeeIsFree];
    
    [self countMoney];
    
    self.state = kLCHEmployeeIsOnHold;
    
    [self notifyWithSelector:@selector(performWorkWithObject:) withObject:self];
}

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.wallet);
}

@end
