#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PUSquarePosition) {
    PUSquarePositionTopLeft,
    PUSquarePositionBottomLeft,
    PUSquarePositionBottomRight,
    PUSquarePositionTopRight
};

@interface PUView : UIView
@property (nonatomic, strong) IBOutlet  UIView  *areaView;
@property (nonatomic, strong) IBOutlet  UIView  *controlsView;

@property (nonatomic, strong) IBOutlet  UIView      *square;
@property (nonatomic, strong) IBOutlet  UISwitch    *switcher;
@property (nonatomic, strong) IBOutlet  UIButton    *startButton;
@property (nonatomic, strong) IBOutlet  UIButton    *stopButton;

@property (nonatomic, assign) PUSquarePosition squarePosition;

- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated;
- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated completionHandler:(void(^)(void))handler;

- (void)moveSquare;
- (void)stopSquare;

- (void)updateSquare;

@end
