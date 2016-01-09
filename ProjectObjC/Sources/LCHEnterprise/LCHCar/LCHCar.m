#import "LCHCar.h"

static const NSUInteger kLCHInitialMoney = 20;

@interface LCHCar ()
@property (nonatomic, readwrite)    NSUInteger  wallet;

@end

@implementation LCHCar

#pragma mark -
#pragma mark Class Methods

+ (instancetype)car {
    return [[[self alloc] initWithMoney:kLCHInitialMoney] autorelease];
}

+ (instancetype)carWithMoney:(NSUInteger)money {
    return [[[self alloc] initWithMoney:money] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithMoney:(NSUInteger)money {
    self = [self init];
    if (self) {
        self.wallet = money;
    }
    
    return self;
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver {
    @synchronized(self) {
        [self giveMoney:money];
        [receiver takeMoney:money];
    }
}

- (void)giveMoney:(NSUInteger)money {
    self.wallet -= money;
}

- (void)takeMoney:(NSUInteger)money {
    self.wallet += money;
}

@end
