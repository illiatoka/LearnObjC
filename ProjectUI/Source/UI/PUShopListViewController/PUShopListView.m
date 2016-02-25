#import "PUShopListView.h"

@implementation PUShopListView

#pragma mark -
#pragma mark Public

- (void)showActivityIndicator {
    self.foregroundView.alpha = 1;
    self.addButton.alpha = 0;
    [self.activityView startAnimating];
}

- (void)hideActivityIndicator {
    [self.activityView stopAnimating];
    self.foregroundView.alpha = 0;
    self.addButton.alpha = 1;
}

@end
