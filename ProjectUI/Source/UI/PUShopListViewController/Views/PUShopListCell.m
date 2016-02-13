#import "PUShopListCell.h"

#import "PUShopListItem.h"

#import "UIColor+PUExtensions.h"

static NSString * const kPUCheckImageName = @"check";
static NSString * const kPUUncheckImageName = @"uncheck";

static const PUColor kPUGreyColor  = {187, 187, 189, 1.0};
static const PUColor kPUBlackColor = {29, 29, 38, 1.0};

@interface PUShopListCell ()

- (void)fillWithModel:(PUShopListItem *)shopListItem;

- (UIImage *)imageForModelCheckedStatus:(BOOL)status;
- (NSAttributedString *)labelAttributedString;

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
    NSLog(@"On delete");
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

- (IBAction)onLongPress:(UILongPressGestureRecognizer *)sender {
    if (UIGestureRecognizerStateBegan == sender.state) {
        NSLog(@"On long press");
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(PUShopListItem *)shopListItem {
    UILabel *label = self.itemTextLabel;
    BOOL checkedStatus = shopListItem.isChecked;
    
    label.attributedText = [self labelAttributedString];
    self.statusImageView.image = [self imageForModelCheckedStatus:checkedStatus];
}

- (UIImage *)imageForModelCheckedStatus:(BOOL)status {
    static UIImage *__checkImage = nil;
    static UIImage *__uncheckImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __checkImage = [UIImage imageNamed:kPUCheckImageName];
        __uncheckImage = [UIImage imageNamed:kPUUncheckImageName];
    });

    return status ? __checkImage : __uncheckImage;
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

#pragma mark -
#pragma mark PUListObserverProtocol

- (void)shopListItemModelDidChange:(id)model {
    [self fillWithModel:model];
}

@end
