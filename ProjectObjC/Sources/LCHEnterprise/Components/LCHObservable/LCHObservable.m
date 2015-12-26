#import "LCHObservable.h"
#import "LCHContainer.h"

@interface LCHObservable ()
@property (nonatomic, readwrite, retain) LCHContainer *mutableObservers;

@end

@implementation LCHObservable
@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableObservers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableObservers = [LCHContainer object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    LCHContainer *mutableObservers = self.mutableObservers;
    
    @synchronized(mutableObservers) {
        NSSet *objects = mutableObservers.items;
        NSMutableSet *observers = [NSMutableSet set];
        
        for (NSValue *object in objects) {
            [observers addObject:[object pointerValue]];
        }
        
        return [observers allObjects];
    }
    
    return nil;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addObserver:(id)observer {
    LCHContainer *mutableObservers = self.mutableObservers;
    
    @synchronized(mutableObservers) {
        if (![self containsObserver:observer]) {
            NSValue *object = [NSValue valueWithNonretainedObject:observer];
            [mutableObservers addItem:object];
        }
    }
}

- (void)removeObserver:(id)observer {
    LCHContainer *mutableObservers = self.mutableObservers;
    
    @synchronized(mutableObservers) {
        NSSet *objects = mutableObservers.items;
        
        for (NSValue *object in objects) {
            if ([object pointerValue] == observer) {
                [mutableObservers removeItem:object];
                
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

- (BOOL)containsObserver:(id)observer {
    NSArray *observers = self.observers;
    
    @synchronized(observers) {
        return [observers containsObject:observer];
    }
    
    return NO;
}

@end
