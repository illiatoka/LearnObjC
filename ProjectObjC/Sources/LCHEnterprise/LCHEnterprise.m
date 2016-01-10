#import "LCHEnterprise.h"
#import "LCHContainer.h"
#import "LCHController.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHEnterprise ()
@property (nonatomic, retain)   LCHContainer    *employees;
@property (nonatomic, retain)   LCHController   *controller;

- (void)hireStaff;
- (void)retireStaff;

@end

@implementation LCHEnterprise

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self retireStaff];
    
    self.employees = nil;
    self.controller = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.employees = [LCHContainer object];
        self.controller = [LCHController controllerWithEnterprise:self];
        
        [self hireStaff];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithCar:(LCHCar *)car {
    [self.controller performWorkWithObject:(id<LCHCashProtocol>)car];
}

- (void)performWorkWithCars:(NSArray *)cars {
    [self.controller performWorkWithObjects:cars];
}

#pragma mark -
#pragma mark Private Implementations

- (void)hireStaff {
    LCHContainer *employeesContainer = self.employees;
    NSArray *employees = @[[LCHWasherman object], [LCHWasherman object], [LCHAccountant object], [LCHManager object]];
    
    for (id employee in employees) {
        [employee addObserver:self.controller];
        [employeesContainer addItem:employee];
    }
}

- (void)retireStaff {
    LCHController *controller = self.controller;
    for (id employee in self.employees.items) {
        [employee removeObserver:controller];
    }
}

@end
