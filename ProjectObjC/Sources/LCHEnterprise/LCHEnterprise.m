#import "LCHEnterprise.h"

#import "LCHContainer.h"
#import "LCHController.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHEnterprise ()
@property (nonatomic, readwrite, retain) LCHContainer   *mutableEmployees;
@property (nonatomic, readwrite, retain) LCHController  *controller;

@end

@implementation LCHEnterprise
@dynamic employees;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableEmployees = nil;
    self.controller = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableEmployees = [LCHContainer object];
        self.controller = [LCHController controllerWithEnterprise:self];
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
    
    [washerman addObserver:self.controller];
    [washerman2 addObserver:self.controller];
    [accountant addObserver:self.controller];
    
    NSSet *employees = [NSSet setWithObjects:manager, accountant, washerman, washerman2, nil];
    
    for (LCHEmployee *employee in employees) {
        [self.mutableEmployees addItem:employee];
    }
}

- (void)performAsyncWorkWithCar:(LCHCar *)car {
    [self.controller performSelectorInBackground:@selector(performBackgroundWorkWithCar:) withObject:car];
}

- (void)performAsyncWorkWithCars:(NSSet *)cars {
    [self.controller performSelectorInBackground:@selector(performBackgroundWorkWithCars:) withObject:cars];
}

@end
