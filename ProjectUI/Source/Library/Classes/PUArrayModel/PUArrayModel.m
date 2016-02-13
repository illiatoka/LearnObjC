#import "PUArrayModel.h"

#import "PUArrayModelChanges.h"

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
            
            PUArrayModelChanges *changes = [PUArrayModelChanges modelOfChangesWithAction:PUArrayModelActionInsert
                                                                                    idx1:items.count - 1
                                                                                    idx2:0];
            
            [self notifyWithSelector:@selector(arrayModelDidChange:withObject:) withObject:changes];
        }
    }
}

- (void)removeObject:(id)object {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        NSUInteger objectIndex = [items indexOfObject:object];
        [items removeObject:object];
        
        PUArrayModelChanges *changes = [PUArrayModelChanges modelOfChangesWithAction:PUArrayModelActionRemove
                                                                                idx1:objectIndex
                                                                                idx2:0];
        
        [self notifyWithSelector:@selector(arrayModelDidChange:withObject:) withObject:changes];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items insertObject:object atIndex:index];
            
            PUArrayModelChanges *changes = [PUArrayModelChanges modelOfChangesWithAction:PUArrayModelActionInsert
                                                                                    idx1:index
                                                                                    idx2:0];
            
            [self notifyWithSelector:@selector(arrayModelDidChange:withObject:) withObject:changes];
        }
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (object) {
        NSMutableArray *items = self.mutableItems;
        @synchronized(items) {
            [items replaceObjectAtIndex:index withObject:object];
            
            PUArrayModelChanges *changes = [PUArrayModelChanges modelOfChangesWithAction:PUArrayModelActionReplace
                                                                                    idx1:index
                                                                                    idx2:0];
            
            [self notifyWithSelector:@selector(arrayModelDidChange:withObject:) withObject:changes];
        }
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        
        PUArrayModelChanges *changes = [PUArrayModelChanges modelOfChangesWithAction:PUArrayModelActionExchange
                                                                                idx1:idx1
                                                                                idx2:idx2];
        
        [self notifyWithSelector:@selector(arrayModelDidChange:withObject:) withObject:changes];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        [items removeObjectAtIndex:index];
        
        PUArrayModelChanges *changes = [PUArrayModelChanges modelOfChangesWithAction:PUArrayModelActionRemove
                                                                                idx1:index
                                                                                idx2:0];
        
        [self notifyWithSelector:@selector(arrayModelDidChange:withObject:) withObject:changes];
    }
}

@end
