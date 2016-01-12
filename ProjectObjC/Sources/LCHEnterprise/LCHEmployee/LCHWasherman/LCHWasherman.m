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
        @synchronized(self) {
            [self washCar:object];
            [object giveMoney:kLCHDefaultPrice toReceiver:self];
        }
    }
}

- (void)finishProcessingWithObject:(LCHCar *)object {
    @synchronized(self) {
        self.state = kLCHEmployeeDidFinish;
    }
}

@end
