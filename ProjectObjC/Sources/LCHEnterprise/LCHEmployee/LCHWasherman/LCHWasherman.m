#import "LCHWasherman.h"
#import "LCHCar.h"

@implementation LCHWasherman

#pragma mark -
#pragma mark Public Implementations

- (void)washCar:(LCHCar *)car {
    car.clean = YES;
}

#pragma mark -
#pragma mark Private Implementations

- (void)processWithObject:(LCHCar *)object {
    @autoreleasepool {
        [self washCar:object];
        [object giveMoney:kLCHDefaultPrice toReceiver:self];
    }
}

- (void)finishWithObject:(LCHCar *)object {
    self.state = kLCHEmployeeIsFinished;
}

@end
