#import "LCHWasherman.h"
#import "LCHCar.h"
#import "LCHConstants.h"

@implementation LCHWasherman

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(LCHCar *)object {
    self.state = kLCHEmployeeIsWorking;
    
    [object giveMoney:kLCHDefaultPrice toReceiver:self];
    [self washCar:object];
    
    self.state = kLCHEmployeeIsOnHold;
    
    [self notifyWithSelector:@selector(performWorkWithObject:) withObject:self];
}

- (void)washCar:(LCHCar *)car {
    [car setClean:YES];
}

@end
