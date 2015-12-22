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
        self.mutableObservers = [LCHContainer container];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    NSSet *objects = self.mutableObservers.items;
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
        [self.mutableObservers addItem:object];
    }
}

- (void)removeObserver:(id)observer {
    NSSet *objects = self.mutableObservers.items;
    
    for (NSValue *object in objects) {
        if ([object pointerValue] == observer) {
            [self.mutableObservers removeItem:object];
            
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
