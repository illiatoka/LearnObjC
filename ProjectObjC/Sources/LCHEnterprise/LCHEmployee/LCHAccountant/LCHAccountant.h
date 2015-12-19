#import "LCHEmployee.h"

@class LCHWasherman;

@interface LCHAccountant : LCHEmployee <LCHCashProtocol>

- (void)countMoney;

@end
