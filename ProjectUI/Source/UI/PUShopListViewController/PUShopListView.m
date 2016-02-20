#import "PUShopListView.h"

#import "PUArraySingleIndexChangeModel.h"
#import "PUArrayDoubleIndexChangeModel.h"

#import "UITableView+PUExtensions.h"
#import "NSIndexPath+PUExtensions.h"

@implementation PUShopListView

#pragma mark -
#pragma mark Public

- (void)updateViewWithChangeModel:(PUArraySingleIndexChangeModel *)model {
    NSUInteger modelAction = model.modelAction;
    UITableView *tableView = self.tableView;
    NSArray *insertIndexPaths = @[[NSIndexPath indexPathForRow:model.index]];
    
    void (^block)(void) = nil;
    
    if (PUArrayModelActionInsert == modelAction) {
        block = ^{
            [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
        };
    } else if (PUArrayModelActionRemove == modelAction) {
        block = ^{
            [tableView deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
        };
    } else if (PUArrayModelActionReplace == modelAction) {
        // In this case tableView updates will perform by HRReorderTableView class
    }
    
    [self updateWithBlock:block];
}

@end
