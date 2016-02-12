#import "PUShopListItem.h"

@implementation PUShopListItem

#pragma mark -
#pragma mark Class Methods

+ (instancetype)shopListItemWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setChecked:(BOOL)checked {
    if (_checked != checked) {
        _checked = checked;
        
        [self notifyWithSelector:@selector(shopListItemModelDidChange:)];
    }
}

@end
