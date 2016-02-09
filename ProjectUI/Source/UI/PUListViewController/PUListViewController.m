#import "PUListViewController.h"

#import "PUList.h"

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
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.listItem = [self.listModel objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected");
}

@end
