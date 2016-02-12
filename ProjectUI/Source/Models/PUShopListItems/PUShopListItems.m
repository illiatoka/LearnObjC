#import "PUShopListItems.h"

#import "PUShopListItem.h"

#import "NSString+PURandomFoodName.h"

static const NSUInteger kPUShopListItemCount = 20;

@interface PUShopListItems ()

- (void)fill;

@end

@implementation PUShopListItems

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self fill];
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (void)fill {
    for (NSUInteger count = 0; count < kPUShopListItemCount; count++) {
        [self addObject:[[PUShopListItem alloc] initWithName:[NSString randomName]]];
    }
}

@end
