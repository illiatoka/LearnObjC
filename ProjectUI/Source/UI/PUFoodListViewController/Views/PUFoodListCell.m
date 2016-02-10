#import "PUFoodListCell.h"

#import "PUFoodListItem.h"

static NSString * const kPUCheckImageName = @"check";
static NSString * const kPUUncheckImageName = @"uncheck";

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
    
    static UIImage *__check = nil;
    static UIImage *__uncheck = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __check = [UIImage imageNamed:kPUCheckImageName];
        __uncheck = [UIImage imageNamed:kPUUncheckImageName];
    });
    
    self.statusImageView.image = foodListItem.isChecked ? __check : __uncheck;
}

#pragma mark -
#pragma mark PUListObserverProtocol

- (void)foodListItemModelDidChange:(id)model {
    if (self.foodListItem == model) {
        [self fillWithModel:model];
    }
}

@end
