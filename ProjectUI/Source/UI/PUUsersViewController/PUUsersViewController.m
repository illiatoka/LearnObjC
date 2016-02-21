#import "PUUsersViewController.h"

#import "PUUsersView.h"
#import "PUUserCell.h"

#import "UITableView+PUExtensions.h"

#import "PUViewControllerMacro.h"

PUViewControllerBaseViewProperty(PUUsersViewController, baseView, PUUsersView)

@interface PUUsersViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PUUsersViewController

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

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PUUserCell *cell = [tableView cellWithClass:[PUUserCell class]];
    
    return cell;
}

@end
