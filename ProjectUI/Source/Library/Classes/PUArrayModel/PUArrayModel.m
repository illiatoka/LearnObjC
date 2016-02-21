#import "PUArrayModel.h"

#import "PUCollectionChangeModel+PUArrayChangeModel.h"

#import "PUCollectionObserver.h"

@interface PUArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableItems;

- (void)notifyObserversWithChangeModel:(PUCollectionChangeModel *)model;

@end

@implementation PUArrayModel

@dynamic items;
@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableItems = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)items {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        return [items copy];
    }
}

- (NSUInteger)count {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        return items.count;
    }
}

#pragma mark -
#pragma mark Public

- (id)objectAtIndex:(NSUInteger)index {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        return [items objectAtIndex:index];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (void)addObject:(id)object {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items addObject:object];
            
            [self notifyObserversWithChangeModel:[PUCollectionChangeModel addingModelWithIndex:items.count - 1]];
        }
    }
}

- (void)removeObject:(id)object {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        NSUInteger objectIndex = [items indexOfObject:object];
        [items removeObject:object];
        
        [self notifyObserversWithChangeModel:[PUCollectionChangeModel removingModelWithIndex:objectIndex]];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items insertObject:object atIndex:index];
            
            [self notifyObserversWithChangeModel:[PUCollectionChangeModel insertingModelWithIndex:index]];
        }
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items replaceObjectAtIndex:index withObject:object];
            
            [self notifyObserversWithChangeModel:[PUCollectionChangeModel replacingModelWithIndex:index]];
        }
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        
        [self notifyObserversWithChangeModel:[PUCollectionChangeModel exchangingModelWithIndex:idx1 toIndex:idx2]];
    }
}

- (void)moveObjectAtIndex:(NSUInteger)idx1 toIndex:(NSUInteger)idx2 {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items insertObject:items[idx1] atIndex:idx1 < idx2 ? (idx2 + 1) : idx2];
        [items removeObjectAtIndex:idx1 < idx2 ? idx1 : (idx1 + 1)];
        
        [self notifyObserversWithChangeModel:[PUCollectionChangeModel movingModelWithIndex:idx1 toIndex:idx2]];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items removeObjectAtIndex:index];
        
        [self notifyObserversWithChangeModel:[PUCollectionChangeModel removingModelWithIndex:index]];
    }
}

#pragma mark -
#pragma mark Private

- (void)notifyObserversWithChangeModel:(PUCollectionChangeModel *)model {
    [self notifyWithSelector:@selector(collection:didChangeWithModel:) withObject:model];
}

@end
