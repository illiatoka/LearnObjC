#import "PUShopListView.h"

@interface PUShopListView ()

- (void)updateViewWithAction:(PUVoidBlock)action;

@end

@implementation PUShopListView

#pragma mark -
#pragma mark Public

- (void)updateViewWithChanges:(PUArrayModelChanges *)changes {
    UITableView *tableView = self.tableView;
    NSArray *insertIndexPaths = @[[NSIndexPath indexPathForRow:changes.idx1 inSection:0]];
    
    void (^action)(void) = nil;
    
    if (PUArrayModelActionInsert == changes.action) {
        action = ^{
            [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
        };
    } else if (PUArrayModelActionRemove == changes.action) {
        [tableView deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
    
    [self updateViewWithAction:action];
}

#pragma mark -
#pragma mark Private

- (void)updateViewWithAction:(PUVoidBlock)action {
    UITableView *tableView = self.tableView;
    
    [tableView beginUpdates];
    action();
    [tableView endUpdates];
}

@end
