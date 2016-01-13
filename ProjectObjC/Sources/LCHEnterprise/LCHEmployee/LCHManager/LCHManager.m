#import "LCHManager.h"
#import "LCHAccountant.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)countProfit {
    NSLog(@"Manager profit is %lu", self.moneyAmount);
}

#pragma mark -
#pragma mark Private Implementations

- (void)processObject:(LCHAccountant *)object {
    @autoreleasepool {
        @synchronized(self) {
            [object giveAllMoneyToReceiver:self];
            [self countProfit];
        }
    }
}

- (void)finishProcessingObject:(LCHAccountant *)object {
    @synchronized(self) {
        object.state = kLCHEmployeeDidBecomeFree;
        self.state = kLCHEmployeeDidBecomeFree;
    }
}

@end
