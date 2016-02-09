#import "PUList.h"
#import "PUListItem.h"

static const NSUInteger kPUListItemCount = 20;

@interface PUList ()
@property (nonatomic, strong)   NSMutableArray  *mutableItems;

- (void)fill;

@end

@implementation PUList

@dynamic items;
@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableItems = [NSMutableArray arrayWithCapacity:kPUListItemCount];
        [self fill];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)items {
    return [self.mutableItems copy];
}

- (NSUInteger)count {
    return self.mutableItems.count;
}

#pragma mark -
#pragma mark Public

- (PUListItem *)objectAtIndex:(NSUInteger)index {
    return [self.mutableItems objectAtIndex:index];
}

- (void)addObject:(id)object {

}

- (void)removeObject:(id)object {

}

- (void)removeObjectAtIndex:(NSUInteger)index {

}

- (void)markObjectAtIndex:(NSUInteger)index {

}

- (void)unmarkObjectAtIndex:(NSUInteger)index {

}

#pragma mark -
#pragma mark Private

- (void)fill {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        for (NSUInteger count = 0; count < kPUListItemCount; count++) {
            [items addObject:[PUListItem new]];
        }
    }
}

@end
