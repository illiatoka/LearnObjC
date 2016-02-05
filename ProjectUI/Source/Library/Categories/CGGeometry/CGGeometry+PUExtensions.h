#import <UIKit/UIKit.h>

#define CGWidth(frame) CGRectGetWidth(frame)
#define CGHeight(frame) CGRectGetHeight(frame)
#define CGMaxX(frame) CGRectGetMaxX(frame)
#define CGMaxY(frame) CGRectGetMaxY(frame)

static inline
CGPoint PUPointBySubtractingRects(CGRect minuend, CGRect subtrahend) {
    return CGPointMake(CGMaxX(minuend) - CGWidth(subtrahend), CGMaxY(minuend) - CGHeight(subtrahend));
}
