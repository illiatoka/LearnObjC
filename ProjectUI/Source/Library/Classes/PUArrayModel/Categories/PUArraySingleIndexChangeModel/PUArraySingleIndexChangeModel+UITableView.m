#import "PUArraySingleIndexChangeModel+UITableView.h"

#import "UITableView+PUExtensions.h"
#import "NSIndexPath+PUExtensions.h"

@implementation PUArraySingleIndexChangeModel (UITableView)

@dynamic indexPath;

#pragma mark -
#pragma mark Accessors

- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:self.index];
}

#pragma mark -
#pragma mark Public

- (void)updateTableView:(UITableView *)tableView {
    NSUInteger modelAction = self.modelAction;
    NSArray *indexPaths = @[self.indexPath];
    
    void (^block)(UITableView *tableView) = nil;
    
    if (PUArrayModelActionInsert == modelAction) {
        block = ^(UITableView *view) {
            [view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
        };
    } else if (PUArrayModelActionRemove == modelAction) {
        block = ^(UITableView *view) {
            [view deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        };
    }
    
    [tableView updateWithBlock:block];
}

@end
