#import "LCHDispatcher.h"
#import "LCHObservableObject.h"
#import "LCHEmployee.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

@interface LCHDispatcher ()
@property (nonatomic, readwrite, retain) NSMutableSet   *mutableHandlers;
@property (nonatomic, readwrite, retain) LCHQueue       *queue;

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
    NSArray *handlers = nil;
    NSMutableSet *mutableHandlers = self.mutableHandlers;
    
    @synchronized(mutableHandlers) {
        handlers = mutableHandlers.allObjects;
    }
    
    return handlers;
}

#pragma mark -
#pragma mark Public Implementations

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

#pragma mark -
#pragma mark Private Implementations

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
    @synchronized(self) {
        for (id handler in self.handlers) {
            if (kLCHEmployeeDidBecomeFree == [handler state]) {
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
