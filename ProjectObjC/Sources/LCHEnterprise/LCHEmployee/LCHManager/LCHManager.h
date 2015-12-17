#import "LCHEmployee.h"

@interface LCHManager : LCHEmployee
@property (nonatomic, readonly, getter=isAbleToCountProfit) BOOL    ableToCountProfit;

- (void)countProfit;

@end
