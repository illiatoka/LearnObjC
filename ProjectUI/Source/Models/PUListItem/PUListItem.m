#import "PUListItem.h"

@implementation PUListItem

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemText = @"Random text";
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setChecked:(BOOL)checked {
    if (_checked != checked) {
        _checked = checked;
        
        [self notifyWithSelector:@selector(listItemModelDidChange:)];
    }
}

@end
