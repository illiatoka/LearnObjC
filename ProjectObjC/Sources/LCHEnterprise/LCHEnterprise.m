#import "LCHEnterprise.h"
#import "LCHDispatcher.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

static const NSUInteger kLCHDefaultWashermanCount   = 4;
static const NSUInteger kLCHDefaultAccountantCount  = 3;
static const NSUInteger kLCHDefaultManagerCount     = 2;

@interface LCHEnterprise ()
@property (nonatomic, retain)   LCHDispatcher   *washermanDispatcher;
@property (nonatomic, retain)   LCHDispatcher   *accountantDispatcher;
@property (nonatomic, retain)   LCHDispatcher   *managerDispatcher;
@property (nonatomic, retain)   NSMutableArray  *mutableEmployees;

- (void)hireEmployees;
- (void)retireEmployees;

- (void)setupEmployees:(NSArray *)employees withDispatcher:(LCHDispatcher *)dispatcher;

@end

@implementation LCHEnterprise

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self retireEmployees];
    
    self.washermanDispatcher = nil;
    self.accountantDispatcher = nil;
    self.managerDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.washermanDispatcher = [LCHDispatcher object];
        self.accountantDispatcher = [LCHDispatcher object];
        self.managerDispatcher = [LCHDispatcher object];
        
        [self hireEmployees];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)performWorkWithCar:(LCHCar *)car {
    [self.washermanDispatcher performWorkWithObject:car];
}

#pragma mark -
#pragma mark Private

- (void)hireEmployees {
    NSArray *washermen = [LCHWasherman objectsWithCount:kLCHDefaultWashermanCount];
    NSArray *accountants = [LCHAccountant objectsWithCount:kLCHDefaultAccountantCount];
    NSArray *managers = [LCHManager objectsWithCount:kLCHDefaultManagerCount];
    
    [self setupEmployees:washermen withDispatcher:self.washermanDispatcher];
    [self setupEmployees:accountants withDispatcher:self.accountantDispatcher];
    [self setupEmployees:managers withDispatcher:self.managerDispatcher];
}

- (void)retireEmployees {
    NSArray *observers = @[self, self.washermanDispatcher, self.accountantDispatcher, self.managerDispatcher];
    for (id employee in self.mutableEmployees) {
        [employee removeObserversFromArray:observers];
    }
    
    self.mutableEmployees = nil;
}

- (void)setupEmployees:(NSArray *)employees withDispatcher:(LCHDispatcher *)dispatcher {
    NSMutableArray *mutableEmployees = self.mutableEmployees;
    NSArray *observers = @[self, dispatcher];
    
    for (id employee in employees) {
        [dispatcher addHandler:employee];
        [mutableEmployees addObject:employee];
        [employee addObserversFromArray:observers];
    }
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)employeeDidFinishWork:(id)employee {
    if ([employee class] == [LCHWasherman class]) {
        [self.accountantDispatcher performWorkWithObject:employee];
    } else if ([employee class] == [LCHAccountant class]) {
        [self.managerDispatcher performWorkWithObject:employee];
    }
}

@end
