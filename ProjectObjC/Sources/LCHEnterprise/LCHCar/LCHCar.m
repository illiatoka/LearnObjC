#import "LCHCar.h"

static const NSUInteger kLCHInitialMoney = 20;

@interface LCHCar ()
// TODO: Give a proper name for this properties
@property (nonatomic, readwrite, retain)    id          blablaReceiver;
@property (nonatomic, readwrite, assign)    NSUInteger  blablaWallet;

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
    self.blablaReceiver = nil;
    
    [super dealloc];
}

- (instancetype)initWithMoney:(NSUInteger)money {
    self = [self init];
    
    if (self) {
        self.blablaWallet = money;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)wallet {
    return self.blablaWallet;
}

- (id)receiver {
    return self.blablaReceiver;
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money {
    if ([self canGiveMoney:money]) {
        if (self.receiver) {
            [self.receiver takeMoney:money];
            self.blablaWallet = self.blablaWallet - money;
        }
    }
}

- (void)takeMoney:(NSUInteger)money {
    self.blablaWallet = self.blablaWallet + money;
}

- (BOOL)canGiveMoney:(NSUInteger)money {
    return self.blablaWallet > money;
}

- (void)addMoneyReceiver:(id)receiver {
    self.blablaReceiver = receiver;
}

- (void)removeMoneyReceiver {
    self.blablaReceiver = nil;
}

@end
