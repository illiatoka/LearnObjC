#import "PUFoodListViewController.h"

#import "PUFoodListItems.h"
#import "PUFoodListItem.h"

#import "PUFoodListView.h"
#import "PUFoodListCell.h"

#import "PUViewControllerMacro.h"

PUViewControllerBaseViewProperty(PUFoodListViewController, baseView, PUFoodListView)

@implementation PUFoodListViewController

#pragma mark -
#pragma mark Accessors

- (void)setListModel:(PUFoodListItems *)foodListItems {
    if (_foodListItems != foodListItems) {
        _foodListItems = foodListItems;
        
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
    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodListItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cellClass = [PUFoodListCell class];
    NSString *cellClassString = NSStringFromClass(cellClass);
    
    PUFoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassString];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:cellClassString bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        
        for (id result in cells) {
            if ([result isMemberOfClass:cellClass]) {
                cell = result;
            }
        }
    }
    
    PUFoodListItems *foodListItems = self.foodListItems;
    PUFoodListItem *foodListItem = [foodListItems objectAtIndex:indexPath.row];
    
    // TODO: Don't forget to remove cell from listModel observers!
    if (![foodListItem containsObserver:cell]) {
        [foodListItem addObserver:cell];
    }
    
    cell.foodListItem = foodListItem;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PUFoodListItem *foodListItem = [self.foodListItems objectAtIndex:indexPath.row];
    [foodListItem setChecked:foodListItem.isChecked ? NO : YES];
}

@end
