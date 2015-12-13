#import "LCHEmployee.h"

@interface LCHWasherman : LCHEmployee <LCHCashProtocol>
@property (nonatomic, readonly, getter=isAbleToWash) BOOL ableToWash;

- (void)performEmployeeSpecificOperationWithPrise:(NSUInteger)price;

@end
