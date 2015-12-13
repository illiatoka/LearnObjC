#import "LCHEmployee.h"

@interface LCHAccountant : LCHEmployee <LCHCashProtocol>

- (void)performEmployeeSpecificOperationWithPrise:(NSUInteger)price;

@end
