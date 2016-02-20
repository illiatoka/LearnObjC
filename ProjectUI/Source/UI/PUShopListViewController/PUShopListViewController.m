#import "PUShopListViewController.h"

#import "PUArrayModelChanges.h"

#import "PUShopListItems.h"
#import "PUShopListItem.h"

#import "PUShopListView.h"
#import "PUShopListCell.h"

#import "NSString+PURandomFoodName.h"
#import "UITableView+PUExtensions.h"
#import "PUArrayModelObserver.h"

#import "PUViewControllerMacro.h"

PUViewControllerBaseViewProperty(PUShopListViewController, baseView, PUShopListView)

@interface PUShopListViewController () <UITableViewDelegate, UITableViewDataSource, PUArrayModelObserver>

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
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shopListItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PUShopListCell *cell = [tableView cellWithClass:[PUShopListCell class]];
    PUShopListItems *shopListItems = self.shopListItems;
    
    cell.shopListItem = shopListItems[indexPath.row];
    cell.deleteCallback = ^(PUShopListCell *listCell) {
        NSIndexPath *cellIndexPath = [tableView indexPathForCell:listCell];
        [shopListItems removeObjectAtIndex:cellIndexPath.row];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PUShopListItem *shopListItem = self.shopListItems[indexPath.row];
    shopListItem.checked = !shopListItem.checked;
}

-   (void)tableView:(UITableView *)tableView
 moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
        toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.shopListItems exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark PUArrayModelObserverProtocol

- (void)arrayModelDidChange:(id)model withObject:(PUArrayModelChanges *)object {
    [self.baseView updateViewWithChanges:object];
}

@end
