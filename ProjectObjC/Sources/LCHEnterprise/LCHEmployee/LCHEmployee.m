#import "LCHEmployee.h"

static const NSUInteger kLCHInitialSalary       = 20;
static const NSUInteger kLCHInitialExperience   = 1;

@interface LCHEmployee ()
@property (nonatomic, readwrite, assign)    NSUInteger          wallet;
@property (nonatomic, readwrite, assign)    LCHEmployeeState    state;

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object;

- (void)notifyObservesOnMainThredWithObject:(id)object;

@end

@implementation LCHEmployee
@synthesize wallet = _wallet;
@synthesize state = _state;

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

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.state = kLCHEmployeeIsReadyToWork;
    }
    
    return self;
}

- (instancetype)initWithSalary:(NSUInteger)salary experience:(NSUInteger)experience {
    self = [self init];
    
    if (self) {
        self.salary = salary;
        self.experience = experience;
    }
    
    return self;
}

#pragma mark -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(id<LCHCashProtocol>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)notifyObservesOnMainThredWithObject:(id)object {
    [self notifyWithSelector:[self selectorForState:kLCHEmployeeProcessingNeeded] withObject:self withObject:object];
}

#pragma mark -
#pragma mark LCHCashProtocol

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver {
    if ([self canGiveMoney:money]) {
        [receiver takeMoney:money];
        self.wallet -= money;
    }
}

- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver {
    NSUInteger money = self.wallet;
    
    if (0 < money) {
        self.wallet -= money;
        [receiver takeMoney:money];
    }
}

- (void)takeMoney:(NSUInteger)money {
    self.wallet += money;
}

- (BOOL)canGiveMoney:(NSUInteger)money {
    return self.wallet > money;
}

#pragma mark -
#pragma mark LCHStateProtocol

- (void)employeeDidFinishWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorOnMainThread:@selector(notifyObservesOnMainThredWithObject:)
                           withObject:object
                        waitUntilDone:YES];
}

- (SEL)selectorForState:(LCHEmployeeState)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

- (void)setStateIsWorking {
    self.state = kLCHEmployeeIsWorking;
}

- (void)setStateProcessingNeeded {
    self.state = kLCHEmployeeProcessingNeeded;
    [self notifyWithSelector:@selector(performAsyncWorkWithObject:) withObject:self];
}

- (void)setStateIsReadyToWork {
    self.state = kLCHEmployeeIsReadyToWork;
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)performAsyncWorkWithObject:(id<LCHCashProtocol>)object {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObject:) withObject:object];
}

@end
