#import "LCHAccountant.h"
#import "LCHWasherman.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public Implementations

- (void)countMoney {
    sleep(arc4random_uniform(2));
    
    NSLog(@"Accountant money count is: %lu", self.wallet);
}

#pragma mark -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(LCHWasherman *)object {
    @autoreleasepool {
        @synchronized(self) {
            [object giveAllMoneyToReceiver:self];
            [self countMoney];
            
            [self employeeDidFinishWithObject:object];
        }
    }
}

@end
