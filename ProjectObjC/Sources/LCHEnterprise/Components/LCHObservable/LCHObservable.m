#import "LCHObservable.h"
#import "LCHContainer.h"

@interface LCHObservable ()
@property (nonatomic, readwrite, retain)    LCHContainer    *observersContainer;

@end

@implementation LCHObservable

@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observersContainer = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observersContainer = [LCHContainer object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    LCHContainer *observersContainer = self.observersContainer;
    @synchronized(observersContainer) {
        NSArray *objects = observersContainer.items;
        NSMutableArray *observers = [NSMutableArray array];
        for (NSValue *object in objects) {
            [observers addObject:object.pointerValue];
        }
        
        return [[observers copy] autorelease];
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
    LCHContainer *mutableObservers = self.observersContainer;
    @synchronized(mutableObservers) {
        if (![self containsObserver:observer]) {
            NSValue *object = [NSValue valueWithNonretainedObject:observer];
            [mutableObservers addItem:object];
        }
    }
}

- (void)removeObserver:(id)observer {
    LCHContainer *observersContainer = self.observersContainer;
    @synchronized(observersContainer) {
        NSArray *objects = observersContainer.items;
        for (NSValue *object in objects) {
            if ([object pointerValue] == observer) {
                [observersContainer removeItem:object];
                
                break;
            }
        }
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
        return @selector(employeeDidStartWork:);
    } else if (kLCHObjectFinished == state) {
        return @selector(employeeDidFinishWork:);
    } else if (kLCHObjectIsFree) {
        return @selector(employeeDidBecomeFree:);
    }
    
    return NULL;
}

- (BOOL)containsObserver:(id)observer {
    NSArray *observers = self.observers;
    @synchronized(observers) {
        return [observers containsObject:observer];
    }
    
    return NO;
}

@end
