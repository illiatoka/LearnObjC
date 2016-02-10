#import "PUFoodListItems.h"

#import "PUFoodListItem.h"
#import "PURandomFoodName.h"

static const NSUInteger kPUListItemCount = 20;

@interface PUFoodListItems ()
@property (nonatomic, strong)   NSMutableArray      *mutableItems;
@property (nonatomic, strong)   PURandomFoodName    *randomFoodNames;

- (void)fill;

@end

@implementation PUFoodListItems

@dynamic items;
@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableItems = [NSMutableArray arrayWithCapacity:kPUListItemCount];
        self.randomFoodNames = [PURandomFoodName new];
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

- (PUFoodListItem *)objectAtIndex:(NSUInteger)index {
    return [self.mutableItems objectAtIndex:index];
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
        for (NSUInteger count = 0; count < kPUListItemCount; count++) {
            [items addObject:[[PUFoodListItem alloc] initWithFoodName:[self.randomFoodNames randomFoodName]]];
        }
    }
}

@end
