#import "LCHDispatcher.h"
#import "LCHObservableObject.h"
#import "LCHHandlerContainer.h"
#import "LCHEmployee.h"
#import "LCHEnterprise.h"
#import "LCHQueue.h"

@interface LCHDispatcher ()
@property (nonatomic, readwrite, retain) LCHHandlerContainer    *handlers;
@property (nonatomic, readwrite, retain) LCHQueue               *queue;

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
        self.handlers = [LCHHandlerContainer object];
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

- (void)performWork {
    id object = [self.queue dequeue];
    if (object) {
        id handler = [self.handlers reserveHandler];
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
