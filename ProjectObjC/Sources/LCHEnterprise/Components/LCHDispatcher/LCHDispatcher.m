#import "LCHDispatcher.h"
#import "LCHObservableObject.h"
#import "LCHEmployee.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

@interface LCHDispatcher ()
@property (nonatomic, retain)   NSMutableSet    *mutableHandlers;
@property (nonatomic, retain)   LCHQueue        *queue;

- (void)performWork;
- (id)reserveHandler;

@end

@implementation LCHDispatcher

@dynamic handlers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableHandlers = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableHandlers = [NSMutableSet object];
        self.queue = [LCHQueue object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)handlers {
    NSMutableSet *mutableHandlers = self.mutableHandlers;
    @synchronized(mutableHandlers) {
        return mutableHandlers.allObjects;
    }
}

#pragma mark -
#pragma mark Public

- (void)performWorkWithObject:(id)object {
    [self.queue enqueue:object];
    [self performWork];
}

- (void)addHandler:(id)handler {
    NSMutableSet *mutableHandlers = self.mutableHandlers;
    @synchronized(mutableHandlers) {
        [mutableHandlers addObject:handler];
    }
}

- (void)removeHandler:(id)handler {
    NSMutableSet *mutableHandlers = self.mutableHandlers;
    @synchronized(mutableHandlers) {
        [mutableHandlers removeObject:handler];
    }
}

- (BOOL)containsHandler:(id)handler {
    return [self.mutableHandlers containsObject:handler];
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
