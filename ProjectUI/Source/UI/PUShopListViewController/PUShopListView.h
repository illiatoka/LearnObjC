#import <UIKit/UIKit.h>

typedef void(^PUVoidBlock)(void);

@interface PUShopListView : UIView
@property (nonatomic, strong)   IBOutlet UITableView                *tableView;
@property (nonatomic, strong)   IBOutlet UIButton                   *addButton;
@property (nonatomic, strong)   IBOutlet UIActivityIndicatorView    *activityView;
@property (nonatomic, strong)   IBOutlet UIView                     *foregroundView;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
