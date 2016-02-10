#import "PUFoodListCell.h"

#import "PUFoodListItem.h"

@interface PUFoodListCell ()

- (void)fillWithModel:(PUFoodListItem *)foodListItem;

@end

@implementation PUFoodListCell

#pragma mark -
#pragma mark Accessors

- (void)setFoodListItem:(PUFoodListItem *)foodListItem {
    if (_foodListItem != foodListItem) {
        _foodListItem = foodListItem;
        
        [self fillWithModel:foodListItem];
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(PUFoodListItem *)foodListItem {
    self.itemTextLabel.text = self.foodListItem.foodName;
    self.statusImageView.image = [UIImage imageNamed:foodListItem.isChecked ? @"check" : @"uncheck"];
}

#pragma mark -
#pragma mark PUListObserverProtocol

- (void)foodListItemModelDidChange:(id)model {
    if (self.foodListItem == model) {
        [self fillWithModel:model];
    }
}

@end
