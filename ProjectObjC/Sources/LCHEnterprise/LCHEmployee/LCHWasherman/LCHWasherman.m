#import "LCHWasherman.h"
#import "LCHCar.h"
#import "LCHConstants.h"

@implementation LCHWasherman

#pragma mark -
#pragma mark Public Implementations

- (void)washCar:(LCHCar *)car {
    sleep(arc4random_uniform(3));
    
    [car setClean:YES];
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)performAsyncWorkWithObject:(LCHCar *)object {
    self.state = kLCHEmployeeIsWorking;
    
    [object giveMoney:kLCHDefaultPrice toReceiver:self];
    [self washCar:object];
    
    self.state = kLCHEmployeeIsOnHold;
    
    [self notifyWithSelector:@selector(performAsyncWorkWithObject:) withObject:self];
}

@end
