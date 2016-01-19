#import "LCHEmployee.h"
#import "LCHDispatch.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite)    NSUInteger  moneyAmount;

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
#pragma mark Public

- (void)performWorkWithObject:(id<LCHCashProtocol>)object {
    LCHDispatchAsyncOnBackgroundQueue(^{
        [self processObject:object];
        
        LCHDispatchAsyncOnMainQueue(^{
            [self completeProcessingObject:object];
            [self cleanupAfterProcessing];
        });
    });
}

- (void)processObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)completeProcessingObject:(LCHEmployee *)object {
    object.state = kLCHEmployeeDidBecomeFree;
}

- (void)cleanupAfterProcessing {
    self.state = kLCHEmployeeDidFinishWork;
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
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver {
    [self giveMoney:money];
    [receiver takeMoney:money];
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
