#import "LCHController.h"
#import "LCHEnterprise.h"
#import "LCHDispatch.h"
#import "LCHCar.h"

static const NSUInteger kLCHDefaultCarCount         = 10000;
static const NSTimeInterval kLCHDefaultTimeInterval = 0.1;

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

- (void)setWorking:(BOOL)working {
    if (working) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kLCHDefaultTimeInterval
                                                      target:self
                                                    selector:@selector(startBackgroundWork:)
                                                    userInfo:nil
                                                     repeats:YES];
    } else {
        self.timer = nil;
    }
}

- (void)setTimer:(NSTimer *)timer {
    if (_timer != timer) {
        [_timer invalidate];
        [_timer release];
        _timer = timer;
    }
}

#pragma mark -
#pragma mark Public

- (void)performWorkWithObject:(id)object {
    LCHDispatchAsyncOnQueue(LCHDispatchQueueDefault, ^{
        [self.enterprise performWorkWithCar:object];
    });
}

- (void)performWorkWithObjects:(NSArray *)objects {
    LCHDispatchAsyncOnQueue(LCHDispatchQueueBackground, ^{
        for (id object in objects) {
            [self performWorkWithObject:object];
        }
    });
}

#pragma -
#pragma mark Private

// TODO: Remove test code bellow
// Variable 'count' and 'if' statement placed below just for testing

static NSUInteger count = 0;

- (void)startBackgroundWork:(NSTimer *)timer {
    if (count > 99) {
        [self setWorking:NO];
        
        return;
    } else {
        count++;
    }
    
    LCHDispatchAsyncOnQueue(LCHDispatchQueueBackground, ^{
        [self performWorkWithObjects:[LCHCar objectsWithCount:kLCHDefaultCarCount]];
    });
}

@end
