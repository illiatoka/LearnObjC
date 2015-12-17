#import "LCHEmployee.h"

@interface LCHAccountant : LCHEmployee <LCHCashProtocol>
@property (nonatomic, readonly, getter=isAbleToCountMoney)  BOOL    ableToCountMoney;

- (void)countMoney;

@end
