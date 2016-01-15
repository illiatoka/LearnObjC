#import "LCHEmployee.h"

@interface LCHEmployee ()
@property (nonatomic, readwrite)    NSUInteger  moneyAmount;

- (void)processObject:(id<LCHCashProtocol>)object;
- (void)finishProcessingObject:(id<LCHCashProtocol>)object;

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
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        [self processObject:object];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self finishProcessingObject:object];
        });
    });
}

#pragma mark -
#pragma mark Private

- (void)processObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishProcessingObject:(id<LCHCashProtocol>)object {
    [self completeProcessingObject:object];
    [self cleanupAfterProcessing];
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
