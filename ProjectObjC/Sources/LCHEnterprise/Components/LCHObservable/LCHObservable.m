#import "LCHObservable.h"

@interface LCHObservable ()
@property (nonatomic, readwrite, retain) NSMutableSet *mutableObservers;

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
        self.mutableObservers = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    NSMutableSet *objects = self.mutableObservers;
    NSMutableSet *observers = [NSMutableSet set];
    
    for (NSValue *object in objects) {
        [observers addObject:[object pointerValue]];
    }
    
    return [observers allObjects];
}

#pragma mark -
#pragma mark Public Implementations

- (void)addObserver:(id)observer {
    if (![self containsObserver:observer]) {
        NSValue *object = [NSValue valueWithNonretainedObject:observer];
        [self.mutableObservers addObject:object];
    }
}

- (void)removeObserver:(id)observer {
    NSMutableSet *objects = self.mutableObservers;
    
    for (NSValue *object in objects) {
        if ([object pointerValue] == observer) {
            [self.mutableObservers removeObject:object];
            
            break;
        }
    }
}

- (void)notifyWithSelector:(SEL)selector {
    [self notifyWithSelector:selector withObject:nil];
}

- (void)notifyWithSelector:(SEL)selector withObject:(id)object {
    NSArray *observers = self.observers;
    
    for (id observer in observers) {
        [observer performSelector:selector withObject:object];
    }
}

- (BOOL)containsObserver:(id)observer {
    NSArray *observers = self.observers;
    
    return [observers containsObject:observer];
}

@end
