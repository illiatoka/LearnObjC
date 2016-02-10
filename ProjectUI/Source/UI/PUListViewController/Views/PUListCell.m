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
    self.statusImageView.image = [UIImage imageNamed:listItem.isChecked ? @"check" : @"uncheck"];
}

#pragma mark -
#pragma mark PUListObserverProtocol

- (void)listItemModelDidChange:(id)model {
    if (self.listItem == model) {
        [self fillWithModel:model];
    }
}

@end
