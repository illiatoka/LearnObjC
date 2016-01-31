#import "PUView.h"

static const CGFloat squareSize = 65;
static const CGFloat framePadding = 40;
static const CGFloat frameOffset = squareSize + framePadding;

static const NSTimeInterval animationDuration = 1.0;
static const NSTimeInterval animationDelay = 0.5;

static NSString *enableAnimation = @"Enable animation";
static NSString *disableAnimation = @"Disable animation";

@interface PUView ()

- (void)moveSquareAnimated:(BOOL)animated;
- (void)moveSquareAtPosition:(PUSquarePosition)position animated:(BOOL)animated;

- (CGPoint)squarePositionForPosition:(PUSquarePosition)position;

@end

@implementation PUView

#pragma mark -
#pragma mark Public

- (void)setSquarePosition:(PUSquarePosition)position {
    [self setSquarePosition:position animated:NO];
}

- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated {
    [self setSquarePosition:position animated:animated completionHandler:NULL];
}

- (void)setSquarePosition:(PUSquarePosition)position animated:(BOOL)animated completionHandler:(void(^)(void))handler {
    if (_squarePosition != position) {
        CGPoint newPosition = [self squarePositionForPosition:position];
        NSTimeInterval duration = animated ? animationDuration : 0.0;
        NSTimeInterval delay = animated ? 0.0 : animationDelay;
        
        void (^updatePosition)() = ^() {
            self.square.frame = CGRectOffset(self.square.frame, newPosition.x, newPosition.y);
        };
        
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionTransitionNone
                         animations:^(void) {updatePosition();}
                         completion:^(BOOL finished){handler();}];
        
        _squarePosition = position;
    }
}

- (void)moveSquare {
    if (self.isMoving) {
        if (self.switcher.isOn) {
            [self moveSquareAnimated:YES];
        } else {
            [self moveSquareAnimated:NO];
        }
    }
}

- (void)stopSquare {
    
}

- (void)updateSwitcherText {
    if (self.switcher.isOn) {
        self.switcherLabel.text = disableAnimation;
    } else {
        self.switcherLabel.text = enableAnimation;
    }
}

#pragma mark -
#pragma mark Private

- (void)moveSquareAnimated:(BOOL)animated {
    NSUInteger position = self.squarePosition;
    if (position < PUSquarePositionTopRight) {
        [self moveSquareAtPosition:position + 1 animated:animated];
    } else {
        [self moveSquareAtPosition:PUSquarePositionTopLeft animated:animated];
    }
}

- (void)moveSquareAtPosition:(PUSquarePosition)position animated:(BOOL)animated {
    __block PUView *_self = self;
    [self setSquarePosition:position animated:animated completionHandler:^(){[_self moveSquare];}];
}

- (CGPoint)squarePositionForPosition:(PUSquarePosition)position {
    CGFloat frameWidth = self.areaView.frame.size.width;
    CGFloat frameHeight = self.areaView.frame.size.height;
    
    switch (position) {
        case PUSquarePositionTopLeft:
            return CGPointMake(-(frameWidth - frameOffset), 0);
            
        case PUSquarePositionBottomLeft:
            return CGPointMake(0, frameHeight - frameOffset);
            
        case PUSquarePositionBottomRight:
            return CGPointMake(frameWidth - frameOffset, 0);
            
        case PUSquarePositionTopRight:
            return CGPointMake(0, -(frameHeight - frameOffset));
            
        default:
            return CGPointMake(0, 0);
    }
}

@end
