#import "LCHEmployee.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite, assign)    NSUInteger  wallet;

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

- (void)performAsyncWorkWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObject:) withObject:object];
}

#pragma mark -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)notifyObserversOnMainThredWithObject:(id)object {
    [self notifyWithSelector:[self selectorForState:kLCHEmployeeProcessingNeeded] withObject:self withObject:object];
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver {
    if ([self canGiveMoney:money]) {
        [receiver takeMoney:money];
        self.wallet -= money;
    }
}

- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver {
    NSUInteger money = self.wallet;
    
    if (0 < money) {
        self.wallet -= money;
        [receiver takeMoney:money];
    }
}

- (void)takeMoney:(NSUInteger)money {
    self.wallet += money;
}

- (BOOL)canGiveMoney:(NSUInteger)money {
    return self.wallet > money;
}

#pragma mark -
#pragma mark LCHStateProtocol

- (void)employeeDidFinishWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorOnMainThread:@selector(notifyObserversOnMainThredWithObject:)
                           withObject:object
                        waitUntilDone:YES];
}

- (SEL)selectorForState:(LCHEmployeeState)state {
    if (kLCHEmployeeProcessingNeeded == state) {
        return @selector(employeeProcessingNeeded:);
    }
    
    return NULL;
}

- (void)setState:(LCHEmployeeState)state {
    if (_state != state) {
        if (kLCHEmployeeIsWorking == state) {
            _state = state;
        } else if (kLCHEmployeeProcessingNeeded == state) {
            _state = state;
            [self notifyWithSelector:@selector(performAsyncWorkWithObject:) withObject:self];
        } else if (kLCHEmployeeIsFree == state) {
            _state = state;
        }
    }
}

@end
