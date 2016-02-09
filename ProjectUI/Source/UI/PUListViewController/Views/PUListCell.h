#import "PUTableViewCell.h"

@class PUListItem;

@interface PUListCell : PUTableViewCell
@property (nonatomic, strong)   IBOutlet UIView         *foregroundView;
@property (nonatomic, strong)   IBOutlet UIImageView    *statusImage;
@property (nonatomic, strong)   IBOutlet UILabel        *itemTextLabel;

@property (nonatomic, strong)   PUListItem  *listItem;

@end
