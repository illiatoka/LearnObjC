#import <UIKit/UIKit.h>

@class PUListItem;

@interface PUListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   PUListItem  *listItem;

@end
