#import "PUShopListItems.h"

#import "PUShopListItem.h"
#import "PURandomName.h"

static const NSUInteger kPUShopListItemCount = 20;

@interface PUShopListItems ()
@property (nonatomic, strong)   NSMutableArray  *mutableItems;
@property (nonatomic, strong)   PURandomName    *randomNames;

- (void)fill;

@end

@implementation PUShopListItems

@dynamic items;
@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableItems = [NSMutableArray arrayWithCapacity:kPUShopListItemCount];
        self.randomNames = [PURandomName new];
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

- (PUShopListItem *)objectAtIndex:(NSUInteger)index {
    return [self.mutableItems objectAtIndex:index];
}

- (PUShopListItem *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (void)addObject:(id)object {

}

- (void)removeObject:(id)object {

}

- (void)removeObjectAtIndex:(NSUInteger)index {

}

#pragma mark -
#pragma mark Private

- (void)fill {
    NSMutableArray *items = self.mutableItems;
    @synchronized(items) {
        for (NSUInteger count = 0; count < kPUShopListItemCount; count++) {
            [items addObject:[[PUShopListItem alloc] initWithName:[self.randomNames randomName]]];
        }
    }
}

@end
