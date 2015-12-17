#import "LCHAccountant.h"

@interface LCHAccountant ()
@property (nonatomic, readwrite, getter=isAbleToCountMoney) BOOL    ableToCountMoney;

@property (nonatomic, readwrite, assign)    NSUInteger  wallet;

@end

@implementation LCHAccountant
@synthesize wallet = _wallet;

#pragma mark -
#pragma mark Public Implementations

- (void)countMoney {
    NSLog(@"Accountant money count is: %lu", self.wallet);
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver {
    NSUInteger money = self.wallet;
    
    if (0 < money) {
        self.wallet -= money;
        [receiver takeMoney:money];
    }
}

@end
