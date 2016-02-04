#import "PUViewController.h"

#import "PUView.h"

#import "PUMacro.h"

PUViewControllerBaseViewProperty(PUViewController, baseView, PUView)

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

- (IBAction)onNextButton {
    [self.baseView moveSquareToNextPosition];
}

- (IBAction)onStartStopButton {
    self.baseView.cycleMoving = !self.baseView.cycleMoving;
}

@end
