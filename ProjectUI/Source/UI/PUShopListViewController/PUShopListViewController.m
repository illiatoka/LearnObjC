#import "PUShopListViewController.h"

#import "PUArrayModelChanges.h"

#import "PUShopListItems.h"
#import "PUShopListItem.h"

#import "PUShopListView.h"
#import "PUShopListCell.h"

#import "NSString+PURandomFoodName.h"
#import "UITableView+PUExtensions.h"

#import "PUViewControllerMacro.h"

PUViewControllerBaseViewProperty(PUShopListViewController, baseView, PUShopListView)

@interface PUShopListViewController ()

- (void)deleteObjectAtIndex:(NSUInteger)index;

@end

@implementation PUShopListViewController

#pragma mark -
#pragma mark Accessors

- (void)setShopListItems:(PUShopListItems *)shopListItems {
    if (_shopListItems != shopListItems) {
        [_shopListItems removeObserver:self];
        _shopListItems = shopListItems;
        [_shopListItems addObserver:self];
        
        [self.baseView.tableView reloadData];
    }
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.baseView.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Public

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)onAddItem:(id)sender {
    [self.shopListItems insertObject:[PUShopListItem shopListItemWithName:[NSString randomName]] atIndex:0];
}

#pragma mark -
#pragma mark Private

- (void)deleteObjectAtIndex:(NSUInteger)index {
    [self.shopListItems removeObjectAtIndex:index];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shopListItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PUShopListCell *cell = [tableView cellWithClass:[PUShopListCell class]];
    cell.shopListItem = self.shopListItems[indexPath.row];
    cell.callback = ^(PUShopListCell *listCell) {
        NSIndexPath *cellIndexPath = [tableView indexPathForCell:listCell];
        [self deleteObjectAtIndex:cellIndexPath.row];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PUShopListItem *shopListItem = self.shopListItems[indexPath.row];
    shopListItem.checked = !shopListItem.checked;
}

#pragma mark -
#pragma mark PUArrayModelObserverProtocol

- (void)arrayModelDidChange:(id)model withObject:(PUArrayModelChanges *)object {
    [self.baseView updateViewWithChanges:object];
}

@end
