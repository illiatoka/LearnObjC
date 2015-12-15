#import "LCHEmployee.h"
#import "LCHEmployee_Privat.h"

static const NSUInteger kLCHInitialSalary = 20;
static const NSUInteger kLCHInitialExperience = 1;

@interface LCHEmployee ()
@property (nonatomic, readwrite, assign)    NSUInteger  blablaWallet;

@property (nonatomic, readwrite, retain)    id  blablaReceiver;
@property (nonatomic, readwrite, assign)    id  parentRoom;

@end


@implementation LCHEmployee
@dynamic wallet;
@dynamic receiver;
@dynamic parrentRoom;

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

- (void)dealloc {
    self.blablaReceiver = nil;
    
    [super dealloc];
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
#pragma mark Accessors

- (NSUInteger)wallet {
    return self.blablaWallet;
}

- (id)receiver {
    return self.blablaReceiver;
}

- (id)parrentRoom {
    return self.parentRoom;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performEmployeeSpecificOperationWithPrice:(NSUInteger)price {
    
}

- (void)addParentRoom:(id)room {
    self.parentRoom = room;
}

- (void)removeParentRoom {
    self.parentRoom = nil;
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
