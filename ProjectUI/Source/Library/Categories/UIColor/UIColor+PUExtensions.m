#import "UIColor+PUExtensions.h"

UIColor *PUColorWithRGBA(NSUInteger red, NSUInteger green, NSUInteger blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
