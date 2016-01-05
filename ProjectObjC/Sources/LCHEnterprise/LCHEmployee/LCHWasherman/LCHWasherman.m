#import "LCHWasherman.h"
#import "LCHCar.h"

@implementation LCHWasherman

#pragma mark -
#pragma mark Public Implementations

- (void)washCar:(LCHCar *)car {
    [car setClean:YES];
}

#pragma mark -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(LCHCar *)object {
    @autoreleasepool {
        if ([object canGiveMoney:kLCHDefaultPrice]) {
            [self washCar:object];
            [object giveMoney:kLCHDefaultPrice toReceiver:self];
        }
        
        [self employeeDidFinishWithObject:object];
    }
}

@end
