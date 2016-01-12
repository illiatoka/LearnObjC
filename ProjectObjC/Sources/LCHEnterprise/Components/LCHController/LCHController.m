#import "LCHController.h"
#import "LCHEnterprise.h"
#import "LCHCar.h"

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

// TODO: Is it possible and necessary to do something with this shit?!
- (void)startWork {
    NSUInteger carCount = 4000;

    NSMutableArray *cars = [NSMutableArray arrayWithCapacity:carCount];
    NSMutableArray *cars2 = [NSMutableArray arrayWithCapacity:carCount];

    for (NSUInteger count = 0; count < carCount; count++) {
        [cars addObject:[LCHCar car]];
    }

    for (NSUInteger count = 0; count < carCount; count++) {
        [cars2 addObject:[LCHCar car]];
    }

    [self performWorkWithObjects:cars];
    [self performWorkWithObjects:cars2];
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
