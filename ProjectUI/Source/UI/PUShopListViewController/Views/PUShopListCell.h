#import "PUTableViewCell.h"

#import "PUShopListItemObserver.h"

typedef void(^PUCellDeletingCallback)(id cell);

@class PUShopListItem;

@interface PUShopListCell : PUTableViewCell <PUShopListItemObserver>
@property (nonatomic, strong)   IBOutlet UIView         *foregroundView;
@property (nonatomic, strong)   IBOutlet UIImageView    *statusImageView;
@property (nonatomic, strong)   IBOutlet UILabel        *itemTextLabel;
@property (nonatomic, copy)     PUCellDeletingCallback  callback;

@property (nonatomic, strong)   PUShopListItem  *shopListItem;

- (IBAction)onDelete:(id)sender;
- (IBAction)onMenuSwipe:(id)sender;
- (IBAction)onLongPress:(id)sender;

@end
