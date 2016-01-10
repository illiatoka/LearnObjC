#import "LCHEnterprise.h"
#import "LCHContainer.h"
#import "LCHController.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHEnterprise ()
@property (nonatomic, retain)   LCHContainer    *handlersContainer;
@property (nonatomic, retain)   LCHController   *controller;

- (void)hireEmployees;

@end

@implementation LCHEnterprise

@dynamic handlers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.controller = nil;
    self.handlersContainer = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.handlersContainer = [LCHContainer object];
        [self hireEmployees];
        
        self.controller = [LCHController controllerWithEnterprise:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)handlers {
    return self.handlersContainer.items;
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

- (void)hireEmployees {
    LCHContainer *handlersContainer = self.handlersContainer;
    NSArray *employees = @[[LCHWasherman object],
                           [LCHWasherman object],
                           [LCHWasherman object],
                           [LCHWasherman object],
                           [LCHAccountant object],
                           [LCHAccountant object],
                           [LCHAccountant object],
                           [LCHManager object],
                           [LCHManager object]];
    
    for (id employee in employees) {
        [handlersContainer addItem:employee];
    }
}

@end
