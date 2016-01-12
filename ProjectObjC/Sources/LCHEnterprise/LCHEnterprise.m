#import "LCHEnterprise.h"
#import "LCHContainer.h"
#import "LCHDispatcher.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHEnterprise ()
@property (nonatomic, retain)   LCHDispatcher   *washermanDispatcher;
@property (nonatomic, retain)   LCHDispatcher   *accountantDispatcher;
@property (nonatomic, retain)   LCHDispatcher   *managerDispatcher;
@property (nonatomic, retain)   LCHContainer    *employees;

- (void)hireEmployees;
- (void)retireEmployees;

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
#pragma mark Public Implementations

- (void)performWorkWithCar:(LCHCar *)car {
    [self.washermanDispatcher performWorkWithObject:car];
}

#pragma mark -
#pragma mark Private Implementations

// TODO: Is it possible and necessary to do something with this shit?!
- (void)hireEmployees {
    NSArray *washermans = @[[LCHWasherman object], [LCHWasherman object], [LCHWasherman object], [LCHWasherman object]];
    NSArray *accountants = @[[LCHAccountant object], [LCHAccountant object], [LCHAccountant object]];
    NSArray *managers = @[[LCHManager object], [LCHManager object]];
    
    LCHDispatcher *washermanDispatcher = self.washermanDispatcher;
    LCHDispatcher *accountantDispatcher = self.accountantDispatcher;
    LCHDispatcher *managerDispatcher = self.managerDispatcher;
    
    LCHContainer *washermanContainer = washermanDispatcher.handlers;
    LCHContainer *accountantContainer = accountantDispatcher.handlers;
    LCHContainer *managerContainer = managerDispatcher.handlers;
    LCHContainer *employees = self.employees;
    
    for (id employee in washermans) {
        [washermanContainer addItem:employee];
        [employees addItem:employee];
        [employee addObserver:self];
        [employee addObserver:washermanDispatcher];
    }
    
    for (id employee in accountants) {
        [accountantContainer addItem:employee];
        [employees addItem:employee];
        [employee addObserver:self];
        [employee addObserver:accountantDispatcher];
    }
    
    for (id employee in managers) {
        [managerContainer addItem:employee];
        [employees addItem:employee];
        [employee addObserver:managerDispatcher];
    }
}

// TODO: Is it possible and necessary to do something with this shit?!
- (void)retireEmployees {
    LCHDispatcher *washermanDispatcher = self.washermanDispatcher;
    LCHDispatcher *accountantDispatcher = self.accountantDispatcher;
    LCHDispatcher *managerDispatcher = self.managerDispatcher;
    NSArray *employees = self.employees.items;
    
    for (id employee in employees) {
        [employee removeObserver:self];
        [employee removeObserver:washermanDispatcher];
        [employee removeObserver:accountantDispatcher];
        [employee removeObserver:managerDispatcher];
    }
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)employeeDidFinish:(id)employee {
    if ([employee class] == [LCHWasherman class]) {
        [self.accountantDispatcher performWorkWithObject:employee];
    } else if ([employee class] == [LCHAccountant class]) {
        [self.managerDispatcher performWorkWithObject:employee];
    }
}

@end
