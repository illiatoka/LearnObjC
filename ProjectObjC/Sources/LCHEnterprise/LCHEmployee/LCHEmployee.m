#import "LCHEmployee.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite)    NSUInteger  wallet;

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object;
- (void)finishProcessingOnMainThredWithObject:(id<LCHCashProtocol>)object;

- (void)processWithObject:(id<LCHCashProtocol>)object;
- (void)finishProcessingWithObject:(id<LCHCashProtocol>)object;

@end

@implementation LCHEmployee

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = kLCHEmployeeDidBecomeFree;
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
    [self finishProcessingOnMainThredWithObject:object];
}

- (void)finishProcessingOnMainThredWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorOnMainThread:@selector(finishProcessingWithObject:) withObject:object waitUntilDone:YES];
}

- (void)processWithObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishProcessingWithObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark LCHObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case kLCHEmployeeDidStart:
            return @selector(employeeDidStart:);
            
        case kLCHEmployeeDidFinish:
            return @selector(employeeDidFinish:);
            
        case kLCHEmployeeDidBecomeFree:
            return @selector(employeeDidBecomeFree:);
            
        default:
            return NULL;
    }
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
    @synchronized(self) {
        self.wallet -= money;
    }
}

- (void)takeMoney:(NSUInteger)money {
    @synchronized(self) {
        self.wallet += money;
    }
}

@end
