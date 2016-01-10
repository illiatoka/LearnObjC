#import "LCHController.h"
#import "LCHObserverProtocol.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHController () <LCHObserverProtocol>
@property (nonatomic, assign)   LCHEnterprise   *enterprise;
@property (nonatomic, retain)   LCHQueue        *carsQueue;
@property (nonatomic, retain)   LCHQueue        *washermanQueue;
@property (nonatomic, retain)   LCHQueue        *accountantQueue;

- (void)performBackgroundWorkWithObject:(id)car;
- (void)performBackgroundWorkWithObjects:(NSArray *)cars;

- (id)freeEmployeeOfClass:(Class)class;

@end

@implementation LCHController

#pragma mark -
#pragma mark Class Methods

+ (instancetype)controllerWithEnterprise:(id)enterprise {
    return [[[self alloc] initWIthEnterprise:enterprise] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.carsQueue = nil;
    self.washermanQueue = nil;
    self.accountantQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.carsQueue = [LCHQueue object];
        self.washermanQueue = [LCHQueue object];
        self.accountantQueue = [LCHQueue object];
    }
    
    return self;
}

- (instancetype)initWIthEnterprise:(id)enterprise {
    self = [self init];
    if (self) {
        self.enterprise = enterprise;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(id)object {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObject:) withObject:object];
}

- (void)performWorkWithObjects:(NSArray *)objects {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObjects:) withObject:objects];
}

#pragma -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(id)car {
    @autoreleasepool {
        LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
        if (washerman) {
            [washerman performWorkWithObject:car];
        } else {
            [self.carsQueue addToQueue:car];
        }
    }
}

- (void)performBackgroundWorkWithObjects:(NSArray *)objects {
    @autoreleasepool {
        for (id object in objects) {
            [self performBackgroundWorkWithObject:object];
        }
    }
}

- (id)freeEmployeeOfClass:(Class)class {
    for (id employee in self.enterprise.employees.items) {
        if ([employee isMemberOfClass:class]) {
            @synchronized(employee) {
                if (kLCHObjectIsFree == [employee state]) {
                    [employee setState:kLCHObjectProcessed];
                    
                    return employee;
                }
            }
        }
    }
    
    return nil;
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
        id car = [self.carsQueue nextObjectFromQueue];
        if (car) {
            [self performWorkWithObject:(id)car];
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
