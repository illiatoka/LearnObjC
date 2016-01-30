#import "PUViewController.h"

#import "PUView.h"

@interface PUViewController ()
- (UIStatusBarStyle)preferredStatusBarStyle;

@end

@implementation PUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark Puclic

- (IBAction)startMoving {
    [(PUView *)self.view moveSquare];
}

- (IBAction)stopMoving {
    [(PUView *)self.view stopSquare];
}

- (IBAction)switcherChanged {
    [(PUView *)self.view updateSquare];
}

@end
