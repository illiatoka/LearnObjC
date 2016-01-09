#import "LCHEmployee.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite)    NSUInteger  wallet;

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object;

- (void)stateDidChange;

- (void)notifyObserversOnMainThred;

@end

@implementation LCHEmployee

@synthesize state = _state;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = kLCHEmployeeIsFree;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Imlementations

- (void)performWorkWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObject:) withObject:object];
}

#pragma mark -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)stateDidChange {
    [self performSelectorOnMainThread:@selector(notifyObserversOnMainThred)
                           withObject:nil
                        waitUntilDone:YES];
}

- (void)notifyObserversOnMainThred {
    [self notifyWithSelector:[self selectorForState:self.state] withObject:self];
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver {
    @synchronized(self) {
        [self giveMoney:money];
        [receiver takeMoney:money];
    }
}

- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver {
    @synchronized(self) {
        NSUInteger money = self.wallet;
        if (0 < money) {
            [self giveMoney:money];
            [receiver takeMoney:money];
        }
    }
}

- (void)giveMoney:(NSUInteger)money {
    self.wallet -= money;
}

- (void)takeMoney:(NSUInteger)money {
    self.wallet += money;
}

#pragma mark -
#pragma mark LCHStateProtocol

- (SEL)selectorForState:(LCHEmployeeState)state {
    if (kLCHEmployeeIsWorking == state) {
        return @selector(employeeDidStartWork:);
    } else if (kLCHEmployeeIsFinished == state) {
        return @selector(employeeDidFinishWork:);
    } else if (kLCHEmployeeIsFree) {
        return @selector(employeeDidBecomeFree:);
    }
    
    return NULL;
}

- (void)setState:(LCHEmployeeState)state {
    if (_state != state) {
        _state = state;
        
        [self stateDidChange];
    }
}

@end
