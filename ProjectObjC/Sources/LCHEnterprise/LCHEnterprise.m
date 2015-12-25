#import "LCHEnterprise.h"

#import "LCHContainer.h"
#import "LCHQueue.h"
#import "LCHConstants.h"

#import "LCHEmployee.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"

@interface LCHEnterprise ()
@property (nonatomic, readwrite, retain) LCHContainer   *mutableEmployees;
@property (nonatomic, readwrite, retain) LCHQueue       *queueOfCars;

- (void)hireAnEmployee:(LCHEmployee *)employee;

- (id)freeEmployeeOfClass:(Class)class;

- (void)performBackgroundWorkWithCar:(LCHCar *)car;
- (void)performBackgroundWorkWithCars:(NSSet *)cars;

@end

@implementation LCHEnterprise
@dynamic employees;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableEmployees = nil;
    self.queueOfCars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableEmployees = [LCHContainer object];
        self.queueOfCars = [LCHQueue object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)employees {
    return [self.mutableEmployees items];
}

#pragma mark -
#pragma mark Public Implementations

- (void)hireBasicStuff {
    LCHManager *manager = [LCHManager employee];
    LCHAccountant *accountant = [LCHAccountant employee];
    LCHWasherman *washerman = [LCHWasherman employee];
    LCHWasherman *washerman2 = [LCHWasherman employee];
    
    [washerman addObserver:accountant];
    [washerman2 addObserver:accountant];
    [accountant addObserver:manager];
    
    NSSet *employees = [NSSet setWithObjects:manager, accountant, washerman, washerman2, nil];
    
    for (LCHEmployee *employee in employees) {
        [self hireAnEmployee:employee];
    }
}

- (void)performAsyncWorkWithCar:(LCHCar *)car {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithCar:) withObject:car];
}

- (void)performAsyncWorkWithCars:(NSSet *)cars {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithCars:) withObject:cars];
}

#pragma mark -
#pragma mark Private Implementations

- (void)hireAnEmployee:(LCHEmployee *)employee {
    [self.mutableEmployees addItem:employee];
}

- (id)freeEmployeeOfClass:(Class)class {
    NSSet *employees = self.employees;
    id result = nil;
    
    @synchronized(employees) {
        for (id employee in employees) {
            if ([employee isMemberOfClass:class] && kLCHEmployeeIsFree == [employee state]) {
                result = employee;
            }
        }
    }
    
    return result;
}

- (void)performBackgroundWorkWithCar:(LCHCar *)car {
    @autoreleasepool {
        LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
       
        if (washerman) {
            @synchronized(washerman) {
                NSLog(@"Washerman %@ locked", washerman);
                
                if (kLCHEmployeeIsFree == [washerman state]) {
                    if ([car canGiveMoney:kLCHDefaultPrice]) {
                        [washerman performAsyncWorkWithObject:car];
                        
                        NSLog(@"Is car clean: %hhd Money is: %lu", car.isClean, car.wallet);
                    }
                } else {
                    [self.queueOfCars addToQueue:car];
                    NSLog(@"Car %@ added to Queue", car);
                }
            }
        } else {
            NSLog(@"Car %@ added to Queue", car);
            [self.queueOfCars addToQueue:car];
        }
    }
}

- (void)performBackgroundWorkWithCars:(NSSet *)cars {
    @autoreleasepool {
        for (LCHCar *car in cars) {
            LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
            
            if (washerman) {
                [self performAsyncWorkWithCar:car];
            } else {
                NSLog(@"Car %@ added to Queue", car);
                [self.queueOfCars addToQueue:car];
            }
        }
    }
}

@end
