#import "UIColor+PUExtensions.h"

UIColor *UIRGBAColor(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

UIColor *UIRGBColor(CGFloat red, CGFloat green, CGFloat blue) {
    return UIRGBAColor(red, green, blue, 1.0);
}

UIColor *UIColorWithPUColor(PUColor color) {
    return UIRGBAColor(color.red, color.green, color.blue, color.alpha);
}
