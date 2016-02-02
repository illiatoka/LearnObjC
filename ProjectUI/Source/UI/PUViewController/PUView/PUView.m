#import "PUView.h"

static const CGFloat kPUFramePadding = 40;

static const NSTimeInterval kPUAnimationDuration = 1.0;
static const NSTimeInterval kPUAnimationDelay = 0.5;

static NSString * const kPUEnableAnimation = @"Enable animation";
static NSString * const kPUDisableAnimation = @"Disable animation";

@interface PUView ()
@property (nonatomic, assign, getter=isStopButtonDidPush)   BOOL    stopButtonDidPush;

- (void)moveSquareAtPosition:(PUSquarePosition)position animated:(BOOL)animated;

- (CGRect)squareFrameWithSquarePosition:(PUSquarePosition)position;

- (CGPoint)nextPointWithPosition:(PUSquarePosition)position frameWidth:(CGFloat)width frameHeight:(CGFloat)height;

@end

@implementation PUView

#pragma mark -
#pragma mark Accessors

- (void)setCycleMovingDidStart:(BOOL)cycleMovingDidStart {
    if (_cycleMovingDidStart != cycleMovingDidStart) {
        self.stopButton.alpha = cycleMovingDidStart ? 1.0 : 0.0;
        self.startButton.alpha = cycleMovingDidStart ? 0.0 : 1.0;
        
        _cycleMovingDidStart = cycleMovingDidStart;
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
        void (^updatePosition)(void) = ^() {
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
                              delay:animated ? 0.0 : (self.isCycleMovingDidStart ? kPUAnimationDelay : 0.0)
                            options:UIViewAnimationOptionTransitionNone
                         animations:updatePosition
                         completion:completePosition];
    }
}

- (void)moveSquareInCycle {
    if (!self.isCycleMovingDidStart && !self.squareMoving) {
        self.cycleMovingDidStart = YES;
        [self moveSquareToNextPosition];
    }
}

- (void)moveSquareToNextPosition {
    if (!self.isSquareMoving && !self.isStopButtonDidPush) {
        self.squareMoving = YES;
        NSUInteger position = (self.squarePosition + 1) % PUSquarePositionCount;
        [self moveSquareAtPosition:position animated:self.controlSwitch.isOn];
    }
    
    self.stopButtonDidPush = NO;
}

- (void)stopSquareMoving {
    self.cycleMovingDidStart = NO;
    self.stopButtonDidPush = YES;
}

- (void)updateSwitcherText {
    self.controlLabel.text = self.controlSwitch.isOn ? kPUDisableAnimation : kPUEnableAnimation;
}

#pragma mark -
#pragma mark Private

- (void)moveSquareAtPosition:(PUSquarePosition)position animated:(BOOL)animated {
    __weak typeof(self) weakSelf = self;
    void (^updatePosition)(void) = nil;
    
    if (self.isCycleMovingDidStart) {
        updatePosition = ^() {
            __strong typeof(self) self = weakSelf;
            
            if (!self) {
                return;
            }
            
            [self moveSquareToNextPosition];
        };
    }
    
    [self setSquarePosition:position animated:animated completionHandler:updatePosition];
}

- (CGRect)squareFrameWithSquarePosition:(PUSquarePosition)position {
    CGRect areaFrame = self.areaView.frame;
    CGRect squareFrame = self.squareView.frame;
    
    CGFloat frameWidth = CGRectGetWidth(areaFrame) - CGRectGetWidth(squareFrame) - kPUFramePadding;
    CGFloat frameHeight = CGRectGetHeight(areaFrame) - CGRectGetHeight(squareFrame) - kPUFramePadding;
    
    CGPoint newOrigin = [self nextPointWithPosition:position frameWidth:frameWidth frameHeight:frameHeight];
    
    return CGRectOffset(squareFrame, newOrigin.x, newOrigin.y);
}

- (CGPoint)nextPointWithPosition:(PUSquarePosition)position frameWidth:(CGFloat)width frameHeight:(CGFloat)height {
    CGPoint point = CGPointZero;
    switch (position) {
        case PUSquarePositionTopLeft:
            point.x = -width;
            break;
            
        case PUSquarePositionBottomLeft:
            point.y = height;
            break;
            
        case PUSquarePositionBottomRight:
            point.x = width;
            break;
            
        case PUSquarePositionTopRight:
            point.y = -height;
            break;
            
        default:
            break;
    }
    
    return point;
}

@end
