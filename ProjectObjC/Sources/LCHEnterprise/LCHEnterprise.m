#import "LCHEnterprise.h"
#import "LCHObserverProtocol.h"

#import "LCHContainer.h"
#import "LCHQueue.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHEnterprise () <LCHObserverProtocol>
@property (nonatomic, retain)   LCHContainer    *employees;
@property (nonatomic, retain)   LCHQueue        *carsQueue;
@property (nonatomic, retain)   LCHQueue        *washermanQueue;
@property (nonatomic, retain)   LCHQueue        *accountantQueue;

- (void)hireStaff;

- (id)freeEmployeeOfClass:(Class)class;

- (void)performBackgroundWorkWithCar:(LCHCar *)car;
- (void)performBackgroundWorkWithCars:(NSSet *)cars;

@end

@implementation LCHEnterprise

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.employees = nil;
    self.carsQueue = nil;
    self.washermanQueue = nil;
    self.accountantQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.employees = [LCHContainer object];
        self.carsQueue = [LCHQueue object];
        self.washermanQueue = [LCHQueue object];
        self.accountantQueue = [LCHQueue object];
        
        [self hireStaff];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithCar:(LCHCar *)car {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithCar:) withObject:car];
}

- (void)performWorkWithCars:(NSSet *)cars {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithCars:) withObject:cars];
}

#pragma mark -
#pragma mark Private Implementations

- (void)hireStaff {
    LCHContainer *employeesContainer = self.employees;
    NSArray *employees = @[[LCHWasherman object], [LCHWasherman object], [LCHAccountant object], [LCHManager object]];
    
    for (id employee in employees) {
        [employee addObserver:self];
        [employeesContainer addItem:employee];
    }
}

- (id)freeEmployeeOfClass:(Class)class {
    for (id employee in self.employees.items) {
        if ([employee isMemberOfClass:class] && kLCHEmployeeIsFree == [employee state]) {
            @synchronized(employee) {
                if (kLCHEmployeeIsFree == [employee state]) {
                    [employee setState:kLCHEmployeeIsWorking];
                    
                    return employee;
                }
            }
        }
    }
    
    return nil;
}

- (void)performBackgroundWorkWithCar:(id<LCHCashProtocol>)car {
    @autoreleasepool {
        LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
        if (washerman) {
            [washerman performWorkWithObject:car];
        } else {
            [self.carsQueue addToQueue:car];
        }
    }
}

- (void)performBackgroundWorkWithCars:(NSSet *)cars {
    @autoreleasepool {
        for (LCHCar *car in cars) {
            [self performBackgroundWorkWithCar:car];
        }
    }
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)employeeDidFinishWork:(id)employee {
    if ([employee class] == [LCHWasherman class]) {
        LCHAccountant *accountant = [self freeEmployeeOfClass:[LCHAccountant class]];
        if (accountant) {
            [accountant performWorkWithObject:employee];
        } else {
            [self.washermanQueue addItem:employee];
        }
    } else if ([employee class] == [LCHAccountant class]) {
        LCHManager *manager = [self freeEmployeeOfClass:[LCHManager class]];
        if (manager) {
            [manager performWorkWithObject:employee];
        } else {
            [self.accountantQueue addItem:employee];
        }
    }
}

- (void)employeeDidBecomeFree:(id)employee {
    if ([employee class] == [LCHWasherman class]) {
        if (kLCHEmployeeIsFree == [employee state]) {
            @synchronized(employee) {
                if (kLCHEmployeeIsFree == [employee state]) {
                    LCHCar *car = [self.carsQueue nextObjectFromQueue];
                    if (car) {
                        [employee setState:kLCHEmployeeIsWorking];
                        [employee performWorkWithObject:(id<LCHCashProtocol>)car];
                    }
                }
            }
        }
    } else if ([employee class] == [LCHAccountant class]) {
        LCHWasherman *washerman = [self.washermanQueue nextObjectFromQueue];
        if (washerman) {
            [employee performWorkWithObject:washerman];
        }
    } else if ([employee class] == [LCHManager class]) {
        LCHAccountant *accountant = [self.accountantQueue nextObjectFromQueue];
        if (accountant) {
            [employee performWorkWithObject:accountant];
        }
    }
}

@end
