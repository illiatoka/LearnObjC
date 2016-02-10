#import <UIKit/UIKit.h>

@class PUFoodListItems;

@interface PUFoodListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   PUFoodListItems *foodListItems;

- (IBAction)onAddItem:(id)sender;

@end
