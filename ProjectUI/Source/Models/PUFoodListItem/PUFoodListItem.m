#import "PUFoodListItem.h"

@implementation PUFoodListItem

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFoodName:(NSString *)foodName {
    self = [super init];
    if (self) {
        self.foodName = foodName;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setChecked:(BOOL)checked {
    if (_checked != checked) {
        _checked = checked;
        
        [self notifyWithSelector:@selector(foodListItemModelDidChange:)];
    }
}

@end
