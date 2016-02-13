#import <UIKit/UIKit.h>

#import "PUArrayModelObserver.h"

@class PUShopListItems;

@interface PUShopListViewController : UIViewController <UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        PUArrayModelObserver>

@property (nonatomic, strong)   PUShopListItems *shopListItems;

- (IBAction)onAddItem:(id)sender;

@end
