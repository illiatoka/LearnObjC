#import "LCHManager.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)countProfit {
    sleep(arc4random_uniform(3));
    
    NSLog(@"Manager profit is %lu", self.wallet);
}

#pragma mark -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object {
    @autoreleasepool {
        @synchronized(self) {
            [object giveAllMoneyToReceiver:self];
            [self countProfit];
            
            [self employeeDidFinishWithObject:object];
        }
    }
}

@end
