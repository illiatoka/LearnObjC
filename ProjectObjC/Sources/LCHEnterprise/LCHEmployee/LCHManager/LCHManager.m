#import "LCHManager.h"

@interface LCHManager ()
@property (nonatomic, readwrite, getter=isAbleToCountProfit)    BOOL    ableToCountProfit;

@end

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)countProfit {
    NSLog(@"Manager profit is %lu", self.wallet);
}

@end
