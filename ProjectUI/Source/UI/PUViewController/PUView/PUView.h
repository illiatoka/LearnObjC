#import <UIKit/UIKit.h>

typedef void(^PUVoidBlock)(void);

typedef NS_ENUM(NSUInteger, PUSquarePosition) {
    PUSquarePositionTopLeft,
    PUSquarePositionBottomLeft,
    PUSquarePositionBottomRight,
    PUSquarePositionTopRight,
    PUSquarePositionCount
};

@interface PUView : UIView
@property (nonatomic, strong) IBOutlet  UIView      *areaView;
@property (nonatomic, strong) IBOutlet  UIView      *squareView;

@property (nonatomic, strong) IBOutlet  UISwitch    *controlSwitch;
@property (nonatomic, strong) IBOutlet  UILabel     *controlLabel;

@property (nonatomic, strong) IBOutlet  UIButton    *startButton;
@property (nonatomic, strong) IBOutlet  UIButton    *stopButton;

@property (nonatomic, assign) PUSquarePosition squarePosition;

@property (nonatomic, assign, getter=isSquareMoving)        BOOL    squareMoving;
@property (nonatomic, assign, getter=isCycleMovingDidStart) BOOL    cycleMovingDidStart;

- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated;
- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated completionHandler:(PUVoidBlock)handler;

- (void)moveSquareInCycle;
- (void)moveSquareToNextPosition;

- (void)stopSquareMoving;

- (void)updateSwitcherText;

@end
