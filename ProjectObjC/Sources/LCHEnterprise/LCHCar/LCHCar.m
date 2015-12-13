#import "LCHCar.h"

static const NSUInteger kLCHInitialMoney = 20;

@interface LCHCar ()
@property (nonatomic, readwrite, retain)    id          privateReceiver;
@property (nonatomic, readwrite, assign)    NSUInteger  privateWallet;

@end

@implementation LCHCar
@dynamic wallet;
@dynamic receiver;

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

- (void)dealloc {
    self.privateReceiver = nil;
    
    [super dealloc];
}

- (instancetype)initWithMoney:(NSUInteger)money {
    self = [self init];
    
    if (self) {
        self.privateWallet = money;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)wallet {
    return self.privateWallet;
}

- (id)receiver {
    return self.privateReceiver;
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money {
    if ([self canGiveMoney:money]) {
        if (self.receiver) {
            [self.receiver takeMoney:money];
            self.privateWallet = self.privateWallet - money;
        }
    }
}

- (void)takeMoney:(NSUInteger)money {
    self.privateWallet = self.privateWallet + money;
}

- (BOOL)canGiveMoney:(NSUInteger)money {
    return self.privateWallet > money;
}

- (void)addMoneyReceiver:(id)receiver {
    self.privateReceiver = receiver;
}

- (void)removeMoneyReceiver {
    self.privateReceiver = nil;
}

@end
