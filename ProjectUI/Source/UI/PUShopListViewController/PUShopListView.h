#import <UIKit/UIKit.h>

typedef void(^PUVoidBlock)(void);

@interface PUShopListView : UIView
@property (nonatomic, strong)   IBOutlet UITableView    *tableView;

@end
