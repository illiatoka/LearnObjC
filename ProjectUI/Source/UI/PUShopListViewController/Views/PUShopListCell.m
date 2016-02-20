#import "PUShopListCell.h"

#import "PUShopListItem.h"

#import "UIColor+PUExtensions.h"
#import "UIImage+PUExtensions.h"

static const PUColor kPUGreyColor  = {187, 187, 189, 1.0};
static const PUColor kPUBlackColor = {29, 29, 38, 1.0};

@interface PUShopListCell ()

- (void)fillWithModel:(PUShopListItem *)shopListItem;

- (UIImage *)imageForModelCheckedStatus:(BOOL)status;
- (NSAttributedString *)labelAttributedString;

- (void)resetForegroundView;

@end

@implementation PUShopListCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.shopListItem = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layoutMargins = UIEdgeInsetsZero;
}

#pragma mark -
#pragma mark Accessors

- (void)setShopListItem:(PUShopListItem *)shopListItem {
    if (_shopListItem != shopListItem) {
        [_shopListItem removeObserver:self];
        _shopListItem = shopListItem;
        [_shopListItem addObserver:self];
        
        [self fillWithModel:shopListItem];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onDelete:(id)sender {
    self.deleteCallback(self);
}

- (IBAction)onMenuSwipe:(UISwipeGestureRecognizer *)sender {
    if (UIGestureRecognizerStateRecognized == sender.state) {
        CGRect frame = self.foregroundView.frame;
        
        if (UISwipeGestureRecognizerDirectionRight == sender.direction) {
            frame.origin.x = frame.size.width / 2;
        } else if (UISwipeGestureRecognizerDirectionLeft == sender.direction) {
            frame.origin.x = 0;
        }
        
        self.foregroundView.frame = frame;
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(PUShopListItem *)shopListItem {
    UILabel *label = self.itemTextLabel;
    BOOL checkedStatus = shopListItem.isChecked;
    
    [self resetForegroundView];
    
    label.attributedText = [self labelAttributedString];
    self.statusImageView.image = [self imageForModelCheckedStatus:checkedStatus];
}

- (UIImage *)imageForModelCheckedStatus:(BOOL)status {
    return status ? [UIImage checkedImage] : [UIImage uncheckedImage];
}

- (NSAttributedString *)labelAttributedString {
    NSDictionary *attributes = @{NSForegroundColorAttributeName:UIColorWithPUColor(kPUBlackColor)};
    PUShopListItem *model = self.shopListItem;
    
    if (model.checked) {
        attributes = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                       NSForegroundColorAttributeName:UIColorWithPUColor(kPUGreyColor)
                       };
    }
    
    return [[NSAttributedString alloc] initWithString:model.name attributes:attributes];
}

- (void)resetForegroundView {
    CGRect frame = self.foregroundView.frame;
    frame.origin.x = 0;
    self.foregroundView.frame = frame;
}

#pragma mark -
#pragma mark PUListObserverProtocol

- (void)shopListItemModelDidChange:(id)model {
    [self fillWithModel:model];
}

@end
