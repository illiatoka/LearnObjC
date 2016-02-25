#import "PUShopListItem.h"

static NSString * const kPUNameKey      = @"name";
static NSString * const kPUCheckedKey   = @"checked";


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

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:kPUNameKey];
        self.checked = [coder decodeBoolForKey:kPUCheckedKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:kPUNameKey];
    [coder encodeBool:self.checked forKey:kPUCheckedKey];
}

@end
