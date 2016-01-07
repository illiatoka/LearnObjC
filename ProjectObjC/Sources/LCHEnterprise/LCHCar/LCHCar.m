#import "LCHCar.h"

static const NSUInteger kLCHInitialMoney = 20;

@interface LCHCar ()
@property (nonatomic, readwrite)    NSUInteger  wallet;

@end

@implementation LCHCar

@synthesize wallet = _wallet;

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
        if ([self canGiveMoney:money]) {
            [receiver takeMoney:money];
            self.wallet -= money;
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

@end
