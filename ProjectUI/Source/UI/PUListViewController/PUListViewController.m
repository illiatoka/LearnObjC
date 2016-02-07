#import "PUListViewController.h"

#import "PUListView.h"
#import "PUListCell.h"

#import "PUMacro.h"

PUViewControllerBaseViewProperty(PUListViewController, baseView, PUListView)

@implementation PUListViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.baseView.listView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Public

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = NSStringFromClass([PUListCell class]);
    
    PUListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        cell = [cells firstObject];
    }
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.listItem = self.listItem;
    
    return cell;
}

@end
