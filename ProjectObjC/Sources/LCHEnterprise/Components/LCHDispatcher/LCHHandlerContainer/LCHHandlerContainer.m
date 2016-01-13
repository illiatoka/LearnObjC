#import "LCHHandlerContainer.h"
#import "LCHEmployee.h"

@interface LCHHandlerContainer ()
@property (nonatomic, readwrite, retain)    NSMutableSet   *mutableHandlers;

@end

@implementation LCHHandlerContainer

@dynamic handlers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableHandlers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableHandlers = [NSMutableSet set];
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

@end
