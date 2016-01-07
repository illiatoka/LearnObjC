#import "LCHEmployee.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite)    NSUInteger  wallet;

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object;

- (void)notifyObserversOnMainThredWithObject:(id)object;

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

- (void)notifyObserversOnMainThredWithObject:(id)object {
    [self notifyWithSelector:[self selectorForState:self.state] withObject:self];
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver {
    @synchronized(self) {
        if ([self canGiveMoney:money]) {
            [receiver takeMoney:money];
            self.wallet -= money;
        }
    }
    
}

- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver {
    @synchronized(self) {
        NSUInteger money = self.wallet;
        
        if (0 < money) {
            self.wallet -= money;
            [receiver takeMoney:money];
        }
    }
    
}

- (void)takeMoney:(NSUInteger)money {
    @synchronized(self) {
        self.wallet += money;
    }
    
}

- (BOOL)canGiveMoney:(NSUInteger)money {
    return self.wallet > money;
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
        
        [self performSelectorOnMainThread:@selector(notifyObserversOnMainThredWithObject:)
                               withObject:self
                            waitUntilDone:YES];
    }
}

@end
