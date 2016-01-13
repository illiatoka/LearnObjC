#import "LCHController.h"
#import "LCHEnterprise.h"
#import "LCHCar.h"

static const NSUInteger kLCHDefaultCarCount = 4000;

@interface LCHController ()
@property (nonatomic, retain)   LCHEnterprise   *enterprise;

- (void)performBackgroundWorkWithObject:(id)object;
- (void)performBackgroundWorkWithObjects:(NSArray *)cars;

@end

@implementation LCHController

#pragma mark -
#pragma mark Class Methods

+ (instancetype)controllerWithEnterprise:(id)enterprise {
    return [[[self alloc] initWithEnterprise:enterprise] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.enterprise = nil;
    
    [super dealloc];
}

- (instancetype)initWithEnterprise:(id)enterprise {
    self = [self init];
    if (self) {
        self.enterprise = enterprise;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)startWork {
    NSUInteger carCount = kLCHDefaultCarCount;

    NSMutableArray *cars = [NSMutableArray arrayWithCapacity:carCount];
    NSMutableArray *cars2 = [NSMutableArray arrayWithCapacity:carCount];
    NSMutableArray *cars3 = [NSMutableArray arrayWithCapacity:carCount];
    
    for (NSUInteger count = 0; count < carCount; count++) {
        [cars addObject:[LCHCar car]];
    }

    for (NSUInteger count = 0; count < carCount; count++) {
        [cars2 addObject:[LCHCar car]];
    }

    for (NSUInteger count = 0; count < carCount; count++) {
        [cars3 addObject:[LCHCar car]];
    }
    
    for (id car in cars) {
        [self performBackgroundWorkWithObject:car];
    }

    [self performWorkWithObjects:cars2];
    [self performWorkWithObjects:cars3];
}

- (void)performWorkWithObject:(id)object {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObject:) withObject:object];
}

- (void)performWorkWithObjects:(NSArray *)objects {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObjects:) withObject:objects];
}

#pragma -
#pragma mark Private Implementations

- (void)performBackgroundWorkWithObject:(id)object {
    @autoreleasepool {
        [self.enterprise performWorkWithCar:object];
    }
}

- (void)performBackgroundWorkWithObjects:(NSArray *)objects {
    @autoreleasepool {
        for (id object in objects) {
            [self performBackgroundWorkWithObject:object];
        }
    }
}

@end
