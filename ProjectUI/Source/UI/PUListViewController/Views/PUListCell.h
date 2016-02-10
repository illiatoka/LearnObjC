#import "PUTableViewCell.h"

#import "PUListItemObserverProtocol.h"

@class PUListItem;

@interface PUListCell : PUTableViewCell <PUListItemObserverProtocol>
@property (nonatomic, strong)   IBOutlet UIView         *foregroundView;
@property (nonatomic, strong)   IBOutlet UIImageView    *statusImageView;
@property (nonatomic, strong)   IBOutlet UILabel        *itemTextLabel;

@property (nonatomic, strong)   PUListItem  *listItem;

@end
