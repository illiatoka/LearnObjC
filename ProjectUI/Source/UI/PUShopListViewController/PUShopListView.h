#import <UIKit/UIKit.h>

#import "PUArrayModelChanges.h"

typedef void(^PUVoidBlock)(void);

@interface PUShopListView : UIView
@property (nonatomic, strong)   IBOutlet UITableView    *tableView;

- (void)updateViewWithChanges:(PUArrayModelChanges *)changes;

@end
