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
@property (nonatomic, readwrite, retain) LCHQueue       *queue;

- (void)hireAnEmployee:(LCHEmployee *)employee;

- (id)freeEmployeeOfClass:(Class)class;

- (void)performBackgroundWorkWithCar:(LCHCar *)car;
- (void)performBackgroundWorkWithCars:(NSSet *)cars;

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
        self.mutableEmployees = [LCHContainer object];
        self.queue = [LCHQueue object];
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
    [self performSelectorInBackground:@selector(performBackgroundWorkWithCar:) withObject:car];
}

- (void)performWorkWithCars:(NSArray *)cars {
    NSUInteger index = 0;
    
    NSUInteger count = [cars count];
    NSUInteger chunk = 20;
    
    NSUInteger chunkCount = 0 == count % chunk ? chunk : count / chunk;
    NSUInteger chunkGroupCount = 0 == count % chunk ? count / chunk : count % chunk;
    
    NSUInteger chunkRestCount = count / chunk + 1;
    NSUInteger chunkGroupRestCount = count % chunk;
    
    NSLog(@"Chunk count is: %lu", chunkCount);
    NSLog(@"Chunk group count is: %lu", chunkGroupCount);
    
    NSLog(@"Chunk rest count is: %lu", chunkRestCount);
    NSLog(@"Chunk group rest count is: %lu", chunkGroupRestCount);
    
    for (NSUInteger chunkIndex = 0; chunkIndex < chunkGroupCount; chunkIndex++) {
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:chunkCount];
        
        for (NSUInteger itemIndex = 0; itemIndex < chunkCount; itemIndex++) {
            NSLog(@"Index is: %lu", index);
            [result addObject:[cars objectAtIndex:index]];
            index ++;
            
            NSLog(@"Index is: %lu", index);
        }
        
        [self performSelectorInBackground:@selector(performBackgroundWorkWithCars:) withObject:result];
    }
    
    if (chunkGroupRestCount) {
        for (NSUInteger chunkIndex = 0; chunkIndex < chunkGroupRestCount; chunkIndex++) {
            NSMutableArray *result = [NSMutableArray arrayWithCapacity:chunkRestCount];
            
            for (NSUInteger itemIndex = 0; itemIndex < chunkRestCount; itemIndex++) {
                NSLog(@"Index is: %lu", index);
                [result addObject:[cars objectAtIndex:index]];
                index ++;
                
                NSLog(@"Index is: %lu", index);
            }
            
            [self performSelectorInBackground:@selector(performBackgroundWorkWithCars:) withObject:result];
        }

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

- (void)performBackgroundWorkWithCar:(LCHCar *)car {
    @autoreleasepool {
        NSLog(@"Method invoked");
        
        LCHWasherman *washerman = [self freeEmployeeOfClass:[LCHWasherman class]];
       
        if (washerman) {
            @synchronized(washerman) {
                NSLog(@"Washerman %@ locked", washerman);
                
                if (kLCHEmployeeIsFree == [washerman state]) {
                    if ([car canGiveMoney:kLCHDefaultPrice]) {
                        [washerman performWorkWithObject:car];
                        
                        NSLog(@"Is car clean: %hhd Money is: %lu", car.isClean, car.wallet);
                    }
                } else {
                    [self.queue addToQueue:car];
                    NSLog(@"Car %@ added to Queue", car);
                }
            }
        } else {
            NSLog(@"Car %@ added to Queue", car);
            [self.queue addToQueue:car];
        }
    }
}

- (void)performBackgroundWorkWithCars:(NSArray *)cars {
    @autoreleasepool {
        for (LCHCar *car in cars) {
            [self performBackgroundWorkWithCar:car];
        }
    }
}

@end
