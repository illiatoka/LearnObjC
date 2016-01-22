#import "LCHAccountant.h"
#import "LCHWasherman.h"

@implementation LCHAccountant

#pragma mark -
#pragma mark Public

- (void)countMoney {

}

#pragma mark -
#pragma mark LCHEmployee

- (void)processObject:(LCHWasherman *)object {
    [object giveAllMoneyToReceiver:self];
    [self countMoney];
}

@end
