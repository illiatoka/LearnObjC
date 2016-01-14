#import "LCHController.h"
#import "LCHEnterprise.h"
#import "LCHCar.h"

static const NSUInteger kLCHDefaultCarCount = 400;

@interface LCHController ()
@property (nonatomic, retain)   LCHEnterprise   *enterprise;
@property (nonatomic, retain)   NSTimer         *timer;

- (void)startBackgroundWork:(NSTimer *)timer;
- (NSTimer *)setupTimer;
- (void)generateCars;

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
    self.timer = nil;
    
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
#pragma mark Accessors

- (BOOL)isWorking {
    return nil != self.timer;
}

- (void)setTimer:(NSTimer *)timer {
    if (timer != _timer) {
        [_timer invalidate];
        [_timer release];
        _timer = timer;
    }
}

#pragma mark -
#pragma mark Public Implementations

- (void)startWork {
    self.timer = [self setupTimer];
}

- (void)stopWork {
    self.timer = nil;
}

- (void)performWorkWithObject:(id)object {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObject:) withObject:object];
}

- (void)performWorkWithObjects:(NSArray *)objects {
    [self performSelectorInBackground:@selector(performBackgroundWorkWithObjects:) withObject:objects];
}

#pragma -
#pragma mark Private Implementations

- (void)startBackgroundWork:(NSTimer *)timer {
    [self performSelectorInBackground:@selector(generateCars) withObject:nil];
}

- (NSTimer *)setupTimer {
    return [NSTimer scheduledTimerWithTimeInterval:5.0
                                            target:self
                                          selector:@selector(startBackgroundWork:)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)generateCars {
    @autoreleasepool {
        NSArray *cars = [LCHCar objectsOfClassWithCount:kLCHDefaultCarCount];
        for (id car in cars) {
            [self performBackgroundWorkWithObject:car];
        }
    }
}

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
