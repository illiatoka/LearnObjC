#import "PUListCell.h"

#import "PUListItem.h"

@implementation PUListCell

#pragma mark -
#pragma mark Accessors

- (void)setListItem:(PUListItem *)listItem {
    if (_listItem != listItem) {
        _listItem = listItem;
        
        [self fillWithModel:listItem];
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(PUListItem *)listItem {
    self.listItemTextLabel.text = self.listItem.listItemText;
}

@end
