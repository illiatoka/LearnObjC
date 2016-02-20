#import <UIKit/UIKit.h>

@class PUShopListItems;

@interface PUShopListViewController : UIViewController
@property (nonatomic, strong)   PUShopListItems *shopListItems;

- (IBAction)onAddItem:(id)sender;

@end
