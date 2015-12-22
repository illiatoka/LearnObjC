#import "LCHEnterprise.h"

#import "NSObject+LCHExtensions.h"
#import "LCHContainer.h"
#import "LCHConstants.h"

#import "LCHEmployee.h"
#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"
#import "LCHCar.h"

@interface LCHEnterprise ()
@property (nonatomic, readwrite, retain) LCHContainer *mutableEmployees;

- (void)hireAnEmployee:(LCHEmployee *)employee;

- (id)freeEmployeeOfClass:(Class)class;

- (void)performWorkInBackgroundWithCar:(LCHCar *)car;

@end

@implementation LCHEnterprise
@dynamic employees;

#pragma mark -
#pragma Class Methods
+ (instancetype)enterprise {
    return [self object];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableEmployees = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableEmployees = [LCHContainer container];
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

- (void)performWorkWithCar:(LCHCar *)car {
    [self performSelectorInBackground:@selector(performWorkInBackgroundWithCar:) withObject:car];
}

- (void)performWorkWithCars:(NSSet *)cars {
    for (LCHCar *car in cars) {
        [self performWorkWithCar:car];
    }
}

#pragma mark -
#pragma mark Private Implementations

- (void)hireAnEmployee:(LCHEmployee *)employee {
    [self.mutableEmployees addItem:employee];
}

- (id)freeEmployeeOfClass:(Class)class {
    for (id employee in self.employees) {
        if ([employee isMemberOfClass:class] && kLCHEmployeeIsFree == [employee state]) {
            return employee;
        }
    }
    
    return nil;
}

- (void)performWorkInBackgroundWithCar:(LCHCar *)car {
    NSLog(@"Method invoked");
    sleep(arc4random_uniform(3));
    
    LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
   
    
    @synchronized(washerman) {
        NSLog(@"Washerman %@ locked", washerman);
        
        sleep(1);
        
        if (kLCHEmployeeIsFree == [washerman state]) {
            if ([car canGiveMoney:kLCHDefaultPrice]) {
                [washerman performWorkWithObject:car];
                
                NSLog(@"Is car clean: %hhd Money is: %lu", car.isClean, car.wallet);
            }
        }
    }
}

@end
