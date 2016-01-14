#import "LCHAccountant.h"
#import "LCHWasherman.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.moneyAmount);
}

#pragma mark -
#pragma mark Private

- (void)processObject:(LCHWasherman *)object {
    @autoreleasepool {
        @synchronized(self) {
            [object giveAllMoneyToReceiver:self];
            [self countMoney];
        }
    }
}

@end
