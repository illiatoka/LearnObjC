#import <UIKit/UIKit.h>

#import "PUArrayModelObserverProtocol.h"

@class PUShopListItems;

@interface PUShopListViewController : UIViewController <UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        PUArrayModelObserverProtocol>

@property (nonatomic, strong)   PUShopListItems *shopListItems;

- (IBAction)onAddItem:(id)sender;

@end
