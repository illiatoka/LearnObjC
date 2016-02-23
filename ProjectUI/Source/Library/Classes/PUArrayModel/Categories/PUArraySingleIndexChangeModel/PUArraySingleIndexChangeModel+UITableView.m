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
    NSIndexPath *indexPath = self.indexPath;
    NSArray *indexPaths = @[indexPath];
    
    void (^block)(UITableView *tableView) = nil;
    void (^completion)(UITableView *tableView) = nil;
    
    if (PUArrayModelActionInsert == modelAction) {
        block = ^(UITableView *view) {
            [view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
        };
        
        completion = ^(UITableView *view) {
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        };
    } else if (PUArrayModelActionRemove == modelAction) {
        block = ^(UITableView *view) {
            [view deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        };
    }
    
    [tableView updateWithBlock:block completion:completion];
}

@end
