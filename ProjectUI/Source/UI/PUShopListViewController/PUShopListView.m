#import "PUShopListView.h"

#import "PUArraySingleIndexChangeModel.h"
#import "PUArrayDoubleIndexChangeModel.h"

#import "NSIndexPath+PUExtensions.h"

@interface PUShopListView ()

- (void)updateWithBlock:(PUVoidBlock)block;

@end

@implementation PUShopListView

#pragma mark -
#pragma mark Public

- (void)updateViewWithChangeModel:(PUArraySingleIndexChangeModel *)model {
    NSUInteger modelAction = [model modelAction];
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
        // In this case tableView updates performed by HRReorderTableView class
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
