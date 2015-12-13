#import "LCHEmployee.h"

static const NSUInteger kLCHInitialSalary = 20;
static const NSUInteger kLCHInitialExperience = 1;

@interface LCHEmployee ()
@property (nonatomic, readwrite, assign)    NSUInteger  privateWallet;

@property (nonatomic, readwrite, retain)    id  privateReceiver;
@property (nonatomic, readwrite, assign)    id  privateParrentRoom;

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
    self.privateReceiver = nil;
    
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
    return self.privateWallet;
}

- (id)receiver {
    return self.privateReceiver;
}

- (id)parrentRoom {
    return self.privateParrentRoom;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performEmployeeSpecificOperationWithPrise:(NSUInteger)price {
    
}

- (void)__addParrentRoom:(id)room {
    self.privateParrentRoom = room;
}

- (void)__removeParrentRoom {
    self.privateParrentRoom = nil;
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
