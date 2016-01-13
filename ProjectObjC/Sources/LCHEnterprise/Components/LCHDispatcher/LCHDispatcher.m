#import "LCHDispatcher.h"
#import "LCHObservableObject.h"
#import "LCHEmployee.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

@interface LCHDispatcher ()
@property (nonatomic, readwrite, retain) LCHContainer   *handlers;
@property (nonatomic, readwrite, retain) LCHQueue       *queue;

- (id)freeHandler;
- (void)performWork;

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

- (void)performWorkWithObject:(id)object {
    [self.queue enqueue:object];
    [self performWork];
}

#pragma mark -
#pragma mark Private Implementations

- (id)freeHandler {
    @synchronized(self.handlers) {
        for (id handler in self.handlers.items) {
            @synchronized(handler) {
                if (kLCHEmployeeDidBecomeFree == [handler state]) {
                    [handler setState:kLCHEmployeeDidStartWork];
                    
                    return handler;
                }
            }
        }
    }

    return nil;
}

- (void)performWork {
    id object = [self.queue dequeue];
    if (object) {
        id handler = [self freeHandler];
        if (handler) {
            [handler performWorkWithObject:object];
        } else {
            [self.queue enqueue:object];
        }
    }
}

#pragma mark -
#pragma mark LCHObserverProtocol

- (void)employeeDidBecomeFree:(id)employee {
    [self performWork];
}

@end
