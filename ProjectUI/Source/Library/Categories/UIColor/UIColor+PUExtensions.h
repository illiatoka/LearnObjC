#import <UIKit/UIKit.h>

union PUColor {
    struct {
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        CGFloat alpha;
    };
    CGFloat colors[4];
};

typedef union PUColor PUColor;

extern
UIColor *UIRGBAColor(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);

extern
UIColor *UIRGBColor(CGFloat red, CGFloat green, CGFloat blue);

extern
UIColor *UIColorWithPUColor(PUColor color);
