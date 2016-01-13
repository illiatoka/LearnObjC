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

- (void)processObject:(LCHCar *)object {
    @autoreleasepool {
        @synchronized(self) {
            [self washCar:object];
            [object giveMoney:kLCHDefaultPrice toReceiver:self];
        }
    }
}

- (void)finishProcessingObject:(LCHCar *)object {
    @synchronized(self) {
        self.state = kLCHEmployeeDidFinishWork;
    }
}

@end
