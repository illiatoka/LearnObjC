#import "PUViewController.h"

#import "PUView.h"

@interface PUViewController ()
@property (nonatomic, assign, getter=isMovingDidStart)  BOOL    movingDidStart;

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
    if (!self.isMovingDidStart) {
        self.movingDidStart = YES;
        [(PUView *)self.view setMoving:YES];
        [(PUView *)self.view moveSquare];
    }
}

- (IBAction)stopMoving {
    self.movingDidStart = NO;
    [(PUView *)self.view setMoving:NO];
    [(PUView *)self.view stopSquare];
}

- (IBAction)switcherDidChange {
    [(PUView *)self.view updateSwitcherText];
}

@end
