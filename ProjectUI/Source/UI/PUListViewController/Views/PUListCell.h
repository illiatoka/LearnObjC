#import "PUTableViewCell.h"

@class PUListItem;

@interface PUListCell : PUTableViewCell
@property (nonatomic, strong)   IBOutlet UILabel    *listItemTextLabel;

@property (nonatomic, strong)   PUListItem  *listItem;

- (void)fillWithModel:(PUListItem *)listItem;

@end
