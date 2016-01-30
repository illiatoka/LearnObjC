#import "PUView.h"

@interface PUView ()

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
        if (animated) {
            [UIView animateWithDuration:1.0 animations:^() {
                self.square.frame = CGRectOffset(self.square.frame, newPosition.x, newPosition.y);
            }];
        } else {
            self.square.frame = CGRectOffset(self.square.frame, newPosition.x, newPosition.y);
        }
        
        _squarePosition = position;
    }
}

- (void)moveSquare {
    if (self.switcher.isOn) {
        if (self.squarePosition < 3) {
            [self setSquarePosition:self.squarePosition + 1 animated:YES];
        } else {
            [self setSquarePosition:PUSquarePositionTopLeft animated:YES];
        }
    } else {
        if (self.squarePosition < 3) {
            [self setSquarePosition:self.squarePosition + 1 animated:NO];
        } else {
            [self setSquarePosition:PUSquarePositionTopLeft animated:NO];
        }
    }
}

- (void)stopSquare {

}

- (void)updateSquare {

}

#pragma mark -
#pragma mark Private

- (CGPoint)squarePositionForPosition:(PUSquarePosition)position {
    CGFloat frameWidth = self.areaView.frame.size.width;
    CGFloat frameHeight = self.areaView.frame.size.height;
    
    switch (position) {
        case PUSquarePositionTopLeft:
            return CGPointMake(-(frameWidth - 105), 0);
            
        case PUSquarePositionBottomLeft:
            return CGPointMake(0, frameHeight - 105);
            
        case PUSquarePositionBottomRight:
            return CGPointMake(frameWidth - 105, 0);
            
        case PUSquarePositionTopRight:
            return CGPointMake(0, -(frameHeight - 105));
            
        default:
            return CGPointMake(0, 0);
    }
}

@end
