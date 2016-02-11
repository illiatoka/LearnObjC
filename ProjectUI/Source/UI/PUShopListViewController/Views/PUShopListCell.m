#import "PUShopListCell.h"

#import "PUShopListItem.h"

static NSString * const kPUCheckImageName = @"check";
static NSString * const kPUUncheckImageName = @"uncheck";

@interface PUShopListCell ()

- (void)fillWithModel:(PUShopListItem *)shopListItem;

- (UIImage *)imageForModelStatus:(BOOL)status;
- (NSAttributedString *)labelAttribureForModelStatus:(BOOL)status;

@end

@implementation PUShopListCell

#pragma mark -
#pragma mark Accessors

- (void)setShopListItem:(PUShopListItem *)shopListItem {
    if (_shopListItem != shopListItem) {
        _shopListItem = shopListItem;
        
        [self fillWithModel:shopListItem];
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(PUShopListItem *)shopListItem {
    BOOL modelStatus = shopListItem.isChecked;
    
    self.itemTextLabel.text = self.shopListItem.name;
    self.itemTextLabel.alpha = modelStatus ? 0.3 : 1.0;
    self.statusImageView.image = [self imageForModelStatus:modelStatus];
    self.itemTextLabel.attributedText = [self labelAttribureForModelStatus:modelStatus];
}

- (UIImage *)imageForModelStatus:(BOOL)status {
    static UIImage *__check = nil;
    static UIImage *__uncheck = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __check = [UIImage imageNamed:kPUCheckImageName];
        __uncheck = [UIImage imageNamed:kPUUncheckImageName];
    });

    return status ? __check : __uncheck;
}

- (NSAttributedString *)labelAttribureForModelStatus:(BOOL)status {
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.shopListItem.name];
    
    if (status) {
        NSNumber *style = [NSNumber numberWithInt:NSUnderlineStyleSingle];
        NSDictionary *attributes = @{ NSStrikethroughStyleAttributeName:style };
        
        attrString = [[NSAttributedString alloc] initWithString:self.shopListItem.name attributes:attributes];
    }
    
    return attrString;
}

#pragma mark -
#pragma mark PUListObserverProtocol

- (void)shopListItemModelDidChange:(id)model {
    if (self.shopListItem == model) {
        [self fillWithModel:model];
    }
}

@end
