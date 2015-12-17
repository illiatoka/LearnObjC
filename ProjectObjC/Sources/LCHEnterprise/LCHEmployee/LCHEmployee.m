#import "LCHEmployee.h"

static const NSUInteger kLCHInitialSalary = 20;
static const NSUInteger kLCHInitialExperience = 1;

@interface LCHEmployee ()
@property (nonatomic, readwrite, assign)    NSUInteger  wallet;

@end


@implementation LCHEmployee
@synthesize wallet = _wallet;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)employee {
    return [[[self alloc] initWithSalary:kLCHInitialSalary experience:kLCHInitialExperience] autorelease];
}

+ (instancetype)employeeWithSalary:(NSUInteger)salary experience:(NSUInteger)experience {
    return [[[self alloc] initWithSalary:salary experience:experience] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSalary:(NSUInteger)salary experience:(NSUInteger)experience {
    self = [self init];
    
    if (self) {
        self.salary = salary;
        self.experience = experience;
    }
    
    return self;
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver {
    if ([self canGiveMoney:money]) {
        [receiver takeMoney:money];
        self.wallet -= money;
    }
}

- (void)takeMoney:(NSUInteger)money {
    self.wallet += money;
}

- (BOOL)canGiveMoney:(NSUInteger)money {
    return self.wallet > money;
}

@end
