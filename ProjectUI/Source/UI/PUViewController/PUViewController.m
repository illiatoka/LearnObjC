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

- (IBAction)moveOnce {
    [(PUView *)self.view moveSquareToNextPosition];
}

- (IBAction)startMoving {
    [(PUView *)self.view moveSquareInCycle];
}

- (IBAction)stopMoving {
    [(PUView *)self.view stopSquareMoving];
}

- (IBAction)animationControlDidChange {
    [(PUView *)self.view updateSwitcherText];
}

@end
