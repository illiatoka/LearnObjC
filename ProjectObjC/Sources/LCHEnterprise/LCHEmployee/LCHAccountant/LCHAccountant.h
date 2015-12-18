#import "LCHEmployee.h"

@interface LCHAccountant : LCHEmployee <LCHCashProtocol>

- (void)countMoney;

@end
