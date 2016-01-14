#import "LCHEmployee.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite)    NSUInteger  moneyAmount;

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object;
- (void)finishProcessingOnMainThreadWithObject:(id<LCHCashProtocol>)object;

- (void)processObject:(id<LCHCashProtocol>)object;
- (void)finishProcessingObject:(id<LCHCashProtocol>)object;
- (void)completeProcessingObject:(id<LCHCashProtocol>)object;
- (void)cleanupAfterProcessing;

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
    [self processObject:object];
    [self finishProcessingOnMainThreadWithObject:object];
}

- (void)finishProcessingOnMainThreadWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorOnMainThread:@selector(finishProcessingObject:) withObject:object waitUntilDone:YES];
}

- (void)processObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishProcessingObject:(id<LCHCashProtocol>)object {
    [self completeProcessingObject:object];
    [self cleanupAfterProcessing];
}

- (void)completeProcessingObject:(LCHEmployee *)object {
    @synchronized(self) {
        object.state = kLCHEmployeeDidBecomeFree;
    }
}

- (void)cleanupAfterProcessing {
    @synchronized(self) {
        self.state = kLCHEmployeeDidFinishWork;
    }
}

#pragma mark -
#pragma mark LCHObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case kLCHEmployeeDidStartWork:
            return @selector(employeeDidStartWork:);
            
        case kLCHEmployeeDidFinishWork:
            return @selector(employeeDidFinishWork:);
            
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
        NSUInteger money = self.moneyAmount;
        if (0 < money) {
            [self giveMoney:money];
            [receiver takeMoney:money];
        }
    }
}

- (void)giveMoney:(NSUInteger)money {
    @synchronized(self) {
        self.moneyAmount -= money;
    }
}

- (void)takeMoney:(NSUInteger)money {
    @synchronized(self) {
        self.moneyAmount += money;
    }
}

@end
