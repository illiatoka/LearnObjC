#import "LCHEmployee.h"

@interface LCHAccountant : LCHEmployee <LCHCashProtocol>

- (void)performEmployeeSpecificOperationWithPrice:(NSUInteger)price;

@end
