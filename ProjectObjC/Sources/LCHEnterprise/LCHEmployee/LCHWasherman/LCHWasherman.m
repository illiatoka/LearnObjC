#import "LCHWasherman.h"
#import "LCHCar.h"

@implementation LCHWasherman

#pragma mark -
#pragma mark Public

- (void)washCar:(LCHCar *)car {
    car.clean = YES;
}

#pragma mark -
#pragma mark LCHEmployee

- (void)processObject:(LCHCar *)object {
    @autoreleasepool {
        @synchronized(self) {
            [self washCar:object];
            [object giveMoney:kLCHDefaultPrice toReceiver:self];
        }
    }
}

- (void)completeProcessingObject:(id)object {
    
}

@end
