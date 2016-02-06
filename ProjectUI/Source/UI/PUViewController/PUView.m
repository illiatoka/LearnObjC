#import "PUView.h"

#import "PUMacro.h"

#import "CGGeometry+PUExtensions.h"
#import "UIColor+PUExtensions.h"

static const CGFloat kPUFramePadding = 20;

static const NSTimeInterval kPUAnimationDuration    = 1.0;
static const NSTimeInterval kPUAnimationDelay       = 0.5;

const PUColor kPURedColor   = {210, 52, 48, 1.0};
const PUColor kPUBlackColor = {60, 58, 63, 1.0};

static NSString * const kPUStart    = @"Start";
static NSString * const kPUStop     = @"Stop";

static NSString * const kPUEnableAnimation  = @"Enable animation";
static NSString * const kPUDisableAnimation = @"Disable animation";

@interface PUView ()
@property (nonatomic, assign, getter=isSquareMoving)    BOOL    squareMoving;
@property (nonatomic, assign, getter=isCycleStoped)     BOOL    cycleStoped;

- (void)stopSquareMoving;
- (void)updateStartStopButton;
- (IBAction)updateSwitcherText;

- (void)moveSquareAtPosition:(PUSquarePosition)position animated:(BOOL)animated;
- (PUSquarePosition)nextPositionWithPosition:(PUSquarePosition)position;
- (CGRect)squareFrameWithSquarePosition:(PUSquarePosition)position;

@end

@implementation PUView

#pragma mark -
#pragma mark Accessors

- (void)setCycleMoving:(BOOL)cycleMoving {
    if (_cycleMoving != cycleMoving) {
        if (cycleMoving) {
            if (!self.squareMoving) {
                _cycleMoving = cycleMoving;
                [self moveSquareToNextPosition];
                [self updateStartStopButton];
            }
        } else {
            _cycleMoving = cycleMoving;
            [self stopSquareMoving];
            [self updateStartStopButton];
        }
    }
}

#pragma mark -
#pragma mark Public

- (void)setSquarePosition:(PUSquarePosition)position {
    [self setSquarePosition:position animated:NO];
}

- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated {
    [self setSquarePosition:position animated:animated completionHandler:NULL];
}

- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated completionHandler:(PUVoidBlock)handler {
    if (_squarePosition != position) {
        void (^updatePosition)(void) = ^{
            self.squareView.frame = [self squareFrameWithSquarePosition:position];
        };
        
        void (^completePosition)(BOOL finished) = ^(BOOL finished) {
            if (finished) {
                _squarePosition = position;
                self.squareMoving = NO;
            }
            
            if (handler) {
                handler();
            }
        };
        
        [UIView animateWithDuration:animated ? kPUAnimationDuration : 0.0
                              delay:animated ? 0.0 : (self.cycleMoving ? kPUAnimationDelay : 0.0)
                            options:UIViewAnimationOptionTransitionNone
                         animations:updatePosition
                         completion:completePosition];
    }
}

- (void)moveSquareToNextPosition {
    if (!self.squareMoving && !self.cycleStoped) {
        self.squareMoving = YES;
        
        [self moveSquareAtPosition:[self nextPositionWithPosition:self.squarePosition]
                          animated:self.controlSwitch.isOn];
    }
    
    self.cycleStoped = NO;
}

#pragma mark -
#pragma mark Private

- (void)stopSquareMoving {
    self.cycleStoped = YES;
}

- (void)updateStartStopButton {
    UIButton *button = self.startStopButton;
    UIColor *whiteColor = [UIColor whiteColor];
    BOOL cycleMoving = self.cycleMoving;
    
    [button setBackgroundColor:cycleMoving ? UIColorWithPUColor(kPURedColor) : whiteColor];
    [button setTitle:cycleMoving ? kPUStop : kPUStart forState:UIControlStateNormal];
    [button setTitleColor:cycleMoving ? whiteColor : UIColorWithPUColor(kPUBlackColor) forState:UIControlStateNormal];
}

- (IBAction)updateSwitcherText {
    self.controlLabel.text = self.controlSwitch.isOn ? kPUDisableAnimation : kPUEnableAnimation;
}

- (void)moveSquareAtPosition:(PUSquarePosition)position animated:(BOOL)animated {
    PUWeakify(self);
    void (^updatePosition)(void) = nil;
    
    if (self.cycleMoving) {
        updatePosition = ^{
            PUStrongifyAndReturnIfNil(self);
            
            [self moveSquareToNextPosition];
        };
    }
    
    [self setSquarePosition:position animated:animated completionHandler:updatePosition];
}

- (PUSquarePosition)nextPositionWithPosition:(PUSquarePosition)position {
    return (position + 1) % PUSquarePositionCount;
}

- (CGRect)squareFrameWithSquarePosition:(PUSquarePosition)position {
    CGRect area = CGRectInset(self.areaView.bounds, kPUFramePadding, kPUFramePadding);
    CGRect square = self.squareView.frame;
    
    CGPoint bottomRight = CGPointOfBottomRightCornerCommonForRects(area, square);
    CGPoint origin = area.origin;
    
    switch (position) {
        case PUSquarePositionBottomLeft:
            origin.y = bottomRight.y;
            break;
            
        case PUSquarePositionBottomRight:
            origin = bottomRight;
            break;
            
        case PUSquarePositionTopRight:
            origin.x = bottomRight.x;
            break;
            
        default:
            break;
    }
    
    square.origin = origin;
    
    return square;
}

@end
