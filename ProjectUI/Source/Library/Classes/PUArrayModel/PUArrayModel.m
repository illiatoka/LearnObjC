#import "PUArrayModel.h"

#import "PUArraySingleIndexChangeModel.h"
#import "PUArrayDoubleIndexChangeModel.h"

#import "PUArrayModelObserver.h"

typedef PUArraySingleIndexChangeModel PUSingleChangeModel;
typedef PUArrayDoubleIndexChangeModel PUDoubleChangeModel;

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
            
            PUSingleChangeModel *model = [PUSingleChangeModel changeModelWithAction:PUArrayModelActionInsert
                                                                              index:items.count - 1];
            
            [self notifyWithSelector:@selector(arrayModel:didChangeWithModel:) withObject:model];
        }
    }
}

- (void)removeObject:(id)object {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        NSUInteger objectIndex = [items indexOfObject:object];
        [items removeObject:object];
        
        PUSingleChangeModel *model = [PUSingleChangeModel changeModelWithAction:PUArrayModelActionRemove
                                                                          index:objectIndex];
        
        [self notifyWithSelector:@selector(arrayModel:didChangeWithModel:) withObject:model];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items insertObject:object atIndex:index];
            
            PUSingleChangeModel *model = [PUSingleChangeModel changeModelWithAction:PUArrayModelActionInsert
                                                                              index:index];
            
            [self notifyWithSelector:@selector(arrayModel:didChangeWithModel:) withObject:model];
        }
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items replaceObjectAtIndex:index withObject:object];
            
            PUSingleChangeModel *model = [PUSingleChangeModel changeModelWithAction:PUArrayModelActionReplace
                                                                              index:index];
            
            [self notifyWithSelector:@selector(arrayModel:didChangeWithModel:) withObject:model];
        }
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        
        PUDoubleChangeModel *model = [PUDoubleChangeModel changeModelWithAction:PUArrayModelActionExchange
                                                                           idx1:idx1
                                                                           idx2:idx2];
        
        [self notifyWithSelector:@selector(arrayModel:didChangeWithModel:) withObject:model];
    }
}

- (void)moveObjectAtIndex:(NSUInteger)idx1 toIndex:(NSUInteger)idx2 {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items insertObject:items[idx1] atIndex:idx1 < idx2 ? (idx2 + 1) : idx2];
        [items removeObjectAtIndex:idx1 < idx2 ? idx1 : (idx1 + 1)];
        
        PUDoubleChangeModel *model = [PUDoubleChangeModel changeModelWithAction:PUArrayModelActionMove
                                                                           idx1:idx1
                                                                           idx2:idx2];
        
        [self notifyWithSelector:@selector(arrayModel:didChangeWithModel:) withObject:model];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items removeObjectAtIndex:index];
        
        PUSingleChangeModel *model = [PUSingleChangeModel changeModelWithAction:PUArrayModelActionRemove
                                                                          index:index];
        
        [self notifyWithSelector:@selector(arrayModel:didChangeWithModel:) withObject:model];
    }
}

@end
