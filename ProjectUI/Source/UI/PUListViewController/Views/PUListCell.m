#import "PUListCell.h"

#import "PUListItem.h"

@interface PUListCell ()

- (void)fillWithModel:(PUListItem *)listItem;

@end

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
#pragma mark Private

- (void)fillWithModel:(PUListItem *)listItem {
    self.itemTextLabel.text = self.listItem.itemText;
}

@end
