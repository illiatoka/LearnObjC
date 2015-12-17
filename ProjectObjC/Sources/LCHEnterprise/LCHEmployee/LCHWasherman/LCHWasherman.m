#import "LCHWasherman.h"
#import "LCHCar.h"

@interface LCHWasherman ()
@property (nonatomic, readwrite, getter=isAbleToWash)   BOOL    ableToWash;

@property (nonatomic, readwrite, assign)    NSUInteger  wallet;

@end

@implementation LCHWasherman
@synthesize wallet = _wallet;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.ableToWash = YES;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)washCar:(LCHCar *)car {
    [car setClean:YES];
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver {
    NSUInteger money = self.wallet;
    
    if (0 < money) {
        self.wallet -= money;
        [receiver takeMoney:money];
    }
}

@end
