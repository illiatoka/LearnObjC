#import "LCHWasherman.h"
#import "LCHCar.h"
#import "LCHConstants.h"

@implementation LCHWasherman

#pragma mark -
#pragma mark Public Implementations

- (void)performEmployeeSpecificOperationWithObject:(LCHCar *)object {
    [object giveMoney:kLCHDefaultPrice toReceiver:self];
    [self washCar:object];
}

- (void)washCar:(LCHCar *)car {
    [car setClean:YES];
}

@end
