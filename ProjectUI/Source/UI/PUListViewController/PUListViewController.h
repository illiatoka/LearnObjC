#import <UIKit/UIKit.h>

@class PUList;

@interface PUListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   PUList  *listModel;

- (IBAction)onAddItem:(id)sender;

@end
