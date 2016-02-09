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

@end
