#import "LCHController.h"

#import "LCHEnterprise.h"
#import "LCHQueue.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHController ()
@property (nonatomic, readwrite, retain)    LCHQueue        *queueOfCars;
@property (nonatomic, readwrite, assign)    LCHEnterprise   *enterprise;

- (id)freeEmployeeOfClass:(Class)class;

@end

@implementation LCHController

#pragma mark -
#pragma mark Class Methods

+ (instancetype)controllerWithEnterprise:(LCHEnterprise *)enterprise {
    return [[[self alloc] initWithEnterprise:enterprise] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.queueOfCars = nil;
    self.enterprise = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.queueOfCars = [LCHQueue object];
    }
    
    return self;
}

- (instancetype)initWithEnterprise:(LCHEnterprise *)enterprise {
    self = [self init];
    
    if (self) {
        self.enterprise = enterprise;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

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
#pragma mark Private Implementations

- (id)freeEmployeeOfClass:(Class)class {
    NSSet *employees = [self.enterprise employees];
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
