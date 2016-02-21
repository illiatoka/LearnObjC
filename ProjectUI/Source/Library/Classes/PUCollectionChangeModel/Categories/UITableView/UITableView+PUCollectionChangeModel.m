#import "UITableView+PUCollectionChangeModel.h"

#import "PUCollectionChangeModel+UITableView.h"

@implementation UITableView (PUCollectionChangeModel)

- (void)updateWithCollectionChangeModel:(id)model {
    [model updateTableView:self];
}

@end
