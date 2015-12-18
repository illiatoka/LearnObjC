#import "LCHEmployee.h"

@class LCHCar;

@interface LCHWasherman : LCHEmployee <LCHCashProtocol>

- (void)washCar:(LCHCar *)car;

@end
