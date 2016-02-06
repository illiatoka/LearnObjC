#import "PUViewController.h"

#import "PUView.h"

#import "PUMacro.h"

PUViewControllerBaseViewProperty(PUViewController, baseView, PUView)

@implementation PUViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
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
#pragma mark Interface Handling

- (IBAction)onNextPosition:(id)sender {
    [self.baseView moveSquareToNextPosition];
}

- (IBAction)onAnimate:(id)sender {
    PUView *baseView = self.baseView;
    baseView.cycleMoving = !baseView.cycleMoving;
}

@end
