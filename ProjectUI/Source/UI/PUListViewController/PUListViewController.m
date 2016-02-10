#import "PUListViewController.h"

#import "PUList.h"
#import "PUListItem.h"

#import "PUListView.h"
#import "PUListCell.h"

#import "PUViewControllerMacro.h"

PUViewControllerBaseViewProperty(PUListViewController, baseView, PUListView)

@implementation PUListViewController

#pragma mark -
#pragma mark Accessors

- (void)setListModel:(PUList *)listModel {
    if (_listModel != listModel) {
        _listModel = listModel;
        
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
    return self.listModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cellClass = [PUListCell class];
    NSString *cellClassString = NSStringFromClass(cellClass);
    
    PUListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassString];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:cellClassString bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        
        for (id result in cells) {
            if ([result isMemberOfClass:cellClass]) {
                cell = result;
            }
        }
    }
    
    PUList *listModel = self.listModel;
    PUListItem *listItem = [listModel objectAtIndex:indexPath.row];
    
    // TODO: Don't forget to remove cell from listModel observers!
    if (![listItem containsObserver:cell]) {
        [listItem addObserver:cell];
    }
    
    cell.listItem = [listModel objectAtIndex:indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PUListItem *listItem = [self.listModel objectAtIndex:indexPath.row];
    [listItem setChecked:listItem.isChecked ? NO : YES];
}

@end
