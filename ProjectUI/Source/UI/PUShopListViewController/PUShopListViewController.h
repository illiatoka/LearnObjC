#import <UIKit/UIKit.h>

@class PUShopListItems;

@interface PUShopListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   PUShopListItems *shopListItems;

- (IBAction)onAddItem:(id)sender;

@end
