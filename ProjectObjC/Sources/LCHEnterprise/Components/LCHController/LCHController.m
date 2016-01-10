#import "LCHController.h"
#import "LCHEnterprise.h"

#import "LCHWashermanDispatcher.h"
#import "LCHAccountantDispatcher.h"
#import "LCHManagerDispatcher.h"

#import "LCHManager.h"
#import "LCHAccountant.h"
#import "LCHWasherman.h"

@interface LCHController ()
@property (nonatomic, assign)   LCHEnterprise   *enterprise;

@property (nonatomic, retain)   LCHWashermanDispatcher      *washermanDispatcher;
@property (nonatomic, retain)   LCHAccountantDispatcher     *accountantDispatcher;
@property (nonatomic, retain)   LCHManagerDispatcher        *managerDispatcher;

- (void)performBackgroundWorkWithObject:(id)object;
- (void)performBackgroundWorkWithObjects:(NSArray *)cars;

- (void)subscribeForNotifications;
- (void)unsubscribeFromNotifications;

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
    [self unsubscribeFromNotifications];
    
    self.washermanDispatcher = nil;
    self.accountantDispatcher = nil;
    self.managerDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)initWithEnterprise:(id)enterprise {
    self = [self init];
    if (self) {
        self.enterprise = enterprise;
        self.washermanDispatcher = [LCHWashermanDispatcher dispatcherWithEnterprise:enterprise];
        self.accountantDispatcher = [LCHAccountantDispatcher dispatcherWithEnterprise:enterprise];
        self.managerDispatcher = [LCHManagerDispatcher dispatcherWithEnterprise:enterprise];
        
        [self subscribeForNotifications];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

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
        [self.washermanDispatcher performWorkWithObject:object];
    }
}

- (void)performBackgroundWorkWithObjects:(NSArray *)objects {
    @autoreleasepool {
        for (id object in objects) {
            [self performBackgroundWorkWithObject:object];
        }
    }
}

- (void)subscribeForNotifications {
    for (id handler in self.enterprise.handlers) {
        [handler addObserver:self];
    }
}

- (void)unsubscribeFromNotifications {
    for (id handler in self.enterprise.handlers) {
        [handler removeObserver:self];
    }
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)handlerDidFinishWork:(id)handler {
    if ([handler class] == [LCHWasherman class]) {
        [self.accountantDispatcher performWorkWithObject:handler];
    } else if ([handler class] == [LCHAccountant class]) {
        [self.managerDispatcher performWorkWithObject:handler];
    }
}

@end
