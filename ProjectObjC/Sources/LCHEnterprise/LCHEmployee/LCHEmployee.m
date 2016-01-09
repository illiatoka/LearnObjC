#import "LCHEmployee.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite)    NSUInteger  wallet;

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object;

- (void)processWithObject:(id<LCHCashProtocol>)object;
- (void)finishWithObject:(id<LCHCashProtocol>)object;
- (void)updateStateWithObject:(id<LCHCashProtocol>)object;

@end

@implementation LCHEmployee

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
    [self processWithObject:object];
    [self updateStateWithObject:object];
}

- (void)processWithObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishWithObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)updateStateWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorOnMainThread:@selector(finishWithObject:) withObject:object waitUntilDone:YES];
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

@end
