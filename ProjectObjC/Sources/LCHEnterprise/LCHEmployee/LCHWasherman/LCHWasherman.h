#import "LCHEmployee.h"

@class LCHCar;

@interface LCHWasherman : LCHEmployee <LCHCashProtocol>
@property (nonatomic, readonly, getter=isAbleToWash)    BOOL    ableToWash;

- (void)washCar:(LCHCar *)car;

@end
