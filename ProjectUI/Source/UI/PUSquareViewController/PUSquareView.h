#import <UIKit/UIKit.h>

typedef void(^PUVoidBlock)(void);

typedef NS_ENUM(NSUInteger, PUSquarePosition) {
    PUSquarePositionTopLeft,
    PUSquarePositionBottomLeft,
    PUSquarePositionBottomRight,
    PUSquarePositionTopRight,
    PUSquarePositionCount
};

@interface PUSquareView : UIView
@property (nonatomic, strong) IBOutlet  UIView      *areaView;
@property (nonatomic, strong) IBOutlet  UIView      *squareView;

@property (nonatomic, strong) IBOutlet  UISwitch    *controlSwitch;
@property (nonatomic, strong) IBOutlet  UILabel     *controlLabel;

@property (nonatomic, strong) IBOutlet  UIButton    *startStopButton;

@property (nonatomic, assign) PUSquarePosition squarePosition;

@property (nonatomic, readonly, getter=isMoving)    BOOL    moving;
@property (nonatomic, assign, getter=isCycleMoving) BOOL    cycleMoving;

- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated;
- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated completionHandler:(PUVoidBlock)handler;

- (void)moveSquareToNextPosition;

@end
