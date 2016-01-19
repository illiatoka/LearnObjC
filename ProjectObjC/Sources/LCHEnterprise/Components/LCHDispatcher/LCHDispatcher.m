#import "LCHDispatcher.h"
#import "LCHObservableObject.h"
#import "LCHEmployee.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

@interface LCHDispatcher ()
@property (nonatomic, retain)   NSMutableSet    *handlers;
@property (nonatomic, retain)   LCHQueue        *queue;

- (void)performWork;
- (id)reserveHandler;

@end

@implementation LCHDispatcher

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.handlers = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.handlers = [NSMutableSet object];
        self.queue = [LCHQueue object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)performWorkWithObject:(id)object {
    [self.queue enqueue:object];
    [self performWork];
}

- (void)addHandler:(id)handler {
    NSMutableSet *handlers = self.handlers;
    @synchronized(handlers) {
        [handlers addObject:handler];
    }
}

- (void)removeHandler:(id)handler {
    NSMutableSet *handlers = self.handlers;
    @synchronized(handlers) {
        [handlers removeObject:handler];
    }
}

- (BOOL)containsHandler:(id)handler {
    NSMutableSet *handlers = self.handlers;
    @synchronized(handlers) {
        return [handlers containsObject:handler];
    }
}

#pragma mark -
#pragma mark Private

- (void)performWork {
    id object = [self.queue dequeue];
    if (object) {
        id handler = [self reserveHandler];
        if (handler) {
            [handler performWorkWithObject:object];
        } else {
            [self.queue enqueue:object];
        }
    }
}

- (id)reserveHandler {
    for (LCHEmployee *handler in self.handlers) {
        @synchronized(handler) {
            if (kLCHEmployeeDidBecomeFree == handler.state) {
                [handler setState:kLCHEmployeeDidStartWork];
                
                return handler;
            }
        }
    }
    
    return nil;
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)employeeDidBecomeFree:(id)employee {
    [self performWork];
}

@end
