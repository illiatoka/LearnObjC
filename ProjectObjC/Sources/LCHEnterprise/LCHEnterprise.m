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

- (void)hireEmployees;

@end

@implementation LCHEnterprise

#pragma mark -
#pragma mark Initializations and Deallocations

// TODO: Add retireEmployee method
- (void)dealloc {
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
    
    for (id employee in washermans) {
        [self.washermanDispatcher.handlers addItem:employee];
        [employee addObserver:self];
        [employee addObserver:self.washermanDispatcher];
    }
    
    for (id employee in accountants) {
        [self.accountantDispatcher.handlers addItem:employee];
        [employee addObserver:self];
        [employee addObserver:self.accountantDispatcher];
    }
    
    for (id employee in managers) {
        [self.managerDispatcher.handlers addItem:employee];
        [employee addObserver:self.managerDispatcher];
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
