#import "PUArrayDoubleIndexChangeModel+UITableView.h"
#import "PUArraySingleIndexChangeModel+UITableView.h"

#import "UITableView+PUExtensions.h"
#import "NSIndexPath+PUExtensions.h"

@implementation PUArrayDoubleIndexChangeModel (UITableView)

@dynamic toIndexPath;

#pragma mark -
#pragma mark Accessors

- (NSIndexPath *)toIndexPath {
    return [NSIndexPath indexPathForRow:self.toIndex];
}

#pragma mark -
#pragma mark Public

- (void)updateTableView:(UITableView *)tableView {
    NSUInteger modelAction = self.modelAction;
    NSArray *indexPaths = @[self.indexPath, self.toIndexPath];
    
    void (^block)(UITableView *tableView) = nil;
    
    if (PUArrayModelActionExchange == modelAction) {
        // In this case tableView updates will perform by HRReorderTableView class!
        // How can I fix this?
        indexPaths = nil;
    }
    
    [tableView updateWithBlock:block];
}

@end
