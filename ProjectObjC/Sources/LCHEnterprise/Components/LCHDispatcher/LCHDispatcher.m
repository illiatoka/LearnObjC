#import "LCHDispatcher.h"
#import "LCHObservableObject.h"
#import "LCHEmployee.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

@interface LCHDispatcher ()
@property (nonatomic, readwrite, retain) LCHContainer   *handlers;
@property (nonatomic, readwrite, retain) LCHQueue       *queue;

- (id)freeHandler;

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
        self.handlers = [LCHContainer object];
        self.queue = [LCHQueue object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

// TODO: Add object to queue first than perform work with object
- (void)performWorkWithObject:(id)object {
    @synchronized(self) {
        id handler = [self freeHandler];
        if (handler) {
            [handler performWorkWithObject:object];
        } else {
            [self.queue enqueue:object];
        }
    }
}

#pragma mark -
#pragma mark Private Implementations

- (id)freeHandler {
    @synchronized(self.handlers) {
        for (id handler in self.handlers.items) {
            @synchronized(handler) {
                if (kLCHEmployeeDidBecomeFree == [handler state]) {
                    [handler setState:kLCHEmployeeDidStart];
                    
                    return handler;
                }
            }
        }
    }

    return nil;
}

#pragma mark -
#pragma mark LCHObserverProtocol

// TODO: Just call performWorkWithObject without using queue
- (void)employeeDidBecomeFree:(id)employee {
    id object = [self.queue dequeue];
    if (object) {
        [self performWorkWithObject:object];
    }
}

@end
