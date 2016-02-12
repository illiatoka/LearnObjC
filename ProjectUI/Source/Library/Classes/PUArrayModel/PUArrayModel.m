#import "PUArrayModel.h"

@interface PUArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableItems;

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
            [self notifyWithSelector:@selector(arrayModelDidChange:)];
        }
    }
}

- (void)removeObject:(id)object {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items removeObject:object];
        [self notifyWithSelector:@selector(arrayModelDidChange:)];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items insertObject:object atIndex:index];
            [self notifyWithSelector:@selector(arrayModelDidChange:)];
        }
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items replaceObjectAtIndex:index withObject:object];
            [self notifyWithSelector:@selector(arrayModelDidChange:)];
        }
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        [self notifyWithSelector:@selector(arrayModelDidChange:)];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items removeObjectAtIndex:index];
        [self notifyWithSelector:@selector(arrayModelDidChange:)];
    }
}

@end
