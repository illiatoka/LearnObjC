#import "LCHController.h"
#import "LCHEnterprise.h"
#import "LCHDispatch.h"
#import "LCHCar.h"

static const NSUInteger kLCHDefaultCarCount         = 1000;
static const NSTimeInterval kLCHDefaultTimeInterval = 5.0;

@interface LCHController ()
@property (nonatomic, retain)   LCHEnterprise       *enterprise;
@property (nonatomic, retain)   NSTimer             *timer;

- (void)startBackgroundWork:(NSTimer *)timer;

- (void)performWorkWithObject:(id)object;
- (void)performWorkWithObjects:(NSArray *)objects;

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
#pragma mark Public

- (void)startWork {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kLCHDefaultTimeInterval
                                                  target:self
                                                selector:@selector(startBackgroundWork:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopWork {
    self.timer = nil;
}

- (void)performWorkWithObject:(id)object {
    LCHDispatchAsyncOnBackgroundQueue(^{
        [self.enterprise performWorkWithCar:object];
    });
}

- (void)performWorkWithObjects:(NSArray *)objects {
    LCHDispatchAsyncOnBackgroundQueue(^{
        for (id object in objects) {
            [self performWorkWithObject:object];
        }
    });
}

#pragma -
#pragma mark Private

- (void)startBackgroundWork:(NSTimer *)timer {
    LCHDispatchAsyncOnBackgroundQueue(^{
        NSArray *cars = [LCHCar objectsWithCount:kLCHDefaultCarCount];
        for (id car in cars) {
            [self performWorkWithObject:car];
        }
    });
}

@end
