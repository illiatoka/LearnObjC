#import "LCHController.h"
#import "LCHEnterprise.h"
#import "LCHCar.h"

static const NSUInteger kLCHDefaultCarCount = 400;

@interface LCHController ()
@property (nonatomic, retain)   LCHEnterprise       *enterprise;
@property (nonatomic, retain)   NSTimer             *timer;

- (void)startBackgroundWork:(NSTimer *)timer;
- (NSTimer *)setupTimer;

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
    self.timer = [self setupTimer];
}

- (void)stopWork {
    self.timer = nil;
}

- (void)performWorkWithObject:(id)object {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        [self.enterprise performWorkWithCar:object];
    });
}

- (void)performWorkWithObjects:(NSArray *)objects {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        for (id object in objects) {
            [self performWorkWithObject:object];
        }
    });
}

#pragma -
#pragma mark Private

- (void)startBackgroundWork:(NSTimer *)timer {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSArray *cars = [LCHCar objectsOfClassWithCount:kLCHDefaultCarCount];
        for (id car in cars) {
            [self performWorkWithObject:car];
        }
    });
}

- (NSTimer *)setupTimer {
    return [NSTimer scheduledTimerWithTimeInterval:5.0
                                            target:self
                                          selector:@selector(startBackgroundWork:)
                                          userInfo:nil
                                           repeats:YES];
}

@end
