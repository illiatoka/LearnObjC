#import "LCHObservable.h"
#import "LCHContainer.h"

@interface LCHObservable ()
@property (nonatomic, readwrite, retain)    NSHashTable *observersHashTable;

@end

@implementation LCHObservable

@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observersHashTable = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observersHashTable = [NSHashTable object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    NSHashTable *observersHashTable = self.observersHashTable;
    @synchronized(observersHashTable) {
        return [observersHashTable allObjects];
    }
    
    return nil;
}

- (void)setState:(LCHObjectState)state {
    if (_state != state) {
        _state = state;
        [self notifyWithSelector:[self selectorForState:state] withObject:self];
    }
}

#pragma mark -
#pragma mark Public Implementations

- (void)addObserver:(id)observer {
    NSHashTable *observersHashTable = self.observersHashTable;
    @synchronized(observersHashTable) {
        if (![observersHashTable containsObject:observer]) {
            [observersHashTable addObject:observer];
        }
    }
}

- (void)removeObserver:(id)observer {
    NSHashTable *observersHashTable = self.observersHashTable;
    @synchronized(observersHashTable) {
        [observersHashTable removeObject:observer];
    }
}

- (void)notifyWithSelector:(SEL)selector {
    [self notifyWithSelector:selector withObject:nil];
}

- (void)notifyWithSelector:(SEL)selector withObject:(id)object {
    [self notifyWithSelector:selector withObject:object withObject:nil];
}

- (void)notifyWithSelector:(SEL)selector withObject:(id)object withObject:(id)object2 {
    NSArray *observers = self.observers;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:object withObject:object2];
        }
    }
}

- (SEL)selectorForState:(LCHObjectState)state {
    if (kLCHObjectProcessed == state) {
        return @selector(handlerDidStartWork:);
    } else if (kLCHObjectFinished == state) {
        return @selector(handlerDidFinishWork:);
    } else if (kLCHObjectIsFree) {
        return @selector(handlerDidBecomeFree:);
    }
    
    return NULL;
}

- (BOOL)containsObserver:(id)observer {
    NSHashTable *observersHashTable = self.observersHashTable;
    @synchronized(observersHashTable) {
        return [observersHashTable containsObject:observer];
    }
    
    return NO;
}

@end
