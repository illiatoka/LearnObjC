#import "LCHObservableObject.h"

@interface LCHObservableObject ()
@property (nonatomic, retain)   NSHashTable *observersHashTable;

@end

@implementation LCHObservableObject

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
        self.observersHashTable = [NSHashTable weakObjectsHashTable];
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

- (void)setState:(NSUInteger)state {
    [self setState:state withObject:nil];
}

- (void)setState:(NSUInteger)state withObject:(id)object {
    if (_state != state) {
        _state = state;
        [self notifyWithSelector:[self selectorForState:state] withObject:object];
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

- (void)addObserversFromArray:(NSArray *)array {
    for (id observer in array) {
        [self addObserver:observer];
    }
}

- (void)removeObserversFromArray:(NSArray *)array {
    for (id observer in array) {
        [self removeObserver:observer];
    }
}

- (BOOL)containsObserver:(id)observer {
    return [self.observersHashTable containsObject:observer];
}

- (void)notifyWithSelector:(SEL)selector {
    [self notifyWithSelector:selector withObject:nil];
}

- (void)notifyWithSelector:(SEL)selector withObject:(id)object {
    NSArray *observers = self.observers;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self withObject:object];
        }
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

@end
