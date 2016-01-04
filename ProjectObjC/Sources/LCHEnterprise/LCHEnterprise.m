#import "LCHEnterprise.h"
#import "LCHObserverProtocol.h"

#import "LCHContainer.h"
#import "LCHQueue.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHEnterprise () <LCHObserverProtocol>
@property (nonatomic, readwrite, retain) LCHContainer   *employees;
@property (nonatomic, readwrite, retain) LCHQueue       *queueOfCars;

- (void)hireBasicStuff;

- (id)freeEmployeeOfClass:(Class)class;

- (void)performBackgroundWorkWithCar:(LCHCar *)car;
- (void)performBackgroundWorkWithCars:(NSSet *)cars;

@end

@implementation LCHEnterprise

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.employees = nil;
    self.queueOfCars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.employees = [LCHContainer object];
        self.queueOfCars = [LCHQueue object];
        
        [self hireBasicStuff];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performAsyncWorkWithCar:(LCHCar *)car {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithCar:) withObject:car];
}

- (void)performAsyncWorkWithCars:(NSSet *)cars {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithCars:) withObject:cars];
}

#pragma mark -
#pragma mark Private Implementations

- (void)hireBasicStuff {
    NSArray *washermans = @[[LCHWasherman employee], [LCHWasherman employee]];
    LCHAccountant *accountant = [LCHAccountant employee];
    LCHManager *manager = [LCHManager employee];
    
    for (id washerman in washermans) {
        [washerman addObserver:accountant];
        [washerman addObserver:self];
        [self.employees addItem:washerman];
    }
    
    [accountant addObserver:manager];
    [accountant addObserver:self];
    
    [self.employees addItem:accountant];
    [self.employees addItem:manager];
}

- (id)freeEmployeeOfClass:(Class)class {
    NSSet *employees = self.employees.items;
    id result = nil;
    
    @synchronized(employees) {
        for (id employee in employees) {
            if ([employee isMemberOfClass:class] && kLCHEmployeeIsReadyToWork == [employee state]) {
                result = employee;
            }
        }
    }
    
    return result;
}

- (void)performBackgroundWorkWithCar:(id<LCHCashProtocol>)car {
    @autoreleasepool {
        LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
        
        if (washerman) {
            @synchronized(washerman) {
                if (kLCHEmployeeIsReadyToWork == [washerman state]) {
                    [washerman setStateIsWorking];
                    [washerman performAsyncWorkWithObject:car];
                } else {
                    [self.queueOfCars addToQueue:car];
                }
            }
        } else {
            [self.queueOfCars addToQueue:car];
        }
    }
}

- (void)performBackgroundWorkWithCars:(NSSet *)cars {
    @autoreleasepool {
        for (LCHCar *car in cars) {
            LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
            
            if (washerman) {
                [self performBackgroundWorkWithCar:car];
            } else {
                [self.queueOfCars addToQueue:car];
            }
        }
    }
}

#pragma mark -
#pragma mark LCHObservableProtocol

- (void)washerman:(id)washerman didFinishWithObject:(LCHCar *)object {
    id car = [self.queueOfCars nextObjectFromQueue];
    
    if (car) {
        [washerman performAsyncWorkWithObject:car];
    } else {
        [washerman setStateProcessingNeeded];
    }
}

- (void)accountant:(id)accountant didFinishWithObject:(LCHWasherman *)object {
    [object setStateIsReadyToWork];
    [accountant setStateProcessingNeeded];
}

@end
