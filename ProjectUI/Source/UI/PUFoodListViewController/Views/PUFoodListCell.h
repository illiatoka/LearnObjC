#import "PUTableViewCell.h"

#import "PUFoodListItemObserverProtocol.h"

@class PUFoodListItem;

@interface PUFoodListCell : PUTableViewCell <PUFoodListItemObserverProtocol>
@property (nonatomic, strong)   IBOutlet UIView         *foregroundView;
@property (nonatomic, strong)   IBOutlet UIImageView    *statusImageView;
@property (nonatomic, strong)   IBOutlet UILabel        *itemTextLabel;

@property (nonatomic, strong)   PUFoodListItem  *foodListItem;

@end
