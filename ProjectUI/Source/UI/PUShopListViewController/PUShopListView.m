#import "PUShopListView.h"

@interface PUShopListView ()

- (void)updateWithBlock:(PUVoidBlock)block;

@end

@implementation PUShopListView

#pragma mark -
#pragma mark Public

- (void)updateViewWithChanges:(PUArrayModelChanges *)changes {
    UITableView *tableView = self.tableView;
    NSArray *insertIndexPaths = @[[NSIndexPath indexPathForRow:changes.idx1 inSection:0]];
    
    void (^block)(void) = nil;
    
    if (PUArrayModelActionInsert == changes.action) {
        block = ^{
            [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
        };
    } else if (PUArrayModelActionRemove == changes.action) {
        block = ^{
            [tableView deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
        };
    }
    
    [self updateWithBlock:block];
}

#pragma mark -
#pragma mark Private

- (void)updateWithBlock:(PUVoidBlock)block {
    UITableView *tableView = self.tableView;
    
    if (block) {
        [tableView beginUpdates];
        block();
        [tableView endUpdates];
    }
}

@end
