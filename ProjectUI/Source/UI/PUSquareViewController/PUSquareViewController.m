#import "PUSquareViewController.h"

#import "PUSquareView.h"

#import "PUViewControllerMacro.h"

PUViewControllerBaseViewProperty(PUSquareViewController, baseView, PUSquareView)

@implementation PUSquareViewController

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
    PUSquareView *baseView = self.baseView;
    baseView.cycleMoving = !baseView.cycleMoving;
}

@end
