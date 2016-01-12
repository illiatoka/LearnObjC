#import "LCHObservableObject.h"
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

- (BOOL)containsObserver:(id)observer {
    return [self.observersHashTable containsObject:observer];
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

- (SEL)selectorForState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

@end
