#import "LCHDispatcher.h"
#import "LCHObservable.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

@interface LCHDispatcher ()
@property (nonatomic, assign)   LCHEnterprise   *enterprise;
@property (nonatomic, readwrite, retain) LCHQueue *queue;

- (void)subscribeForNotifications;
- (void)unsubscribeFromNotifications;

@end

@implementation LCHDispatcher

#pragma mark -
#pragma mark Class Methods

+ (instancetype)dispatcherWithEnterprise:(id)enterprise {
    return [[[self alloc] initWithEnterprise:enterprise] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self unsubscribeFromNotifications];
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.queue = [LCHQueue object];
    }
    
    return self;
}

- (instancetype)initWithEnterprise:(id)enterprise {
    self = [self init];
    if (self) {
        self.enterprise = enterprise;
        [self subscribeForNotifications];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performWorkWithObject:(id)object {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark Private Implementations

- (id)freeHandlerOfClass:(Class)class {
    for (id handler in self.enterprise.handlers) {
        if ([handler isMemberOfClass:class]) {
            @synchronized(handler) {
                if (kLCHObjectIsFree == [handler state]) {
                    [handler setState:kLCHObjectProcessed];
                    
                    return handler;
                }
            }
        }
    }
    
    return nil;
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

- (void)handlerDidBecomeFree:(id)handler {
    id object = [self.queue nextObjectFromQueue];
    if (object) {
        [self performWorkWithObject:object];
    }
}

@end
